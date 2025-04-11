local services = {}

RegisterNetEvent("M:StartService", function ()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = xPlayer.getIdentifier()

    if services[id] ~= nil then
        xPlayer.showNotification("Vous êtes déjà en service !")
    else
        services[id] = {
            start = os.time(),
            firstname = xPlayer.get('firstName'),
            name = xPlayer.get('lastName'),
            jobname = xPlayer.job.name
        }
        xPlayer.showNotification("Vous avez commencer un service !")
        print(json.encode(services[id]))
    end
end)

RegisterNetEvent("esx:playerDropped", function (playerId, reason)
    local xPlayerID = ESX.GetPlayerFromId(playerId)?.getIdentifier()
    services[xPlayerID] = {}
end)

RegisterNetEvent('M:StopServiceAndSendLogs', function ()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = xPlayer.getIdentifier()
    local fin = os.time()

    if not services[id] or not services[id].start then
        return xPlayer.showNotification("Vous n'avez pas commencer de service !")
    else
        local total = (fin - services[id].start)
        SendDiscordLog("https://discord.com/api/webhooks/1335693378075099227/geuoOheuMrnhH4KOfpm2HVKM6yh6VVRAfKmBC6MJoXyZiJFDFEBOq_vlXxhUJXvZloXq", "Temps de service", "Nom & Prénom : " .. services[id].firstname .. " " .. services[id].name .. " Job : " .. services[id].jobname .. " | Temps de service : " ..os.date("!%H:%M:%S", total), 65280)
        MySQL.insert("INSERT INTO `mService` (`id`, `firstname`, `name`, `job`, `start`, `fin`) VALUES (@id, @firstname, @name, @job, @start, @fin)", {
            ['@id'] = id,
            ['@firstname'] = services[id].firstname,
            ['@name'] = services[id].name,
            ['@job'] = services[id].jobname,
            ['@start'] = services[id].start,
            ['@fin'] = fin
        })
        services[id] = {}
        print(json.encode(services[id]))
        xPlayer.showNotification("Vous avez terminé votre service !")
    end
end)

function SendDiscordLog(webhook, title, message, color)
    local embedData = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = color,
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers)
        if err ~= 200 then
            return
        end
    end, "POST", json.encode({username = "Service Logs", embeds = embedData}), {["Content-Type"] = "application/json"})
end

function GetPlayerIsInService(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return false end

    local id = xPlayer.getIdentifier()
    return services[id] and services[id].start ~= nil and true or false
end

function MaroGetHowMuchPlayerIsInService(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return false end

    local id = xPlayer.getIdentifier()
    if services[id] and services[id].start then
        local serviceTime = os.time() - services[id].start
        return os.date("!%H:%M:%S", serviceTime)
    end
    return false
end

RegisterNetEvent("M:PlayerService", function()
    local src = source
    local resultPlayerService = GetPlayerIsInService(src)
    TriggerClientEvent("M:ClientReturn:IsInService", src, resultPlayerService)
end)

RegisterNetEvent("M:PlayerTimeInService", function()
    local src = source
    local resultTimeServicePlayer = MaroGetHowMuchPlayerIsInService(src)
    TriggerClientEvent("M:ClientReturn:ServiceTime", src, resultTimeServicePlayer)
end)
