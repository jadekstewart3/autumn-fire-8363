require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end
end
