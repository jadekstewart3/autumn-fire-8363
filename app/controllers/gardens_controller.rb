class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @unique_plants = @garden.unique_plants_less_than_100_days
  end
end