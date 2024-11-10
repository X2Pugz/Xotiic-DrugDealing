local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local inJob = false


local function FetchModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

local LocalNPCs = {}

local function GetLocalNPC(index)
    return LocalNPCs[index]
end

local function CreateLocalNPC(index)
    if (LocalNPCs[index]) then
        DestroyLocalNPC(index)
    end

    LocalNPCs[index] = {}
    local cfg = Config.DrugHitsDeliveryPed[index]

    FetchModel(cfg.DrugHitsDeliveryPedModel)


    local DrugHitsDeliveryPed = CreatePed(1, cfg.DrugHitsDeliveryPedModel, cfg.DrugHitsDeliveryPedLocation, false, true)
    FreezeEntityPosition(DrugHitsDeliveryPed, true)
    SetEntityInvincible(DrugHitsDeliveryPed, true)
    SetBlockingOfNonTemporaryEvents(DrugHitsDeliveryPed, true)
    SetPedComponentVariation(DrugHitsDeliveryPed, 3, 0, 0, 1)
    SetPedComponentVariation(DrugHitsDeliveryPed, 4, 0, 0, 1)
    SetPedComponentVariation(DrugHitsDeliveryPed, 6, 0, 0, 1)
    SetPedComponentVariation(DrugHitsDeliveryPed, 0, 1, 0, 1)
    ----- | CREATING TARGET FOR PED | -----
        exports['qb-target']:AddTargetEntity(DrugHitsDeliveryPed, {
            options = {
                {
                    type = "client",
                    event = "Xotiic-Drugs:client:DeliveryStartAlert",
                    icon = "fa-solid fa-cannabis",
                    label = "Drug Dealer",
                },
            },
            distance = 1.5,
        })
    LocalNPCs[index].DrugHitsDeliveryPed = DrugHitsDeliveryPed
end


local function DestroyLocalNPC(index)
    if (LocalNPCs[index]) then
        DeleteEntity(LocalNPCs[index].DrugHitsDeliveryPed)
        LocalNPCs[index] = nil
    end
end


Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId() 
        local pcoords = GetEntityCoords(ped)
        for i=1, 1 do 
            local cfg = Config.DrugHitsDeliveryPed[i]
            local coords = vector3(cfg.DrugHitsDeliveryPedLocation)
            local dist = #(pcoords - coords)
            local DrugHitsDeliveryPed = GetLocalNPC(i)
            if dist < cfg.DrugHitsDeliveryRenderDistance then 
                if (GetLocalNPC(i) == nill) then 
                  CreateLocalNPC(i)
                end 
            else 
                DestroyLocalNPC(i)
            end 
        end
      Wait(wait)
    end
end)

RegisterNetEvent('Xotiic-Drugs:client:DeliveryStartAlert', function()
    if inJob == false then
        local drugalert = lib.alertDialog({
            header = 'Drug Deal?',
            content = 'Are you sure you would like Drug Deal?',
            centered = true,
            size = 'xs',
            cancel = true,
            labels = {
                cancel = 'No',
                confirm = 'Yes',
            },
        })
        if drugalert == 'confirm'  then
            TriggerEvent('Xotiic-Drugs:client:RecieveDelivery')
        elseif drugalert == 'cancel' then
            lib.notify({
                id = 'drug_hits',
                title = 'Drug Deal?',
                description = 'Hows Ur Dealer Gonna Grow Without Product!',
                showDuration = false,
                position = 'top-right',
                style = {
                    backgroundColor = '#141517',
                    color = '#00ff59',
                    ['.description'] = {
                      color = '#909296'
                    }
                },
                icon = 'cannabis',
                iconColor = '#00ff4c'
            })
        end
    elseif inJob == true then
        lib.notify({
            id = 'drug_hits',
            title = 'Drug Deal?',
            description = 'You already have a Drug Deal started, Check your GPS',
            showDuration = false,
            position = 'top-right',
            style = {
                backgroundColor = '#141517',
                color = '#00ff59',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'cannabis',
            iconColor = '#00ff4c'
        })
    end
end)

local function DeliveryAnim()
    if lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            scenario = 'mini@repair',
            clip = 'fixing_a_ped',
        },
    })
    then -- if progressCircle is going then
        -- do this
    else
        lib.notify({
            id = 'drug_hits',
            title = 'Drug Deal',
            description = 'Canceled',
            showDuration = false,
            position = 'top-right',
            style = {
                backgroundColor = '#141517',
                color = '#00ff59',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'cannabis',
            iconColor = '#00ff4c'
        })
    end
end


RegisterNetEvent('Xotiic-Drugs:client:RecieveDelivery', function()
    local route = math.random(1, #Config.DeliveryLocations["deliveryroute"])
    local randomRoute = Config.DeliveryLocations["deliveryroute"][math.random(1, #Config.DeliveryLocations["deliveryroute"])].coords
    deliveryBlip = AddBlipForCoord(randomRoute.x, randomRoute.y, randomRoute.z)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipScale(deliveryBlip, 0.7)
    SetBlipSprite(deliveryBlip, 40)
    SetBlipColour(deliveryBlip, 3)
    SetBlipAsShortRange(deliveryBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Trap House")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
    inJob = true
    TriggerServerEvent('Xotiic-Drugs:server:RecieveDrugs')
    lib.notify({
        id = 'drug_hits',
        title = 'Drug Hits',
        description = 'Drug Deal Started! Check your GPS for the marked location',
        showDuration = false,
        position = 'top-right',
        style = {
            backgroundColor = '#141517',
            color = '#00ff59',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'cannabis',
        iconColor = '#00ff4c'
    })
    exports['qb-target']:AddCircleZone("DrugHitsDelivery", randomRoute, 1.0, {
        name = "DrugHitsDelivery",
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "Xotiic-Drugs:client:CompleteDelivery",
                icon = "fa-solid fa-cannabis",
                label = 'Deal Drugs',
            },
        },
        distance = 2.5
    })
    print(randomRoute)
end)

RegisterNetEvent('Xotiic-Drugs:client:CompleteDelivery', function()
    DeliveryAnim()
    RemoveBlip(deliveryBlip)
    inJob = false
    exports['qb-target']:RemoveZone("DrugHitsDelivery")
    TriggerServerEvent('Xotiic-Drugs:server:FinishDrugDeal')
    lib.notify({
        id = 'drug_hits',
        title = 'Drug Deal',
        description = 'Dealer Can Now Start To Grow',
        showDuration = false,
        position = 'top-right',
        style = {
            backgroundColor = '#141517',
            color = '#00ff59',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'cannabis',
        iconColor = '#00ff4c'
    })
end)