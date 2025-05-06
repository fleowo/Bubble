repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character

local PromptLib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/fleowo/Bubble/request/Utilities/PromptLibrary.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

if Bubble and Bubble.Loaded then
    PromptLib("Error", "Bubble is already loaded \n(Error Code: 0)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function() end}
    })
    return
end

local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
if not success then
    PromptLib("Error", "Failed to retrieve product info. \n(Error Code: 0)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function() end}
    })
    return
end

local function Loadscript(Script)
    local Domain = "https://raw.githubusercontent.com/fleowo/Bubble/request/"
    return pcall(function()
        return loadstring(game:HttpGet(("%s%s.lua"):format(Domain, Script)))()
    end)
end

getgenv().Bubble = {
    Loaded = false,
    Utilities = {Misc = Loadscript("Utilities/Misc")},
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

        Players.LocalPlayer.Idled:connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
        end)
    end
end

if not Bubble.Loaded then
    PromptLib("Error", "Bubble does not support this game \n(Error Code: 0)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function() end}
    })
    return
end