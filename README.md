# Bedside Dashboard

## Install

1. Install the dashing ruby gem `gem install dashing`
2. Run `bundle install`

## Configuration

1. In `jobs/google_calendar_school.rb`, set the `ical_url` to point to the address of an calendar.
2. In `jobs/google_calendar_personal.rb`, set the `ical_url` to point to the address of an calendar.
3. In `jobs/gmail.rb`, set the `username` to your email address and `password`
   to the respective password for that email address. I STRONGLY recommend
   creating an application specific password for this in case you leak the
   password somehow.
4. In `jobs/verbinski.rb` set the `forecast_location_lat` to your current
   latitude and `forecast_location_long` to your current longitude. Go to
   http://developer.forecast.io and signup as a developer so you can get an api
   key.

## Run it
Execute `dashing start`


