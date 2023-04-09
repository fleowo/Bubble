local Bracket = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local NetworkModules = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"))

local Window = Bracket:Window({Name = "Bubble - Fly Race",Enabled = true,Position = UDim2.new(0.05,0,0.5,-248)}) do Window:Watermark({Enabled = true})

    local MainTab = Window:Tab({Name = "Main"}) do
        local FarmingSection = MainTab:Section({Name = "Farming"}) do
            FarmingSection:Toggle({Name = "Auto Laps",Flag = "Farming/AutoLap"})
            FarmingSection:Toggle({Name = "Auto Studs",Flag = "Farming/AutoStud"})
            FarmingSection:Toggle({Name = "Auto Orbs",Flag = "Farming/AutoOrb"})
            FarmingSection:Toggle({Name = "Auto Rebirth",Flag = "Farming/AutoRebirth"})
        end
        local EggSection = MainTab:Section({Name = "Egg",Side = "Right"}) do local EggList = {}
            EggSection:Toggle({Name = "Auto Craft",Flag = "Egg/AutoCraft"})
            EggSection:Toggle({Name = "Auto Hatch",Flag = "Egg/AutoHatch"})
            for i,v in pairs(Workspace.Eggs:GetChildren()) do
                if not table.find(EggList, {Name = v.Name}) then
                    table.insert(EggList, {Name = v.Name})
                end
            end 
            EggSection:Dropdown({Name = "Egg",Flag = "Egg/EggList", List = EggList})
        end
        local PlayerSection = MainTab:Section({Name = "Player", Side = "Right"}) do
            PlayerSection:Toggle({Name = "White Screen",Flag = "Player/WhiteScreen",Value = false,Callback = function() 
            if Value then 
                RunService:Set3dRenderingEnabled(false)
            else 
                RunService:Set3dRenderingEnabled(true) 
            end end})
            PlayerSection:Slider({Name = "WalkSpeed",Flag = "Player/WalkSpeed",Min = 10,Max = 300,Value = 16,Precise = 0,Unit = "studs/s",Callback = function(Value) Players.Character.Humanoid.WalkSpeed = Value end})
            PlayerSection:Slider({Name = "JumpHight",Flag = "Player/JumpHight",Min = 10,Max = 300,Value = 50,Precise = 0,Unit = "studs",Callback = function(Value) Players.Character.Humanoid.JumpHeight = Value end})
        end
    end
end

task.spawn(function()
    while task.wait() do
        if Window.Flags["Farming/AutoLap"] then 
            pcall(function()
                Players.Character.HumanoidRootPart.CFrame = Workspace.LandSpots1.End.CFrame 
                task.wait()
                firetouchinterest(Player.Character.HumanoidRootPart, Workspace.Worlds[Players.WorldsData.Current.Value].Launch, 0)
                firetouchinterest(Player.Character.HumanoidRootPart, Workspace.Worlds[Players.WorldsData.Current.Value].Launch, 1) 
            end)
        end
    end 
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Farming/AutoStud"] then
            for i,v in pairs(Workspace:GetChildren()) do
                if v:FindFirstChild("End") then
                    firetouchinterest(Players.Character.HumanoidRootPart, Workspace.Worlds[Players.WorldsData.Current.Value].Launch, 0)
                    firetouchinterest(Players.Character.HumanoidRootPart, Workspace.Worlds[Players.WorldsData.Current.Value].Launch, 1) task.wait(1)
                    firetouchinterest(Players.Character.HumanoidRootPart, v.Land, 0)
                    firetouchinterest(Players.Character.HumanoidRootPart, v.Land, 1)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Farming/AutoOrb"] then
            for i,v in pairs(Workspace.Camera:GetChildren()) do
                if v:IsA("BasePart") then
                    NetworkModules.send("claimorb", i)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Window.Flags["Farming/AutoRebirth"] then
            if Players.PlayerGui.Main.SideTabs.Big.Rebirths.Main.Unchecked.Visible then
               NetworkModules.send("rebirth")
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Egg/AutoHatch"] then
            if Window.Flags["Egg/EggList"][1] ~= nil then
                Players.Character.HumanoidRootPart.CFrame = Workspace.Eggs[Window.Flags["Egg/EggList"][1]].UIanchor.CFrame + Vector3.new(0, 0, 5)
                local args = {
                    [1] = Window.Flags["Egg/EggList"][1],
                    [2] = "Single"
                }
                ReplicatedStorage.RemoteEvents.EggOpened:InvokeServer(unpack(args)) task.wait(3)
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Window.Flags["Egg/AutoCraft"] then
            for i,v in pairs(Players.Pets:GetDescendants()) do
                if v:IsA("NumberValue") and v.Name == "PetID" then
                    local args = {
                        [1] = "CraftAll",
                        [2] = {["PetID"] = v.Value}
                    }
                    ReplicatedStorage.RemoteEvents.PetActionRequest:InvokeServer(unpack(args))
                end
            end task.wait(5)
        end
    end
end)

Bubble.Utilities.Misc:SettingsSection(Window,"RightShift")
Bubble.Utilities.Misc:SetupWatermark(Window)
Bubble.Utilities.Misc:InitAutoLoad(Window)
