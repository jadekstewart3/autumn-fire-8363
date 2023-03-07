class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_plants_less_than_100_days
    plants.where('days_to_harvest < 100').distinct.pluck(:name)
  end
end
