class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def plants_by_popularity_less_than_100_days
    plants
    .joins(:plant_plots)
    .group(:name).where('days_to_harvest < 100')
    .order('count(plant_plots.id) desc')
    .pluck(:name)
  end
end
