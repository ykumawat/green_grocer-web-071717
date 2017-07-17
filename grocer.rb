def consolidate_cart(cart)
  # code here
  cartkeys = {}

  cart.each do |e|
    count = 1
    e.each do |key, value|
      if cartkeys[key]
        cartkeys[key][:count] += 1
      else
        cartkeys[key] = value
        cartkeys[key][:count] = count
      end
    end
  end
  cartkeys
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |e|
    item = e[:item]
    discountitem = "#{item} W/COUPON"
    if cart.key?(item) && cart[item][:count] >= e[:num]
      cart[item][:count] = cart[item][:count] - e[:num]
      if cart[discountitem]
        cart[discountitem][:count] += 1
      else
        cart[discountitem] = {
          price: e[:cost],
          clearance: cart[item][:clearance],
          count: 1
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance]
      value[:price] = value[:price] * 0.80
      value[:price] = value[:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  newcart = consolidate_cart(cart)
  newcart2 = apply_coupons(newcart, coupons)
  newcart3 = apply_clearance(newcart2)
  total = 0.0
  newcart3.each do |key, value|
    total += value[:price] * value[:count]
  end

  if total > 100
    total = total * 0.9
  end
  total
end
