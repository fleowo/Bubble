local Bracket = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players").LocalPlayer

local Window = Bracket:Window({Name = "Bubble - Sword Slasher",Enabled = true,Position = UDim2.new(0.05,0,0.5,-248)}) do Window:Watermark({Enabled = true})

    local MainTab = Window:Tab({Name = "Main"}) do
        local FarmingSection = MainTab:Section({Name = "Farming"}) do
            FarmingSection:Dropdown({Name = "Farming Area",Flag = "Farming/FarmArea",List = {{Name = "Normal", Value = true},{Name = "Space"},{Name = "Lava"}}})
            FarmingSection:Toggle({Name = "Auto Farm",Flag = "Farming/AutoFarm"})
            FarmingSection:Toggle({Name = "Auto Rebirth",Flag = "Farming/AutoRebirth"})
            FarmingSection:Divider({Text = "Auto Attack"})
            FarmingSection:Toggle({Name = "Auto Attack",Flag = "Farming/AutoAttack"})
            FarmingSection:Slider({Name = "Delay",Wide = true,Flag = "Farming/AttackDelay",Min = 0,Max = 10,Value = 1,Precise = 1,Unit = "second"})
        end
        local UpgradeSection = MainTab:Section({Name = "Upgrade", Side = "Right"}) do
            UpgradeSection:Toggle({Name = "Damage",Flag = "Upgrade/AutoStatsDamage"})
            UpgradeSection:Toggle({Name = "Health",Flag = "Upgrade/AutoStatsHealth"})
            UpgradeSection:Toggle({Name = "Regen",Flag = "Upgrade/AutoStatsRegen"})
            UpgradeSection:Toggle({Name = "Speed",Flag = "Upgrade/AutoStatsSpeed"})
            UpgradeSection:Toggle({Name = "Critical Hit",Flag = "Upgrade/AutoStatsCritical"})
            UpgradeSection:Slider({Name = "Point",Wide = true,Flag = "Upgrade/PointSpend",Min = 1,Max = 100,Value = 1,Precise = 0,Unit = ""})
        end
        local EggsSection = MainTab:Section({Name = "Egg", Side = "Right"}) do local EggList = {}
            EggsSection:Toggle({Name = "Auto Hatch",Flag = "Eggs/AutoHatch"})
            EggsSection:Toggle({Name = "Triple Hatch",Flag = "Eggs/TripleHatch"})
            for _,v in pairs(Workspace.Eggs:GetChildren()) do
                if v.Name == "Space" or v.Name == "Volcano" then
                    for _,c in pairs(v:GetChildren()) do
                        EggList[#EggList + 1] = {Name = c.Name}
                    end
                end
                if not string.match(v.Name, "Exclusiv.") and v:IsA("Model") and v.Name ~= "Default" then
                    EggList[#EggList + 1] = {Name = v.Name}
                end
            end 
            EggsSection:Dropdown({Name = "Select Egg",Flag = "Eggs/EggList", List = EggList})
        end
        local PlayerSection = MainTab:Section({Name = "Player", Side = "Left"}) do
            PlayerSection:Toggle({Name = "White Screen",Flag = "Player/WhiteScreen",Value = false,Callback = function(Value) 
            if Value then 
                Game:GetService("RunService"):Set3dRenderingEnabled(false)
            else 
                game:GetService("RunService"):Set3dRenderingEnabled(true) 
            end end})
            PlayerSection:Slider({Name = "WalkSpeed",Flag = "Player/WalkSpeed",Min = 10,Max = 300,Value = 16,Precise = 0,Unit = "studs/s",Callback = function(Value) Players.Character.Humanoid.WalkSpeed = Value end})
            PlayerSection:Slider({Name = "JumpHight",Flag = "Player/JumpHight",Min = 10,Max = 300,Value = 50,Precise = 0,Unit = "studs",Callback = function(Value) Players.Character.Humanoid.JumpHeight = Value end})
        end
    end
end

task.spawn(function()
    while true do task.wait(3)
        if Methods == 1 then
            Methods = 2
            Method = CFrame.new(0,0,7)
        else
            Methods = 1
            Method = CFrame.new(0,0,8)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Farming/AutoFarm"] then
            if Players.Character and Players.Character:FindFirstChild("Humanoid") and Players.Character:FindFirstChild("Humanoid").Health > 0 then
                pcall(function()
                    for i,v in pairs(Workspace.Mobs:GetChildren()) do
                        if v.Name == "Model" then
                            local mon = v.HumanoidRootPart
                            for i2,v2 in pairs(Workspace.Mobs:GetChildren()) do
                                if v2.Name == "Model" and v ~= v2 then
                                    local otherMon = v2.HumanoidRootPart
                                    otherMon.CFrame = mon.CFrame
                                    otherMon.CanCollide = false
                                end
                            end
                        end
                    end

                    for i,v in pairs(Workspace.Mobs:GetChildren()) do
                        if v.Name == "Model" then
                            Players.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * Method
                        end
                    end
                end)

                waveFound = false
                for _, child in pairs(ReplicatedStorage:GetChildren()) do
                    if string.match(child.Name, "Wave.") then
                        waveFound = true
                        break
                    end
                end

                if not waveFound then
                    if Window.Flags["Farming/FarmArea"][1] == "Normal" then
                        Players.Character.HumanoidRootPart.CFrame = CFrame.new(-0.155442566, 2.5058918, -24.7257271, 0.997494578, 1.3970987e-08, 0.0707433, -6.4340675e-09, 1, -1.06766855e-07, -0.0707433, 1.0604419e-07, 0.997494578)
                    elseif Window.Flags["Farming/FarmArea"][1] == "Space" then
                        Players.Character.HumanoidRootPart.CFrame = CFrame.new(797.648438, 2.5058918, -30.6170845, 0.99572593, -4.2951207e-08, 0.0923573524, 3.17721423e-08, 1, 1.22511722e-07, -0.0923573524, -1.19053702e-07, 0.99572593)
                    elseif Window.Flags["Farming/FarmArea"][1] == "Lava" then
                        Players.Character.HumanoidRootPart.CFrame = CFrame.new(1678.59021, 2.5058918, -30.6615372, 0.999519229, -2.99323299e-09, -0.0310042612, 1.6955248e-11, 1, -9.59960218e-08, 0.0310042612, 9.59493462e-08, 0.999519229)
                    end
                end
            end
        end
    end
end)

local function RebirthCost()
    return 150000 * Players.Data.Rebirth.Value * 5 + 500000
end

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoRebirth"] then
            local Cost = RebirthCost()
            if Cost <= Players.Data.Gems.Value then
                ReplicatedStorage.EventStorage.Rebirth:InvokeServer()
                break
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Window.Flags["Farming/AttackDelay"]) do
        if Window.Flags["Farming/AutoAttack"] then
            ReplicatedStorage.EventStorage.Attack:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do

        if Window.Flags["Upgrade/AutoStatsDamage"] then
            if Players.Data.Points.Value >= 1 then
                local args = {
                    [1] = "Strength",
                    [2] = Window.Flags["Upgrade/PointSpend"]
                }
                ReplicatedStorage.EventStorage.Upgrade:InvokeServer(unpack(args))
            end
        end

        if Window.Flags["Upgrade/AutoStatsHealth"] then
            if Players.Data.Points.Value >= 1 then
                local args = {
                    [1] = "Defence",
                    [2] = Window.Flags["Upgrade/PointSpend"]
                }
                ReplicatedStorage.EventStorage.Upgrade:InvokeServer(unpack(args))
            end
        end

        if Window.Flags["Upgrade/AutoStatsRegen"] then
            if Players.Data.Points.Value >= 1 then
                local args = {
                    [1] = "Regen",
                    [2] = Window.Flags["Upgrade/PointSpend"]
                }
                ReplicatedStorage.EventStorage.Upgrade:InvokeServer(unpack(args))
            end
        end

        if Window.Flags["Upgrade/AutoStatsSpeed"] then
            if Players.Data.Points.Value >= 1 then
                local args = {
                    [1] = "Agility",
                    [2] = Window.Flags["Upgrade/PointSpend"]
                }
                ReplicatedStorage.EventStorage.Upgrade:InvokeServer(unpack(args))
            end
        end

        if Window.Flags["Upgrade/AutoStatsCritical"] then
            if Players.Data.Points.Value >= 1 then
                local args = {
                    [1] = "Luck",
                    [2] = Window.Flags["Upgrade/PointSpend"]
                }
                ReplicatedStorage.EventStorage.Upgrade:InvokeServer(unpack(args))
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Eggs/AutoHatch"] then
            for _, egg in pairs(Workspace.Eggs:GetDescendants()) do
                if egg.Name == Window.Flags["Eggs/EggList"][1] then
                    local price = egg.stand.SurfaceGui.Gems.TextLabel.Text:gsub(",", "")
                    if tonumber(price) <= Players.Data.Gems.Value then
                        ReplicatedStorage.EventStorage.EggHandler:FireServer(Window.Flags["Eggs/EggList"][1], 1)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if Window.Flags["Eggs/TripleHatch"] then
            for _, egg in pairs(Workspace.Eggs:GetDescendants()) do
                if egg.Name == Window.Flags["Eggs/EggList"][1] then
                    local price = egg.stand.SurfaceGui.Gems.TextLabel.Text:gsub(",", "") * 3
                    if tonumber(price) <= Players.Data.Gems.Value then
                        ReplicatedStorage.EventStorage.EggHandler:FireServer(Window.Flags["Eggs/EggList"][1], 3)
                    end
                end
            end
        end
    end
end)

Bubble.Utilities.Misc:SettingsSection(Window,"RightShift")
Bubble.Utilities.Misc:SetupWatermark(Window)
Bubble.Utilities.Misc:InitAutoLoad(Window)
