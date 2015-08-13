RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) { FactoryGirl.lint }
end
