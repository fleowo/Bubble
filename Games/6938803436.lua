local Bracket = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players").LocalPlayer

local RaidText = Workspace.InteractionCircles.RaidPortal.RaidTimer.Frame.RaidTimerText
local Lobby = {6938803436,7274690025,7338881230}
local MapList = {"Fate Dimension", "Ghoul Dimension", "Villain Dimension", "Sword Dimension", "Slime Dimension","Titan Dimension", 
"Curse Dimension", "Demon Dimension", "Devil Dimension", "Pirate Dimension",
"Yomiichi Raid", "Titan Raid", "Matsuri Raid", "Tengoku Raid", "Hirito Raid", "Reku 100 Raid", "Gear 5 Fluffy Raid"}
repeat task.wait() until Players.PlayerGui:FindFirstChild("MainGui")

local function getCharacters()
    local CharacterLists = {}
    for _,v in pairs(Players.PlayerGui.MainGui.CenterUIFrame.Inventory.Frame.CharacterInventoryFrame.CharacterInventoryScrollingFrame:GetChildren()) do
        if v.Name ~= "CharacterInventorySlot" and v:IsA("ImageButton") then
            CharacterLists[#CharacterLists + 1] = {Name = v.Name}
        end
    end
    return CharacterLists
end

local Window = Bracket:Window({Name = "Bubble - Anime Dimensions Simulator",Enabled = true,Position = UDim2.new(0.05,0,0.5,-248)}) do Window:Watermark({Enabled = true})

    local MainTab = Window:Tab({Name = "Main"}) do
        local FarmingSection = MainTab:Section({Name = "Farming"}) do local Dimension = {} local Raid = {}
            FarmingSection:Toggle({Name = "Auto Level",Flag = "Farming/AutoLevel"})
            FarmingSection:Toggle({Name = "Speed Raid",Flag = "Farming/AutoSpeed"})
            FarmingSection:Toggle({Name = "Boss Rush",Flag = "Farming/AutoRush"})
            FarmingSection:Toggle({Name = "Infinite Mode",Flag = "Farming/AutoInfinite"})
            FarmingSection:Toggle({Name = "Time Challenge",Flag = "Farming/AutoTime"})
            FarmingSection:Divider({Text = "Specific Map"})
            FarmingSection:Toggle({Name = "Specific Map",Flag = "Farming/AutoSpecific"})
            for _,v in pairs(Players.PlayerGui.MainGui.CenterUIFrame.PlayFrame.Frame.PlayRoomFrame.MapSelectionScrollingFrame:GetChildren()) do
                if string.match(v.Name, ".Raid") then
                    Raid[#Raid + 1] = {Name = v.Name}
                end
            end
            for _,v in pairs(MapList) do
                if string.match(v, ".Dimension") then
                    Dimension[#Dimension + 1] = {Name = v}
                elseif game.PlaceId ~= 7338881230 and string.match(v, ".Raid") then
                    Raid[#Raid + 1] = {Name = v}
                end
            end
            FarmingSection:Dropdown({Name = "Map",Flag = "Farming/DimensionMap", List = Dimension})
            FarmingSection:Dropdown({Name = "Difficulty",Flag = "Farming/Difficulty", List = {{Name = "Easy",Value = true},{Name = "Hard"},{Name = "Nightmare"}}})
            FarmingSection:Divider({Text = "Raid Boss"})
            FarmingSection:Toggle({Name = "Raid Boss",Flag = "Farming/AutoRaid"})
            RaidMap = FarmingSection:Dropdown({Name = "Map",Flag = "Farming/RaidMap", List = Raid})
            FarmingSection:Divider({Text = "AFK"})
            FarmingSection:Toggle({Name = "Enabled",Flag = "Farming/AFK"})
            FarmingSection:Dropdown({Name = "Mode",Flag = "Farming/AFKMode", List = {{Name = "Gem",Value = true},{Name = "RaidCurrency"}}})
            FarmingSection:Divider({Text = "Extra"})
            FarmingSection:Toggle({Name = "Friends Only",Flag = "Farming/FriendsOnly"})
            FarmingSection:Toggle({Name = "Hardcore",Flag = "Farming/Hardcore"})
            FarmingSection:Toggle({Name = "Auto Retry",Flag = "Farming/AutoRetry"})
        end
        local CharacterSection = MainTab:Section({Name = "Character"}) do
            CharacterSection:Toggle({Name = "Auto Equip Main",Flag = "Character/AutoEquipMain"})
            CharacterSection:Toggle({Name = "Auto Equip Assist",Flag = "Character/AutoEquipAssist"})
            CharacterSection:Dropdown({Name = "Main Character" ,Flag = "Character/MainCharacter", List = getCharacters()})
            CharacterSection:Dropdown({Name = "Assist Character 1" ,Flag = "Character/AssistCharacter1", List = getCharacters()})
            CharacterSection:Dropdown({Name = "Assist Character 2" ,Flag = "Character/AssistCharacter2", List = getCharacters()})
        end
        local SettingSection = MainTab:Section({Name = "Setting"}) do
            SettingSection:Divider({Text = "Punch Setting"})
            SettingSection:Toggle({Name = "Auto Punch",Flag = "Setting/AutoPunch"})
            SettingSection:Dropdown({Name = "Mode" ,Flag = "Setting/PunchMode", List = {{Name = "MouseClick",Value = true},{Name = "Send Packet"}}})
            SettingSection:Slider({Name = "Delay",Wide = true,Flag = "Setting/PunchDelay",Min = 0.5,Max = 10,Value = 0.5,Precise = 1,Unit = "second"})
            SettingSection:Divider({Text = "Skill Setting"})
            SettingSection:Toggle({Name = "Auto Skill",Flag = "Setting/AutoSkill"})
            SettingSection:Dropdown({Name = "Mode" ,Flag = "Setting/SkillMode", List = {{Name = "Keypress",Value = true},{Name = "Send Packet"}}})
            SettingSection:Slider({Name = "Delay",Wide = true,Flag = "Setting/SkillDelay",Min = 0.5,Max = 10,Value = 1,Precise = 1,Unit = "second"})
            SettingSection:Divider({Text = "Teleport Setting"})
            SettingSection:Toggle({Name = "Teleport Behind",Flag = "Setting/TPBehind"})
            SettingSection:Dropdown({Name = "Mode" ,Flag = "Setting/TPBehind/Mode", List = {{Name = "Nearest",Value = true},{Name = "Normal"}}})
            SettingSection:Slider({Name = "Distance",Wide = true,Flag = "Setting/TPDistance",Min = 0,Max = 10,Value = 6,Precise = 0,Unit = "studs"})
            SettingSection:Slider({Name = "Speed",Wide = true,Flag = "Setting/TPSpeed",Min = 50,Max = 150,Value = 100,Precise = 0,Unit = "%"})
            SettingSection:Divider({Text = "Dodge Setting"})
            SettingSection:Toggle({Name = "Auto Dodge",Flag = "Setting/AutoDodge"})
            SettingSection:Slider({Name = "DodgeSize",Wide = true,Flag = "Setting/DodgeSize",Min = 1.5,Max = 6.5,Value = 3,Precise = 2,Unit = "studs"})
            SettingSection:Slider({Name = "Delay",Wide = true,Flag = "Setting/DodgeDelay",Min = 0.4,Max = 1,Value = 0.5,Precise = 1,Unit = "second"})
        end
    end
    local ExtraTab = Window:Tab({Name = "Extra"}) do
        local AutoSection = ExtraTab:Section({Name = "Auto"}) do local Capsules = {}
            AutoSection:Toggle({Name = "Daily Quest",Flag = "Auto/DailyQuest"})
            AutoSection:Toggle({Name = "Raid Token",Flag = "Auto/RaidToken"})
            AutoSection:Toggle({Name = "Speed Raid",Flag = "Auto/SpeedRaid"})
            AutoSection:Divider({Text = "Auto Capsule"})
            AutoSection:Toggle({Name = "Open Capsule",Flag = "Auto/AutoCapsule"})
            for _,v in pairs(Players.PlayerGui.MainGui.CenterUIFrame.Shop.Frame.RightShade.ShopPetScrollingFrame:GetChildren()) do
                if string.match(v.Name, ".Capsule") or string.match(v.Name, "Capsule Series.") then
                    Capsules[#Capsules + 1] = {Name = v.Name}
                end
            end 
            AutoSection:Dropdown({Name = "Capsule",Flag = "Auto/Capsule", List = Capsules})
            AutoSection:Slider({Name = "Delay",Wide = true,Flag = "Auto/OpenDelay",Min = 1,Max = 10,Value = 1,Precise = 1,Unit = "second"})
            AutoSection:Divider({Text = "Auto Sell Card"})
            AutoSection:Toggle({Name = "Enabled",Flag = "Auto/AutoSell",Callback = function(Value) 
                if Value then
                    if table.find(Lobby, game.PlaceId) then
                        local inventoryFrame = Players.PlayerGui.MainGui.CenterUIFrame.Inventory.Frame.CardInventoryFrame.CardInventoryScrollingFrame
                        for _,CardRarity in pairs(Window.Flags["Auto/CardRarity"]) do
                            pcall(function()
                                for _, cardButton in pairs(inventoryFrame:GetChildren()) do
                                    if cardButton:IsA("ImageButton") then
                                        for _,v in next, getconnections(cardButton.CardClick.MouseButton1Down) do v:Fire()
                                        local rarityText = Players.PlayerGui.MainGui.CenterUIFrame.Inventory.Frame.InvOverlayOuterFrame.CardInventoryOverlay.Rarity.Text
                                            if rarityText == CardRarity then
                                                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("SellCard", cardButton.Name)
                                            end
                                        end 
                                    end
                                end
                            end)
                        end
                    end
                end
            end})
            AutoSection:Dropdown({Name = "Card Rarity" ,Flag = "Auto/CardRarity", List = {{Name = "Common",Mode = "Toggle"},{Name = "Uncommon",Mode = "Toggle"},{Name = "Rare",Mode = "Toggle"},{Name = "Epic",Mode = "Toggle"},{Name = "Legendary",Mode = "Toggle"}}})
        end
        local PlayerSection = ExtraTab:Section({Name = "Player", Side = "Right"}) do
            PlayerSection:Toggle({Name = "Dash No Cooldown",Flag = "Player/DashNoCD",Callback = function(Value)
            if Value then 
                ReplicatedStorage[Players.Name .. "StatDisplay"].No_DashCooldown.Value = true
            else 
                ReplicatedStorage[Players.Name .. "StatDisplay"].No_DashCooldown.Value = false
            end end})
            PlayerSection:Toggle({Name = "Hide NameTag",Flag = "Player/HideNametag"})
            PlayerSection:Toggle({Name = "Auto Rejoin",Flag = "Player/AutoRejoin"})
            PlayerSection:Toggle({Name = "White Screen",Flag = "Player/WhiteScreen",Callback = function(Value)
            if Value then 
                game:GetService("RunService"):Set3dRenderingEnabled(false)
            else 
                game:GetService("RunService"):Set3dRenderingEnabled(true) 
            end end})
            PlayerSection:Toggle({Name = "Leave When Raid Open",Flag = "Player/LeaveWhenRaidOpen"})
            PlayerSection:Divider({Text = "Lobby Change"})
            PlayerSection:Button({Name = "Starter Lobby",Callback = function() TeleportService:Teleport(6938803436, Players) end})
            PlayerSection:Button({Name = "High Lobby",Callback = function() TeleportService:Teleport(7274690025, Players) end})
            PlayerSection:Button({Name = "Raid Lobby",Callback = function() TeleportService:Teleport(7338881230, Players) end})
            PlayerSection:Button({Name = "Raid Lobby",Callback = function() print(tweenFinish) end})
        end
        function webhook(embed, contents)
            local Request = (syn and syn.request) or (http and http.request) or request
            Request({
                Url = Window.Flags["Setting/Webhook/Link"],
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({embeds = {embed}, content = contents})
            })
        end
        local WebhookSection = ExtraTab:Section({Name = "Webhook",Side = "Right"}) do
            WebhookSection:Toggle({Name = "Enabled",Flag = "Setting/Webhook",Value = false})
            WebhookSection:Textbox({Name = "Wehbook Link",Flag = "Setting/Webhook/Link",Value = "",Placeholder = "https://discordapp.com/api/webhooks/...",NumberOnly = false,Callback = function(Text) end})
            WebhookSection:Button({Name = "Send Notification",Callback = function()
                local embed = {
                    ["title"] = "Anime Dimensions Simulator",
                    ["type"] = "rich",
                    ["color"] = 8913097,
                    ["thumbnail"] = {
                        ["url"] = "https://tr.rbxcdn.com/ca07113fc6127bf3e8196f9d3a9086c8/512/512/Image/Png"
                    },
                    ["image"] = {
                        ["url"] = "https://tr.rbxcdn.com/3eba3ee83f4f32a0691f8e40738f1833/768/432/Image/Png"
                    },
                    ["footer"] = {
                        ["text"] = "Bubble",
                        ["icon_url"] = "https://media.discordapp.net/attachments/859027411366969364/1067274572212228116/2.png"
                    },
                    ["description"] =
                    "**Username: **"..Players.Name.."\n"..
                    "**Level: **"..Players.leaderstats.Level.Value.."\n"..
                    "**Player XP: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].Experience.Value.."/"..ReplicatedStorage[Players.Name .. "StatDisplay"].MaxExperience.Value.."\n"..
                    "**Card Inventory: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].CardsOwned.Value.."/"..ReplicatedStorage[Players.Name .. "StatDisplay"].MaxCardsOwned.Value.."\n"..
                    "**Best Combo**: "..ReplicatedStorage[Players.Name .. "StatDisplay"].BestCombo.Value.."\n"..
                    "**Defeat Enemies: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].EnemiesDefeatedRound.Value.."\n"..
                    "**Exploit Detected**: "..tostring(ReplicatedStorage[Players.Name .. "StatDisplay"].ExploitsDetected.Value).."\n"..
                    "```md".."\n".."# Rewards".."\n".. " - Example Reward x10" .. "```".."\n"..
                    "[**Contact us!**](https://discord.gg/ZSQzPK3t2f)",
                    ["timestamp"] = DateTime.now():ToIsoDate()
                }
                webhook(embed, "")
            end})
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if Window.Flags["Farming/AutoRaid"] then
            if table.find(Lobby, game.PlaceId) then
                if string.match(RaidText.Text, "RAID IS OPEN.") and RaidMap.Value[1] ~= nil then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = RaidMap.Value[1],
                            ["Hardcore"] = false
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
            end
        end
    end
end)

local function getCharacter()
    local CharacterList = {}
    for _,v in pairs(Players.PlayerGui.MainGui.CenterUIFrame.Inventory.Frame.CharacterInventoryFrame.CharacterInventoryScrollingFrame:GetChildren()) do
        if v.Name ~= "CharacterInventorySlot" and v:IsA("ImageButton") then
            CharacterList[#CharacterList + 1] = v.Name
        end
    end
    return CharacterList
end

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoSpeed"] then
            if table.find(Lobby, game.PlaceId) then
                local Text = Players.PlayerGui.MainGui.CenterUIFrame.PlayButtonsFrame.Frame.SpeedRaidBanner.SpeedRaidBannerOpenText.Text
                if Text == "Ready to enter" then 
                    if not string.match(RaidText.Text, "RAID IS OPEN.") then
                        local character = getCharacter()
                        local random = math.random(1, #character)
                        local final = character[random]
                        local LayoutOrder = Players.PlayerGui.MainGui.CenterUIFrame.SpeedRaidCharacterSelector.Shade.SpeedRaidCharacterInventoryScrollingFrame[final].LayoutOrder
                        if LayoutOrder ~= 999 then
                            ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportToShadowRaid", final)
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoLevel"] then
            if table.find(Lobby, game.PlaceId) then
                local Level = Players.leaderstats.Level.Value
                if Level > 0 and Level < 6 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Titan Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 5 and Level < 11 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Hard",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Titan Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 10 and Level < 16 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Titan Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 15 and Level < 21 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Demon Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 20 and Level < 26 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Hard",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Demon Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 25 and Level < 31 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Demon Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 30 and Level < 36 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Curse Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 35 and Level < 41 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Hard",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Curse Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 40 and Level < 46 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Curse Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 45 and Level < 51 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Villain Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 50 and Level < 56 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Hard",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Villain Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 55 and Level < 61 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Villain Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 60 and Level < 68 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Sword Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 67 and Level < 76 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Sword Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 75 and Level < 83 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Ghoul Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 82 and Level < 91 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Ghoul Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 90 and Level < 98 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Fate Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 97 and Level < 106 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Fate Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 105 and Level < 114 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Easy",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Slime Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 113 and Level < 121 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Slime Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 120 and Level < 131 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Devil Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
                if Level > 130 then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = {
                            ["Difficulty"] = "Nightmare",
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = "Pirate Dimension",
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoRush"] then
            if table.find(Lobby, game.PlaceId) then
                local Ticket = Players.PlayerGui.MainGui.CenterUIFrame.BossRushFrame.BossRushEntryPassCount.Text
                local Free = Players.PlayerGui.MainGui.CenterUIFrame.BossRushFrame.BossRushFreeEntry.Text
                if tonumber(Ticket) >= 1 or string.match(Free, "1.") then
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportToBossRush")
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoSpecific"] then
            if table.find(Lobby, game.PlaceId) then
                if Window.Flags["Farming/DimensionMap"][1] ~= nil then
                    local args = {
                        [1] = "CreateRoom",
                        [2] = { 
                            ["Difficulty"] = Window.Flags["Farming/Difficulty"][1],
                            ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                            ["MapName"] = Window.Flags["Farming/DimensionMap"][1],
                            ["Hardcore"] = Window.Flags["Farming/Hardcore"]
                        }
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoInfinite"] then
            if table.find(Lobby, game.PlaceId) then
                local args = {
                    [1] = "CreateRoom",
                    [2] = {
                        ["Difficulty"] = "Infinite",
                        ["FriendsOnly"] = Window.Flags["Farming/FriendsOnly"],
                        ["MapName"] = "Infinite Mode",
                        ["Hardcore"] = false
                    }
                }
                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoTime"] then
            if table.find(Lobby, game.PlaceId) then
                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportToTimeChallenge")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AFK"] then
            if game.PlaceId == 6990131029 then
                local Name = Players.Name .. "StatDisplay"
                local Value = ReplicatedStorage[Name].AfkCurrencyChosen.Value
                if Value ~= Window.Flags["Farming/AFKMode"][1] then task.wait(10)
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("ChangeAFKCurrency")
                end
            end

            if table.find(Lobby, game.PlaceId) then
                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportToAFK")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoRetry"] then
            if Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.Visible then
                ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer("RetryDungeon")
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Character/AutoEquipMain"] then
            if table.find(Lobby, game.PlaceId) then
                local Name = Players.Name .. "StatDisplay"
                local Main = ReplicatedStorage[Name].CharacterName.Value
                if Main ~= Window.Flags["Character/MainCharacter"][1] then
                    local args = {
                        [1] = "EquipCharacter",
                        [2] = Window.Flags["Character/MainCharacter"][1]
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    task.wait(15)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Character/AutoEquipAssist"] then
            if table.find(Lobby, game.PlaceId) then
                local Name = Players.Name .. "StatDisplay"
                local a = ReplicatedStorage[Name].AssistCharacterName1.Value
                local b = ReplicatedStorage[Name].AssistCharacterName2.Value
                local Main = ReplicatedStorage[Name].CharacterName.Value
                if a ~= Window.Flags["Character/AssistCharacter1"][1] and Window.Flags["Character/AssistCharacter1"][1] ~= Main then
                    local args = {
                        [1] = "EquipCharacterAssist",
                        [2] = Window.Flags["Character/AssistCharacter1"][1],
                        [3] = 1
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    task.wait(15)
                end
                if b ~= Window.Flags["Character/AssistCharacter2"][1] and Window.Flags["Character/AssistCharacter2"][1] ~= Main then
                    local args = {
                        [1] = "EquipCharacterAssist",
                        [2] = Window.Flags["Character/AssistCharacter2"][1],
                        [3] = 2
                    }
                    ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
                    task.wait(15)
                end
            end
        end
    end
end)

Workspace.Folders.Debris.ChildAdded:Connect(function(debris)
    if Window.Flags["Setting/AutoDodge"] and table.find({"telegraph"}, debris.Name:lower()) and debris.Material ~= Enum.Material.Neon then
        local originalMaterial = debris.Material
        task.wait(Window.Flags["Setting/DodgeDelay"])
        local clone = debris:Clone()
        local padding = math.clamp(Window.Flags["Setting/DodgeSize"], 1.5, 6.5)
        local targetSize = debris.Size + Vector3.new(padding, 100, padding)
        clone.Size = Vector3.new(0, 100, debris.Size.Z)
        if debris.ClassName == "MeshPart" then
            clone.Size = Vector3.new(0, 0, 100)
            targetSize = debris.Size + Vector3.new(padding, padding, 100)
        end
        TweenService:Create(clone, TweenInfo.new(0.07), {Size = targetSize}):Play()
        clone.Anchored = true
        clone.Transparency = 1
        clone.CanCollide = true
        clone.Name = "Dodge"
        clone.Parent = debris.Parent
        local startTime = tick()
        repeat task.wait() until tick() - startTime > 999 or not debris.Parent
        clone:Destroy()
    end
end)

function getNearestMobs()
    local TargetDistance = math.huge
    local Target
    for i,v in pairs(Workspace.Folders.Monsters:GetChildren()) do
        if v.ClassName == "Model" and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health ~= 0 then
            local Mag = (Players.Character.HumanoidRootPart.Position - v:FindFirstChildOfClass("Part").Position).Magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end

task.spawn(function()
    while task.wait() do
        if Window.Flags["Setting/TPBehind"] then
            if Players.Character and Players.Character:FindFirstChild("Humanoid") and Players.Character.Humanoid.Health > 0 then
                pcall(function()
                    if Window.Flags["Setting/TPBehind/Mode"][1] == "Nearest" then
                        local nearestMobs = getNearestMobs()
                        if nearestMobs then
                            local distance = (nearestMobs.HumanoidRootPart.Position - Players.Character.HumanoidRootPart.Position).Magnitude
                            local tweenInfo = TweenInfo.new(tonumber(distance) / Window.Flags["Setting/TPSpeed"], Enum.EasingStyle.Linear)
                            local tween = TweenService:Create(Players.Character.HumanoidRootPart, tweenInfo, {CFrame = nearestMobs.HumanoidRootPart.CFrame * CFrame.new(0, 0, Window.Flags["Setting/TPDistance"])})
            
                            tween.Completed:Connect(function()
                                tweenFinish = true
                            end)
            
                            tween:Play()
                            tweenFinish = false
                        end
                    end
                    if Window.Flags["Setting/TPBehind/Mode"][1] == "Normal" then
                        for _, monster in pairs(Workspace.Folders.Monsters:GetChildren()) do
                            local distance = (monster.HumanoidRootPart.Position - Players.Character.HumanoidRootPart.Position).Magnitude
                            local tweenInfo = TweenInfo.new(tonumber(distance) / Window.Flags["Setting/TPSpeed"], Enum.EasingStyle.Linear)
                            local tween = TweenService:Create(Players.Character.HumanoidRootPart, tweenInfo, {CFrame = monster.HumanoidRootPart.CFrame * CFrame.new(0, 0, Window.Flags["Setting/TPDistance"])})
                            tween.Completed:Connect(function()
                                tweenFinish = true
                            end)
            
                            tween:Play()
                            tweenFinish = false
                        end
                    end
                    if not Players.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                        BodyVelocity = Instance.new("BodyVelocity", Players.Character.HumanoidRootPart)
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                    if not Window.Flags["Setting/TPBehind"] or not getNearestMobs() then
                        tweenFinish = false
                        for _, v in pairs(Players.Character.HumanoidRootPart:GetChildren()) do
                            if v:IsA("BodyVelocity") then
                                v:Destroy()
                            end
                        end
                    end
                end)
            end
        end
    end
end)

task.spawn(function()
    while wait(Window.Flags["Setting/PunchDelay"]) do
        if Window.Flags["Setting/AutoPunch"] then
            if not table.find(Lobby, game.PlaceId) then

                if Window.Flags["Setting/PunchMode"][1] == "MouseClick" then
                    VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0) wait()
                    VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0)
                elseif Window.Flags["Setting/PunchMode"][1] == "Send Packet" then
                    pcall(function()
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame,
                                ["attackNumber"] = 1
                            },
                            [3] = "BasicAttack"
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame,
                                ["attackNumber"] = 2
                            },
                            [3] = "BasicAttack"
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame,
                                ["attackNumber"] = 3
                            },
                            [3] = "BasicAttack"
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame,
                                ["attackNumber"] = 4
                            },
                            [3] = "BasicAttack"
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                    end)
                end
            end
        end
    end
end)

task.spawn(function()
    while wait(Window.Flags["Setting/SkillDelay"]) do
        if Window.Flags["Setting/AutoSkill"] then
            if not table.find(Lobby, game.PlaceId) and tweenFinish then

                if Window.Flags["Setting/SkillMode"][1] == "Keypress" then
                    local keycodes1 = {Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three}
                    local keycodes2 = {Enum.KeyCode.Four, Enum.KeyCode.Five} 
                    local keycodes3 = {Enum.KeyCode.E, Enum.KeyCode.R}

                    VirtualInputManager:SendKeyEvent(true, keycodes1[math.random(#keycodes1)], false, game)
                    VirtualInputManager:SendKeyEvent(true, keycodes2[math.random(#keycodes2)], false, game)
                    VirtualInputManager:SendKeyEvent(true, keycodes3[math.random(#keycodes3)], false, game)
                elseif Window.Flags["Setting/SkillMode"][1] == "Send Packet" then
                    pcall(function()
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 1
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 3
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 2
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseAssistSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 2
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 5
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 4
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                        local args = {
                            [1] = "UseAssistSkill",
                            [2] = {
                                ["hrpCFrame"] = getNearestMobs().HumanoidRootPart.CFrame
                            },
                            [3] = 1
                        }
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer(unpack(args))
                    end)
                end
            end
        end
    end
end)

local function checkQuest(questName)
    local PlayerGui = Players.PlayerGui.MainGui.CenterUIFrame.QuestFrame.QuestFrames.DailyQuestFrame.DailyQuestScrollingFrame[questName]
    if PlayerGui.QuestComplete:FindFirstChild("ExclamationPoint") then
        ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("CompleteDailyQuest", questName)
    end
end

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Auto/DailyQuest"] then
            if table.find(Lobby, game.PlaceId) then
                checkQuest("DailyQuest_Login")
                checkQuest("DailyQuest_Enemies")
                checkQuest("DailyQuest_DungeonClear")
                checkQuest("DailyQuest_Raid")
                checkQuest("DailyQuest_BossRush")
                checkQuest("DailyQuest_AllQuestClear")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Auto/RaidToken"] then
            if Players.PlayerGui.MainGui.CenterUIFrame.RaidShop.RaidShopUIHolder.RaidShopScrollingFrame.FreeDailyGemShopClaim.Visible then
                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("GiveFreeDailyGemFromShop")
                task.wait(5)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Auto/SpeedRaid"] then
            if table.find(Lobby, game.PlaceId) then
                local scrollingFrame         
                for _, v in pairs(Players.PlayerGui.MainGui.CenterUIFrame.SpeedRaidFrame:GetDescendants()) do
                    if v.Name == "SpeedRaidScrollingFrame" then
                        scrollingFrame = v
                        break
                    end
                end

                if scrollingFrame then
                    for _, child in pairs(scrollingFrame:GetChildren()) do
                        if string.match(child.Name, "SpeedRaidReward.") then
                            local RewardClaim = child:FindFirstChild("RewardClaim")
                            local cost = RewardClaim:FindFirstChild("Cost")
                            if cost.Text == "CLAIM" then
                                local number = tonumber(string.sub(child.Name, -1))
                                ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("ClaimWeeklySpeedRaidReward", number)
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while wait(Window.Flags["Auto/OpenDelay"]) do
        if Window.Flags["Auto/AutoCapsule"] then
            if table.find(Lobby, game.PlaceId) then
                if Window.Flags["Auto/Capsule"][1] ~= nil then
                    local price = Players.PlayerGui.MainGui.CenterUIFrame.Shop.Frame.RightShade.ShopPetScrollingFrame[Window.Flags["Auto/Capsule"][1]].CostBlack.Cost.Text
                    local token = Players.PlayerGui.MainGui.CenterUIFrame.Shop.Frame.ShopRaidTokenCounter.ShopRaidTokenAmount.Text:gsub(",", "")
                    local gems = Players.PlayerGui.MainGui.CenterUIFrame.Shop.Frame.ShopGemCounter.ShopGemAmount.Text:gsub(",", "")
                    if tonumber(price) <= tonumber(token) or tonumber(price) <= tonumber(gems) then
                        if Window.Flags["Auto/Capsule"][1] == "Raid Capsule" then
                            ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("BuyEgg","Raid Capsule 1")
                        else
                            ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("BuyEgg",Window.Flags["Auto/Capsule"][1])
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Player/HideNametag"] then
            pcall(function()
                Players.Character.Head.PlayerHealthBarGui:Destroy()
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                Players.CharacterAdded:Connect(function(player)
                    player.Humanoid.Died:Connect(function()
                        Players.Character.Head.PlayerHealthBarGui:Destroy()
                        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
                    end)
                end)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if Window.Flags["Player/AutoRejoin"] then
            game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(prompt)
                if prompt.Name == "ErrorPrompt" and prompt:FindFirstChild("MessageArea") and prompt.MessageArea:FindFirstChild("ErrorFrame") then
                    TeleportService:Teleport(6938803436, Players)
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Player/LeaveWhenRaidOpen"] then
            if not table.find(Lobby, game.PlaceId) then
                local CurrentTime = os.date("%H:%M")
                if string.sub(CurrentTime, -2) == "00" then
                    TeleportService:Teleport(6938803436, Players)
                end
                task.wait(60)
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Setting/Webhook"] then
            function getDimensionReward()
                local DimensionReward = {}
                local rewardGridFrame
                local uiVisible = Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.Visible or Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.RaidResultUI.Visible

                if uiVisible then
                    if Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.Visible then
                        rewardGridFrame = Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.RewardFrame.RewardGridFrame
                    elseif Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.RaidResultUI.Visible then
                        for _,c in pairs(Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.RaidResultUI.Frame:GetDescendants()) do
                            if c.Name == "RaidRewardGridFrame" then
                                rewardGridFrame = c
                                break
                            end
                        end
                    end

                    if rewardGridFrame then
                        for _,v in pairs(rewardGridFrame:GetChildren()) do
                            if v.Name ~= "UIGridLayout" then
                                if DimensionReward[v.Name] then
                                    DimensionReward[v.Name] = DimensionReward[v.Name] + 1
                                else
                                    DimensionReward[v.Name] = 1
                                end
                            end
                        end
                        local DimensionRewardString = ""
                        for k,v in pairs(DimensionReward) do
                            if v > 1 then
                                DimensionRewardString = DimensionRewardString .. " - " .. k .. " x" .. v .. "\n"
                            else
                                DimensionRewardString = DimensionRewardString .. " - " .. k .. "\n"
                            end
                        end
                        return "```md".."\n".."# Rewards".."\n".. DimensionRewardString .. "```"
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Window.Flags["Setting/Webhook"] then
            local rewards = getDimensionReward()
            if rewards then
                local embed = {
                        ["title"] = "Anime Dimensions Simulator",
                        ["type"] = "rich",
                        ["color"] = 8913097,
                        ["thumbnail"] = {
                            ["url"] = "https://tr.rbxcdn.com/ca07113fc6127bf3e8196f9d3a9086c8/512/512/Image/Png"
                        },
                        ["image"] = {
                            ["url"] = "https://tr.rbxcdn.com/3eba3ee83f4f32a0691f8e40738f1833/768/432/Image/Png"
                        },
                        ["footer"] = {
                            ["text"] = "Bubble",
                            ["icon_url"] = "https://media.discordapp.net/attachments/859027411366969364/1067274572212228116/2.png"
                        },
                        ["description"] =
                        "**Username: **"..Players.Name.."\n"..
                        "**Level: **"..Players.leaderstats.Level.Value.."\n"..
                        "**Player XP: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].Experience.Value.."/"..ReplicatedStorage[Players.Name .. "StatDisplay"].MaxExperience.Value.."\n"..
                        "**Card Inventory: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].CardsOwned.Value.."/"..ReplicatedStorage[Players.Name .. "StatDisplay"].MaxCardsOwned.Value.."\n"..
                        "**Best Combo**: "..ReplicatedStorage[Players.Name .. "StatDisplay"].BestCombo.Value.."\n"..
                        "**Defeat Enemies: **"..ReplicatedStorage[Players.Name .. "StatDisplay"].EnemiesDefeatedRound.Value.."\n"..
                        "**Exploit Detected**: "..tostring(ReplicatedStorage[Players.Name .. "StatDisplay"].ExploitsDetected.Value).."\n"..
                        rewards .."\n"..
                        "[**Contact us!**](https://discord.gg/ZSQzPK3t2f)",
                        ["timestamp"] = DateTime.now():ToIsoDate()
                    }
                if Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.Visible then
                    webhook(embed, "")
                    task.wait(15)
                elseif Players.PlayerGui.UniversalGui.UniversalCenterUIFrame.RaidResultUI.Visible then
                    webhook(embed, "")
                    task.wait(15)
                end
            end
        end
    end
end)

Bubble.Utilities.Misc:SettingsSection(Window,"RightShift")
Bubble.Utilities.Misc:SetupWatermark(Window)
Bubble.Utilities.Misc:InitAutoLoad(Window)
