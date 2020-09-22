require 'rails_helper'

RSpec.describe 'Edit Merchant Discount' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @discount_1 = @merchant_1.discounts.create!(minimum_quantity: 5, discounted_percentage: 20, discount_name: "Fall 5")
      @discount_2 =@merchant_1.discounts.create!(minimum_quantity: 10, discounted_percentage: 40, discount_name: "Fall 10")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)

    end
    describe "On my merchants discounts page I see every discount my merchant offers" do
      it "and next to each I see a link to edit the discount" do

        visit '/merchant/discounts'

        @merchant_1.discounts.each do |discount|
          within "#discount-#{discount.id}" do
            expect(page).to have_link('Edit Discount')
          end
        end
      end

      it "When I click an edit discount link I am taken to an edit form" do
        visit '/merchant/discounts'

        within "#discount-#{@discount_1.id}" do
          click_link('Edit Discount')
        end

        expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")
      end

      it "When I click an edit discount link I am taken to an edit form" do
        visit "/merchant/discounts/#{@discount_1.id}/edit"

        fill_in 'Minimum quantity', with: 7
        fill_in 'Discounted percentage', with: 25
        fill_in 'Discount name', with: 'Fall 7'
        click_button 'Update Discount'

        expect(current_path).to eq('/merchant/discounts')

        within "#discount-#{@discount_1.id}" do
          expect(page).to have_content('Name: Fall 7')
          expect(page).to have_content('Minimum Quantity: 7')
          expect(page).to have_content('Discounted Percentage: 25')
        end
      end

      it 'I can not edit the item with an incomplete form' do
        name = 'Fall 7'

        visit "/merchant/discounts/#{@discount_1.id}/edit"

        fill_in 'Discount name', with: name
        click_button 'Update Discount'

        expect(page).to have_content("minimum_quantity: [\"can't be blank\"]")
        expect(page).to have_content("discounted_percentage: [\"can't be blank\"]")
      end
    end
  end
end
