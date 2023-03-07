class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots
end
