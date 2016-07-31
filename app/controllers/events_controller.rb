require "business_days"

class EventsController < ApplicationController
  def index
    business_days = BusinessDays.new(params[:start], params[:end], :pl)

    render json: {
      events: business_days.events,
      month: business_days.current_month,
      business_days: business_days.business_days
    }
  end
end
