require 'rails_helper'

RSpec.describe 'Destroy Merchant Discount' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @discount_1 = @merchant_1.discounts.create!(minimum_quantity: 5, discounted_percentage: 20, discount_name: "Fall 5")
      @discount_2 =@merchant_1.discounts.create!(minimum_quantity: 10, discounted_percentage: 40, discount_name: "Fall 10")
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    describe "From my merchant discounts page" do
      it 'I can delete a discount from my discounts show page' do
        visit '/login'
        # save_and_open_page
        fill_in 'Email', with: 'megan@example.com'
        fill_in 'Password', with: 'securepassword'
        click_button 'Log In'

        visit '/merchant/discounts'

        within "#discount-#{@discount_1.id}" do
          click_link('Delete Discount')
        end


        expect(current_path).to eq('/merchant/discounts')
        expect(page).to have_css("#discount-#{@discount_2.id}")
        expect(page).to_not have_css("#discount-#{@discount_1.id}")
      end
    end
  end
end
