class CalculateNewCounterValue
  def for(counter)
    Thread.new { calculate(counter) }
    counter
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event_name, *args)
    puts "notifying listeners"
    @listeners && @listeners.each do |listener|
      puts "notifying #{listener.class}"
      if listener.respond_to?(event_name)
        listener.public_send(event_name, self, *args)
      end
    end
  end

  private

  def calculate(counter)
    sleep(1)
    new_value = (counter || 0) + 1
    puts "new value: #{new_value}"
    notify_listeners(:on_counter_value_calculated, new_value)
    new_value
  end
end
