repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

if Bubble and Bubble.Loaded then
    warn("Bubble is already loaded")
    return
end

local success, response = pcall(function()
    return request({
        Url = "https://apis.roblox.com/universes/v1/places/" .. game.PlaceId .. "/universe",
        Method = "GET"
    })
end)

if success and response and response.Body then
    data = HttpService:JSONDecode(response.Body)
else
    warn("Failed to get universeId from API")
    return
end

local function Loadscript(Script)
    local Domain = "https://raw.githubusercontent.com/fleowo/Bubble/request/"
    return pcall(function()
        return loadstring(game:HttpGetAsync(("%s%s.lua"):format(Domain, Script)))()
    end)
end

getgenv().Bubble = {
    Loaded = false,
    Games = {
        [87039211657390] = {Name = "Arise Crossover",  UUID = 7074860883},
    }
}

for id, gameData in pairs(Bubble.Games) do
    if data.universeId == gameData.UUID then
        print("Found supported game:", gameData.Name)
        Loadscript("Games/"..id)
        Bubble.Loaded = true
        PlaceId = id
    end
end

if not Bubble.Loaded then
    warn("Bubble does not support this game")
    return
end

CoreGui.DescendantAdded:Connect(function(Ins)
    if Ins.Name == "LeaveButton" then
        task.delay(1, function()
            TeleportService:Teleport(PlaceId, Players.LocalPlayer)
        end)
    end
end)