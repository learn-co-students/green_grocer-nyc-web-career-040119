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


def apply_coupons(cart,coupons)
  coupon_item_names = []
  coupons.each do |coupon|
      coupon_item_names << coupon[:item]
  end
  # make array of coupon items to check if a coupon exists for item. if not, add item to updated_cart hash.
  updated_cart = {}
  final_couponed_cart = {}
  total_applied_coupon_count = 0
  i = 0
  while i < cart.length
    #if total_applied_coupon_count > 1 || i == 0
    cart.each do |item_name,item_details|
      couponed_cart = {}
      applied_current_coupon_count = 0
      if coupon_item_names.include?(item_name)
        total_applied_coupon_count += 1
        #applied_current_coupon_count = 0
        # coupon exists that can be applied
        coupons.each_with_index do |coupon,index|
          # set applied_coupon_count to be used to figure out non_couponed_item count
          #applied_current_coupon_count = 0
          # find valid coupon
          if item_name == coupon[:item]
            # coupon and item match; apply coupon
            if item_details[:count] >= coupon[:num]
              # if cart item count is greater than num needed for coupon; apply coupon, edit orig item count
              applied_current_coupon_count += 1

              # apply coupon and create couponed item hash
              couponed_item_details = {:price => coupon[:cost], :clearance => item_details[:clearance], :count => applied_current_coupon_count}
              couponed_item = {"#{item_name} W/COUPON" => couponed_item_details}
              couponed_cart = couponed_item.merge!(couponed_cart)

              # edit orig item with new count
              non_couponed_item_count = (item_details[:count] - (applied_current_coupon_count * (coupon[:num])))

              non_couponed_item_count_hash = {:count => non_couponed_item_count}

              new_non_couponed_item_details = item_details.merge!(non_couponed_item_count_hash)
            end

          end
        end
        final_couponed_cart = final_couponed_cart.merge!(couponed_cart)
      #else
        # coupon cannot be applied
        #no_coupon_item = {item_name => item_details}
        #final_couponed_cart = couponed_cart.merge!(no_coupon_item)
      end
      #final_couponed_cart = final_couponed_cart.merge!(final_couponed_cart)
    end # end of cart iteration
  #end
    cart.merge!(final_couponed_cart)

    i +=1
  end #end while loop

  #cart.delete_if do |item_name,item_details|
  #  item_details[:count] == 0
  #end

  return cart
end #apply_coupons method end