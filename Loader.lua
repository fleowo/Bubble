repeat task.wait() until game:IsLoaded()

local PromptLib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Roblox/main/Useful/PromptLibrary.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local QueueOnTeleport = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)

local Players = game:GetService("Players")
repeat task.wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

if Bubble and Bubble.Loaded then
    PromptLib("Error", "Bubble is already loaded \n(Error Code: 167)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function() end}
    })
    return
end

local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
if not success then
    PromptLib("Error", "Failed to retrieve product info. \n(Error Code: 117)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function() end}
    })
    return
end

local function Loadscript(Script)
    local Domain = "https://raw.githubusercontent.com/fleowo/Bubble/request/"
    return loadstring(game:HttpGetAsync(("%s%s.lua"):format(Domain, Script)))()
end

getgenv().Bubble = {
    Loaded = false,
    Utilities = {Misc = Loadscript("Utilities/Misc")},
    Games = {
        [10824616460] = {Name = "Sword Slasher"},
        [6938803436]  = {Name = "Anime Dimensions."},
        [8884433153]  = {Name = "Collect All Pets"},
        [8540346411]  = {Name = "Rebirth Champions X"},
        [9285238704]  = {Name = "Race Clicker"},
        [6679968919]  = {Name = "Fly Race"},
        [10982284336] = {Name = "Anime Idle Simulator"}
    }
}

for id, gameData in pairs(Bubble.Games) do
    if game.PlaceId == id or string.match(info.Name, gameData.Name) then
        print("Found supported game:", gameData.Name)
        Loadscript("Games/"..id)
        Bubble.Loaded = true
    end
end

if not Bubble.Loaded then
    PromptLib("Error", "Bubble does not support this game \nDiscord link has been copied to your clipboard \n(Error Code: 0)", {
        {Text = "OK", LayoutOrder = 0, Primary = true, Callback = function()
            setclipboard("https://discord.gg/ZSQzPK3t2f")
        end}
    })
    return
end

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.InProgress then
        QueueOnTeleport("loadstring(game:HttpGetAsync'https://raw.githubusercontent.com/fleowo/Bubble/request/Loader.lua')()")
    end
end)
