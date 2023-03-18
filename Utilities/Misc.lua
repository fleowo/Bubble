-- THANKS PARVUS FOR THIS SCRIPT :D

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

repeat task.wait() until Stats.Network:FindFirstChild("ServerStatsItem")
local Ping = Stats.Network.ServerStatsItem["Data Ping"]
local Request = (syn and syn.request) or (http and http.request) or request
local LocalPlayer = Players.LocalPlayer
local Misc = {}

function Misc:SetupFPS()
    local StartTime,TimeTable,LastTime = os.clock(),{},nil
    return function() LastTime = os.clock()
        for Index = #TimeTable, 1, -1 do
            TimeTable[Index + 1] = TimeTable[Index] >= LastTime - 1
            and TimeTable[Index] or nil
        end TimeTable[1] = LastTime
        return os.clock() - StartTime >= 1 and #TimeTable
        or #TimeTable / (os.clock() - StartTime)
    end
end

function Misc:ReJoin()
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\nBubble Hub\nRejoining...")
        task.wait(0.5) TeleportService:Teleport(game.PlaceId)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
end

function Misc:ServerHop()
    local DataDecoded,Servers = HttpService:JSONDecode(game:HttpGetAsync(
        "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100"
    )).data,{}
    for Index,ServerData in ipairs(DataDecoded) do
        if type(ServerData) == "table" and ServerData.id ~= game.JobId then
            table.insert(Servers,ServerData.id)
        end
    end
    if #Servers > 0 then
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,Servers[math.random(#Servers)]
        )
    end
end

function Misc:JoinDiscord()
    Request({
        ["Url"] = "http://localhost:6463/rpc?v=1",
        ["Method"] = "POST",
        ["Headers"] = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        },
        ["Body"] = HttpService:JSONEncode({
            ["cmd"] = "INVITE_BROWSER",
            ["nonce"] = string.lower(HttpService:GenerateGUID(false)),
            ["args"] = {
                ["code"] = "ZSQzPK3t2f"
            }
        })
    })
end

function Misc:SetupWatermark(Window)
    local GetFPS = Misc:SetupFPS()
    RunService.Heartbeat:Connect(function()
        if Window.Watermark.Enabled then
            Window.Watermark.Title = string.format(
                "%s    %i FPS    %i MS",
                os.date("%A %d %B %Y %X"), GetFPS(), math.round(Ping:GetValue())
            )
        end
    end)
end

function Misc:SettingsSection(Window,UIKeybind)
    local SettingsTab = Window:Tab({Name = "Settings"}) do
        local MenuSection = SettingsTab:Section({Name = "Menu",Side = "Left"}) do
            local UIToggle = MenuSection:Toggle({Name = "UI Enabled",Flag = "UI/Enabled",IgnoreFlag = true,
            Value = Window.Enabled,Callback = function(Bool) Window.Enabled = Bool end})
            UIToggle:Keybind({Value = UIKeybind,Flag = "UI/Keybind",DoNotClear = true})
            UIToggle:Colorpicker({Flag = "UI/Color",Value = {1,0.25,1,0,true},
            Callback = function(HSVAR,Color) Window.Color = Color end})

            MenuSection:Toggle({Name = "Open On Load",Flag = "UI/OOL",Value = true})
            MenuSection:Toggle({Name = "Blur Gameplay",Flag = "UI/Blur",Value = false,
            Callback = function(Bool) Window.Blur = Bool end})

            MenuSection:Toggle({Name = "Watermark",Flag = "UI/Watermark/Enabled",Value = true,
            Callback = function(Bool) Window.Watermark.Enabled = Bool end}):Keybind({Flag = "UI/Watermark/Keybind"})

            MenuSection:Button({Name = "Rejoin",Side = "Left",
            Callback = Bubble.Utilities.Misc.ReJoin})

            MenuSection:Button({Name = "Server Hop",Side = "Left",
            Callback = Bubble.Utilities.Misc.ServerHop})
        end

        SettingsTab:AddConfigSection("Bubble","Left")

        local BackgroundSection = SettingsTab:Section({Name = "Background",Side = "Right"}) do
            BackgroundSection:Colorpicker({Name = "Color",Flag = "Background/Color",Value = {1,0,0.372,0,false},
            Callback = function(HSVAR,Color) Window.Background.ImageColor3 = Color Window.Background.ImageTransparency = HSVAR[4] end})
            BackgroundSection:Textbox({HideName = true,Flag = "Background/CustomImage",Placeholder = "rbxassetid://ImageId",
            Callback = function(String,EnterPressed) if EnterPressed then Window.Background.Image = String end end})
            BackgroundSection:Dropdown({HideName = true,Flag = "Background/Image",List = {
                {Name = "Legacy",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://2151741365"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hearts",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073763717"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Abstract",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073743871"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hexagon",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073628839"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Circles",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071579801"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Lace With Flowers",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071575925"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Floral",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://5553946656"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Halloween",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://11113209821"
                    Window.Flags["Background/CustomImage"] = ""
                end,Value = true},
                {Name = "Christmas",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://11711560928"
                    Window.Flags["Background/CustomImage"] = ""
                end}
            }})
            BackgroundSection:Slider({Name = "Tile Offset",Flag = "Background/Offset",Wide = true,Min = 74,Max = 296,Value = 74,
            Callback = function(Number) Window.Background.TileSize = UDim2.fromOffset(Number,Number) end})
        end

        local DiscordSection = SettingsTab:Section({Name = "Discord",Side = "Right"}) do
            DiscordSection:Label({Text = "Invite Code: ZSQzPK3t2f"})

            DiscordSection:Button({Name = "Copy Invite Link",Side = "Left",
            Callback = function() setclipboard("https://discord.gg/ZSQzPK3t2f") end})

            DiscordSection:Button({Name = "Join Through Discord App",Side = "Left",
            Callback = Bubble.Utilities.Misc.JoinDiscord})
        end
    end
end

function Misc:InitAutoLoad(Window)
    Window:SetValue("Background/Offset",296)
    Window:AutoLoadConfig("Bubble")
    Window:SetValue("UI/Enabled",Window.Flags["UI/OOL"])
end

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
end)

return Misc