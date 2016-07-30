class EventsController < ApplicationController
  def index
    from = Date.parse(params[:start])
    to = Date.parse(params[:end])

    events = Holidays.between(from, to, :pl).each do |event|
      event[:title] = event[:name]
      event[:start] = event[:date]
      event[:allDay] = true
    end

    render json: events
  end
end
