RSpec.configure do |config|
  config.around do |example|
    if example.metadata[:freeze_time]
      Timecop.freeze(Time.now) { example.run }
    else
      example.run
    end
  end
end