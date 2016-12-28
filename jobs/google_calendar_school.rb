require 'icalendar'

ical_url = 'https://calendar.google.com/calendar/ical/tvtg4v7g598t53krltk53s95do%40group.calendar.google.com/public/basic.ics'
uri = URI ical_url
puts 'Loading School Calendar'
SCHEDULER.every '15s', :first_in => 4 do |job|
    result = Net::HTTP.get uri
    calendars = Icalendar.parse(result)
    calendar = calendars.first
    events = calendar.events.map do |event|
        {
            start: event.dtstart,
            end: event.dtend,
            summary: event.summary
        }
    end.select { |event| event[:start] > DateTime.now }

    events = events.sort { |a, b| a[:start] <=> b[:start] }

    events = events[0..5]

    send_event('google_calendar_school', { events: events })
end
