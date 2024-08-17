Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            local weapon = GetSelectedPedWeapon(PlayerPedId())
            if weapon ~= GetHashKey("WEAPON_PETROLCAN") then
                TriggerServerEvent('playerShotWeapon', tostring(weapon)) 
            end
        end
    end
end)
