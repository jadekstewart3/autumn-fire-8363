require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many(:plant_plots) }
    it { should have_many(:plots).through(:plant_plots) }
  end
end
