# app/workers/update_weather_worker.rb
class UpdateWeatherWorker
    include Sidekiq::Worker
    
    def perform(city_id)
      city = City.find(city_id)
      weather_service = WeatherService.new(city)
      temperature = weather_service.fetch_temperature
    
      retries ||= 0
      begin
        # Find or initialize the temperature record for today
        temperature_record = city.temperatures.find_or_initialize_by(date: Date.today)
        temperature_record.temperature = temperature
    
        # Save the temperature record
        temperature_record.save!
      rescue ActiveRecord::StatementInvalid => e
        if e.message.include?('database is locked') && retries < 3
          retries += 1
          sleep 1 # Wait before retrying
          retry
        else
          raise e
        end
      end
    
      # Broadcast the new temperature data to the ActionCable channel
      ActionCable.server.broadcast "temperature_channel", {
        city: city.name,
        date: Date.today.strftime('%Y-%m-%d'),
        temperature: temperature
      }
  
      # Schedule the worker to run again after 10 seconds
      self.class.perform_in(120.seconds, city_id)
    end
  end
  