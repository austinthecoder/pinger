RSpec.configure do |config|
  config.include ActionView::TestCase::Behavior,
    :example_group => {:file_path => %r{spec/presenters}}
end