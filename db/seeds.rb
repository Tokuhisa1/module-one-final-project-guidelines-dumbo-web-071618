require_relative '../config/environment'

hanz = Character.create(name: "hanz")
natsuki = Character.create(name: "natsuki")
#tyrell = Character.create(name: "tyrell")

#potion1 = Item.create_potion(name: "elixir", healing:10)


axe = Item.create_weapon(name: "Blood Axe",attack: 5)

samurai_sword = Item.create_weapon(name:"Sword of Souls",attack: 20)
#stick = Item.create_weapon(name: "stick of oak",attack: 1)

natsuki.add_item(samurai_sword)
hanz.add_item(samurai_sword)
hanz.add_item(axe)
