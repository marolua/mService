RegisterNetEvent("M:ClientReturn:IsInService", function(isInService)
    print("Est en service :", isInService)
end)

RegisterNetEvent("M:ClientReturn:ServiceTime", function(time)
    print("Temps de service :", time)
end)

RegisterCommand('TestPlayerService', function ()
    TriggerServerEvent("M:PlayerService")
end, false)

RegisterCommand('testplayertimeservice', function ()
    TriggerServerEvent("M:PlayerTimeInService")
end, false)

RegisterCommand("prisedeservice", function()
    TriggerServerEvent("M:StartService")
end, false)

RegisterCommand("findeservice", function()
    TriggerServerEvent("M:StopServiceAndSendLogs")
end, false)
