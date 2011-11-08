opts = {
  cucumber_env: {'RAILS_ENV' => 'test'},
  rspec_env: {'RAILS_ENV' => 'test'},
  wait: 60
}
guard 'spork', opts do
  watch 'config/application.rb'
  watch 'config/environment.rb'
  watch 'config/routes.rb'
  watch %r{^config/environments/.+\.rb$}
  watch %r{^config/initializers/.+\.rb$}
  watch 'Gemfile'
  watch 'Gemfile.lock'
  watch 'spec/spec_helper.rb'
  watch %r{^spec/support/.+\.rb$}
  watch 'test/test_helper.rb'
  watch 'lib/test_support/factories.rb'
end
