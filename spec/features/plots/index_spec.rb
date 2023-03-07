require 'rails_helper'
RSpec.describe 'Plots Index Page' do
  describe 'As a visitor' do
    before :each do
      @garden = Garden.create!(name: "Turing Community Garden", organic: true)

      @plot_1 = @garden.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_2 = @garden.plots.create!(number: 26, size: "Medium", direction: "West")
      @tomato = Plant.create!(name: "Tomato", description: "Red", days_to_harvest: 100)
      @basil = Plant.create!(name: "Basil", description: "Green", days_to_harvest: 50)

      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @tomato.id)
      PlantPlot.create!(plot_id: @plot_1.id, plant_id: @basil.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @basil.id)
      PlantPlot.create!(plot_id: @plot_2.id, plant_id: @tomato.id)
      
      visit plots_path
    end
    context 'When I visit the plots index page' do

      it 'I see a list of all plot numbers and under that plot number I see all of the associated plants' do
        within("#plot-#{@plot_1.id}") do
          expect(page).to have_content("Plot number: #{@plot_1.number}")
          expect(page).to have_content(@tomato.name)
          expect(page).to have_content(@basil.name)
        end
        within("#plot-#{@plot_2.id}") do
          expect(page).to have_content("Plot number: #{@plot_2.number}")
          expect(page).to have_content(@tomato.name)
          expect(page).to have_content(@basil.name)
        end
      end

      it 'next to each plants name I see a link to remove that plant from that plot' do
        within("#plot-#{@plot_1.id}") do
          expect(page).to have_content("Plot number: #{@plot_1.number}")
          expect(page).to have_link("Remove #{@tomato.name}")
          expect(page).to have_content("Remove #{@basil.name}")
        end

        within("#plot-#{@plot_2.id}") do
          expect(page).to have_content("Plot number: #{@plot_2.number}")
          expect(page).to have_content("Remove #{@tomato.name}")
          expect(page).to have_content("Remove #{@basil.name}")
        end
      end

      it 'when I click on that link I am returned to the plots index page I no longer see that plant listed under that plot' do
        within("#plot-#{@plot_1.id}") do
          click_link "Remove #{@tomato.name}"

          expect(current_path).to eq(plots_path)
          
          expect(page).to have_content(@basil.name)
          expect(page).to have_content("Remove #{@basil.name}")

          expect(page).to_not have_content(@tomato.name)
          expect(page).to_not have_content("Remove #{@tomato.name}")
        end
       
        within("#plot-#{@plot_2.id}") do
          expect(page).to have_content("Plot number: #{@plot_2.number}")
          expect(page).to have_content(@tomato.name)
          expect(page).to have_content("Remove #{@tomato.name}")
          expect(page).to have_content(@basil.name)
          expect(page).to have_content("Remove #{@basil.name}")
        end
      end
    end
  end
end