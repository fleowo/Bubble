local Bracket = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players").LocalPlayer
local Character = Players.Character or Players.CharacterAdded:Wait()
local Codes = {"RELEASE","NODELAY","HUNTER","UPDATE3","ONEPUNCH","JOJO","JUJUTSU","5KLIKES","BANKAI","SOLO","DUNGEON"}
repeat task.wait() until Workspace.Game.PlayerIslands[Players.Name]:FindFirstChild("spawnedAllies")

local Window = Bracket:Window({Name = "Bubble - Anime Idle Simulator",Enabled = true,Position = UDim2.new(0.05,0,0.5,-248)}) do Window:Watermark({Enabled = true})

    local MainTab = Window:Tab({Name = "Main"}) do
        local FarmingSection = MainTab:Section({Name = "Farming"}) do
            FarmingSection:Toggle({Name = "Auto Mob",Flag = "Farming/AutoMob"})
            FarmingSection:Toggle({Name = "Auto Swing",Flag = "Farming/AutoSwing"})
            FarmingSection:Toggle({Name = "Auto Skill",Flag = "Farming/AutoSkill"})
            FarmingSection:Slider({Name = "Swing Delay",Flag = "Farming/AutoSwing/Delay",Min = 0,Max = 10,Value = 0.5,Precise = 1,Unit = "second"})
            FarmingSection:Slider({Name = "Skill Delay",Flag = "Farming/AutoSkill/Delay",Min = 0,Max = 10,Value = 0.5,Precise = 1,Unit = "second"})
        end
        local UpgradeSection = MainTab:Section({Name = "Upgrade"}) do local Unit = {}
            UpgradeSection:Toggle({Name = "Auto Upgrade",Flag = "Upgrade/AutoUpgrade"})
            UpgradeSection:Toggle({Name = "Auto Upgrade All",Flag = "Upgrade/AutoUpgrade/All"})
            UpgradeSection:Slider({Name = "Upgrade Delay",Flag = "Upgrade/AutoUpgrade/Delay",Min = 0,Max = 10,Value = 0.5,Precise = 1,Unit = "second"})
            for _,v in pairs(Workspace.Game.PlayerIslands[Players.Name].spawnedAllies:GetChildren()) do
                if not table.find(Unit, {Name = v.Name}) then
                    table.insert(Unit, {Name = v.Name, Mode = "Toggle"})
                end
            end
            UpgradeSection:Dropdown({Name = "Unit",Flag = "Upgrade/Unit",List = Unit})
            UpgradeSection:Dropdown({Name = "Amount",Flag = "Upgrade/Amount", List = {{Name = "x1",Value = true},{Name = "x10"},{Name = "x25"},{Name = "x100"}}})
        end
        local GameplaySection = MainTab:Section({Name = "Gameplay"}) do
            GameplaySection:Toggle({Name = "Auto Hire",Flag = "Gameplay/AutoHire"})
            GameplaySection:Toggle({Name = "Auto Next Level",Flag = "Gameplay/AutoNextLevel"})
            GameplaySection:Toggle({Name = "Auto Reincarnate",Flag = "Gameplay/AutoReincarnate"})
        end
        local ClaimSection = MainTab:Section({Name = "Auto Claim",Side = "Right"}) do
            ClaimSection:Toggle({Name = "Playtime",Flag = "Claim/Playtime"})
            ClaimSection:Toggle({Name = "Achivements",Flag = "Claim/Achivements"})
            ClaimSection:Toggle({Name = "Daily Spin",Flag = "Claim/DailySpin"})
            ClaimSection:Toggle({Name = "Daily Chest",Flag = "Claim/DailyChest"})
            ClaimSection:Button({Name = "Redeem Code",Callback = function()
                for _,v in pairs(Codes) do
                    ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.UpdateCodes:FireServer("EnterCode", v)
                end
            end})
        end
        local ChestSection = MainTab:Section({Name = "Chest",Side = "Left"}) do local Chest = {}
            ChestSection:Toggle({Name = "Auto Chest",Flag = "Chest/AutoChest"})
            ChestSection:Slider({Name = "Open Delay",Flag = "Chest/AutoChest/Delay",Min = 0,Max = 10,Value = 0.5,Precise = 1,Unit = "second"})
            for _,v in pairs(ReplicatedStorage["_GAME"]["_DATA"].Chests.Chests:GetChildren()) do
                if v.Name ~= "Heroic Chest" then
                    Chest[#Chest + 1] = {Name = v.Name}
                end
            end
            ChestSection:Dropdown({Name = "Chest",Flag = "Chest/Chest",List = Chest})
        end
    end
end

task.spawn(function()
    while task.wait() do
        if Window.Flags["Farming/AutoMob"] then
            if not nextLevel then
                pcall(function()
                    for i,v in pairs(Workspace.Game.Hits:GetDescendants()) do
                        if v:IsA("Part") and v.Name == "hitbox" then
                            Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 0, 2)
                        end
                    end
                end)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Farming/AutoSwing/Delay"]) do
        if Window.Flags["Farming/AutoSwing"] then
            ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Functions.Weapon:InvokeServer("Swing")
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Farming/AutoSkill/Delay"]) do
        if Window.Flags["Farming/AutoSkill"] then
            pcall(function()
                for _,v in pairs(ReplicatedStorage["_GAME"]["_DATA"].Skills.Skills:GetChildren()) do
                    local Cooldown = Players.PlayerGui.HUD.ActiveSkills.List[v.Name].Skill.Cooldown.Visible
                    if not Cooldown then
                        ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Skills:FireServer("Use", v.Name)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        local SkipScene = Players.PlayerGui.Hire.Holder.MainFrame.SkipFrame.Toggle.Icon.Visible
        if not SkipScene then
            ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.UpdateSettings:FireServer("CanSkipHireScene")
        elseif Players.PlayerGui.Feedback:FindFirstChild("Verification") then
            Players.PlayerGui.Feedback.Verification:Destroy()
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Upgrade/AutoUpgrade/Delay"]) do
        if Window.Flags["Upgrade/AutoUpgrade"] then
            pcall(function()
                for _,z in pairs(Window.Flags["Upgrade/Unit"]) do
                    for i,v in pairs(Workspace.Game.PlayerIslands[Players.Name].spawnedAllies:GetChildren()) do
                        if v.Name == z then
                            local newAmount = string.sub(Window.Flags["Upgrade/Amount"][1], 2)
                            ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Allies:FireServer("Upgrade", i, tonumber(newAmount))
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Upgrade/AutoUpgrade/Delay"]) do
        if Window.Flags["Upgrade/AutoUpgrade/All"] then
            pcall(function()
                for i,v in pairs(Workspace.Game.PlayerIslands[Players.Name].spawnedAllies:GetChildren()) do
                    local newAmount = string.sub(Window.Flags["Upgrade/Amount"][1], 2)
                    ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Allies:FireServer("Upgrade", i, tonumber(newAmount))
                end
            end)
        end
    end
end)

local function convertPrice(priceString)
    local numericalValue, multiplier = string.lower(priceString):match("(%d+%.?%d*)(%a?)")
    local multipliers = { k = 1e3, m = 1e6, b = 1e9, t = 1e12 , q = 1e15}
    return tonumber(numericalValue) * (multipliers[multiplier] or 1)
end

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Gameplay/AutoHire"] then
            local Cost = Players.PlayerGui.Hire.Holder.MainFrame.Unit1.YenAmount.Text
            local Yen = Players.PlayerData.Stats.Yen.Value
            if tonumber(Yen) >= convertPrice(Cost) then
                ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Allies:FireServer("Hire")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Gameplay/AutoNextLevel"] then
            local NextLevel = Workspace.Game.PlayerIslands[Players.Name].Buttons.NextLevel["Meshes/Circle"]
            if NextLevel.Transparency ~= 1 then
                nextLevel = true
                Character.HumanoidRootPart.CFrame = NextLevel.CFrame + Vector3.new(4, 1, 0)
                Character:FindFirstChildOfClass("Humanoid"):MoveTo(NextLevel.Position)
            else
                nextLevel = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Window.Flags["Gameplay/AutoReincarnate"] then
            local LevelText = Players.PlayerGui.HUD.Up.Level.Label.Text
            local Level = string.sub(LevelText, 7)
            pcall(function()
                if tonumber(Level) >= 70 then
                    ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Reincarnate:FireServer()
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Claim/Playtime"] then
            for i = 1, 10 do
                if Players.PlayerGui.HUD.Left["Up Buttons"]["Playtime Rewards"].Claimable.Visible then
                    ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Rewards:FireServer("ClaimPlaytimeReward", i)
                end
            end
        end
    end
end)

local function convertNumber(number)
    local romanToArabicTable = {I = 1,V = 5,X = 10,L = 50,C = 100,D = 500,M = 1000}
    local result, prev = 0, 0
    for i = #number, 1, -1 do
        local curr = romanToArabicTable[string.sub(number, i, i)]
        result, prev = result + curr * (curr >= prev and 1 or -1), curr
    end
    return result
end

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Claim/Achivements"] then
            for _,v in pairs(Players.PlayerGui.Achievements.Holder.MainFrame.List:GetDescendants()) do
                if v.Name == "Claimable" and v.Visible == true then
                    local Achievement = tostring(v.Parent)
                    local Name = string.match(Achievement, "^%S+")
                    local Id = string.match(Achievement, "%S+$")
                    ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Functions["Claim Achievement"]:InvokeServer(Name, convertNumber(Id))
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Claim/DailySpin"] then
            if Players.PlayerGui["Daily Spin"].Holder.SpinButton.Title.Text == "Spin" then
                ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Rewards:FireServer("PerformDailySpin")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Claim/DailyChest"] then
            if Workspace.MainIsland.Chests["Daily Chest"].Chest.Display.Display.Interface.Frame.Value.Text == "Ready To Collect!" then
                ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.UpdateChests:FireServer("CollectReward", "Daily Chest")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Chest/AutoChest/Delay"]) do
        if Window.Flags["Chest/AutoChest"] then
            if Window.Flags["Chest/Chest"][1] ~= nil then
                ReplicatedStorage._GAME._MODULES.Utilities.NetworkUtility.Events.Chests:FireServer("Purchase", Window.Flags["Chest/Chest"][1])
            end
        end
    end
end)

Bubble.Utilities.Misc:SettingsSection(Window,"RightShift")
Bubble.Utilities.Misc:SetupWatermark(Window)
Bubble.Utilities.Misc:InitAutoLoad(Window)
