class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :minimum_quantity
      t.integer :discounted_percentage
      t.string :discount_name
    end
  end
end
