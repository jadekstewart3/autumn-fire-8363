require 'rails_helper'
RSpec.describe 'Garden Show Page' do
  describe 'As a visitor' do
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
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @peppers.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @peppers.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @peppers.id)
      visit garden_path(@garden)
    end

    context 'When I visit a garden show page' do
      it "I see a list of plants that are in that garden's plots and that are unique, and take less than 100 days to harvest" do
        expect(page).to have_content(@garden.name)
        expect(page).to have_content("Turing Community Garden")
        expect(page).to have_content("Unique Plants in Garden:")

        within "#unique_plants" do
          expect(page).to have_content("Basil", count: 1)
          expect(page).to have_content("Jalapenos", count: 1)
          expect(page).to_not have_content("Tomato")
        end
      end

      it 'I see that list of plants is ordered by most to least common' do 
        within "#unique_plants" do
          expect("Jalapenos").to appear_before("Basil")
          expect(page).to have_content("Basil", count: 1)
          expect(page).to have_content("Jalapenos", count: 1)
          expect(page).to_not have_content("Tomato")
        end
      end
    end
  end
end