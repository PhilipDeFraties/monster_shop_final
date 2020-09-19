require 'rails_helper'

RSpec.describe 'New Merchant Discount' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end
    it "I see a link on my merchant dashboard to make a new discount" do
      visit '/merchant'

      expect(page).to have_link('New Discount')
    end

    it 'When I click the new discount link I am taken to a page with a form' do
      visit '/merchant'
      click_link 'New Discount'

      expect(current_path).to eq('/merchant/discounts/new')
    end
  end
end
