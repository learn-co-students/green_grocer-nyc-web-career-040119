require "pry"


def consolidate_cart(cart)
  consolidated_cart_hash = {}
  cart.each do |item|
      count = cart.count(item)
    item.each do |name,details|
      new_details_hash = details.merge({:count=>count})
      new_item = {name => new_details_hash}
      consolidated_cart_hash = new_item.merge!(consolidated_cart_hash)
    end
  end
  cart = consolidated_cart_hash

  return cart#consolidated_cart_hash

end

def apply_coupons(cart, coupons)

  total_applied_coupon_count = 0
  updated_cart = {}
  final_cart = ''
  coupon_names = []
  if coupons.length > 0

    coupons.each do |coupon|
      coupon_names << coupon[:item]
    end

    cart.each do |item_name,item_details|
      #binding.pry
      couponed_cart = {}
        coupons.each_with_index do |coupon,index|
          applied_coupon_count = 0
          #binding.pry
            if item_name == coupon[:item] && coupon_names.include?(item_name)
            # at this point we know this coupon can be applied
              total_applied_coupon_count += 1

              if item_details[:count] == coupon[:num]
                applied_coupon_count += 1
                # if item count matches coupon num, create couponed_item and add to new cart
                couponed_item_details = {:price => coupon[:cost], :clearance => item_details[:clearance], :count => applied_current_coupon_count}
                couponed_item = {"#{item_name} W/COUPON" => couponed_item_details}
                couponed_cart = couponed_item.merge!(couponed_cart)

                
                couponed_item_details = {:price => coupon[:cost], :clearance => item_details[:clearance], :count => applied_coupon_count}
                couponed_item = {"#{item_name} W/COUPON" => couponed_item_details}
                couponed_cart = couponed_item.merge!(couponed_cart)
                #updated_cart =  updated_cart.merge!(couponed_cart)
              elsif item_details[:count] > coupon[:num]
                applied_coupon_count += 1
                # if item count is higher than coupon num, create couponed_item and non_ couponed_item with orig details and updated count
                couponed_item_details = {:price => coupon[:cost], :clearance => item_details[:clearance], :count => applied_coupon_count}
                couponed_item = {"#{item_name} W/COUPON" => couponed_item_details}
                couponed_cart = couponed_item.merge!(couponed_cart)

                non_couponed_item_details = {:price => item_details[:price], :clearance => item_details[:clearance], :count => ((item_details[:count]) - (coupon[:num]))}
                non_couponed_item = {"#{item_name}" => non_couponed_item_details}
                couponed_cart = non_couponed_item.merge(couponed_cart)
                #updated_cart =  updated_cart.merge!(couponed_cart)
              end # end of applying coupon specifics

              updated_cart =  updated_cart.merge!(couponed_cart)
            elsif item_name != coupon[:item] && coupon_names.include?(item_name)
              final_cart = "blah, blah, blah"
            elsif item_name != coupon[:item] && coupon_names.include?(item_name) == false
            #  binding.pry
              # at this point we know this coupon cannot be applied
              non_couponed_item_details = {:price => item_details[:price], :clearance => item_details[:clearance], :count => item_details[:count]}
              non_couponed_item = {"#{item_name}" => non_couponed_item_details}
              couponed_cart = non_couponed_item.merge!(couponed_cart)
              #updated_cart =  updated_cart.merge!(couponed_cart)

            end # end of applying coupon
              updated_cart =  updated_cart.merge!(couponed_cart)
          #binding.pry
        end

        #updated_cart =  updated_cart.merge!(couponed_cart)
        #binding.pry
      end #check if coupons can be applied again
  else
    return cart
  end
    cart = updated_cart
end # apply_coupons method end



def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
