class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @popular_unique_plants = @garden.plants_by_popularity_less_than_100_days
  end
end