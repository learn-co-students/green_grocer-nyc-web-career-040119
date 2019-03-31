require 'pry'

def consolidate_cart(cart)
n_cart = {}
  cart.each do |item|
    item.each do |name , prod_info|
   # binding.pry
      if !n_cart[name] # if does not contain name, insert key-value pair
        n_cart[name] = prod_info
      end 
      if !n_cart[name][:count]
        n_cart[name][:count] = cart.count(item)
      end
  end 
end 
  #binding.pry
  n_cart
end

def apply_coupons(cart, coupons)
coupons.each do |coupon| #{:item=>"AVOCADO", :num=>2, :cost=>5.0}
#cart ["AVOCADO", {:price=>3.0, :clearance=>true, :count=>2}]

  if cart[coupon[:item]] && cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item] + " W/COUPON"] = {
       :price => coupon[:cost] , 
       :clearance => cart[coupon[:item]][:clearance] ,
       :count => cart[coupon[:item]][:count]/coupon[:num] }
    cart[coupon[:item]][:count] %= coupon[:num]
  end 
end 
cart
end

def apply_clearance(cart)
  clearance = 0.8
  cart.each do |name,info|
    #binding.pry
   if info[:clearance] == true
    info[:price] = (info[:price] * 0.8).round(2)
   end 
   cart
  end 
  
end

def checkout(cart, coupons)
  cart_total = 0
cart = consolidate_cart(cart)
cart = apply_coupons(cart, coupons)
cart = apply_clearance(cart)
cart.each do |item,info|
  #binding.pry
  cart_total += info[:price] * info[:count]
end 
 if cart_total > 100
   cart_total *= 0.9
 end 
 cart_total
end
