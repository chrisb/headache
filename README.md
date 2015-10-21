# HeadACHe

[![Code Climate](https://img.shields.io/codeclimate/github/teampayoff/headache.svg?style=flat-square)](https://codeclimate.com/github/teampayoff/headache) [![Travis CI](https://img.shields.io/travis/teampayoff/headache.svg?style=flat-square)](https://travis-ci.org/teampayoff/headache) [![Coverage](https://img.shields.io/coveralls/teampayoff/headache.svg?style=flat-square)](https://coveralls.io/r/teampayoff/headache)

Headache takes a lot of the guesswork out of building [ACH (Automated Clearing House)](https://en.wikipedia.org/wiki/Automated_Clearing_House) files to move money around between banks.

Headache is built on top of the excellent [Fixy gem](https://github.com/Chetane/fixy) for handling fixed-width files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'headache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install headache

## Usage

It is outside of the scope of this document to describe NACHA's ACH file format. There are plenty of resources available that explain the syntax in detail.

### Record Types

ACH files contain 5 different record types. They are:

* File Header `Headache::Record::FileHeader`
* Batch Header `Headache::Record::FileHeader`
* Entry Detail `Headache::Record::Entry`
* Batch Control `Headache::Record::BatchControl`
* File Control `Headache::Record::FileControl`

A batch itself is represented by `Headache::Batch` and the document is unsurprisingly `Headache::Document`.

### Building an ACH Document

Headache provides some convenience out-of-the-box if you only plan to generate ACH files that contain a single batch, however there's nothing stopping you from implementing multiple batches.

Calling `#batch` or `#first_batch` will automatically create a `Headache::Batch` if the document's batch list is empty. `#batch` will raise an exception if the document contains multiple batches.

All ACH fields are represented and available to you. Headache attempts to abstract batch header and control records, allowing you to specify those details directly on the `Batch` object itself, but more granular control over that data is available if needed.

Further, Headache abstracts an ACH record _definition_ from the record itself; so should you need to create your own record and document objects, you're free to re-use the [definition mixins](https://github.com/teampayoff/headache/blob/master/lib/headache/definition) for this purpose.

Create a new ACH document (some optional fields are omitted in this example):

```ruby
ach_doc = Headache::Document.new.tap do |document|
  document.header.tap do |file_header|
    file_header.destination_name = '1ST INTERNET BANK'
    file_header.destination      = '111111111' # Originating DFI number
    file_header.origin_name      = 'ACME CORP'
    file_header.origin           = '1111111111'
    file_header.reference_code   = '11111111'
  end

  document.batch.tap do |batch|
    batch.type                   = :debit
    batch.odfi_id                = '11111111'
    batch.company_identification = '1111111111'
    batch.batch_number           = 1
    batch.effective_date         = Date.today
    batch.company_name           = 'ACME CORP FTW'
    batch.entry_description      = 'My Description'
    batch.entry_class_code       = 'WEB'
    batch.discretionary          = 'My Discretionary Data'

    # Now, for each credit/debit, generate an Entry ...
    batch << Headache::Record::Entry.new.tap do |entry|
      entry.routing_number   = '123456789'
      entry.account_number   = '1234567890'
      entry.amount           = -100_00 # $100.00 (negative, since we're debiting)
      entry.individual_name  = 'Bob Smith'

      # these fields are for your own tracking...
      entry.trace_number     = '1234567890'
      entry.internal_id      = '1234567890'
      entry.transaction_code = '1234567890'
    end
  end
end
```

Finally, you can generate the file:

```ruby
ach_doc.generate_to_file 'ACH.txt'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/teampayoff/headache.

## Authors

Made possible by all of our [contributors](https://github.com/teampayoff/headache/graphs/contributors).
