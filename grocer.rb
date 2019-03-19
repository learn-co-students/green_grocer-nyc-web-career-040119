require 'pry'

def consolidate_cart(cart)
  # code here
  consolidate_cart = {}

  cart.each do |items|
    items.each do |item, hash|
      if consolidate_cart[item].nil?
        consolidate_cart[item] = hash
        consolidate_cart[item][:count] = 1
      else
        consolidate_cart[item][:count] += 1
      end #if
    end #items
  end #cart
  consolidate_cart
end

def apply_coupons(cart, coupons)
  # code here

  #a new key needs to be created from coupons
  #check if coupon is applicable to cart items

  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      cart[name][:count] = cart[name][:count] - coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {
          :price => coupon[:cost],
          :count => 1,
          :clearance => cart[name][:clearance]
        }
      end #if
    end #if
  end #coupons

  cart

end


def apply_clearance(cart)
  # code here
  #discount = 20%

  cart.each do |items|
    if items[1][:clearance]
      discount_price = items[1][:price] * 0.8
      items[1][:price] = discount_price.round(1)
    end#if
  end #cart
end

def checkout(cart, coupons)
  #code here
  #calculate total, price * count
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  total_price = [] #sum all array with array.inject(:+)
  cart3.each do |item, key|
    total_price << key[:price] * key[:count]
  end #cart3
  if total_price.inject(:+) > 100
    total_price.inject(:+) * 0.9
  else
    total_price.inject(:+)
  end
end
