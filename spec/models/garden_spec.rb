require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }

    before (:each) do
      @garden = Garden.create!(name: "Turing Community Garden", organic: true)

      @plot_1 = @garden.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_2 = @garden.plots.create!(number: 26, size: "Medium", direction: "West")
      @tomato = Plant.create!(name: "Tomato", description: "Red", days_to_harvest: 100)
      @basil = Plant.create!(name: "Basil", description: "Green", days_to_harvest: 50)
      @peppers = Plant.create!(name: "Jalapenos", description: "Also Green", days_to_harvest: 50)

      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @tomato.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @tomato.id)
      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @basil.id)
      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @basil.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @basil.id)
      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @peppers.id)
      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @peppers.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @peppers.id)
    end

    it 'returns unique plants that take less than 100 days to harvest' do
      expect(@garden.unique_plants_less_than_100_days).to eq([@basil.name, @peppers.name])
      expect(@garden.unique_plants_less_than_100_days).to_not eq([@tomato.name, @basil.name, @peppers.name])
    end
  end
end
