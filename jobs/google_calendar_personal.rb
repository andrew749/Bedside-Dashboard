require 'icalendar'

ical_url = 'https://calendar.google.com/calendar/ical/andrewcod749%40gmail.com/private-0f848abef314f80c11a86f475734199c/basic.ics'
uri = URI ical_url
puts 'Loading Personal Calendar'
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

  send_event('google_calendar_personal', { events: events })
end
