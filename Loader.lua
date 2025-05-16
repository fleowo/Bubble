repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

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
    local data = HttpService:JSONDecode(response.Body)
    universeId = data.universeId
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
        [2655311011] = {Name = "Anime Dimensions"},
        [7074860883] = {Name = "Arise Crossover"},
    }
}

for id, game in pairs(Bubble.Games) do
    if universeId == id then
        print("Found supported game:", game.Name)
        Loadscript("Games/"..id)
        Bubble.Loaded = true

        Players.LocalPlayer.Idled:connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

if not Bubble.Loaded then
    warn("Bubble does not support this game")
    return
end