local services = {}

RegisterNetEvent("M:StartService")
AddEventHandler('M:StartService', function ()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = xPlayer.getIdentifier()
    if not services[id] == nil then
        xPlayer.showNotification("Vous êtes déjà en service !")
    else
        services[id] = {
            firstname = xPlayer.get('firstName'),
            name = xPlayer.get('lastName'),
            start = os.time()
        }
    end
end)

RegisterNetEvent('M:StopServiceAndSendLogs')
AddEventHandler('M:StopServiceAndSendLogs', function ()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = xPlayer.getIdentifier()
    local fin = os.time()

    if services[id] == nil then
        xPlayer.showNotification("Vous n'avez pas commencer de service !")
    else
        local total = (fin - services[id].start)
        SendDiscordLog("https://discord.com/api/webhooks/1335693378075099227/geuoOheuMrnhH4KOfpm2HVKM6yh6VVRAfKmBC6MJoXyZiJFDFEBOq_vlXxhUJXvZloXq", "Temps de service", "Nom & Prénom : " .. services[id].firstname .. " " .. services[id].name .. " | Temps de service : " ..os.date("!%H:%M:%S", total), 65280)
        MySQL.insert("INSERT INTO `mService` (`id`, `firstname`, `name`, `start`, `fin`) VALUES (@id, @firstname, @name, @start, @fin)", {
            ['@id'] = id,
            ['@firstname'] = xPlayer.get('firstName'),
            ['@name'] = xPlayer.get('lastName'),
            ['@start'] = services[id].start,
            ['@fin'] = fin
        })
        services[id] = {}
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