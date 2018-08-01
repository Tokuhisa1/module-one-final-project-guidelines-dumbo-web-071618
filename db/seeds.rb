require_relative '../config/environment'
#
# hanz = Character.create(name: "hanz")
# natsuki = Character.create(name: "natsuki")
# #tyrell = Character.create(name: "tyrell")
#
# #potion1 = Item.create_potion(name: "elixir", healing:10)
#
isiah = Character.create(name: "isiah")
staff = Item.create_weapon(name: "Void Staff",attack: 15)
isiah.add_item(staff)
#
# axe = Item.create_weapon(name: "Blood Axe",attack: 5)
#
# samurai_sword = Item.create_weapon(name:"Sword of Souls",attack: 20)
# lance_of_justice = Item.create_weapon(name:"Lance of Justice",attack: 40)
#
# #stick = Item.create_weapon(name: "stick of oak",attack: 1)
#
# natsuki.add_item(lance_of_justice)
# hanz.add_item(samurai_sword)
# hanz.add_item(axe)
