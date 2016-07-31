class BusinessDays
  attr_reader :from, :to, :country, :events, :current_month, :current_year

  def initialize(from, to, country)
    @from = Time.zone.at(from.to_i).to_date
    @to = Time.zone.at(to.to_i).to_date

    @country = country
    @events = load_events
    @current_month = find_current_month
    @current_year = find_current_year
  end

  def business_days
    (first_day_of_month..last_day_of_month).to_a.count { |day| [1, 2, 3, 4, 5].include?(day.wday) }
  end

  private

  def load_events
    Holidays.between(from, to, country).each do |event|
      event[:title] = event[:name]
      event[:start] = event[:date]
      event[:allDay] = true
    end
  end

  def find_current_month
    months = (from..to).to_a.group_by(&:month).map { |k, v| [k, v.count] }
    Hash[*months.flatten].max_by { |_, v| v }[0]
  end

  def find_current_year
    from.year
  end

  def first_day_of_month
    Date.new(current_year, current_month, 1)
  end

  def last_day_of_month
    Date.new(current_year, current_month, -1)
  end
end
