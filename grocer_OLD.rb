require "pry"


def consolidate_cart(cart)
  consolidated_cart_hash = {}
  cart.each do |item|
      count = cart.count(item)
    item.each do |name,details|
      new_details_hash = details.merge({:count=>count})
      new_item = {name => new_details_hash}
      consolidated_cart_hash = new_item.merge(consolidated_cart_hash)
    end
  end

  return consolidated_cart_hash

end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|

    cart.each do |item_name,item_details|

      if item_name == coupon[:item] && item_details[:count] <= coupon[:num]
        # at this point we know coupon can be applied.









end
end
end
end


#&& item_details[:count] >= coupon[:num]
def apply_clearance(cart)
  cart.each do |item_name,item_details|

    if item_details[:clearance] == true
      # at this point we know coupon can be applied
        coupons.each do |coupon|
          if item_name == coupon[:item]
            #at this point we know the coupn is for the item
            if item_details[:count] == coupon[:num]
            binding.pry
            discounted_item = {"#{item} W/COUPON" => }


            elsif item_details[:count] < coupon[:count]


            end
          end
        end
      end
    end
end

def checkout(cart, coupons)
  # code here
end
