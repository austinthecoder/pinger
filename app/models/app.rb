class App
  def schedule_pings!
    Location.without_scheduled_ping.each &:schedule_ping!
  end

  def debug(*objects)
    objects.each do |object|
      lines = object.is_a?(String) ? object.split("\n") : [object.inspect]
      Rails.logger.tagged 'debug' do
        lines.each do |line|
          puts line.to_s
          Rails.logger.info line
        end
      end
    end
  end
end