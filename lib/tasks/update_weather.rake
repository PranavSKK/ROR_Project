namespace :weather do
    desc "Update weather data for all cities"
    task update: :environment do
      City.find_each do |city|
        UpdateWeatherWorker.perform_async(city.id)
      end
    end
  end
  