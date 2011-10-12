require 'resque_spec/scheduler'

Resque.inline = true

module ResqueSpecSchedulerExt
  def perform_scheduled(queue_name)
    queue = queue_by_name(queue_name)
    queue.each_with_index do |payload, i|
      if payload[:time] <= Time.now
        perform(queue_name, queue.delete_at(i))
      end
    end
  end
end

ResqueSpec.extend(ResqueSpecSchedulerExt)

Before do
  ResqueSpec.reset!
end