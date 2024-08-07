ESX = exports["es_extended"]:getSharedObject()
local ResetStress = false

lib.addCommand('cash', {
    help = Lang:t('info.check_cash_balance'),
}, function(source, args)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cashamount = Player.getAccounts('money').money
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

lib.addCommand('bank', {
    help = Lang:t('info.check_bank_balance'),
}, function(source, args)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cashamount = Player.getAccounts('bank').money
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

lib.addCommand('dev', {
    help = Lang:t('info.toggle_dev_mode'),
}, function(source, args)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    TriggerClientEvent("qb-admin:client:ToggleDevmode", source)
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local Job = Player.job.name
    local newStress
    if not Player or Config.WhitelistedJobs[Job] then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.setMeta('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('esx:showNotification', src, Lang:t('notify.stress_gain'), 'error', 1500)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.setMeta('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('esx:showNotification', src, Lang:t('notify.stress_removed'))
end)

ESX.RegisterServerCallback('hud:server:getMenu', function(_, cb)
    cb(Config.Menu)
end)
