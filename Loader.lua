repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

if Bubble and Bubble.Loaded then
    print("Bubble is already loaded")
    return
end

local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
if not success then
    print("Failed to retrieve product info")
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
        [6938803436]      = {Name = "Anime Dimensions."},
        [87039211657390]  = {Name = "Arise."}
    }
}

for id, gameData in pairs(Bubble.Games) do
    if game.PlaceId == id or string.match(info.Name, gameData.Name) then
        print("Found supported game:", info.Name)
        Loadscript("Games/"..id)
        Bubble.Loaded = true
    end
end

if not Bubble.Loaded then
    print("Bubble does not support this game")
    return
end