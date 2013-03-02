require 'icalendar'

class Ical
  include Icalendar
  include Rails.application.routes.url_helpers


  def initialize(events = [], user = User.new)
    @calendar = Calendar.new
    @user = user

    add_events(events) if events

    @calendar
  end

  def add_events(events)
    events.each do |e|
      @calendar.custom_property('X-WR-CALNAME', 'NowPlayUs - '+@user.username)

      @calendar.event do
        # Add all basic data
        dtstart       e.starts_at.to_datetime
        dtend         (e.starts_at+e.duration).to_datetime
        last_modified e.updated_at.to_datetime

        summary       "NowPlayUs: " + e.title + " on " + e.platform.name
        description   "Jump on your " + e.platform.name + " and play some " + e.title
        url           'http://www.nowplay.us/events/' + e.id.to_s
        klass         "PRIVATE"

        # Set an alarm for 30 minutes before events starts
        alarm do
          action        "AUDIO"
          trigger       "-PT30M"
        end

      end
    end
    @calendar.publish
  end


  def to_s
    @calendar.to_ical
  end
end