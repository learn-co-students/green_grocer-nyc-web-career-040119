require 'pry'
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |name, attributes|
      if !new_hash[name]
        new_hash[name] = attributes
        new_hash[name][:count] = 1
      elsif new_hash[name]
        new_hash[name][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {
          :count => 1,
          :price => coupon[:cost]
        }
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[1][:clearance]
      new_price = item[1][:price] * 0.8
      item[1][:price] = new_price.round(1)
    end
  end
end

def checkout(cart, coupons)
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  price_array = []
  cart3.each do |name, attributes|
    price_array << attributes[:price] * attributes[:count]
  end
  if price_array.inject(:+) > 100
    price_array.inject(:+) * 0.9
  else
    price_array.inject(:+)
  end
end
