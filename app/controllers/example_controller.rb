class ExampleController < ApplicationController
  before_filter :retrieve_from_session, except: :reset
  after_filter :store_to_session, except: :index

  def index
  end

  def reset
    puts "resetting"
    @counter = 0
    flash[:notice] = "Counter reset"
    redirect_to action: :index
  end

  def increase
    puts "increasing"
    calculate = CalculateNewCounterValue.new
    calculate.add_listener(self)
    calculate.for(@counter)
    flash[:notice] = "Incresed the counter, refresh to see results"
    redirect_to action: :index
  end

  def on_counter_value_calculated(context, new_value)
    @counter = new_value
    puts "callback counter: #{@counter}"
    store_to_session
  end

  private

  def retrieve_from_session
    @counter = session[:counter] || 0
    puts "retrieved counter: #{@counter}, for session: #{request.session_options[:id]}"
  end

  def store_to_session
    puts "storing counter: #{@counter}, for session: #{request.session_options[:id]}"
    session[:counter] = @counter
  end
end
