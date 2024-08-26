# config/schedule.rb
every 1.hour do
    rake "weather:update"
end
  