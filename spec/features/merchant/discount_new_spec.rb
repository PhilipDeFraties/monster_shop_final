require 'rails_helper'

RSpec.describe 'New Merchant Discount' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end
    it 'When I click the new discount link I am taken to a new discount form' do
      visit '/merchant/discounts'
      click_link 'New Discount'

      expect(current_path).to eq('/merchant/discounts/new')
    end

    it "I can create a new discount for a merchant" do
      min_quantity = 20
      discounted_percentage = 5
      discount_name = 'Fall Discount'

      visit "/merchant/discounts/new"
      fill_in 'Minimum quantity', with: min_quantity
      fill_in "Discounted percentage", with: discounted_percentage
      fill_in "Discount name", with: discount_name
      click_button 'Create Discount'
      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_content("Fall Discount")
    end
  end
end
