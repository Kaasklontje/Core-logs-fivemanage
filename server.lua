function SendLogToFivemanage(logData)
    
    logData.resource = GetCurrentResourceName()

    local jsonData = json.encode(logData)
    print("Sending log data to Fivemanage:", jsonData)

    PerformHttpRequest(Config.apiUrl, function(err, text, headers)
        if err ~= 200 then
            print('Error sending log to Fivemanage:', err)
            print('Response:', text)
        else
            print('Log sent to Fivemanage:', text)
        end
    end, 'POST', jsonData, { 
        ['Content-Type'] = 'application/json',
        ['Authorization'] = Config.apiKey, 
        ['User-Agent'] = 'core+'
    })
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local playerId = source
    local license = GetPlayerIdentifiers(playerId)[1]
    local logData = {
        level = "Core",
        message = "Player joined",
        metadata = {
            action = "join",
            player = {
                id = playerId,
                name = name,
                license = license
            }
        }
    }
    SendLogToFivemanage(logData)
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local license = GetPlayerIdentifiers(playerId)[1]
    local logData = {
        level = "Core",
        message = "Player left",
        metadata = {
            action = "leave",
            player = {
                id = playerId,
                license = license
            },
            reason = reason
        }
    }
    SendLogToFivemanage(logData)
end)

RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
    local playerId = source
    local license = GetPlayerIdentifiers(playerId)[1]
    local logData = {
        level = "Core",
        message = "Player shot weapon",
        metadata = {
            action = "shot",
            player = {
                id = playerId,
                license = license
            },
            weapon = weapon
        }
    }
    SendLogToFivemanage(logData)
end)
