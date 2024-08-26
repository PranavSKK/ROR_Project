# app/channels/temperature_channel.rb
class TemperatureChannel < ApplicationCable::Channel
  def subscribed
    stream_from "temperature_channel"
  end
end
