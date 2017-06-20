#!/usr/bin/env ruby

require 'bigdecimal'
require './lib/file_loader'
require './lib/input_parser'
include FileLoader
require_all('/../models/*.rb')

orders = InputParser.orders_file(InputParser.data_dir + 'orders')

opera_house = Item.find('OH')
bridge_climb = Item.find('BC')
sky_tower = Item.find('SK')

promotion_1 = Promotion.new
promotion_1.add_qualifier(opera_house, 3)
promotion_1.add_effect("3 for 2 Deal on #{opera_house.name} Tickets", opera_house.price)


promotion_2 = Promotion.new
promotion_2.add_qualifier(opera_house, 1)
promotion_2.add_qualifier(sky_tower, 1)
promotion_2.add_effect("Free #{sky_tower.name} with every #{opera_house.name}", sky_tower.price)


promotion_3 = Promotion.new(apply_amount_for_each_match: false)
promotion_3.add_qualifier(bridge_climb, 4)
order = orders.last
line_item = order.line_items[bridge_climb.id]
total_discount = line_item.quantity * 20
promotion_3.add_effect("Bridge Climb Bulk Discount", total_discount)



orders.each do |order|
    
  order.add_adjustments(promotion_1.process_order(order.line_items))
  order.add_adjustments(promotion_2.process_order(order.line_items))
  order.add_adjustments(promotion_3.process_order(order.line_items))
  
  puts "------------------\n\n"
  puts order.print_total
  puts "\n"
  
  
end
