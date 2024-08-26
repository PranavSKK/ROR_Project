# app/jobs/update_temperatures_job.rb
class UpdateTemperaturesJob < ApplicationJob
  queue_as :default

  def perform
    City.find_each do |city|
      temperature = WeatherService.new(city).fetch_temperature
      city.temperatures.create!(date: Date.today, temperature: temperature)
    end
  rescue StandardError => e
    Rails.logger.error "Failed to update temperatures: #{e.message}"
  end
end
