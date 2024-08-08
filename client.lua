Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            local weapon = GetSelectedPedWeapon(PlayerPedId())
            TriggerServerEvent('playerShotWeapon', weapon)
        end
    end
end)
