require 'rails_helper'

RSpec.describe Discount do
  describe 'Relationships' do
    it {should belong_to :merchant}
  end
    describe 'Validations' do
      it {should validate_presence_of :minimum_quantity}
      it {should validate_presence_of :discounted_percentage}
      it {should validate_presence_of :discount_name}
    end
end
