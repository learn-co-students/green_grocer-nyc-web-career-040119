def consolidate_cart(cart)
  cart_item = {}
  cart.each do |item|
    item.each do |name, data|
      if cart_item[name] == nil
        cart_item[name] = data
        cart_item[name][:count] = 1
      else
        cart_item[name][:count] += 1
      end
    end
  end
  cart_item
end

def apply_coupons(cart, coupons)

  after_coupon = {}

  if coupons == nil || coupons.empty?
    after_coupon = cart
  end

  coupons.each do |coupon|
    cart.each do |name, data|
      if name == coupon[:item]
        count = data[:count] - coupon[:num]

        if count >= 0
          if after_coupon["#{name} W/COUPON"] == nil
            after_coupon["#{name} W/COUPON"] = {:price => coupon[:cost], :clearance => data[:clearance], :count => 1}
          else
            couponcount = after_coupon["#{name} W/COUPON"][:count] + 1
            after_coupon["#{name} W/COUPON"][:count] = couponcount
          end
        else
          count = data[:count]
        end

        after_coupon[name] = data
        after_coupon[name][:count] = count
      else
        after_coupon[name] = data
      end
    end
  end
  after_coupon
end

def apply_clearance(cart)
  cart.each do |item, data|
    if data[:clearance] == true
      discount = data[:price] * 0.8
      data[:price] = discount.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0

  cart.each do |item, data|
    total += data[:price] * data[:count]
  end

  if total > 100
    total = total * 0.9
  end
  total
end
