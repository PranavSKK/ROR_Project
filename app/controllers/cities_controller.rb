# app/controllers/cities_controller.rb
class CitiesController < ApplicationController
  def index
    @cities = City.includes(:temperatures).all
  end

  def show
    @city = City.find(params[:id])
    @temperatures = @city.temperatures.order(date: :desc).limit(7)
  end
end
