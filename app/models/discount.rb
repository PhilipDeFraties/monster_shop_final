class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :minimum_quantity,
                        :discounted_percentage,
                        :discount_name
end
