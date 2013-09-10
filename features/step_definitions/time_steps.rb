def next_due_payload_before(time)
  queue = ResqueSpec.queue_by_name :high_scheduled
  queue.sort_by { |p| p[:time] }.detect { |p| p[:time] <= time }
end

def current_time=(time)
  time = time.is_a?(String) ? Time.zone.parse(time) : time
  THE_ACCOUNT.schedule_pings!

  if payload = next_due_payload_before(time)
    Timecop.freeze payload[:time]
    ResqueSpec.perform_scheduled :high_scheduled
    self.current_time = time
  else
    Timecop.freeze time
  end
end

def pass_time(minutes)
  self.current_time = minutes.to_i.minutes.from_now
end

##################################################

Given /^the date\/time is "([^"]*)"$/ do |date_time_string|
  self.current_time = date_time_string
end

##################################################

When /^(\d+) minutes? pass(es)?$/ do |mins, x|
  pass_time mins
end