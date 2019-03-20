=begin
items = 
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}},
		{"AVOCADO" => {:price => 3.00, :clearance => true}}
	]
=end

def consolidate_cart(cart)
	final_arr = []
	new_cart = {}
	cart.each do |index|
		index.each do |key, value|
			if !new_cart[key]
				new_cart[key] = value
			end
			if !new_cart[key][:count]
				new_cart[key][:count] = cart.count(index)
			end
		end
	end
	new_cart
end

#consolidate_cart(items)

=begin
apply_cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

apply_coup = [
	{:item => "AVOCADO", :num => 2, :cost => 5.0}
]
=end

def apply_coupons(cart, coupons)
	coup = "W/COUPON"
	coupons.each do |coupon|
    food = coupon[:item]
	    if cart[food] && cart[food][:count] >= coupon[:num]
	      cart["#{food} #{coup}"] ? cart["#{food} #{coup}"][:count] += 1 : \
		      cart["#{food} #{coup}"] = {
		      	count: 1, 
		      	price: coupon[:cost], 
		      	clearance: cart[food][:clearance]
		      }
	      cart[food][:count] -= coupon[:num]
	    end
  end
  cart
end

#apply_coupons(apply_cart, apply_coup)

=begin
clear = {
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3},
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1},
}
=end

def apply_clearance(cart)
  cart.each do |item, key|
  	if key[:clearance] == true
  		key[:price] -= (key[:price] * 0.20)
  	end
  end
  cart
end

#apply_clearance(clear)

def checkout(cart, coupons)
  consol = consolidate_cart(cart)
  apply = apply_coupons(consol, coupons)
  clear = apply_clearance(apply)
  your_total = 0

  clear.each do |item, info|
  	your_total += info[:price] * info[:count]
  end
  your_total > 100 ? your_total -= your_total * 0.1 : your_total
end









