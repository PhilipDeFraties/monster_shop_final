class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      # grand_total += Item.find(item_id).price * quantity
      grand_total += subtotal_of(item_id)
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * adjusted_price(item_id)
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def find_discount(item_id, quantity)
    @discount = Item.find(item_id).discounts.where('minimum_quantity <= ?', quantity).order(:minimum_quantity).last
  end

  def apply_discount(item_id, discount)
    ((100 - discount) * 0.01) * Item.find(item_id).price
  end

  def adjusted_price(item_id)
    if find_discount(item_id, count_of(item_id))
      apply_discount(item_id, @discount.discounted_percentage)
    else
      Item.find(item_id).price
    end
  end
end
