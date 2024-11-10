local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

local src = source
local Player = QBCore.Functions.GetPlayer(src)
local drugs = math.random(Config.MinDrugs, Config.MaxDrugs)

if Config.InventorySystem == 'ox' then
    RegisterNetEvent('Xotiic-Drugs:server:RecieveDrugs', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        ox_inventory:AddItem(src, Config.DrugStartItem, drugs)
        ox_inventory:AddItem(src, Config.DrugStartItem2, drugs)
        ox_inventory:AddItem(src, Config.DrugStartItem3, drugs)
    end)


    RegisterNetEvent('Xotiic-Drugs:server:FinishDrugDeal', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        ox_inventory:AddItem(src, Config.RewardItem, drugs, false)
        ox_inventory:AddItem(src, Config.RewardItem2, drugs, false)
        ox_inventory:AddItem(src, Config.RewardItem3, drugs, false)
        ox_inventory:RemoveItem(src, Config.DrugStartItem, drugs, false)
        ox_inventory:RemoveItem(src, Config.DrugStartItem2, drugs, false)
        ox_inventory:RemoveItem(src, Config.DrugStartItem3, drugs, false)
    end)
elseif Config.InventorySystem == 'qb' then
    RegisterNetEvent('Xotiic-Drugs:server:RecieveDrugs', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        exports['qb-inventory']:AddItem(src, Config.DrugStartItem, drugs, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem], 'add', drugs)
        exports['qb-inventory']:AddItem(src, Config.DrugStartItem2, drugs, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem2], 'add', drugs)
        exports['qb-inventory']:AddItem(src, Config.DrugStartItem3, drugs, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem3], 'add', drugs)
    end)

    RegisterNetEvent('Xotiic-Drugs:server:FinishDrugDeal', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        exports['qb-inventory']:AddItem(src, Config.RewardItem, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RewardItem], 'add')
        exports['qb-inventory']:AddItem(src, Config.RewardItem2, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RewardItem2], 'add')
        exports['qb-inventory']:AddItem(src, Config.RewardItem3, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RewardItem3], 'add')
        exports['qb-inventory']:RemoveItem(src, Config.DrugStartItem, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem], 'remove')
        exports['qb-inventory']:RemoveItem(src, Config.DrugStartItem2, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem2], 'remove')
        exports['qb-inventory']:RemoveItem(src, Config.DrugStartItem3, drugs, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[Config.DrugStartItem3], 'remove')
    end)
end