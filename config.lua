Config = {}
Config.InventorySystem = 'ox' -- Supports 'qb' & 'ox'

Config.DrugHitsDeliveryPed = {
    {
        DrugHitsDeliveryPedModel = 'mp_f_meth_01',
        DrugHitsDeliveryPedLocation = vector3(370.17, -817.3, 28.29),
        DrugHitsDeliveryRenderDistance = 5,
    }
  }

Config.DrugStartItem = 'weed_brick' -- item thats given when u start a deal
Config.DrugStartItem2 = 'coke_brick' -- item thats given when u start a deal
Config.DrugStartItem3 = 'meth_brick' -- item thats given when u start a deal

  Config.DeliveryLocations = {
    ['deliveryroute'] = {
      [1] = {
        name = "grovestreet",
        coords = vector4(76.34, -1948.13, 21.17, 51.65),
      },
      [2] = {
        name = "motel",
        coords = vector4(-35.63, -1555.33, 30.68, 133.71),
      },
      [3] = {
        name = "gsf",
        coords = vector4(-186.35, -1701.66, 32.83, 133.94),
      },
      [4] = {
        name = "legion",
        coords = vector4(322.06, -822.59, 29.27, 257.63),
      },
      [5] = {
        name = "mg",
        coords = vector4(1380.25, -1743.97, 65.32, 116.58),
      },
    }
  }
  
  Config.MinDrugs = 10 -- Min amount of Drugs  for Deal this also changes the amount of drugs u get after u take it to the trap house
  Config.MaxDrugs = 15 -- Min amount of Drugs  for Deal this also changes the amount of drugs u get after u take it to the trap house
  
  Config.RewardItem = 'weed_purplehaze' -- item thats given when u complete a deal
  Config.RewardItem2 = 'cokebaggy' -- item thats given when u complete a deal
  Config.RewardItem3 = 'meth' -- item thats given when u complete a deal