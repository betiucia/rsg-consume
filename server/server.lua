local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------
-- eat
-----------------------
for k, _ in pairs(Config.Consumables.Eat) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        local Player = RSGCore.Functions.GetPlayer(source)
        for l, v in pairs(Player.PlayerData.items) do
            if v.type == 'food' then
                if v.info.quality > 0 then
                    TriggerClientEvent('rsg-consume:client:eat', source, item.name)
                else
                    TriggerClientEvent('rsg-consume:client:eatbad', source, item.name)
                end
            else
                TriggerClientEvent('rsg-consume:client:eat', source, item.name)
            end
        end
    end)
end

-----------------------
-- drink
-----------------------
for k, _ in pairs(Config.Consumables.Drink) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:drink', source, item.name)
        local Player = RSGCore.Functions.GetPlayer(source)
        for l, v in pairs(Player.PlayerData.items) do
            if v.type == 'food' then
                if v.info.quality > 0 then
                    TriggerClientEvent('rsg-consume:client:drink', source, item.name)
                else
                    TriggerClientEvent('rsg-consume:client:drinkbad', source, item.name)
                end
            else
                TriggerClientEvent('rsg-consume:client:drink', source, item.name)
            end
        end
    end)
end

-----------------------
-- stew
-----------------------
for k, _ in pairs(Config.Consumables.Stew) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:stew', source, item.name)
        for l, v in pairs(Player.PlayerData.items) do
            if v.type == 'food' then
                if v.info.quality > 0 then
                    TriggerClientEvent('rsg-consume:client:stew', source, item.name)
                else
                    TriggerClientEvent('rsg-consume:client:stewbad', source, item.name)
                end
            else
                TriggerClientEvent('rsg-consume:client:stew', source, item.name)
            end
        end
    end)
end

-----------------------
-- update hunger
-----------------------
RegisterNetEvent('rsg-consume:server:addHunger', function(amount)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    if amount > 100 then
        amount = 100
    end
    Player.Functions.SetMetaData('hunger', amount)
    TriggerClientEvent('hud:client:UpdateHunger', source, amount)
end)

-----------------------
-- update thirst
-----------------------
RegisterNetEvent('rsg-consume:server:addThirst', function(amount)
    local Player = RSGCore.Functions.GetPlayer(source)
    if not Player then return end
    if amount > 100 then
        amount = 100
    end
    Player.Functions.SetMetaData('thirst', amount)
    TriggerClientEvent('hud:client:UpdateThirst', source, amount)
end)

---------------------------------------------
-- remove item
---------------------------------------------
RegisterServerEvent('rsg-consume:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', amount)
end)


---------------------------------------------
-- item quality
---------------------------------------------

CreateThread(function()
    while true do
        Wait(Config.DecayTime * 1000)
        local Players = RSGCore.Functions.GetRSGPlayers()
        local svslot = nil
        for k, v in pairs(Players) do
            for slot, item in pairs(v.PlayerData.items) do
                if item.type == 'food' then
                    local svslot = item.slot
                    local newquality = math.floor((v.PlayerData.items[svslot].info.quality - Config.DecayAmount))
                    v.PlayerData.items[svslot].info.quality = newquality
                    v.Functions.SetInventory(v.PlayerData.items)
                    if item.info.quality < 0 then
                        v.PlayerData.items[svslot].info.quality = 0
                        v.Functions.SetInventory(v.PlayerData.items)
                        local Player = RSGCore.Functions.GetPlayer(k)
                        Player.Functions.RemoveItem(item.name, 1, svslot)

                    end
                end
            end
            -- v.Functions.SetInventory(v.PlayerData.items)
        end
    end
end)
