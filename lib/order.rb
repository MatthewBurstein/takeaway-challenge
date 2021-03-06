require_relative './restaurant.rb'
require_relative './checkout.rb'

class Order

  attr_reader :menu, :basket

  def initialize(restaurant = Restaurant.new)
    @menu = restaurant.menu
    @basket = {}
  end

  def add(item, quantity)
    item = item.to_sym
    raise "Item not on menu" unless @menu.has_key?(item)
    @basket[item] += quantity if @basket.has_key?(item)
    @basket[item] = quantity unless @basket.has_key?(item)
    string_formatter(item, quantity)
  end

  def basket_summary
    raise "Basket empty" if @basket.empty?
    @basket.to_a
      .map { |arr| string_formatter(arr[0], arr[1]) }
      .join(", ")
  end

  def total
    amount = @basket.map { |item, quantity| quantity * menu[item] }.inject(&:+)
    "£#{amount}"
  end

  def checkout(checkout_class = Checkout)
    total_float = total.delete("£").to_f
    checkout_class.new(total_float)
  end

  private

  def string_formatter(item, quantity)
    "#{quantity} x #{item} = £#{quantity * @menu[item.to_sym]}"
  end

end
