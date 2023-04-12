-- Put the cars you want to spawn here its common sense honestly
local vehicles = {
  {model = "carhere", name = "carhere"},
  {model = "carhere", name = "carhere"},
  {model = "carhere", name = "carhere"},
  {model = "carhere", name = "carhere"},
  {model = "carhere", name = "carhere"}
}

-- Only touch this if you know what your doing or editiing text
local menu = NativeUI.CreateMenu("Car Spawner", "Select a vehicle to spawn")

-- Create a submenu for each vehicle
for i, v in ipairs(vehicles) do
  local submenu = menu:AddSubMenu(v.name)
  
  -- Add a button to spawn the vehicle when the submenu is opened
  submenu.OnMenuOpened = function()
    local playerPed = GetPlayerPed(-1)
    local vehicleHash = GetHashKey(v.model)
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
      Citizen.Wait(0)
    end
    local vehicle = CreateVehicle(vehicleHash, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1)
  end
end

-- Add the menu to the game's menu pool
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    menu:ProcessMenus()
  end
end)
