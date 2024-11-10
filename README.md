# Xotiic-DrugDealing
Fivem Custom QBCore Drug Dealing Scripts That Allows Players To Speak To A Npc To Get A Mission To deliver To A Trap House

- Highly Customisable Within The Config.lua
- Locations Can Be Changed For Delivery Via Config

- Features Of The Script
- items u get from starting the mission can be changed via the config.lua
- items u can get from delivering the drugs can be changed in the config.lua
- npc model location and render distance can be changed in the config.lua 
- sends a blip and waypoint to playes gps of drop of spot
- supports ox_inventory and qb-inventory can change in the config

## Video Previews
- https://streamable.com/4zqah6
- https://www.youtube.com/watch?v=dhAHBakAKnc

## Dependencies
- ox_lib https://github.com/overextended/ox_lib
- qb-target or ox_target
- qb-inventory or ox_inventory

# How to install
 
- Drag and drop folder into ur resources folder
- add this to ur server.cfg
```
ensure Xotiic-DrugsDealing
```
### Item installation
- uses base qb weed and coke brick but can also be changed to ur own items through the config.lua

### My Discord
- https://discord.gg/ZkP8mr9c

### My Youtube
- https://www.youtube.com/@Xotiic-scripts



### Item installation

- add these to ur ox_inventory/data/items.lua
```lua
-- Xoticc-DrugItems
	["mystry_package"] = {
		label = "Sus Package",
		weight = 1000,
		stack = true,
		close = true,
		description = "Heavy package of Drugs,",
		client = {
			image = "mystry_package.png",
		}
	},
```

- add these to ur qb-core/shared/items.lua if using qb-inventory
```lua
-- Xoticc-DrugItems
['mystry_package'] 	         			 = {['name'] = 'mystry_package', 						['label'] = 'Sus Package', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'mystry_package.png', 				['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sus Package?'},
```


### Adding Images

- go to the images folder and add the image into ox_inventory/web/images for ox_inventory
- go to images folder and add the image to qb-inventory/html/images for qb-inventory
