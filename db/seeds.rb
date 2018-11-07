require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all
Address.destroy_all

admin = create(:admin)
user = create(:user)
merchant_1 = create(:merchant)
user_2 = create(:user, active: false)
user_3 = create(:user)
user_4 = create(:user)

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

address_1 = create(:address, user: admin)
address_2 = create(:address, user: user)
address_3 = create(:address, user: merchant_1)
address_4 = create(:address, user: user_2)
address_5 = create(:address, user: user_3)
address_6 = create(:address, user: user_4)
address_7 = create(:address, user: merchant_2)
address_8 = create(:address, user: merchant_3)
address_9 = create(:address, user: merchant_4)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
create_list(:item, 10, user: merchant_1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:completed_order, user: admin)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:completed_order, user: user_4)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
