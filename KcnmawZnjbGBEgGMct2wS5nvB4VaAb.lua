local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local VERSION = "1.0.0"
local MAINFILE = "Project Ninja Assassin v" .. VERSION .. " Settings.txt"

local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local Workspace = cloneref(game:GetService("Workspace"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local TweenService = cloneref(game:GetService("TweenService"))
local Lighting = cloneref(game:GetService("Lighting"))

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Options = Fluent.Options
local Variables = {}
local Functions = {}
Functions.NinjutsuChanged = {}
Functions.CharacterAdded = {}
Functions.PlayerAdded = {}
Functions.PlayerRemoved = {}
Functions.UserInputBegan = {}
Functions.UserInputEnded = {}
Functions.CharacterTouched = {}
Functions.WhitelistCharacterTouched = {}
Functions.WorkspaceDescendantAdded = {}
Functions.WorkspaceDescendantRemoved = {}

local Constants = {
    BodyParts = {"Head","HumanoidRootPart","UpperTorso","LowerTorso","RightUpperArm","LeftUpperArm","RightLowerArm","LeftLowerArm","RightHand","LeftHand","RightUpperLeg","LeftUpperLeg","RightLowerLeg","LeftLowerLeg","RightFoot", "LeftFoot"};
    Modes = {'Soft', 'Semi', 'Normal', 'Permanent'};
}

local Lists = {
    Whitelist = {
        Soft = {};
        Semi = {};
        Normal = {};
        Permanent = {};
    };
    Blacklist = {
        Soft = {};
        Semi = {};
        Normal = {};
        Permanent = {};
    };
    Targetlist = {
        Soft = {};
        Semi = {};
        Normal = {};
        Permanent = {};
    };
    BreakShurlist = {
        Soft = {};
        Semi = {};
        Normal = {};
        Permanent = {};
    };
    DisableShurslist = {
        Soft = {};
        Semi = {};
        Normal = {};
        Permanent = {};
    };
}

local AutoExecuteFuncs = {
    InfiniteYield = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

        --[[
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            local uiElement = gui:FindFirstChild("VegaXAndroidUI")
            if uiElement then
                local chatLogs = ui Element:FindFirstChild("selectChat", true).Parent.chat.scroll
                chatLogs.ChildAdded:Connect(function(child)
                if not child.RichText then
                    child.RichText = true
                end
            end)
        end]]
    end;
    --[[StatsImprover = function()

            --Update Player Stats
            local function updatePlayerStats(player)
                if player:FindFirstChild("leaderstats") then
                    for_, stat in ipairs (player.leaderstats:GetChildren()) do
                        stat:GetPropertyChangedSignal("Value"):Connect(function()
                        updateTeamStats()
                    end)
                end
            end
        end

        -- Attach Listeners
        Players.PlayerAdded:Connect(updatePlayerStats)
        for _, player in ipairs (Players:GetPlayers()) do
            updatePlayerStats(player)
        end
        end;
        }

        -- Tried and gave up 💀 - Dark_Turns

        local numofstats = 0
        for i,v in ipairs(Players.LocalPlayer:FindFirstChild("leaderstats"):GetChildren()) do
            numofstats = numofstats + 1
        end
        local numnum = numofstats * 110
        local xvalue = numnum + 172
        local divxvalue = xvalue - 110
        local coregui = game:GetService("CoreGui")
        local playerlist = coregui:FindFirstChild("RoactAppExperimentProvider") or coregui:FindFirstChild("PlayerList")
        local Teams = game:GetService("Teams")
        local plrlistmaster = playerlist:FindFirstChild("PlayerListMaster") or playerlist:FindFirstChild("Children")
        local offsetframe = plrlistmaster:FindFirstChild("OffsetFrame") or playerlistmaster:FindFirstChild("Children") -- among us
        local plrsandteams = plrlistmaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
        local titlebar = plrlistmaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame:WaitForChild("TitleBar")
        local suffixes = {'','K+','M+','B+','T+','qd+','Qn+','sx+','Sp+','O+','N+','de+','Ud+','DD+','tdD+','qdD+','QnD+','sxD+','SpD+','OcD+','NvD+','Vgn+','UVg+','DVg+','TVg+','qtV+','QnV+','SeV+','SPG+','OVG+','NVG+','TGN+','UTG+','DTG+','tsTG+','qtTG+','QnTG+','ssTG+','SpTG+','OcTG+','NoAG+','UnAG+','DuAG+','TeAG+','QdAG+','QnAG+','SxAG+','SpAG+','OcAG+','NvAG+','CT+'}
        local TeamValues = {}
        local PlayerValues = {}
        local Exceptions = {
            ['Reputation'] = 1;
            ['Power'] = 1;
        }
        local LBExceptions = {
            ['Realm'] = 150;
        }

        local function comma_value(n)
            if tonumber(n) then
                local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
                return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
            else
                return n
            end
        end
        local function format(val)
            if tonumber(val) then
                local negative = false
                if string.sub(val,1,1) == "-" then
                    val = string.sub(val,2,string.len(val))
                    negative = true
                end
                for i=1, #suffixes do
                    if tonumber(val) < 10^(i*3) then
                        local value = math.floor(val/((10^((i-1)*3))/100))/(100)..suffixes[i]
                        if negative then value = "-"..value end
                        return value
                    end
                end
            else
                return val
            end
        end
        local function GetPlayer(text)
            for _,Player in pairs(game.Players:GetPlayers()) do
                if string.sub(string.lower(Player.Name),1,string.len(text)) == string.lower(text) then
                    return Player
                elseif string.sub(string.lower(Player.DisplayName),1,string.len(text)) == string.lower(text) then
                    return Player
                elseif Player.UserId == tonumber(text) then
                    return Player
                end
            end
        end
        local function UpdateTeamValues()
            for i,v in pairs(TeamValues) do
                TeamValues[i] = 0
            end
            local plr
            for i,v in pairs(Players:GetPlayers()) do
                if v:FindFirstChild("leaderstats") then
                    plr = v
                    for i,v in pairs(v:FindFirstChild("leaderstats"):GetChildren()) do
                        if tonumber(v.Value) then
                            TeamValues[plr.Team.Name.."_"..v.Name] = TeamValues[plr.Team.Name.."_"..v.Name] + v.Value
                        end
                    end
                end
            end
            for i,v in pairs(plrsandteams:GetChildren()) do
                if string.sub(v.Name,1,1) == "t" then
                    for i,v in pairs(v:GetChildren()) do
                        if string.lower(string.sub(v.Name,1,8)) == "gamestat" then
                            local statname = string.sub(v.Name,10,string.len(v.Name))
                            if Exceptions[statname] then
                                if tonumber(TeamValues[v.Parent.NameFrame.BGFrame.OverlayFrame.TeamName.Text.."_"..statname]) then
                                    v.OverlayFrame.StatText.Text = format(TeamValues[v.Parent.NameFrame.BGFrame.OverlayFrame.TeamName.Text.."_"..statname])
                                else
                                    v.OverlayFrame.StatText.Text = "-"
                                end
                            else
                                if tonumber(TeamValues[v.Parent.NameFrame.BGFrame.OverlayFrame.TeamName.Text.."_"..statname]) then
                                    v.OverlayFrame.StatText.Text = comma_value(TeamValues[v.Parent.NameFrame.BGFrame.OverlayFrame.TeamName.Text.."_"..statname])
                                else
                                    v.OverlayFrame.StatText.Text = "-"
                                end
                            end
                        end
                    end
                end
            end
        end
        local function UpdatePlayerStats(plr)
            repeat task.wait(0.1) until plr:FindFirstChild("leaderstats")
            for i,v in pairs(plr:FindFirstChild("leaderstats"):GetChildren()) do
                if not PlayerValues[plr.Name.."_"..v.Name] then
                    PlayerValues[plr.Name.."_"..v.Name] = 0
                end
                PlayerValues[plr.Name.."_"..v.Name] = v.Value
            end
            for i,v in pairs(plrsandteams:GetChildren()) do
                if string.sub(v.Name,1,1) == "p" then
                    if GetPlayer(string.sub(v.Name,3,string.len(v.Name))) == plr then
                        for i,v in pairs(v.ChildrenFrame:GetChildren()) do
                            if string.lower(string.sub(v.Name,1,8)) == "gamestat" then
                                local statname = string.sub(v.Name,10,string.len(v.Name))
                                if Exceptions[statname] then
                                    v.OverlayFrame.StatText.Text = format(PlayerValues[plr.Name.."_"..statname])
                                else
                                    v.OverlayFrame.StatText.Text = comma_value(PlayerValues[plr.Name.."_"..statname])
                                end
                            end
                        end
                    end
                end
            end
        end
        local function UpdatePlayerListSize()
            for i,v in pairs(plrsandteams:GetChildren()) do
                if string.sub(v.Name,1,1) == "t" then
                    for i,v in pairs(v:GetChildren()) do
                        if v.Name == "BackgroundExtender" then
                            if v.Size ~= UDim2.new(1,0,1,0) then
                                v.Size = UDim2.new(1,0,1,0)
                            end
                        end
                        if string.lower(string.sub(v.Name,1,8)) == "gamestat" then
                            local statname = string.sub(v.Name,10,string.len(v.Name))
                            if v.Size ~= UDim2.new(1,-divxvalue,1,0) then
                                v.Size = UDim2.new(1,-divxvalue,1,0)
                            end
                        end
                    end
                elseif string.sub(v.Name,1,1) == "p" then
                    for i,v in pairs(v.ChildrenFrame:GetChildren()) do
                        if v.Name == "BackgroundExtender" then
                            if v.Size ~= UDim2.new(1,0,1,0) then
                                v.Size = UDim2.new(1,0,1,0)
                            end
                        end
                        if string.lower(string.sub(v.Name,1,8)) == "gamestat" then
                            local statname = string.sub(v.Name,10,string.len(v.Name))
                            if v.Size ~= UDim2.new(1,-divxvalue,1,0) then
                                v.Size = UDim2.new(1,-divxvalue,1,0)
                            end
                        end
                    end
                end
            end
            for i,v in pairs(titlebar.ChildrenFrame:GetChildren()) do
                if string.lower(string.sub(v.Name,1,4)) == "stat" then
                    local statname = string.sub(v.Name,10,string.len(v.Name))
                    if v.Size ~= UDim2.new(1,-divxvalue,1,0) then
                        v.Size = UDim2.new(1,-divxvalue,1,0)
                    end
                end
            end
        end

        for i,v in pairs(game.Teams:GetChildren()) do
            local teamname = v.Name
            for i,v in pairs(Players.LocalPlayer:FindFirstChild("leaderstats"):GetChildren()) do
                TeamValues[teamname.."_"..v.Name] = 0
            end
        end

        for i,v in pairs(Players:GetPlayers()) do
            task.spawn(function()
                repeat task.wait() until v:FindFirstChild("leaderstats")
                if v:FindFirstChild("leaderstats") then
                    local plr = v
                    for i,v in pairs(v:FindFirstChild("leaderstats"):GetChildren()) do
                        v:GetPropertyChangedSignal("Value"):Connect(function()
                            UpdateTeamValues()
                            UpdatePlayerStats(plr)
                        end)
                    end
                    UpdatePlayerStats(plr)
                end
                UpdatePlayerListSize()
            end)
        end

        Functions.PlayerAdded.LeaderstatsImprover = function(plr)
            task.spawn(function()
                repeat task.wait() until plr:FindFirstChild("leaderstats")
                repeat
                    task.wait()
                    local plrnumofstats = 0
                    for i,v in ipairs(plr:FindFirstChild("leaderstats"):GetChildren()) do
                        plrnumofstats = plrnumofstats + 1
                    end
                until plrnumofstats == numofstats
                for i,v in pairs(plr:FindFirstChild("leaderstats"):GetChildren()) do
                    v:GetPropertyChangedSignal("Value"):Connect(function()
                        UpdateTeamValues()
                        UpdatePlayerStats(plr)
                    end)
                end
                task.wait(0.5)
                UpdatePlayerStats(plr)
                UpdatePlayerListSize()
            end)
        end
        Functions.PlayerRemoved.LeaderstatsImprover = function(plr)
            task.spawn(function()
                UpdateTeamValues()
            end)
        end

        plrlistmaster.Size = UDim2.new(0,xvalue,0.7,0)
        UpdatePlayerListSize()

        task.spawn(function()
            while task.wait(1) do
                for i,plr in pairs(Players:GetPlayers()) do
                    UpdatePlayerStats(plr)
                end
                UpdateTeamValues()
                UpdatePlayerListSize()
            end
        end)

        local Players = game:GetService("Players")
        local CoreGui = game:GetService("CoreGui")
        local Teams = game:GetService("Teams")

        local suffixes = {
           "", "K+", "M+", "B+", "T+", "qd+", "Qn+", "sx+", "Sp+", "O+", "N+", "de+", 
            "Ud+", "DD+", "tdD+", "qdD+", "QnD+", "sxD+", "SpD+", "OcD+", "NvD+", "Vgn+", 
            "UVg+", "DVg+", "TVg+", "qtV+", "QnV+", "SeV+", "SPG+", "OVG+", "NVG+", "TGN+",
            "UTG+", "DTG+", "tsTG+", "qtTG+", "QnTG+", "ssTG+", "SpTG+", "OcTG+", "NoAG+",
            "UnAG+", "DuAG+", "TeAG+", "QdAG+", "QnAG+", "SxAG+", "SpAG+", "OcAG+", "NvAG+", "CT+"
        }
        local function formatNumber(value)
            if tonumber(value) then
                for i = 1, #suffixes do
                    if tonumber(value) < 10 ^ (i * 3) then
                        return math.floor(value / (10 ^ ((i - 1) * 3)) * 100) / 100 .. suffixes[i]
                    end
                end
            end
        end
        return teamValues
    end;]]
    Spy = function()
        enabled = true
        spyOnMyself = true
        public = false
        publicItalics = true
        privateProperties = {
            Color = Color3.fromRGB(0,255,255); 
            Font = Enum.Font.SourceSansBold;
            TextSize = 18;
        }
        local StarterGui = game:GetService("StarterGui")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
        local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
        local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
        local instance = (_G.chatSpyInstance or 0) + 1
        _G.chatSpyInstance = instance

        local function onChatted(p,msg)
            if _G.chatSpyInstance == instance then
                if p==player and msg:lower():sub(1,4)=="/spy" then
                    enabled = not enabled
                    wait(0.3)
                    privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
                    StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
                elseif enabled and (spyOnMyself==true or p~=player) then
                    msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
                    local hidden = true
                    local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
                        if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
                            hidden = false
                        end
                    end)
                    wait(1)
                    conn:Disconnect()
                    if hidden and enabled then
                        if public then
                            saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
                        else
                            privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
                            StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
                        end
                    end
                end
            end
        end

        for _,p in ipairs(Players:GetPlayers()) do
            p.Chatted:Connect(function(msg) onChatted(p,msg) end)
        end
        Players.PlayerAdded:Connect(function(p)
            p.Chatted:Connect(function(msg) onChatted(p,msg) end)
        end)
        privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
        StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
        if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end
        local chatFrame = player.PlayerGui.Chat.Frame
        chatFrame.ChatChannelParentFrame.Visible = true
        chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
    end;
    FPSCounter = function()

        local RightFrame = nil
        if not game:GetService("CoreGui").TopBarApp.TopBarFrame:FindFirstChild("RightFrame") then
            RightFrame = game:GetService("CoreGui").TopBarApp.TopBarFrame.LeftFrame:Clone()
            RightFrame.Parent = game:GetService("CoreGui").TopBarApp.TopBarFrame
            RightFrame.Name = "RightFrame"
            RightFrame.Position = UDim2.new(0.5,0,0,0)
            RightFrame.Size = UDim2.new(0.5,-16,1,0)
            RightFrame.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            if RightFrame:FindFirstChild("Blank") then
                RightFrame:FindFirstChild("Blank"):Destroy()
            end
        else
            RightFrame = game:GetService("CoreGui").TopBarApp.TopBarFrame:FindFirstChild("RightFrame")
        end

        local Frame = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local Frame2 = Instance.new("Frame")
        local TextLabel2 = Instance.new("TextLabel")
        local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint")
        local Frame3 = Instance.new("Frame")
        local TextLabel3 = Instance.new("TextLabel")
        local UITextSizeConstraint3 = Instance.new("UITextSizeConstraint")
        local HealthBarMimic = Instance.new("Frame")

        --Properties:

        Frame.Parent = RightFrame
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.BorderSizePixel = 0
        Frame.AnchorPoint = Vector2.new(1,0)
        Frame.Position = UDim2.new(1, 0, 0, 0)
        Frame.Size = UDim2.new(0, 76, 0, 37)
        Frame.LayoutOrder = 3
        Frame.Name = "FPS"
        Frame.ZIndex = 10

        TextLabel.Parent = Frame
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.Code
        TextLabel.Text = "N/A FPS"
        TextLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextWrapped = true

        UITextSizeConstraint.Parent = TextLabel
        UITextSizeConstraint.MaxTextSize = 20

        Frame2.Parent = RightFrame
        Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame2.BackgroundTransparency = 1.000
        Frame2.BorderSizePixel = 0
        Frame2.AnchorPoint = Vector2.new(1,0)
        Frame2.Position = UDim2.new(1, 0, 0, 0)
        Frame2.Size = UDim2.new(0, 120, 0, 37)
        Frame2.LayoutOrder = 1
        Frame2.Name = "Timer"
        Frame2.ZIndex = 10

        TextLabel2.Parent = Frame2
        TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel2.BackgroundTransparency = 1.000
        TextLabel2.Size = UDim2.new(1, 0, 1, 0)
        TextLabel2.Font = Enum.Font.Code
        TextLabel2.Text = "00:00:00"
        TextLabel2.TextColor3 = Color3.fromRGB(0, 255, 0)
        TextLabel2.TextScaled = true
        TextLabel2.TextSize = 14.000
        TextLabel2.TextWrapped = true

        UITextSizeConstraint2.Parent = TextLabel2
        UITextSizeConstraint2.MaxTextSize = 20

        Frame3.Parent = RightFrame
        Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame3.BackgroundTransparency = 1.000
        Frame3.BorderSizePixel = 0
        Frame3.AnchorPoint = Vector2.new(1,0)
        Frame3.Position = UDim2.new(1, 0, 0, 0)
        Frame3.Size = UDim2.new(0, 100, 0, 37)
        Frame3.LayoutOrder = 2
        Frame3.Name = "Ping"
        Frame3.ZIndex = 10

        TextLabel3.Parent = Frame3
        TextLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel3.BackgroundTransparency = 1.000
        TextLabel3.Size = UDim2.new(1, 0, 1, 0)
        TextLabel3.Font = Enum.Font.Code
        TextLabel3.Text = "1000 ms"
        TextLabel3.TextColor3 = Color3.fromRGB(0, 255, 0)
        TextLabel3.TextScaled = true
        TextLabel3.TextSize = 14.000
        TextLabel3.TextWrapped = true

        UITextSizeConstraint3.Parent = TextLabel3
        UITextSizeConstraint3.MaxTextSize = 20

        HealthBarMimic.Parent = RightFrame
        HealthBarMimic.LayoutOrder = 0
        HealthBarMimic.Position = UDim2.new(1,0,0,0)
        HealthBarMimic.Size = UDim2.new(0,130,1,0)
        HealthBarMimic.BackgroundTransparency = 1

        coroutine.resume(coroutine.create(function()
            while wait() do
                local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                TextLabel3.Text = string.format("%.2f", ping).." ms"
            end
        end))

        local function Format(Int)
            return string.format("%02i", Int)
        end

        local function convertToHMS()
            local miliseconds = math.floor(workspace.DistributedGameTime * 100)
            local seconds = math.floor(workspace.DistributedGameTime)
            local minutes = math.floor(workspace.DistributedGameTime / 60)
            local hours = math.floor(workspace.DistributedGameTime / 60 / 60)
            local miliseconds = miliseconds - (seconds * 100)
            local seconds = seconds - (minutes * 60)
            local minutes = minutes - (hours * 60)
            return Format(hours)..":"..Format(minutes)..":"..Format(seconds)..":"..Format(miliseconds)
        end

        coroutine.resume(coroutine.create(function()
            while task.wait(0.01) do
                TextLabel2.Text = convertToHMS()
            end
        end))


        local RunService = game:GetService("RunService")
        local FpsLabel = TextLabel
        local TimeFunction = RunService:IsRunning() and time or os.clock

        local LastIteration, Start
        local FrameUpdateTable = {}

        local function HeartbeatUpdate()
            LastIteration = TimeFunction()
            for Index = #FrameUpdateTable, 1, -1 do
                FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
            end
            
            FrameUpdateTable[1] = LastIteration
            local fps = tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start)))
            FpsLabel.Text = fps.. " FPS"
            if tonumber(fps) then
                local num = tonumber(fps)
                if num > 30 then
                    TextLabel.TextColor3 = Color3.fromRGB(0,255,0)
                elseif num > 15 then
                    TextLabel.TextColor3 = Color3.fromRGB(255,150,0)
                elseif num < 15 then
                    TextLabel.TextColor3 = Color3.fromRGB(255,0,0)
                end
            end
        end

        if game:GetService("CoreGui"):FindFirstChild("TopBarApp") then
            if game:GetService("CoreGui").TopBarApp:FindFirstChild("UnibarLeftFrame") then
                if game:GetService("CoreGui").TopBarApp.UnibarLeftFrame:FindFirstChild("HealthBar") then
                    game:GetService("CoreGui").TopBarApp.UnibarLeftFrame:FindFirstChild("HealthBar").Changed:Connect(function()
                        if game:GetService("CoreGui").TopBarApp.UnibarLeftFrame:FindFirstChild("HealthBar").Visible == true then
                            HealthBarMimic.LayoutOrder = 3
                            Frame.LayoutOrder = 2
                            Frame3.LayoutOrder = 1
                            Frame2.LayoutOrder = 0
                        else
                            HealthBarMimic.LayoutOrder = 0
                            Frame.LayoutOrder = 3
                            Frame3.LayoutOrder = 2
                            Frame2.LayoutOrder = 1
                        end
                    end)
                end
            end
        end

        Start = TimeFunction()
        RunService.Heartbeat:Connect(HeartbeatUpdate)
    end;
    AntiMobileGlitch = function()
        task.spawn(function()
            for i,v in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
                if v.Name == "ScreenGui" and v:FindFirstChild("Frame") then
                    v:Destroy()
                end
            end
            repeat task.wait() until Players.LocalPlayer.PlayerGui:FindFirstChild("PlayerScript")
            local clone = Players.LocalPlayer.PlayerGui.PlayerScript:Clone()
            clone.Parent = Players.LocalPlayer.PlayerGui
            repeat task.wait() until Players.LocalPlayer.PlayerGui:FindFirstChild("GuiScript")
            local clone2 = Players.LocalPlayer.PlayerGui.GuiScript:Clone()
            clone2.Parent = Players.LocalPlayer.PlayerGui
            return
        end)
        Functions.CharacterAdded.AntiMobileGlitch = function()
            task.spawn(function()
                Functions.CheckAllParts(Character)
                for i,v in pairs(Player.PlayerGui:GetChildren()) do
                    if v.Name == "ScreenGui" and v:FindFirstChild("Frame") then
                        v:Destroy()
                    end
                end
                repeat task.wait() until Players.LocalPlayer.PlayerGui:FindFirstChild("PlayerScript")
                local clone = Players.LocalPlayer.PlayerGui.PlayerScript:Clone()
                clone.Parent = Players.LocalPlayer.PlayerGui
                repeat task.wait() until Players.LocalPlayer.PlayerGui:FindFirstChild("GuiScript")
                local clone2 = Players.LocalPlayer.PlayerGui.GuiScript:Clone()
                clone2.Parent = Players.LocalPlayer.PlayerGui
            end)
        end
    end;
    AutoTranslator = function()
        --[[
            Message Translator
            NOT Made by Aim, NOT updated by evn
            ZERO Credits to Riptxde for the sending chathook
        --]]

        if not game['Loaded'] then game['Loaded']:Wait() end; repeat wait(.06) until game:GetService('Players').LocalPlayer ~= nil
        local YourLang = "en" -- Language code that the messages are going to be translated to

        local googlev = isfile'googlev.txt' and readfile'googlev.txt' or ''
        local request = request or syn.request

        local function outputHook(fnc)
            return function(...)
                return fnc('[INLINE TRANSLATOR]', ...)
            end
        end

        local print,warn = outputHook(print), outputHook(warn)

        -- // GOOGLE TRANSLATE // --

        local translate, getISOCode do
            function googleConsent(Body) -- Because google really said: "Fuck you."
                local args = {}

                for match in Body:gmatch('<input type="hidden" name=".-" value=".-">') do
                    local k,v = match:match('<input type="hidden" name="(.-)" value="(.-)">')
                    args[k] = v
                end
                googlev = args.v
                writefile('googlev.txt', args.v)
            end

            local function got(url, Method, Body) -- Basic version of https://www.npmjs.com/package/got using synapse's request API for google websites
                Method = Method or "GET"
                
                local res = request({
                    Url = url,
                    Method = Method,
                    Headers = {cookie="CONSENT=YES+"..googlev},
                    Body = Body
                })
                
                if res.Body:match('https://consent.google.com/s') then
                    print('consent')
                    googleConsent(res.Body)
                    res = request({
                        Url = url,
                        Method = "GET",
                        Headers = {cookie="CONSENT=YES+"..googlev}
                    })
                end
                
                return res
            end

            local languages = {
                auto = "Automatic",
                af = "Afrikaans",
                sq = "Albanian",
                am = "Amharic",
                ar = "Arabic",
                hy = "Armenian",
                az = "Azerbaijani",
                eu = "Basque",
                be = "Belarusian",
                bn = "Bengali",
                bs = "Bosnian",
                bg = "Bulgarian",
                ca = "Catalan",
                ceb = "Cebuano",
                ny = "Chichewa",
                ['zh-cn'] = "Chinese Simplified",
                ['zh-tw'] = "Chinese Traditional",
                co = "Corsican",
                hr = "Croatian",
                cs = "Czech",
                da = "Danish",
                nl = "Dutch",
                en = "English",
                eo = "Esperanto",
                et = "Estonian",
                tl = "Filipino",
                fi = "Finnish",
                fr = "French",
                fy = "Frisian",
                gl = "Galician",
                ka = "Georgian",
                de = "German",
                el = "Greek",
                gu = "Gujarati",
                ht = "Haitian Creole",
                ha = "Hausa",
                haw = "Hawaiian",
                iw = "Hebrew",
                hi = "Hindi",
                hmn = "Hmong",
                hu = "Hungarian",
                is = "Icelandic",
                ig = "Igbo",
                id = "Indonesian",
                ga = "Irish",
                it = "Italian",
                ja = "Japanese",
                jw = "Javanese",
                kn = "Kannada",
                kk = "Kazakh",
                km = "Khmer",
                ko = "Korean",
                ku = "Kurdish (Kurmanji)",
                ky = "Kyrgyz",
                lo = "Lao",
                la = "Latin",
                lv = "Latvian",
                lt = "Lithuanian",
                lb = "Luxembourgish",
                mk = "Macedonian",
                mg = "Malagasy",
                ms = "Malay",
                ml = "Malayalam",
                mt = "Maltese",
                mi = "Maori",
                mr = "Marathi",
                mn = "Mongolian",
                my = "Myanmar (Burmese)",
                ne = "Nepali",
                no = "Norwegian",
                ps = "Pashto",
                fa = "Persian",
                pl = "Polish",
                pt = "Portuguese",
                pa = "Punjabi",
                ro = "Romanian",
                ru = "Russian",
                sm = "Samoan",
                gd = "Scots Gaelic",
                sr = "Serbian",
                st = "Sesotho",
                sn = "Shona",
                sd = "Sindhi",
                si = "Sinhala",
                sk = "Slovak",
                sl = "Slovenian",
                so = "Somali",
                es = "Spanish",
                su = "Sundanese",
                sw = "Swahili",
                sv = "Swedish",
                tg = "Tajik",
                ta = "Tamil",
                te = "Telugu",
                th = "Thai",
                tr = "Turkish",
                uk = "Ukrainian",
                ur = "Urdu",
                uz = "Uzbek",
                vi = "Vietnamese",
                cy = "Welsh",
                xh = "Xhosa",
                yi = "Yiddish",
                yo = "Yoruba",
                zu = "Zulu"
            };

            function find(lang)
                for i,v in pairs(languages) do
                    if i == lang or v == lang then
                        return i
                    end
                end
            end

            function isSupported(lang)
                local key = find(lang)
                return key and true or false 
            end

            function getISOCode(lang)
                local key = find(lang)
                return key
            end

            function stringifyQuery(dataFields)
                local data = ""
                for k, v in pairs(dataFields) do
                    if type(v) == "table" then
                        for _,v in pairs(v) do
                            data = data .. ("&%s=%s"):format(
                                game.HttpService:UrlEncode(k),
                                game.HttpService:UrlEncode(v)
                            )
                        end
                    else
                        data = data .. ("&%s=%s"):format(
                            game.HttpService:UrlEncode(k),
                            game.HttpService:UrlEncode(v)
                        )
                    end
                end
                data = data:sub(2)
                return data
            end

            local reqid = math.random(1000,9999)
            local rpcidsTranslate = "MkEWBc"
            local rootURL = "https://translate.google.com/"
            local executeURL = "https://translate.google.com/_/TranslateWebserverUi/data/batchexecute"
            local fsid, bl

            do -- init
                print('initialize')
                local InitialReq = got(rootURL)
                fsid = InitialReq.Body:match('"FdrFJe":"(.-)"')
                bl = InitialReq.Body:match('"cfb2h":"(.-)"')
            end

            local HttpService = game:GetService("HttpService")
            function jsonE(o)
                return HttpService:JSONEncode(o)
            end
            function jsonD(o)
                return HttpService:JSONDecode(o)
            end

            function translate(str, to, from)
                reqid+=10000
                from = from and getISOCode(from) or 'auto'
                to = to and getISOCode(to) or 'en'

                local data = {{str, from, to, true}, {nil}}

                local freq = {
                    {
                        {
                            rpcidsTranslate, 
                            jsonE(data),
                            nil,
                            "generic"
                        }
                    }
                }

                local url = executeURL..'?'..stringifyQuery{rpcids = rpcidsTranslate, ['f.sid'] = fsid, bl = bl, hl="en", _reqid = reqid-10000, rt = 'c'}
                local body = stringifyQuery{['f.req'] = jsonE(freq)}
                
                local req = got(url, "POST", body)
                
                local body = jsonD(req.Body:match'%[.-%]\n')
                local translationData = jsonD(body[1][3])
                local result = {
                    text = "",
                    from = {
                        language = "",
                        text = ""
                    },
                    raw = ""
                }
                result.raw = translationData
                result.text = translationData[2][1][1][6][1][1]
                
                result.from.language = translationData[3]
                result.from.text = translationData[2][5][1]

                return result
            end
        end

        local Players = game:GetService("Players")
        local LP = Players.LocalPlayer
        local StarterGui = game:GetService('StarterGui')
        for i=1, 15 do
            local r = pcall(StarterGui["SetCore"])
            if r then break end
            game:GetService('RunService').RenderStepped:wait()
        end
        wait()

        local properties = {
            Color = Color3.new(1,1,0);
            Font = Enum.Font.SourceSansItalic;
            TextSize = 16;
        }

        game:GetService("StarterGui"):SetCore("SendNotification",
            {
                Title = "Chat Translator",
                Text = "Ported to Google Translate",
                Duration = 3
            }
        )
                        
        properties.Text = "[TR] To send messages in a language, say > followed by the target language/language code, e.g.: >ru or >russian. To disable (go back to original language), say >d."
        StarterGui:SetCore("ChatMakeSystemMessage", properties)

        function translateFrom(message)
            local translation = translate(message, YourLang)

            local text
            if translation.from.language ~= YourLang then 
                text = translation.text
            end

            return {text, translation.from.language}
        end

        -- // CHAT FUNCTIONS // --

        local CBar, Connected = LP['PlayerGui']:WaitForChild('Chat')['Frame'].ChatBarParentFrame['Frame'].BoxFrame['Frame'].ChatBar, {}
        local EventFolder = game:GetService('ReplicatedStorage'):WaitForChild('DefaultChatSystemChatEvents')
        local Chat do
            function Chat(Original, msg, Channel)
                CBar.Text = msg
                for i,v in pairs(getconnections(CBar.FocusLost)) do
                    v:Fire(true, nil, true)
                end
            end

            --[[
            local ChatMain = LP.PlayerScripts:FindFirstChild('ChatMain', true)
            local MessageSender if ChatMain then
                MessageSender = require(ChatMain.MessageSender)
                ChatMain = require(ChatMain)
            end

            function Chat(Original, msg, Channel)
                Channel = Channel or "All"
                if MessageSender and ChatMain then
                    ChatMain.MessagePosted:fire(Original)
                    MessageSender:SendMessage(msg, Channel)
                else
                    if not _G.SecureChat then
                        game:GetService('Players'):Chat(Original); 
                    end
                    EventFolder.SayMessageRequest:FireServer(msg, Channel)
                end
            end]]
        end

        do -- :Chatted replacement!!
            function get(plr, msg)
                print(msg)
                local tab = translateFrom(msg)
                local translation = tab[1]
                print(translation)
                if translation then
                    properties.Text = "("..tab[2]:upper()..") ".."[".. plr .."]: "..translation
                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                end
            end

            EventFolder:WaitForChild("OnMessageDoneFiltering").OnClientEvent:Connect(function(data)
                if data == nil then return end

                local plr = Players:FindFirstChild(data.FromSpeaker)
                local msg = tostring(data.Message)
                local originalchannel = tostring(data.OriginalChannel)

                if plr then 
                    plr = plr.DisplayName 
                else 
                    plr = tostring(data.FromSpeaker)
                end

                if originalchannel:find("To ") then
                    plr = plr..originalchannel
                end

                get(plr, msg)
            end)
        end

        local sendEnabled = false
        local target = ""

        function translateTo(message, target)
            target = target:lower() 
            local translation = translate(message, target, "auto")

            return translation.text
        end

        function disableSend()
            sendEnabled = false
            properties.Text = "[TR] Sending Disabled"
            StarterGui:SetCore("ChatMakeSystemMessage", properties)
        end


        local HookChat = function(Bar)
            coroutine.wrap(function()
                if not table.find(Connected,Bar) then
                    local Connect = Bar['FocusLost']:Connect(function(Enter, _, ignore)
                        if ignore then return end
                        if Enter ~= false and Bar.Text ~= '' then
                            local Message = Bar.Text
                            Bar.Text = ''
                            if Message == ">d" then
                                disableSend()
                            elseif Message:sub(1,1) == ">" and not Message:find(" ") then
                                if getISOCode(Message:sub(2)) then
                                    sendEnabled = true
                                    target = Message:sub(2)
                                else
                                    properties.Text = "[TR] Invalid language"
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                end
                            elseif sendEnabled and not (Message:sub(1,3) == "/e " or Message:sub(1,7) == "/emote ") then
                                local og = Message
                                Message = translateTo(Message, target)
                                --Bar.Text = Message
                                Chat(og, Message)
                            else
                                --Bar.Text = Message
                                Chat(Message, Message)
                            end
                        end
                    end)
                    Connected[#Connected+1] = Bar; Bar['AncestryChanged']:Wait(); Connect:Disconnect()
                end
            end)()
        end

        HookChat(CBar); local BindHook = Instance.new('BindableEvent')

        local MT = getrawmetatable(game); local NC = MT.__namecall; setreadonly(MT, false)

        MT.__namecall = newcclosure(function(...)
            local Method, Args = getnamecallmethod(), {...}
            if rawequal(tostring(Args[1]),'ChatBarFocusChanged') and rawequal(Args[2],true) then 
                if LP['PlayerGui']:FindFirstChild('Chat') then
                    BindHook:Fire()
                end
            end
            return NC(...)
        end)

        BindHook['Event']:Connect(function()
            CBar = LP['PlayerGui'].Chat['Frame'].ChatBarParentFrame['Frame'].BoxFrame['Frame'].ChatBar
            HookChat(CBar)
        end)
    end;
    Cutestring = function()
        getgenv().Meow = false

        faces = {
            ";;w;;", "UwU", ">w<", "^w^",
            "OwO", "UwU", "xD"
        }

        local function getFace()
            return faces[math.random(1, #faces)]
        end

        local function cuteify(msg)
            local replacements = {
                ["r"] = "w",
                ["R"] = "W",
                ["l"] = "w",
                ["L"] = "W",
                ["ove"] = "uv",
            }
            msg = msg:gsub("[rRlL]", replacements)
            msg = msg:gsub("ove", replacements["ove"])
            msg = msg:gsub("!", getFace)

            return msg
        end

        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)

        mt.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" and args[1].Name == 'SayMessageRequest' and getgenv().Meow then
                args[2] = cuteify(args[2])
                return old(unpack(args))

            end
            return(old(...))
        end)
        setreadonly(mt, true)

    end;
    ChatFixer = function()

        game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.Size = UDim2.new(0.35,0,0.45,0)

        local scroller = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller
        scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y

        for i,v in pairs(scroller:GetChildren()) do
            v.Size = UDim2.new(1,0,0,84)
            v.TextLabel.TextSize = 16
            if v.TextLabel:FindFirstChild("TextButton") then
                v.TextLabel.TextButton.TextSize = 16
            end
            v.Size = UDim2.new(1,0,0,v.TextLabel.TextBounds.Y)
            task.wait()
            if not v.TextLabel.TextFits then
                v.TextLabel.RichText = true
            end
        end

        scroller.ChildAdded:Connect(function(child)

            local alls = 0
            for i,v in pairs(scroller:GetChildren()) do
                if v and v:IsA("Frame") then
                    alls = v.Size.Y.Offset + alls
                end
                if not v then
                    alls = 0
                end
            end

            child.Size = UDim2.new(1,0,0,84)
            child.Position = UDim2.new(1,0,0,alls)
            child.TextLabel.TextSize = 16
            if child.TextLabel:FindFirstChild("TextButton") then
                child.TextLabel.TextButton.TextSize = 16
            end
            child.Size = UDim2.new(1,0,0,child.TextLabel.TextBounds.Y)
            task.wait()
            --scroller.CanvasSize = UDim2.new(0,0,0,alls+child.TextLabel.TextBounds.Y)
            if not child.TextLabel.TextFits then
                child.TextLabel.RichText = true
            end
            scroller.CanvasPosition = Vector2.new(0,scroller.AbsoluteCanvasSize.Y-scroller.AbsoluteWindowSize.Y)
        end)

    end;
    SolaraFixer = function()
        local CFrameTable = {}
        local AcceptableAncestors = {
            "ALL";
            "ClothCollection";
            "ForceFieldDetectorParts";
            "FunnySwordPack";
            "FunnyThrowPack";
            "GroupMemberCloth";
            "LeaderBoard";
            "MainBasePlate";
            "NextUpdatePart";
            "NightLightParts";
            "PizzaPack";
            "RainbowPack";
            "RandomMeshes";
            "RandomModels";
            "RandomParts";
            "RandomUnions";
            "SpawnParts";
            "SwordCollection";
            "ThrowableCollection";
            "VipPack";
            "WaterFallSoundPart";
        }

        local function HasAcceptableAncestor(part)
            for _,v in pairs(AcceptableAncestors) do
                if part:FindFirstAncestor(v) then
                    return v
                end
            end
        end

        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") and HasAcceptableAncestor(v) and v.Name ~= "Seat" then
                CFrameTable[v] = {v.CFrame,v.Rotation}
            end
        end

        task.spawn(function()
            while true do
                for i,v in pairs(CFrameTable) do
                    if i.CFrame ~= v[1] then
                        i.CFrame = v[1]
                    end
                    if i.Rotation ~= v[2] then
                        i.Rotation = v[2]
                    end
                end
                task.wait(10)
            end
        end)
    end;
    LightingModifier = function()
        local sky = Instance.new("Sky",Lighting)
        sky.MoonTextureId = "http://www.roblox.com/asset/?id=415755273"
        sky.StarCount = 5000

        Lighting.FogEnd = 5000

        if Lighting.Technology ~= Enum.Technology.Compatibility then
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("Light") and part.Brightness > 1 then
                    part.Brightness = 1
                end
            end
        end
    end;
    WorkspaceModifier = function()
        workspace.FallenPartsDestroyHeight = -50000
    end;
}

local TableFuncs = {
    ["AutoFire"] = {

        --[[ 
            0 = false, 1 = true
            1st = AirStrikeMode, 2nd = PredictMode, 3rd = ServerShurikens, 4th = ShotgunFire
        --]]

        ["0000"] = function()
            if Character and Character:FindFirstChild("Shuriken") then
                for i,v in pairs(Character:GetChildren()) do
                    if v.Name == "Shuriken" and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                        v:FindFirstChild("HitEvent"):FireServer(targetplr.Character:FindFirstChild(Variables.AimPart).Position)
                    end
                end
            end
            if Variables.OptionalEquip then
                for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Shuriken" and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                        v:FindFirstChild("HitEvent"):FireServer(targetplr.Character:FindFirstChild(Variables.AimPart).Position)
                    end
                end
            end
        end;
        ["1000"] = function()
            if Character and Character:FindFirstChild("Shuriken") and Functions.GetRoot(Character) then
                local hrp = Functions.GetRoot(Character)
                for i,v in pairs(Character:GetChildren()) do
                    if v.Name == "Shuriken" then
                        v:FindFirstChild("HitEvent"):FireServer(Vector3.new(hrp.Position.X, hrp.Position.Y + Variables.AirStrikeDistance, hrp.Position.Z))
                    end
                end
            elseif Character and Functions.GetRoot(Character) then
                if Variables.OptionalEquip then
                    local hrp = Functions.GetRoot(Character)
                    for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Shuriken" then
                            v:FindFirstChild("HitEvent"):FireServer(Vector3.new(hrp.Position.X, hrp.Position.Y + Variables.AirStrikeDistance, hrp.Position.Z))
                        end
                    end
                end
            end
        end;
        ["0010"] = function()
            for i,v in pairs(Players:GetPlayers()) do
                if (Variables.PlayerShurikenCheck and v ~= targetplr) or (not Variables.PlayerShurikenCheck) then
                    if v:FindFirstChild("Backpack") and v.Backpack:FindFirstChild("Shuriken") then
                        for i,v in pairs(v.Backpack:GetChildren()) do
                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                                v.HitEvent:FireServer(targetplr.Character:FindFirstChild(Variables.AimPart).Position)
                                Step()
                            end
                        end
                    end
                    if v.Character and v.Character:FindFirstChild("Shuriken") then
                        for i,v in pairs(v.Character:GetChildren()) do
                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                                v.HitEvent:FireServer(targetplr.Character:FindFirstChild(Variables.AimPart).Position)
                                Step()
                            end
                        end
                    end
                end
            end
        end;
        ["1010"] = function()
            if Character and Functions.GetRoot(Character) then
                local hrp = Functions.GetRoot(Character)
                for i,v in pairs(Players:GetPlayers()) do
                    if (Variables.PlayerShurikenCheck and v ~= targetplr) or (not Variables.PlayerShurikenCheck) then
                        if v:FindFirstChild("Backpack") and v.Backpack:FindFirstChild("Shuriken") then
                            for i,v in pairs(v.Backpack:GetChildren()) do
                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                    v.HitEvent:FireServer(Vector3.new(hrp.Position.X, hrp.Position.Y + Variables.AirStrikeDistance, hrp.Position.Z))
                                    Step()
                                end
                            end
                        end
                        if v.Character and v.Character:FindFirstChild("Shuriken") then
                            for i,v in pairs(v.Character:GetChildren()) do
                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                    v.HitEvent:FireServer(Vector3.new(hrp.Position.X, hrp.Position.Y + Variables.AirStrikeDistance, hrp.Position.Z))
                                    Step()
                                end
                            end
                        end
                    end
                end
            end
        end;
        ["1001"] = function()
            if Character and Functions.GetRoot(Character) then
                local hrp = Functions.GetRoot(Character)
                if Character and Character:FindFirstChild("Shuriken") then
                    for i,v in pairs(Character:GetChildren()) do
                        if v.Name == "Shuriken" then
                            local distanceX = math.random(-100,100)
                            local distanceZ = math.random(-100,100)
                            local resultVector = Vector3.new(hrp.Position.X + distanceX,hrp.Position.Y + Variables.ShotgunFireSpread,hrp.Position.Z + distanceZ)
                            v:FindFirstChild("HitEvent"):FireServer(resultVector)
                        end
                    end
                end
                if Variables.OptionalEquip then
                    for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.Name == "Shuriken" then
                            local distanceX = math.random(-100,100)
                            local distanceZ = math.random(-100,100)
                            local resultVector = Vector3.new(hrp.Position.X + distanceX,hrp.Position.Y + Variables.ShotgunFireSpread,hrp.Position.Z + distanceZ)
                            v:FindFirstChild("HitEvent"):FireServer(resultVector)
                        end
                    end
                end
            end
        end;
        ["1011"] = function()
            if Character and Functions.GetRoot(Character) then
                local hrp = Functions.GetRoot(Character)
                for i,v in pairs(Players:GetPlayers()) do
                    if (Variables.PlayerShurikenCheck and v ~= targetplr) or (not Variables.PlayerShurikenCheck) then
                        if v:FindFirstChild("Backpack") and v.Backpack:FindFirstChild("Shuriken") then
                            for i,v in pairs(v.Backpack:GetChildren()) do
                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                    local distanceX = math.random(-100,100)
                                    local distanceZ = math.random(-100,100)
                                    local resultVector = Vector3.new(hrp.Position.X + distanceX,hrp.Position.Y + Variables.ShotgunFireSpread,hrp.Position.Z + distanceZ)
                                    v.HitEvent:FireServer(resultVector)
                                    Step()
                                end
                            end
                        end
                        if v.Character and v.Character:FindFirstChild("Shuriken") then
                            for i,v in pairs(v.Character:GetChildren()) do
                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                    local distanceX = math.random(-100,100)
                                    local distanceZ = math.random(-100,100)
                                    local resultVector = Vector3.new(hrp.Position.X + distanceX,hrp.Position.Y + Variables.ShotgunFireSpread,hrp.Position.Z + distanceZ)
                                    v.HitEvent:FireServer(resultVector)
                                    Step()
                                end
                            end
                        end
                    end
                end
            end
        end;
        ["0001"] = function()
            if Character and Character:FindFirstChild("Shuriken") then
                for i,v in pairs(Character:GetChildren()) do
                    if v.Name == "Shuriken" and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                        local distanceX = math.random(-100,100)
                        local distanceY = math.random(-100,100)
                        local distanceZ = math.random(-100,100)
                        local aimpart = targetplr.Character:FindFirstChild(Variables.AimPart)
                        local resultVector = Vector3.new(aimpart.Position.X + distanceX, aimpart.Position.Y + distanceY, aimpart.Position.Z + distanceZ)
                        v:FindFirstChild("HitEvent"):FireServer(resultVector)
                    end
                end
            end
            if Variables.OptionalEquip then
                for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.Name == "Shuriken" and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                        local distanceX = math.random(-100,100)
                        local distanceY = math.random(-100,100)
                        local distanceZ = math.random(-100,100)
                        local aimpart = targetplr.Character:FindFirstChild(Variables.AimPart)
                        local resultVector = Vector3.new(aimpart.Position.X + distanceX, aimpart.Position.Y + distanceY, aimpart.Position.Z + distanceZ)
                        v:FindFirstChild("HitEvent"):FireServer(resultVector)
                    end
                end
            end
        end;
        ["0011"] = function()
            for i,v in pairs(Players:GetPlayers()) do
                if (Variables.PlayerShurikenCheck and v ~= targetplr) or (not Variables.PlayerShurikenCheck) then
                    if v:FindFirstChild("Backpack") and v.Backpack:FindFirstChild("Shuriken") then
                        for i,v in pairs(v.Backpack:GetChildren()) do
                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                                local distanceX = math.random(-100,100)
                                local distanceY = math.random(-100,100)
                                local distanceZ = math.random(-100,100)
                                local aimpart = targetplr.Character:FindFirstChild(Variables.AimPart)
                                local resultVector = Vector3.new(aimpart.Position.X + distanceX, aimpart.Position.Y + distanceY, aimpart.Position.Z + distanceZ)
                                v.HitEvent:FireServer(resultVector)
                                Step()
                            end
                        end
                    end
                    if v.Character and v.Character:FindFirstChild("Shuriken") then
                        for i,v in pairs(v.Character:GetChildren()) do
                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") and targetplr and targetplr.Character and targetplr.Character:FindFirstChild(Variables.AimPart) then
                                local distanceX = math.random(-100,100)
                                local distanceY = math.random(-100,100)
                                local distanceZ = math.random(-100,100)
                                local aimpart = targetplr.Character:FindFirstChild(Variables.AimPart)
                                local resultVector = Vector3.new(aimpart.Position.X + distanceX, aimpart.Position.Y + distanceY, aimpart.Position.Z + distanceZ)
                                v.HitEvent:FireServer(resultVector)
                                Step()
                            end
                        end
                    end
                end
            end
        end;
        ["0100"] = function()
            if workspace:FindFirstChild("SPEEDPART") then
                if Character and Character:FindFirstChild("Shuriken") then
                    for i,v in pairs(Character:GetChildren()) do
                        if v.Name == "Shuriken" then
                            v:FindFirstChild("HitEvent"):FireServer(workspace:FindFirstChild("SPEEDPART").Position)
                            local shur = v
                            if pshurthrown and Character:FindFirstChild("Humanoid") then
                                for i,v in pairs(AllThrowAnimations) do
                                    v:Stop()
                                end
                                AllThrowAnimations.ThrowAnim = Character:FindFirstChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(shur:FindFirstChild("LocalScript"):FindFirstChild("ThrowAnim"))
                                AllThrowAnimations.ThrowAnim:Play()
                                pshurthrown = false
                            end
                        end
                    end
                end
            end
        end;
    };
}

local MainWindow =
    Fluent:CreateWindow(
    {
        Title = "Project Ninja Assassin v" .. VERSION,
        SubTitle = "by 5 Big Guys",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftAlt
    }
)

local Tabs = {
    Main = MainWindow:AddTab({Title = "Main", Icon = "house"}),
    Training = MainWindow:AddTab({ Title = "Training", Icon = "axe" }),
    Lists = MainWindow:AddTab({ Title = "Lists", Icon = "scroll" }),
    Players = MainWindow:AddTab({ Title = "Players", Icon = "user-cog" }),
    Combat = MainWindow:AddTab({Title = "Combat", Icon = "swords"}),
    Cosmetics = MainWindow:AddTab({Title = "Cosmetics", Icon = "shirt"}),
    Misc = MainWindow:AddTab({Title = "Miscellaneous", Icon = "folder-plus"}),
    Credits = MainWindow:AddTab({Title = "Credits", Icon = "link-2"}),
    Settings = MainWindow:AddTab({Title = "Settings", Icon = "settings"})
}

local function AddVariables(Tab)
    for Name,Value in pairs(Tab) do
        local Value = Value or false
        Variables[Name] = Value
    end
end

Functions.GetRoot = function(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end

Functions.CheckAllParts = function(char)
    for _,v in pairs(Constants.BodyParts) do
        if not char:FindFirstChild(v) then
            char:WaitForChild(v,math.huge)
        end
    end
    return true
end

Functions.GetBubble = function()
    if Character and Functions.GetRoot(Character) then
        local root = Functions.GetRoot(Character)
        local beforepos = root.CFrame
        local ff = Character:FindFirstChild("ForceField")
        if not ff then
            if Character.Humanoid.Health == Character.Humanoid.MaxHealth then
                repeat
                    root.CFrame = CFrame.new(70,98,-335)
                    tas.wait(0.03)
                until Character:FindFirstChild("ForceField")
                root.CFrame = beforepos
            end
        else
            return
        end
    end
end

Functions.InitCharacterTouched = function(Player,CharType)
    if Player.Character then
        Functions.CheckAllParts(Player.Character)
        for _,v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Touched:Connect(function(child)
                    if CharType == "Local" then
                        for _,v in pairs(Functions.CharacterTouched) do
                            v(child)
                        end
                    elseif CharType == "WL" then
                        for _,v in pairs(Functions.WhitelistCharacterTouched) do
                            v(child,Player)
                        end
                    end
                end)
            end
        end
    end
end

Functions.ListFind = function(List,Value,Mode,Exclude)
    for n,t in pairs(Lists[List]) do
        if Mode ~= nil then
            if ((n == Mode and Exclude == nil) or (n == Mode and Exclude ~= nil and Exclude == false) or (n ~= Mode and Exclude ~= nil and Exclude == true)) then
                for w,p in pairs(t) do
                    if p == Value then
                        return w
                    end
                end
            end
        elseif Mode == nil then
            for w,p in pairs(t) do
                if p == Value then
                    return w
                end
            end
        end
    end
    return nil
end

Functions.ListRemove = function(List,Value,Mode)
    if Mode == nil then
        for n,t in pairs(Lists[List]) do
            for w,p in pairs(t) do
                if p == Value then
                    Lists[List][n][w] = nil
                end
            end
        end
    else
        if Lists[List][Mode][Value] ~= nil then
            Lists[List][Mode][Value] = nil
        end
    end
end

Functions.ListFunction = function(List,Value)
    if List == "Whitelist" then
        local Player = Players:FindFirstChild(Value)
        if Player then
            Functions.InitCharacterTouched(Player,"WL")
            Player.CharacterAdded:Connect(function()
                Functions.InitCharacterTouched(Player,"WL")
            end)
        end
    end
end

Functions.ListInsert = function(List,Value,Mode)
    Lists[List][Mode][Value] = Value
    Functions.ListFunction(List,Value)
end

Functions.ListEmpty = function(List)
    if List then
        for n,t in pairs(Lists[List]) do
            if next(t) ~= nil then
                return false
            end
        end
    else
        local tab = {}
        for n,t in pairs(Lists) do
            for w,p in pairs(t) do
                if next(p) ~= nil then
                    table.insert(tab,false)
                else
                    table.insert(tab,true)
                end
            end
        end
        return tab
    end
    return true
end

Functions.ListClear = function(List,Mode)
    if List then
        for n,t in pairs(Lists[List]) do
            if Mode and n == Mode then
                for w,p in pairs(t) do
                    Lists[List][n][w] = nil
                end
            elseif not Mode then
                for w,p in pairs(t) do
                    Lists[List][n][w] = nil
                end
            end
        end
    else
        for n,t in pairs(Lists) do
            for w,p in pairs(t) do
                if Mode and n == Mode then
                    for i,v in pairs(p) do
                        Lists[n][w][i] = nil
                    end
                elseif not Mode then
                    for i,v in pairs(p) do
                        Lists[n][w][i] = nil
                    end
                end
            end
        end
    end
end

Functions.ListPlayerInServer = function(List)
    for n,t in pairs(Lists[List]) do
        for w,p in pairs(t) do
            if Players:FindFirstChild(p) then
                return w
            end
        end
    end
    return nil
end

Functions.GetListPlayersInServer = function(List,Mode)
    local tab = {}
    for n,t in pairs(Lists[List]) do
        if Mode and n == Mode then
            for w,p in pairs(t) do
                if Players:FindFirstChild(p) then
                    tab[p] = true
                end
            end
        elseif not Mode then
            for w,p in pairs(t) do
                if Players:FindFirstChild(p) then
                    tab[p] = true
                end
            end
        end
    end
    return tab
end

Functions.PlayersToStrings = function(tbl)
    local temptab = {}
    for i,v in pairs(tbl) do
        table.insert(temptab,v.Name)
    end
    return temptab
end

Functions.RemovePlayerVanities = function(plr)
    if CoreGui:FindFirstChild(plr.Name.."_PNAESP") then
        CoreGui:FindFirstChild(plr.Name.."_PNAESP"):Destroy()
    end
    if CoreGui:FindFirstChild(plr.Name.."_PNACHMS") then
        CoreGui:FindFirstChild(plr.Name.."_PNACHMS"):Destroy()
    end
end

Functions.IsGodded = function(player)
    if not player:IsA("Model") and player.Character and player.Character:FindFirstChild("Humanoid") then
        if player.Character:FindFirstChild("Humanoid").Health >= 100000000000 then
            return true
        end
    elseif player:IsA("Model") and player:FindFirstChild("Humanoid") then
        if player:FindFirstChild("Humanoid").Health >= 100000000000 then
            return true
        end
    end
    return false
end

Functions.ClosestPlayer = function()
    local dist = math.huge
	local target = nil
	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if Character and v ~= Character then
			if v:FindFirstChild("Humanoid") and v:FindFirstChild(Variables.AimPart) then
                if v.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and not v:FindFirstChild("ForceField") and v.Humanoid.Health >= 1 and (Variables.FireOnGodMode or not Functions.IsGodded(v)) then
                    if not Functions.ListFind("Whitelist",v.Name) and Character:FindFirstChild(Variables.AimPart) then
                        local Magnitude = (v:FindFirstChild(Variables.AimPart).Position - Character:FindFirstChild(Variables.AimPart).Position).Magnitude
                        if Magnitude < dist then
                            dist = Magnitude
                            target = v
                        end
                    end
                end
			end
		end
	end
	return target
end

Functions.GetTargetPlayer = function()
    local Player = nil
    if not Functions.ListEmpty("Targetlist") and Functions.ListPlayerInServer("Targetlist") then
        for n,t in pairs(Lists.Targetlist) do
            for w,p in pairs(t) do
                if Players:FindFirstChild(p) then
                    local v = Players:FindFirstChild(p)
                    if v and v.Character and v.Character ~= Character and not Functions.ListFind("Whitelist",v.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(v)) and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and not v.Character:FindFirstChild("ForceField") and v.Character.Humanoid.Health > 0 then
                        Player = v.Character
                    end
                end
            end
        end
    elseif not Functions.ListEmpty("Blacklist") and Functions.ListPlayerInServer("Blacklist") then
        for i,name in pairs(Lists.Blacklist) do
            if Players:FindFirstChild(name) then
                local v = Players:FindFirstChild(name)
                if v and v.Character and v.Character ~= Character and not Functions.ListFind("Whitelist",v.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(v)) and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and not v.Character:FindFirstChild("ForceField") and v.Character.Humanoid.Health > 0 then
                    Player = v.Character
                end
            end
        end
    elseif Functions.ClosestPlayer() then
        Player = Functions.ClosestPlayer()
    end
    return Player
end

Functions.BoolsToBinary = function(tab)
    local str = ""
    for i = 1,#tab do
        if tab[i] == true then
            str = str.."1"
        else
            str = str.."0"
        end
    end
    return str
end

-- // Main Functions Below \\ --

Functions.SaveSettings = function()
    local httpservice = game:GetService("HttpService")
    if (writefile) then
        local Settings = {}
        for n,t in pairs(Lists) do
            Settings['Permanent'..n] = t.Permanent
        end
        writefile(MAINFILE,httpservice:JSONEncode(Settings))
    end
end

Functions.LoadSettings = function()
    local httpservice = game:GetService("HttpService")
    if (readfile and isfile and isfile(MAINFILE)) then
        local Settings = httpservice:JSONDecode(readfile(MAINFILE))
        for n,t in pairs(Lists) do
            if Settings['Permanent'..n] then
                Lists[n].Permanent = Settings['Permanent'..n]
            end
        end
    end
end

Functions.AutoExecute = function()
    for _,v in pairs(AutoExecuteFuncs) do
        v()
    end
end

Functions.CreateMainTabs = function()

    local function TouchedFuncs()

        Functions.InitCharacterTouched(Players.LocalPlayer,"Local")
    
        Functions.CharacterAdded.CharacterTouched = function()
            task.spawn(function()
                Functions.InitCharacterTouched(Players.LocalPlayer,"Local")
            end)
        end

        for i,v in pairs(Players:GetPlayers()) do
            if Functions.ListFind("Whitelist",v.Name) then
                Functions.InitCharacterTouched(v,"WL")
                v.CharacterAdded:Connect(function()
                    Functions.InitCharacterTouched(v,"WL")
                end)
            end
            v.CharacterAdded:Connect(function()
                for n,t in pairs(Lists) do
                    if Functions.ListFind(n,v.Name,"Soft") then
                        Functions.ListRemove(n,v.Name,"Soft")
                    end
                end
            end)
        end

        Functions.PlayerAdded.WhitelistCharacterTouched = function(player)
            if Functions.ListFind("Whitelist",player.Name) then
                Functions.InitCharacterTouched(player,"WL")
                player.CharacterAdded:Connect(function()
                    Functions.InitCharacterTouched(player,"WL")
                end)
            end
        end

        Functions.PlayerAdded.SoftListRemoval = function(player)
            player.CharacterAdded:Connect(function()
                for n,t in pairs(Lists) do
                    if Functions.ListFind(n,player.Name,"Soft") then
                        Functions.ListRemove(n,player.Name,"Soft")
                    end
                end
            end)
        end

    end

    local function TrainingTab()

        local TrainingToggles = Tabs.Training:AddSection("Toggles")

        AddVariables({["AutoTrain"] = false,["TrainRate"] = 0.7,["TrainAmount"] = 20,["GainingNegativeNin"] = false})
        TrainingToggles:AddToggle("AutoTrain",{
            Title = "Auto Train";
            Description = "Automatically trains your ninjutsu. Uses the Train Amount and Train Rate variables to set how much and how often it trains.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoTrain = true
                    task.spawn(function()
                        while Variables.AutoTrain do
                            if not Variables.GainingNegativeNin then
                                game:GetService("ReplicatedStorage").RemoteEvent.AddPowerEvent:FireServer("FromTraining",Variables.TrainAmount)
                                task.wait(Variables.TrainRate)
                                game:GetService("ReplicatedStorage").RemoteEvent.AddPowerEvent:FireServer("FromTraining",Variables.TrainAmount - 0.001)
                                task.wait(Variables.TrainRate)
                            else
                                task.wait()
                            end
                        end
                    end)
                else
                    Variables.AutoTrain = false
                end
            end
        })

        AddVariables({["DeathTraining"] = false})
        TrainingToggles:AddToggle("Death Training",{
            Title = "Death Training";
            Description = "Allows you to use your training sword even if you're dead. Works with or without dropping sword.";
            Default = false;
            Callback = function(state)
                if state then

                    Variables.DeathTraining = true

                    local function onDeath()
                        if Variables.DeathTraining then
                            if Players.LocalPlayer.Backpack:FindFirstChild("Train") then
                                Players.LocalPlayer.Backpack:FindFirstChild("Train").Parent = Character
                                task.wait(0.03)
                            end
                            local tool = Character:FindFirstChild("Train") or workspace:FindFirstChild("Train")
                            if tool then
                                tool.Handle.CanCollide = true
                                tool.Handle.Anchored = true
                            end
                        end
                    end

                    Character:WaitForChild("Humanoid",math.huge).Died:Connect(onDeath)
                    Functions.CharacterAdded.DeathTraining = function(newChar)
                        task.spawn(function()
                            newChar:WaitForChild("Humanoid",math.huge).Died:Connect(onDeath)
                        end)
                    end

                else
                    Variables.DeathTraining = false
                    Functions.CharacterAdded.DeathTraining = nil
                end
            end;
        })

        AddVariables({["SwordList"] = {}})
        TrainingToggles:AddToggle("Drop Training Sword",{
            Title = "Drop Training Sword";
            Description = "Allows you to walk, jump, and attack while still being able to train. Reset after you turn it off.";
            Default = false;
            Callback = function(state)
                if state then

                    local function DropSword(char)
                        if #Variables.SwordList ~= 0 then
                            for i,v in pairs(Variables.SwordList) do
                                v:Destroy()
                                Variables.SwordList[i] = nil -- Clear the index directly - Dark_Turns
                            end
                        end
                        if not char:FindFirstChild("Train") and Players.LocalPlayer.Backpack:FindFirstChild("Train") then
                            Players.LocalPlayer.Backpack.Train.Parent = char
                            task.wait(0.03)
                        end
                        local tool = char:FindFirstChild("Train")
                        if tool then
                            tool.CanBeDropped = true
                            task.wait(0.03)
                            tool.Parent = workspace
                            tool.LocalScript.Disabled = true
                            tool.Handle.Transparency = 1
                            Variables.SwordList[#Variables.SwordList + 1] = tool
                        end
                    end

                    if Character then
                        DropSword(Character)
                        BackpackChildAdded = Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
                            if child.Name == "Train" and Character then
                                task.wait(0.03)
                                DropSword(Character)
                                if Character:FindFirstChild("Humanoid") and Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead and Variables.DeathTraining then
                                    local tool = workspace:FindFirstChild("Train")
                                    if tool then
                                        tool.Handle.CanCollide = true
                                        tool.Handle.Anchored = true
                                    end
                                end
                            end
                        end)
                    end

                    Functions.CharacterAdded.DropTrainingSword = function(newchar)
                        task.spawn(function()
                            repeat task.wait(0.05) until Players.LocalPlayer.Backpack:FindFirstChild("Train")
                            DropSword(newchar)
                            BackpackChildAdded:Disconnect()
                            task.wait()
                            BackpackChildAdded = Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
                                if child.Name == "Train" and Character then
                                    task.wait(0.03)
                                    DropSword(Character)
                                    if newchar:FindFirstChild("Humanoid") and newchar.Humanoid:GetState() == Enum.HumanoidStateType.Dead and Variables.DeathTraining then
                                        local tool = workspace:FindFirstChild("Train")
                                        if tool then
                                            tool.Handle.CanCollide = true
                                            tool.Handle.Anchored = true
                                        end
                                    end
                                end
                            end)
                        end)
                    end

                else

                    pcall(function()
                        Functions.CharacterAdded.DropTrainingSword = nil
                        BackpackChildAdded:Disconnect()
                    end)

                end
            end
        })

        AddVariables({["CharRespawning"] = false, ["ResPos"] = nil})
        TrainingToggles:AddToggle("Auto Respawn",{
            Title = "Auto Respawn";
            Description = "Automatically respawns your character after you die and teleports you back to your original position.";
            Default = false;
            Callback = function(state)
                if state then

                    local pos
                    local preZoom
                    local Player = Players.LocalPlayer

                    local function HumDied()
                        pos = workspace.CurrentCamera.CFrame
                        preZoom = (workspace.CurrentCamera.CFrame.Position - workspace.CurrentCamera.Focus.Position).Magnitude
                        Variables.CharRespawning = true
                        Variables.ResPos = Functions.GetRoot(Character).CFrame
                        local mainspawn = Player.PlayerGui:FindFirstChild("FirstScreenGui").MainSpawnBtn
                        local randomspawn = Player.PlayerGui:FindFirstChild("FirstScreenGui").RandomSpawnBtn
                        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):WaitForChild("SpawnCharacterEvent"):FireServer("MainSpawn")
                        game:GetService("Lighting"):WaitForChild("Blur").Size = 0
                        game:GetService("Lighting"):WaitForChild("Blur").Enabled = false
                        mainspawn.TextTransparency = 1
                        mainspawn.BackgroundTransparency = 1
                        randomspawn.TextTransparency = 1
                        randomspawn.BackgroundTransparency = 1
                        Player.PlayerGui:FindFirstChild("FirstScreenGui").Enabled = false
                    end

                    Autorespawning = Character:WaitForChild("Humanoid",math.huge).Died:Connect(HumDied)
                    Functions.CharacterAdded.AutoRespawn = function()
                        local count = 0
                        local totalCount = 0
                        local preMaxZoom = Players.LocalPlayer.CameraMaxZoomDistance
                        local preMinZoom = Players.LocalPlayer.CameraMinZoomDistance
                        task.spawn(function()
                            Functions.CheckAllParts(Character)
                            while count <= 20 do
                                local hrp = Functions.GetRoot(Character)
                                if hrp and CFrame.new(math.floor(hrp.CFrame.X),math.floor(hrp.CFrame.Y),math.floor(hrp.CFrame.Z)) ~= CFrame.new(math.floor(Variables.ResPos.X),math.floor(Variables.ResPos.Y),math.floor(Variables.ResPos.Z)) then
                                    if Variables.ResPos ~= nil then
                                        hrp.CFrame = Variables.ResPos
                                        Players.LocalPlayer.CameraMaxZoomDistance = preZoom
                                        Players.LocalPlayer.CameraMinZoomDistance = preZoom
                                        Players.LocalPlayer.CameraMaxZoomDistance = preMaxZoom
                                        Players.LocalPlayer.CameraMinZoomDistance = preMinZoom
                                        if totalCount == 0 then
                                            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                                            workspace.CurrentCamera.CFrame = pos
                                            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                                        end
                                    end
                                    count = 0
                                elseif hrp then
                                    count += 1
                                end
                                totalCount += 1
                                if totalCount > 40 then break end
                                task.wait()
                            end
                        end)
                        Autorespawning = Character:WaitForChild("Humanoid",math.huge).Died:Connect(HumDied)
                    end
                else
                    Functions.CharacterAdded.AutoRespawn = nil
                    pcall(function()
                        Autorespawning:Disconnect()
                    end)
                    Variables.ResPos = nil
                end
            end
        })

        AddVariables({["AntiAfk"] = false})
        TrainingToggles:AddToggle("Anti Afk",{
            Title = "Anti Afk";
            Description = "Disables the Roblox feature that disconnects you after 20 minutes of inactivity.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AntiAfk = true
                    Players.LocalPlayer.Idled:Connect(function()
                        if Variables.AntiAfk then
                            local VirtualUser = game:GetService("VirtualUser")
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton2(Vector2.new())
                        else return end
                    end)
                else
                    Variables.AntiAfk = false
                end
            end
        })

        AddVariables({["AntiBubble"] = false})
        TrainingToggles:AddToggle("Anti Bubble",{
            Title = "Anti Bubble";
            Description = "Gets rid of your bubble whenever you get it.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AntiBubble = true
                    coroutine.resume(coroutine.create(function()
                        local weapon = 1
                        local lastWeapon = nil
                        while Variables.AntiBubble do
                            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildWhichIsA("ForceField") and Variables.CharRespawning == false then
                                if weapon == 1 and Players.LocalPlayer.Backpack:FindFirstChild("Sword") then
                                    lastWeapon = Players.LocalPlayer.Backpack:FindFirstChild("Sword")
                                    lastWeapon.Parent = Character
                                    weapon = 2
                                elseif weapon == 2 and Players.LocalPlayer.Backpack:FindFirstChild("Shuriken") then
                                    lastWeapon = Players.LocalPlayer.Backpack:FindFirstChild("Shuriken")
                                    lastWeapon.Parent = Character
                                    weapon = 1
                                end
                                task.wait()
                                if lastWeapon and lastWeapon.Parent then
                                    lastWeapon.Parent = Players.LocalPlayer.Backpack
                                end
                            else
                                task.wait()
                            end
                        end
                    end))
                else
                    Variables.AntiBubble = false
                end
            end
        })

        AddVariables({["AutoPosition"] = false, ["Positioning"] = {['X'] = 0, ['Y'] = 0, ['Z'] = 0}})
        TrainingToggles:AddToggle("Auto Position",{
            Title = "Auto Position";
            Description = "Automatically teleports you to a position in the world. Uses the X, Y, and Z variables of auto positioning.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoPosition = true
                    coroutine.resume(coroutine.create(function()
                        while Variables.AutoPosition do
                            local location = CFrame.new(Variables.Positioning.x, Variables.Positioning.y, Variables.Positioning.z)
                            if Functions.GetRoot(Character) then
                                Functions.GetRoot(Character).CFrame = location
                            end
                            task.wait(10)
                        end
                    end))
                else
                    Variables.AutoPosition = false
                end
            end
        })

        AddVariables({["AutoReconnect"] = false})
        TrainingToggles:AddToggle("Auto Reconnect",{
            Title = "Auto Reconnect";
            Description = "Automatically reconnects you if you get disconnected from the game.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoReconnect = true
                    coroutine.resume(coroutine.create(function()
                        while Variables.AutoReconnect do
                            if CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then
                                if CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt").TitleFrame.ErrorTitle.Text == "Disconnected" then
                                    if #Players:GetPlayers() <= 1 then
                                        Players.LocalPlayer:Kick("\nRejoining...")
                                        task.wait()
                                        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                                    else
                                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
                                    end
                                end
                            end
                            task.wait(0.5)
                        end
                    end))
                else
                    Variables.AutoReconnect = false
                end
            end
        })

        TrainingToggles:AddToggle("Noclip",{
            Title = "Noclip";
            Description = "Allows you to clip through any basepart in the game.";
            Default = false;
            Callback = function(state)
                if state then
                    function NoclipLoop()
                        if Character then
                            for i,v in pairs(Character:GetDescendants()) do
                                if v:IsA("BasePart") and v.CanCollide == true then
                                    v.CanCollide = false
                                end
                            end
                        end
                    end
                    Noclipping = RunService.Stepped:Connect(NoclipLoop)
                else
                    pcall(function()
                        Noclipping:Disconnect()
                    end)
                end
            end
        })

        TrainingToggles:AddToggle("Freeze Player",{
            Title = "Freeze Player";
            Description = "Completely freezes every part of your character's body in place.";
            Default = false;
            Callback = function(state)
                if state then
                    if Character then
                        for i,v in pairs(Character:GetChildren()) do
                            if v:IsA("BasePart") and v.Anchored ~= true then
                                v.Anchored = true
                            end
                        end
                    end
                    Functions.CharacterAdded.FreezePlayer = function()
                        if Character then
                            task.wait()
                            for i,v in pairs(Character:GetChildren()) do
                                if v:IsA("BasePart") and v.Anchored ~= true then
                                    v.Anchored = true
                                end
                            end
                        end
                    end
                else
                    if Character then
                        for i,v in pairs(Character:GetChildren()) do
                            if v:IsA("BasePart") and v.Anchored ~= false then
                                v.Anchored = false
                            end
                        end
                    end
                    Functions.CharacterAdded.FreezePlayer = nil
                end
            end
        })

        TrainingToggles:AddToggle("Seat ESP",{
            Title = "Seat ESP";
            Description = "Shows where every seat is in the map via box handle adornments.";
            Default = false;
            Callback = function(state)
                if state then
                    for i,v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Seat") then
                            local a = Instance.new("BoxHandleAdornment")
                            a.Name = "SeatESP"
                            a.Parent = v
                            a.Adornee = v
                            a.AlwaysOnTop = true
                            a.ZIndex = 10
                            a.Size = v.Size
                            a.Transparency = 0.2
                            a.Color = BrickColor.new(1001)
                        end
                    end
                else
                    for i,v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("Seat") then
                            if v:FindFirstChild("SeatESP") then
                                v:FindFirstChild("SeatESP"):Destroy()
                            end
                        end
                    end
                end
            end
        })

        AddVariables({["AntiFirstScreen"] = false})
        TrainingToggles:AddToggle("Anti First Screen",{
            Title = "Anti First Screen";
            Description = "Disables the respawn screen, or 'First Screen' as the game calls it, from appearing when you die.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AntiFirstScreen = true
                    coroutine.resume(coroutine.create(function()
                        while Variables.AntiFirstScreen do
                            game:GetService("Lighting"):FindFirstChild("Blur").Enabled = false
                            Player:WaitForChild("PlayerGui"):FindFirstChild("FirstScreenGui").Enabled = false
                            task.wait(0.1)
                        end
                    end))
                else
                    Variables.AntiFirstScreen = false
                end
            end
        })

        AddVariables({["InfiniteJump"] = false})
        TrainingToggles:AddToggle("Infinite Jumps",{
            Title = "Infinite Jumps";
            Description = "Gives you an infinite amount of jumps no matter what your ninjutsu is (you could even have 0).";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.InfiniteJump = true
                    local totalJumps = 0
                    local currentJump = 0
                    local MAX_JUMPS = 0
                    local jumpSide = 1
                    local canJump = true
                    local AllJumpAnims = {}
        
                    local function CreateShockRing()
                        local ring = Instance.new("Part")
                        ring.formFactor = 2
                        ring.Anchored = true
                        ring.Locked = true
                        ring.CanCollide = false
                        ring.archivable = false
                        ring.TopSurface = 0
                        ring.BottomSurface = 0
                        ring.Transparency = 1
                        local decal = Instance.new("Decal", ring)
                        decal.Face = 1
                        decal.Texture = "http://www.roblox.com/asset/?version=1&id=1280730"
                        local rfoot = Character:FindFirstChild("RightFoot")
                        local rfootpos = rfoot.Position
                        ring.CFrame = CFrame.new(rfootpos)
                        ring.Parent = rfoot
                        ring.Size = Vector3.new(1, 0.4, 1)
                        for i = 1, 10, 1 do
                            wait(0.05)
                            ring.Size = ring.Size + Vector3.new(0.75, 0, 0.75)
                            decal.Transparency = decal.Transparency + 0.1
                        end
                        ring:Destroy()
                    end
                    
                    local function StopInGameJumpingAnims()
                        for i,v in pairs(Players.LocalPlayer.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
                            if v.Name == "JumpAnim1" or v.Name == "JumpAnim2" then
                                v:Stop()
                            end
                        end
                    end
                    
                    local function PlayJumpAnim()
                        local humanoid = Character:WaitForChild("Humanoid")
                        if jumpSide == 1 then
                            local jumpanim1 = Player:WaitForChild("PlayerGui"):WaitForChild("PlayerScript"):WaitForChild("JumpAnim1")
                            StopInGameJumpingAnims()
                            AllJumpAnims.JumpAnim1 = humanoid.Animator:LoadAnimation(jumpanim1)
                            AllJumpAnims.JumpAnim1:Play(0.2,1,1)
                            return
                        elseif jumpSide == 2 then
                            local jumpanim2 = Player:WaitForChild("PlayerGui"):WaitForChild("PlayerScript"):WaitForChild("JumpAnim2")
                            StopInGameJumpingAnims()
                            AllJumpAnims.JumpAnim2 = humanoid.Animator:LoadAnimation(jumpanim2)
                            AllJumpAnims.JumpAnim2:Play(0.2,1,1)
                            return
                        end
                    end
        
                    local function manageConsecutiveJumps(_, newState)
                        if newState == Enum.HumanoidStateType.Jumping then
                            local ninjutsu = Player:FindFirstChild("leaderstats"):FindFirstChild("Ninjutsu").Value
                            if ninjutsu < 200 then
                                MAX_JUMPS = 1
                            elseif ninjutsu >= 200 and ninjutsu < 1000 then
                                MAX_JUMPS = 2
                            elseif ninjutsu >= 1000 and ninjutsu < 3500 then
                                MAX_JUMPS = 3
                            elseif ninjutsu >= 3500 and ninjutsu < 17000 then
                                MAX_JUMPS = 4
                            elseif ninjutsu >= 17000 and ninjutsu < 36000 then
                                MAX_JUMPS = 5
                            elseif ninjutsu >= 36000 and ninjutsu < 53000 then
                                MAX_JUMPS = 6
                            elseif ninjutsu >= 53000 and ninjutsu < 84000 then
                                MAX_JUMPS = 7
                            elseif ninjutsu >= 84000 and ninjutsu < 140000 then
                                MAX_JUMPS = 8
                            elseif ninjutsu >= 140000 and ninjutsu < 180000 then
                                MAX_JUMPS = 9
                            elseif ninjutsu >= 180000 and ninjutsu < 240000 then
                                MAX_JUMPS = 10
                            elseif ninjutsu >= 240000 and ninjutsu < 350000 then
                                MAX_JUMPS = 11
                            elseif ninjutsu >= 350000 and ninjutsu < 520000 then
                                MAX_JUMPS = 12
                            elseif ninjutsu >= 520000 and ninjutsu < 830000 then
                                MAX_JUMPS = 13
                            elseif ninjutsu >= 830000 and ninjutsu < 1000000 then
                                MAX_JUMPS = 14
                            elseif ninjutsu >= 1000000 and ninjutsu < 1300000 then
                                MAX_JUMPS = 15
                            elseif ninjutsu >= 1300000 and ninjutsu < 1750000 then
                                MAX_JUMPS = 16
                            elseif ninjutsu >= 1750000 and ninjutsu < 2250000 then
                                MAX_JUMPS = 17
                            elseif ninjutsu >= 2250000 and ninjutsu < 2750000 then
                                MAX_JUMPS = 18
                            elseif ninjutsu >= 2750000 and ninjutsu < 3500000 then
                                MAX_JUMPS = 19
                            elseif ninjutsu >= 3500000 and ninjutsu < 5000000 then
                                MAX_JUMPS = 20
                            elseif ninjutsu >= 5000000 and ninjutsu < 10000000 then
                                MAX_JUMPS = 21
                            elseif ninjutsu >= 10000000 then
                                MAX_JUMPS = math.huge
                            end
                            canJump = false;
                            wait(0.1);
                            if currentJump ~= 0 then
                                if totalJumps%2 == 0 then
                                    jumpSide = 2
                                else
                                    jumpSide = 1
                                end
                                totalJumps = totalJumps + 1;
                            end
                            currentJump = currentJump + 1;
                            canJump = currentJump >= MAX_JUMPS;
                        elseif newState == Enum.HumanoidStateType.Freefall and currentJump == 0 then
                            currentJump = currentJump + 1;
                            if totalJumps%2 == 0 then
                                jumpSide = 2
                            else
                                jumpSide = 1
                            end
                            totalJumps = totalJumps + 1;
                            canJump = currentJump >= MAX_JUMPS;
                        elseif newState == Enum.HumanoidStateType.Landed then
                            currentJump = 0;
                            canJump = true;
                        end
                    end
                    
                    local function dispatchConsecutiveJumps(inputObject,processed)
                        if not processed then
                            local humanoid = Character:WaitForChild("Humanoid")
                            local shouldDispatch = (
                                inputObject.KeyCode == Enum.KeyCode.Space and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and canJump and Variables.InfiniteJump
                            )
                    
                            if shouldDispatch then
                                if currentJump ~= 0 then
                                    PlayJumpAnim()
                                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
                                    local bv = Instance.new("BodyVelocity")
                                    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                    bv.Velocity = Vector3.new(0,60,0)
                                    bv.Parent = Character:FindFirstChild("HumanoidRootPart")
                                    if humanoid.MoveDirection ~= Vector3.new(0,0,0) then
                                        bv.Velocity = bv.Velocity + humanoid.MoveDirection * 100
                                    end
                                    game:GetService("Debris"):AddItem(bv,0.01)
                                    CreateShockRing()
                                elseif humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                                    PlayJumpAnim()
                                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0,0,0)
                                    local bv = Instance.new("BodyVelocity")
                                    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                    bv.Velocity = Vector3.new(0,60,0)
                                    bv.Parent = Character:FindFirstChild("HumanoidRootPart")
                                    if humanoid.MoveDirection ~= Vector3.new(0,0,0) then
                                        bv.Velocity = bv.Velocity + humanoid.MoveDirection * 100
                                    end
                                    game:GetService("Debris"):AddItem(bv,0.01)
                                    CreateShockRing()
                                end
                            end
                        end
                    end
                    
                    consecjumpssc = Character:WaitForChild("Humanoid",math.huge).StateChanged:Connect(manageConsecutiveJumps)
                    consecjumpsuis = UserInputService.InputBegan:Connect(dispatchConsecutiveJumps)
        
                    Functions.CharacterAdded.InfiniteJumps = function()
                        totalJumps = 0
                        jumpSide = 1
                        consecjumpssc = Character:WaitForChild("Humanoid",math.huge).StateChanged:Connect(manageConsecutiveJumps)
                        consecjumpsuis = UserInputService.InputBegan:Connect(dispatchConsecutiveJumps)
                    end
                else
                    pcall(function()
                        Variables.InfiniteJump = true
                        CharacterAddedFunctions.InfiniteJumps = nil
                        consecjumpssc:Disconnect()
                        consecjumpsuis:Disconnect()
                    end)
                end
            end
        })

        AddVariables({["InfiniteTeleport"] = false})
        TrainingToggles:AddToggle("Infinite Teleport",{
            Title = "Infinite Teleport";
            Description = "Gives you infinite teleporting range, assuming you have the teleport tool.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.InfiniteTeleport = true
                    local tool = nil
                    local mouse = Players.LocalPlayer:GetMouse()
                    local AllTeleAnims = {}

                    local function PlayTeleportAnim(tool)
                        local teleanim = tool.LocalScript.TeleportAnim
                        local humanoid = Character:WaitForChild("Humanoid")
                        for i,v in pairs(AllTeleAnims) do
                            v:Stop()
                        end
                        AllTeleAnims.WarpAnim = humanoid:WaitForChild("Animator"):LoadAnimation(teleanim)
                        AllTeleAnims.WarpAnim:Play(0.1, 1, 2)
                    end

                    if Player.leaderstats.Ninjutsu.Value >= 63000 then
                        repeat task.wait(0.05) until Player.Backpack:FindFirstChild("Teleport") or Character:FindFirstChild("Teleport")
                        tool = Player.Backpack:FindFirstChild("Teleport") or Character:FindFirstChild("Teleport")
                        infteleporting = tool.Activated:Connect(function()
                            if Variables.InfiniteTeleport then
                                local ninjutsu = Player:FindFirstChild("leaderstats").Ninjutsu.Value
                                if (ninjutsu / 10000) < (tool.Handle.CFrame.p - mouse.Hit.p).Magnitude then
                                    local teleeffpart = Instance.new("Part",Character:FindFirstChild("HumanoidRootPart"))
                                    local bbgui = Instance.new("BillboardGui",teleeffpart)
                                    local image = Instance.new("ImageLabel",bbgui)
                                    teleeffpart.Size = Vector3.new(1,1,1)
                                    teleeffpart.Position = Character:FindFirstChild("HumanoidRootPart").Position
                                    teleeffpart.CanCollide = false
                                    teleeffpart.Transparency = 1
                                    teleeffpart.Anchored = true
                                    bbgui.Size = UDim2.new(16,0,4,0)
                                    bbgui.SizeOffset = Vector2.new(0.25,0)
                                    bbgui.StudsOffset = Vector3.new(0,2.5,0)
                                    bbgui.ZIndexBehavior = Enum.ZIndexBehavior.Global
                                    bbgui.LightInfluence = 1
                                    bbgui.MaxDistance = math.huge
                                    image.BackgroundTransparency = 1
                                    image.Size = UDim2.new(0.5,0,2,0)
                                    image.Image = "rbxassetid://1105721957"
                                    image.ImageColor3 = Color3.new(0,0,0)
                                    if Player.Team.Name == "Yin" then
                                        image.ImageColor3 = Color3.fromRGB(0,0,0)
                                    elseif Player.Team.Name == "Yang" then
                                        image.ImageColor3 = Color3.fromRGB(242,243,243)
                                    end
                                    task.spawn(function()
                                        for i = 1,10 do
                                            image.ImageTransparency = image.ImageTransparency + 0.1
                                            if image.ImageTransparency == 1 then
                                                teleeffpart:Destroy()
                                            end
                                            task.wait(0.0505)
                                        end
                                    end)
                                    PlayTeleportAnim(tool)
                                    Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Vector3.new(mouse.Hit.p.X,mouse.Hit.p.Y + 2,mouse.Hit.p.Z),Vector3.new(mouse.Hit.p.X,mouse.Hit.p.Y + 2,mouse.Hit.p.Z) + Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector)
                                    if tool.Handle:FindFirstChildWhichIsA("Sound").IsPlaying then
                                        tool.Handle:FindFirstChildWhichIsA("Sound"):Stop()
                                    end
                                    tool.Handle:FindFirstChildWhichIsA("Sound"):Play()
                                    Player:FindFirstChild("LocalSounds").ErrorSound:Stop()
                                end
                            end
                        end)
                    end

                    Functions.CharacterAdded.InfiniteTeleport = function()
                        local tool = nil

                        if Player.leaderstats.Ninjutsu.Value >= 63000 then
                            repeat task.wait() until Player.Backpack:FindFirstChild("Teleport") or Character:FindFirstChild("Teleport")
                            tool = Player.Backpack:FindFirstChild("Teleport") or Character:FindFirstChild("Teleport")
                            infteleporting = tool.Activated:Connect(function()
                                if Variables.InfiniteTeleport then
                                    local ninjutsu = Player:FindFirstChild("leaderstats").Ninjutsu.Value
                                    if (ninjutsu / 10000) < (tool.Handle.CFrame.p - mouse.Hit.p).Magnitude then
                                        local teleeffpart = Instance.new("Part",Character:FindFirstChild("HumanoidRootPart"))
                                        local bbgui = Instance.new("BillboardGui",teleeffpart)
                                        local image = Instance.new("ImageLabel",bbgui)
                                        teleeffpart.Size = Vector3.new(1,1,1)
                                        teleeffpart.Position = Character:FindFirstChild("HumanoidRootPart").Position
                                        teleeffpart.CanCollide = false
                                        teleeffpart.Transparency = 1
                                        teleeffpart.Anchored = true
                                        bbgui.Size = UDim2.new(16,0,4,0)
                                        bbgui.SizeOffset = Vector2.new(0.25,0)
                                        bbgui.StudsOffset = Vector3.new(0,2.5,0)
                                        bbgui.ZIndexBehavior = Enum.ZIndexBehavior.Global
                                        bbgui.LightInfluence = 1
                                        bbgui.MaxDistance = math.huge
                                        image.BackgroundTransparency = 1
                                        image.Size = UDim2.new(0.5,0,2,0)
                                        image.Image = "rbxassetid://1105721957"
                                        image.ImageColor3 = Color3.new(0,0,0)
                                        if Player.Team.Name == "Yin" then
                                            image.ImageColor3 = Color3.fromRGB(0,0,0)
                                        elseif Player.Team.Name == "Yang" then
                                            image.ImageColor3 = Color3.fromRGB(242,243,243)
                                        end
                                        task.spawn(function()
                                            for i = 1,10 do
                                                image.ImageTransparency = image.ImageTransparency + 0.1
                                                if image.ImageTransparency == 1 then
                                                    teleeffpart:Destroy()
                                                end
                                                task.wait(0.0505)
                                            end
                                        end)
                                        PlayTeleportAnim(tool)
                                        Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Vector3.new(mouse.Hit.p.X,mouse.Hit.p.Y + 2,mouse.Hit.p.Z),Vector3.new(mouse.Hit.p.X,mouse.Hit.p.Y + 2,mouse.Hit.p.Z) + Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector)
                                        if tool.Handle:FindFirstChildWhichIsA("Sound").IsPlaying then
                                            tool.Handle:FindFirstChildWhichIsA("Sound"):Stop()
                                        end
                                        tool.Handle:FindFirstChildWhichIsA("Sound"):Play()
                                        Player:FindFirstChild("LocalSounds").ErrorSound:Stop()
                                    end
                                end
                            end)
                        end
                    end
                else
                    pcall(function()
                        Variables.InfiniteTeleport = false
                        Functions.CharacterAdded.InfiniteTeleporting = nil
                        infteleporting:Disconnect()
                    end)
                end
            end
        })

        TrainingToggles:AddToggle("Safe Spot",{
            Title = "Safe Spot";
            Description = "Teleports you to a safe spot anywhere in the entire world. Uses X, Y, and Z variables of safe spot.";
            Default = false;
            Callback = function(state)
                if state then
                    if Character and Functions.GetRoot(Character) then
                        respos = Functions.GetRoot(Character).CFrame
                        local safepart = Instance.new("Part",workspace)
                        safepart.Name = "SAFEPART_1"
                        safepart.CFrame = Variables.SafePartCFrame
                        safepart.Anchored = true
                        safepart.Size = Vector3.new(2048,50,2048)
                        safepart.Color = Color3.fromRGB(99,95,98)
                        safepart.Material = Enum.Material.Slate
                        Functions.GetRoot(Character).CFrame = safepart.CFrame + Vector3.new(0,27,0)
                    end
                else
                    if Character and Functions.GetRoot(Character) and workspace:FindFirstChild("SAFEPART_1") then
                        Functions.GetRoot(Character).CFrame = respos
                    end
                    if workspace:FindFirstChild("SAFEPART_1") then
                        workspace:FindFirstChild("SAFEPART_1"):Destroy()
                    end
                end
            end
        })

        AddVariables({["AutoSpeed"] = false})
        TrainingToggles:AddToggle("Auto Ctrl",{
            Title = "Auto Ctrl";
            Description = "Automatically presses left control, to bring your speed back to normal, when you take out a training sword.";
            Default = false;
            Callback = function(state)
                if state then
                    oldConnect = Character.ChildAdded:Connect(function(child)
                        if Variables.AutoSpeed and child.Name == "Train" and Character:FindFirstChild("Humanoid") then
                            repeat task.wait() until Character.Humanoid.WalkSpeed == 0
                            if Players.LocalPlayer.Stats.SelectedWalkSpeed.Value == 0 then
                                Character.Humanoid.WalkSpeed = 100
                            else
                                Character.Humanoid.WalkSpeed = Players.LocalPlayer.Stats.SelectedWalkSpeed.Value
                            end
                        elseif not Variables.AutoSpeed then return end
                    end)
        
                    Functions.CharacterAdded.AutoSpeed = function()
                        oldConnect:Disconnect()
                        oldConnect = Character.ChildAdded:Connect(function(child)
                            if Variables.AutoSpeed and child.Name == "Train" and Character:FindFirstChild("Humanoid") then
                                repeat task.wait() until Character.Humanoid.WalkSpeed == 0
                                if Players.LocalPlayer.Stats.SelectedWalkSpeed.Value == 0 then
                                    Character.Humanoid.WalkSpeed = 100
                                else
                                    Character.Humanoid.WalkSpeed = Players.LocalPlayer.Stats.SelectedWalkSpeed.Value
                                end
                            elseif not Variables.AutoSpeed then return end
                        end)
                    end
                else
                    Functions.CharacterAdded.AutoSpeed = nil
                end
            end
        })

        local TrainingSettings = Tabs.Training:AddSection("Training Settings")

        TrainingSettings:AddInput("Train Amount",{
            Title = "Train Amount";
            Description = "Configures normal train amount";
            Default = 20;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(value)
                Variables.TrainAmount = tonumber(value)
            end
        })

        TrainingSettings:AddInput("Train Rate",{
            Title = "Train Rate";
            Description = "Configures normal train rate";
            Default = 0.7;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(value)
                Variables.TrainRate = tonumber(value)
            end
        })

        local SafeSpotSettings = Tabs.Training:AddSection("Safe Spot Settings")

        AddVariables({["SafePartCFrame"] = CFrame.new(0,200000,0)})
        SafeSpotSettings:AddInput("Safe Spot X Value",{
            Title = "Safe Spot X Value";
            Description = "Configures safe spot X value";
            Default = 0;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(value)
                Variables.SafePartCFrame = CFrame.new(value, Variables.SafePartCFrame.Position.Y, Variables.SafePartCFrame.Position.Z)
                if workspace:FindFirstChild("SAFEPART_1") then
                    workspace:FindFirstChild("SAFEPART_1").CFrame = Variables.SafePartCFrame
                    if Players.LocalPlayer.Character and Functions.GetRoot(Players.LocalPlayer.Character) then
                        local difference = value - workspace:FindFirstChild("SAFEPART_1").Position.X
                        local hrp = Functions.GetRoot(Players.LocalPlayer.Character)
                        hrp.CFrame = Variables.SafePartCFrame + Vector3.new(0,27,0)
                    end
                end
            end
        })

        SafeSpotSettings:AddInput("Safe Spot Y Value",{
            Title = "Safe Spot Y Value";
            Description = "Configures safe spot Y value";
            Default = 200000;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(value)
                Variables.SafePartCFrame = CFrame.new(Variables.SafePartCFrame.Position.X, value, Variables.SafePartCFrame.Position.Z)
                if workspace:FindFirstChild("SAFEPART_1") then
                    workspace:FindFirstChild("SAFEPART_1").CFrame = Variables.SafePartCFrame
                    if Players.LocalPlayer.Character and Functions.GetRoot(Players.LocalPlayer.Character) then
                        local difference = value - workspace:FindFirstChild("SAFEPART_1").Position.Y
                        local hrp = Functions.GetRoot(Players.LocalPlayer.Character)
                        hrp.CFrame = Variables.SafePartCFrame + Vector3.new(0,27,0)
                    end
                end
            end
        })

        SafeSpotSettings:AddInput("Safe Spot Z Value",{
            Title = "Safe Spot Z Value";
            Description = "Configures safe spot Z value";
            Default = 0;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(value)
                Variables.SafePartCFrame = CFrame.new(Variables.SafePartCFrame.Position.X, Variables.SafePartCFrame.Position.Y, value)
                if workspace:FindFirstChild("SAFEPART_1") then
                    workspace:FindFirstChild("SAFEPART_1").CFrame = Variables.SafePartCFrame
                    if Players.LocalPlayer.Character and Functions.GetRoot(Players.LocalPlayer.Character) then
                        local difference = value - workspace:FindFirstChild("SAFEPART_1").Position.Z
                        local hrp = Functions.GetRoot(Players.LocalPlayer.Character)
                        hrp.CFrame = Variables.SafePartCFrame + Vector3.new(0,27,0)
                    end
                end
            end
        })

    end

    local function ListsTab()

        local ListsDropdowns = Tabs.Lists:AddSection("Dropdowns")
        local currentList = "Whitelist"
        local currentMode = "Soft"
        local includeWhitelist = false
        local previousValues = {}
        local playersLeft = {}

        for n,t in pairs(Lists) do
            previousValues[n] = {}
            playersLeft[n] = {}
            for w,_ in pairs(t) do
                previousValues[n][w] = {}
                if w == "Normal" or w == "Permanent" then
                    playersLeft[n][w] = {}
                end
            end
        end

        Functions.PlayerRemoved.MultiListUpdate = function(player)
            for n,t in pairs(Lists) do
                if t['Normal'][player.Name] then
                    playersLeft[n]['Normal'][player.Name] = true
                elseif t['Permanent'][player.Name] then
                    playersLeft[n]['Permanent'][player.Name] = true
                end
            end
        end

        ListsDropdowns:AddButton({
            Title = "List Terms";
            Callback = function()
                MainWindow:Dialog({
                    Title = "List Terms";
                    Content = "- Whitelist = Players you don't want to hurt.\n\n- Blacklist = Players you want to hurt first but then move onto the rest.\n\n- Targetlist = Players you ONLY want to hurt. Excludes the rest.\n\n- BreakShurslist = Players you want to break the shurikens of.\n\n- DisableShurslist = Players that disable the whole server's shurikens while they're in game.";
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                            end
                        }
                    };
                })
            end;
        })

        ListsDropdowns:AddButton({
            Title = "Mode Terms";
            Callback = function()
                MainWindow:Dialog({
                    Title = "List Terms";
                    Content = "- Soft = Unadds players from the list when they leave the game or when they spawn.\n\n- Semi = Unadds players from the list only when they leave the game.\n\n- Normal = Never unadds players unless manually unadded, however, it doesn't save when you leave the game.\n\n- Permanent = Never unadds players unless manually unadded. Saves when you leave the game.";
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                            end
                        }
                    };
                })
            end;
        })

        ListsDropdowns:AddDropdown("Multilist",{
            Title = "Soft Whitelist";
            Values = Functions.PlayersToStrings(Players:GetPlayers());
            Multi = true;
            Default = Functions.GetListPlayersInServer(currentList,currentMode);
        })

        ListsDropdowns:AddDropdown("DropDownSelector",{
            Title = "Select DropDown";
            Values = {"Whitelist", "Blacklist", "Targetlist", "BreakShurlist", "DisableShurslist"};
            Multi = false;
            Default = currentList;
        })

        ListsDropdowns:AddDropdown("ModeSelector",{
            Title = "Select Mode";
            Values = {"Soft", "Semi", "Normal", "Permanent"};
            Multi = false;
            Default = currentMode;
        })

        ListsDropdowns:AddButton({
            Title = "Refresh Multilist";
            Callback = function()
                Options.Multilist:SetValues(Functions.PlayersToStrings(Players:GetPlayers()))
                Options.Multilist:SetValue(Functions.GetListPlayersInServer(currentList,currentMode))
            end;
        })

        Options.ModeSelector:OnChanged(function(Value)
            currentMode = Value
            local listplayers = Functions.GetListPlayersInServer(currentList,Value)
            Options.Multilist:SetTitle(Value.." "..currentList)
            Options.Multilist:SetValue(listplayers)
            previousValues[currentList][currentMode] = listplayers
        end)

        Options.DropDownSelector:OnChanged(function(Value)
            currentList = Value
            local listplayers = Functions.GetListPlayersInServer(currentList,Value)
            Options.Multilist:SetTitle(currentMode.." "..Value)
            Options.Multilist:SetValue(listplayers)
            previousValues[currentList][currentMode] = listplayers
        end)

        Options.Multilist:OnChanged(function(Values)
            local tab = {}
            for Value, State in pairs(previousValues[currentList][currentMode]) do
                if not Values[Value] and Functions.ListFind(currentList,Value,currentMode) and ((not playersLeft[currentList][currentMode]) or (playersLeft[currentList][currentMode] and not playersLeft[currentList][currentMode][Value])) then
                    Functions.ListRemove(currentList,Value,currentMode)
                elseif (playersLeft[currentList][currentMode] and playersLeft[currentList][currentMode][Value]) then
                    tab[Value] = State
                    playersLeft[currentList][currentMode][Value] = nil
                end
            end
            for Value, State in pairs(Values) do
                tab[Value] = State
                if not previousValues[currentList][currentMode][Value] and not Functions.ListFind(currentList,Value,currentMode) then
                    Functions.ListInsert(currentList,Value,currentMode)
                end
            end
            previousValues[currentList][currentMode] = tab
        end)

        local ListsAdd = Tabs.Lists:AddSection("Advanced")

        ListsAdd:AddParagraph({
            Title = "Advanced Options";
            Content = "Select a list from any of the following selections and then choose what to do with it at the end.";
        })

        AddVariables({["AddAllLists"] = {}})
        for n,_ in pairs(Lists) do
            Variables.AddAllLists[n] = {}
        end

        local function CreateDropdown(n)
            local selection = ListsAdd:AddDropdown("Select"..n,{
                Title = n.."s";
                Values = {"Soft "..n, "Semi "..n, "Normal "..n, "Permanent "..n};
                Multi = true;
                Default = {};
            })
            selection:OnChanged(function(Values)
                for i,v in pairs(Variables.AddAllLists[n]) do
                    if not Values[i.." "..n] and v then
                        Variables.AddAllLists[n][i] = false
                    elseif Values[i.." "..n] and not v then
                        Variables.AddAllLists[n][i] = true
                    end
                end
            end)
        end

        CreateDropdown("Whitelist")
        CreateDropdown("Blacklist")
        CreateDropdown("Targetlist")
        CreateDropdown("BreakShurlist")
        CreateDropdown("DisableShurslist")

        ListsAdd:AddToggle("IncludeWhitelistedPlrs",{
            Title = "Include Whitelisted Players";
            Default = false;
            Callback = function(state)
                if state then
                    includeWhitelist = true
                else
                    includeWhitelist = false
                end
            end
        })

        ListsAdd:AddToggle("AddAllListPlayers",{
            Title = "Add All Players To Selected Lists";
            Default = false;
            Callback = function(state)
                if state then
                    for i,v in pairs(Players:GetPlayers()) do
                        for n,t in pairs(Variables.AddAllLists) do
                            for w,p in pairs(t) do
                                if p then
                                    if ((not includeWhitelist and n ~= "Whitelist" and not Functions.ListFind("Whitelist",v.Name)) or includeWhitelist) and not Functions.ListFind(n,v.Name,w) then
                                        Functions.ListInsert(n,v.Name,w)
                                    end
                                end
                            end
                        end
                    end
                    Functions.PlayerAdded.AddAllListPlayers = function(v)
                        for n,t in pairs(Variables.AddAllLists) do
                            for w,p in pairs(t) do
                                if p then
                                    if ((not includeWhitelist and n ~= "Whitelist" and not Functions.ListFind("Whitelist",v.Name)) or includeWhitelist) and not Functions.ListFind(n,v.Name,w) then
                                        Functions.ListInsert(n,v.Name,w)
                                    end
                                end
                            end
                        end
                    end
                    Functions.PlayerRemoved.AddAllListPlayers = function(v)
                        for n,t in pairs(Variables.AddAllLists) do
                            for w,p in pairs(t) do
                                if p then
                                    if Functions.ListFind(n,v.Name,w) then
                                        Functions.ListRemove(n,v.Name,w)
                                    end
                                end
                            end
                        end
                    end
                else
                    pcall(function()
                        Functions.PlayerAdded.AddAllListPlayers = nil
                        Functions.PlayerRemoved.AddAllListPlayers = nil
                    end)
                end
            end;
        })

        ListsAdd:AddButton({
            Title = "Remove All Players From Selected Lists";
            Callback = function()
                for i,v in pairs(Players:GetPlayers()) do
                    for n,t in pairs(Variables.AddAllLists) do
                        for w,p in pairs(t) do
                            if p then
                                if Functions.ListFind(n,v.Name,w) then
                                    Functions.ListRemove(n,v.Name,w)
                                end
                            end
                        end
                    end
                end
            end
        })

    end

    local function PlayersTab()

        AddVariables({["SelectedPlayers"] = {}})

    end

    local function CombatTab()

        Functions.IsWL = function(playerName)
            local whitelistedPlayers = Functions.GetListPlayersInServer("Whitelist")
            return whitelistedPlayers[playerName] ~= nil
        end

        local CombatButtons = Tabs.Combat:AddSection("Buttons")

        CombatButtons:AddButton({
            Title = "Main Respawn";
            Description = "Respawns you manually to the main spawn area.";
            Callback = function()
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):WaitForChild("SpawnCharacterEvent"):FireServer("MainSpawn")
            end
        })

        CombatButtons:AddButton({
            Title = "Random Respawn";
            Description = "Respawns you manually to a random spawn area.";
            Callback = function()
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):WaitForChild("SpawnCharacterEvent"):FireServer("RandomSpawn")
            end
        })

        CombatButtons:AddButton({
            Title = "Get Bubble";
            Description = "Gets a bubble from the safe zone and teleports you back. You must have full health.";
            Callback = function()
                if Character and Character:FindFirstChild("Humanoid") and not Character:FindFirstChild("ForceField") and Character.Humanoid.Health == Character.Humanoid.MaxHealth then
                    Character.Humanoid:UnequipTools()
                    Functions.GetBubble()
                end
            end
        })

        local CombatToggles = Tabs.Combat:AddSection("Toggles")

        AddVariables({["Aimbot"] = false, ["AimPart"] = "Head", ["FireOnGodMode"] = false})
        CombatToggles:AddToggle("Aimbot",{
            Title = "Aimbot";
            Description = "Locks your camera onto the nearest player to you. Works best with shift lock or first person.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.Aimbot = true
                    local aiming = false
                    local CurrentCamera = workspace.CurrentCamera
        
                    Aimbotting = RunService.RenderStepped:Connect(function()
                        if aiming then
                            if Functions.GetTargetPlayer() ~= nil then
                                local plr = Functions.GetTargetPlayer()
                                CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position,plr:FindFirstChild(Variables.AimPart).Position)
                            end
                        end
                    end)
        
                    Functions.UserInputBegan.Aimbot = function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton2 and Variables.Aimbot == true then
                            aiming = true
                        end
                    end
        
                    Functions.UserInputEnded.UnAimbot = function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton2 and Variables.Aimbot == true then
                            aiming = false
                        end
                    end
                else
                    pcall(function()
                        Variables.Aimbot = false
                        Functions.UserInputBegan.Aimbotting = nil
                        Functions.UserInputEnded.UnAimbotting = nil
                        Aimbotting:Disconnect()
                    end)
                end
            end
        })

        AddVariables({["SilentAim"] = false, ["FilterList"] = {}, ["ShotgunFire"] = false, ["ShotgunFireSpread"] = 300, ["AirStrikeMode"] = false, ["AirStrikeDistance"] = 300, ["TeleportShuriken"] = false, ["RapidMode"] = false, ["RapidMultiplier"] = 10})
        CombatToggles:AddToggle("SilentAim",{
            Title = "Silent Aim";
            Description = "Moves your shuriken to a speficied player after you shoot it. There are different modes as well.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.SilentAim = true
    
                    for i,v in pairs(game.Workspace:GetDescendants()) do
                        if v:FindFirstAncestorOfClass("Model") and not Players:GetPlayerFromCharacter(v:FindFirstAncestorOfClass("Model")) then
                            if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Part") then
                                if v.CanCollide == false or v.CanTouch == false and not table.find(Variables.FilterList,v) then
                                    table.insert(Variables.FilterList,v)
                                end
                            end
                        end
                    end
    
                    Functions.WorkspaceDescendantAdded.SilentAim = function(child)
                        if child:FindFirstAncestorOfClass("Model") and not Players:GetPlayerFromCharacter(child:FindFirstAncestorOfClass("Model")) then
                            if child:IsA("BasePart") or child:IsA("MeshPart") or child:IsA("Part") then
                                if (child.CanCollide == false or child.CanTouch == false) and not table.find(Variables.FilterList,child) then
                                    table.insert(Variables.FilterList,child)
                                end
                            end
                        end
                        if child.Name == "ThrownKunai" then
                            if child:WaitForChild("creator").Value == Players.LocalPlayer and Variables.SilentAim then
                                task.spawn(function()
                                    local proximity = false
                                    local fixedspeed = nil
                                    local count = 0
                                    local raycastParams = RaycastParams.new()
                                    raycastParams.FilterDescendantsInstances = Variables.FilterList
                                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                                    raycastParams.IgnoreWater = false
                                    if Variables.ShotgunFire then
                                        local number = math.random(150,250)
                                        task.wait(number / 1000)
                                    end
                                    child.Touched:Connect(function(tpart)
                                        if tpart:FindFirstAncestorOfClass("Model") and Players:GetPlayerFromCharacter(tpart:FindFirstAncestorOfClass("Model")) then
                                            local char = tpart:FindFirstAncestorOfClass("Model")
                                            if char:FindFirstChild("Head") and char.Head:FindFirstChild("DamageBBGui") then
                                                child:Destroy()
                                            end
                                        end
                                    end)
                                    while child.Parent == workspace and Variables.SilentAim do
                                        local Player = Functions.GetTargetPlayer()
                                        if Variables.AirStrikeMode and not Variables.ShotgunFire and count == 0 and Character and Functions.GetRoot(Character) then
                                            task.wait()
                                            local c = 0
                                            local root = Functions.GetRoot(Character)
                                            repeat
                                                if root then
                                                    child.CFrame = CFrame.new(root.Position.X, root.Position.Y + 300, root.Position.Z)
                                                end
                                                c += 1
                                            until c == 5
                                        end
                                        if Player then
                                            local ray = workspace:Raycast(child.Position, child.CFrame.LookVector * 15, raycastParams)
                                            local victimAP = Player:FindFirstChild(Variables.AimPart)
                                            local localAP = nil
                                            if Character then
                                                localAP = Character:FindFirstChild(Variables.AimPart)
                                            end
                                            local bv = child:WaitForChild("BodyVelocity")
                                            if (ray or proximity or Variables.TeleportShuriken) and victimAP then
                                                if not proximity then
                                                    proximity = true
                                                end
                                                child.CFrame = victimAP.CFrame
                                                bv.Velocity = Vector3.new(0,0,0)
                                            elseif not proximity and victimAP then
                                                if (victimAP.Position - child.Position).Magnitude > 1000 then
                                                    if not fixedspeed then
                                                        fixedspeed = math.floor(((victimAP.Position - child.Position).Magnitude * 5) + 700)
                                                    end
                                                    bv.Velocity = CFrame.new(child.Position,victimAP.Position).LookVector * fixedspeed
                                                elseif Variables.RapidMode then
                                                    bv.Velocity = CFrame.new(child.Position,victimAP.Position).LookVector * (700 * Variables.RapidMultiplier)
                                                else
                                                    if localAP and not Variables.AirStrikeMode and (victimAP.Position - localAP.Position).Magnitude <= 80 then
                                                        bv.Velocity = CFrame.new(child.Position,victimAP.Position).LookVector * 300
                                                    else
                                                        bv.Velocity = CFrame.new(child.Position,victimAP.Position).LookVector * 700
                                                    end
                                                end
                                                child.CFrame = CFrame.new(child.Position,victimAP.Position)
                                            end
                                        end
                                        count += 1
                                        task.wait()
                                    end
                                end)
                            end
                        end
                    end
    
                    Functions.WorkspaceDescendantRemoved.SilentAim = function(child)
                        if table.find(Variables.FilterList,child) then
                            table.remove(Variables.FilterList,table.find(Variables.FilterList,child))
                        end
                    end
                else
                    pcall(function()
                        Variables.SilentAim = false
                        Functions.WorkspaceDescendantAdded.SilentAim = nil
                        Functions.WorkspaceDescendantRemoved.SilentAim = nil
                        table.clear(Variables.FilterList)
                    end)
                end
            end;
        })

        AddVariables({["Loopbring"] = false, ["LoopBringDistance"] = 7})
        CombatToggles:AddToggle("Loopbring",{
            Title = "Loop Bring";
            Description = "Constantly brings targetted players to your character so you can hit them with your sword.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.Loopbring = false
                    task.wait()
                    Variables.Loopbring = true
                    task.spawn(function()
                        while Variables.Loopbring do
                            for n,t in pairs(Lists['Targetlist']) do
                                for w,p in pairs(t) do
                                    if not Functions.ListFind("Whitelist",p) then
                                        local victim = Players:FindFirstChild(p)
                                        if victim and victim.Character and Functions.GetRoot(victim.Character) and Players.LocalPlayer.Character and Functions.GetRoot(Players.LocalPlayer.Character) and not victim.Character:FindFirstChildWhichIsA("ForceField") then
                                            if Character:FindFirstChild("Sword") and Character:FindFirstChild("Sword"):FindFirstChild("Handle") then
                                                Functions.GetRoot(victim.Character).CFrame = CFrame.new(Character:FindFirstChild("Sword"):FindFirstChild("Handle").Position, Functions.GetRoot(victim.Character).Position + Functions.GetRoot(Character).CFrame.LookVector * 5) + Functions.GetRoot(Character).CFrame.LookVector * 3
                                            else
                                                Functions.GetRoot(victim.Character).CFrame = Functions.GetRoot(Players.LocalPlayer.Character).CFrame + Vector3.new(Variables.LoopBringDistance,1,0)
                                            end
                                        end
                                    end
                                end
                            end
                            task.wait()
                        end
                    end)
                else
                    pcall(function()
                        Variables.Loopbring = false
                    end)
                end
            end;
        })

        AddVariables({["PredictMode"] = false, ["PredictModeOffset"] = 0.05})
        CombatToggles:AddToggle("PredictBot",{
            Title = "Predict Bot";
            Description = "Predicts a player's movements and creates a part that the bot predicts will be the player's position in 3 seconds.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.PredictMode = true
                    local speedpart = workspace:FindFirstChild("SPEEDPART")
                    if not speedpart then
                        speedpart = Instance.new("Part",workspace)
                        speedpart.Name = "SPEEDPART"
                        speedpart.Size = Vector3.new(1,1,1)
                        speedpart.Material = Enum.Material.Neon
                        speedpart.Anchored = true
                        speedpart.CanCollide = false
                    end
                    coroutine.resume(coroutine.create(function()
                        while Variables.PredictMode do
                            local predictplr = Functions.GetTargetPlayer()
                            if predictplr and predictplr:FindFirstChild("Humanoid") and predictplr:FindFirstChild(Variables.AimPart) and Character and Functions.GetRoot(Character) then
                                local speed = 300
                                local dist = (predictplr:FindFirstChild(Variables.AimPart).Position - Functions.GetRoot(Character).Position).Magnitude
                                local time = dist / speed
                                local increase = predictplr:FindFirstChild(Variables.AimPart).Velocity.Magnitude * (time + 0.01 + Variables.PredictModeOffset)
                                speedpart.Position = Vector3.new(predictplr:FindFirstChild(Variables.AimPart).Position.X + (predictplr:FindFirstChild("Humanoid").MoveDirection.X * increase), predictplr:FindFirstChild(Variables.AimPart).Position.Y + (predictplr:FindFirstChild("Humanoid").MoveDirection.Y * increase), predictplr:FindFirstChild(Variables.AimPart).Position.Z + (predictplr:FindFirstChild("Humanoid").MoveDirection.Z * increase))
                            end
                            task.wait()
                        end
                    end))
                else
                    pcall(function()
                        Variables.PredictMode = false
                        workspace:FindFirstChild("SPEEDPART"):Destroy()
                    end)
                end
            end
        })

        AddVariables({["AutoBubble"] = false, ["AltAutoBubble"] = false})
        CombatToggles:AddToggle("AutoBubble",{
            Title = "Auto Bubble";
            Description = "Automatically puts you in a bubble whenever you lose it. Can be configured in settings.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoBubble = true
                    while Variables.AutoBubble do
                        if Character and Character:FindFirstChild("Humanoid") and not Character:FindFirstChild("ForceField") and Character.Humanoid.Health == Character.Humanoid.MaxHealth then
                            if not Variables.AltAutoBubble then
                                Character.Humanoid:UnequipTools()
                                Functions.GetBubble()
                            else
                                if not Character:FindFirstChild("Sword") and not Character:FindFirstChild("Shuriken") and not Character:FindFirstChild("ForceField") then
                                    Functions.GetBubble()
                                end
                            end
                        end
                        task.wait()
                    end
                else
                    Variables.AutoBubble = false
                end
            end;
        })

        AddVariables({["AutoTarget"] = false, ["AutoTargetMode"] = {['Soft'] = true; ['Semi'] = false; ['Normal'] = false; ['Permanent'] = false;}})
        CombatToggles:AddToggle("AutoTarget",{
            Title = "Auto Target";
            Description = "Automatically adds players to a set targetlist when they hit you. Can be configured in settings.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoTarget = true
                    Functions.CharacterTouched.AutoTargetting = function(child)
                        if Variables.AutoTarget then
                            for Mode, State in pairs(Variables.AutoTargetMode) do
                                if State then
                                    if child.Name == "ThrownKunai" then
                                        if not child:FindFirstChild("creator") then
                                            repeat task.wait() until child:FindFirstChild("creator")
                                        end
                                        if Variables.AutoTarget and State and child:FindFirstChild("creator").Value ~= Players.LocalPlayer and not Functions.ListFind("Targetlist",child.creator.Value.Name,Mode) and not Functions.ListFind("Whitelist",child.creator.Value.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(child.creator.Value)) then
                                            Functions.ListInsert("Targetlist", child.creator.Value.Name, Mode)
                                        end
                                    elseif child.Parent.Name == "Sword" then
                                        if Variables.AutoTarget and State and child.Parent.Parent.Name ~= Players.LocalPlayer.Name and not Functions.ListFind("Targetlist",child.Parent.Parent.Name,Mode) and not Functions.ListFind("Whitelist",child.Parent.Parent.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(Players:FindFirstChild(child.Parent.Parent.Name))) then
                                            Functions.ListInsert("Targetlist", child.Parent.Parent.Name, Mode)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    pcall(function()
                        Variables.AutoTarget = false
                        Functions.CharacterTouched.AutoTargetting = nil
                    end)
                end
            end;
        })

        AddVariables({["AutoWLTarget"] = false})
        CombatToggles:AddToggle("AutoWhitelistTarget",{
            Title = "Auto Whitelist Target";
            Description = "Automatically adds players to a set targetlist when they hit anyone on the whitelist. Can be configured in settings.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoWLTarget = true
                    Functions.WhitelistCharacterTouched.AutoWhitelistTargetting = function(child,wlplr)
                        if Variables.AutoWLTarget and Functions.ListFind("Whitelist",wlplr.Name) then
                            for Mode, State in pairs(Variables.AutoTargetMode) do
                                if State then
                                    if child.Name == "ThrownKunai" then
                                        if not child:FindFirstChild("creator") then
                                            repeat task.wait() until child:FindFirstChild("creator")
                                        end
                                        if Variables.AutoWLTarget and State and child:FindFirstChild("creator").Value ~= Players.LocalPlayer and not Functions.ListFind("Targetlist",child.creator.Value.Name,Mode) and not Functions.ListFind("Whitelist",child.creator.Value.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(child.creator.Value)) then
                                            Functions.ListInsert("Targetlist", child.creator.Value.Name, Mode)
                                        end
                                    elseif child.Parent.Name == "Sword" then
                                        if Variables.AutoWLTarget and State and child.Parent.Parent.Name ~= Players.LocalPlayer.Name and not Functions.ListFind("Targetlist",child.Parent.Parent.Name,Mode) and not Functions.ListFind("Whitelist",child.Parent.Parent.Name) and (Variables.FireOnGodMode or not Functions.IsGodded(Players:FindFirstChild(child.Parent.Parent.Name))) then
                                            Functions.ListInsert("Targetlist", child.Parent.Parent.Name, Mode)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    pcall(function()
                        Variables.AutoWLTarget = false
                        Functions.WhitelistCharacterTouched.AutoWhitelistTargetting = nil
                    end)
                end
            end
        })

        AddVariables({["AutoFire"] = false, ["AutoFireWait"] = 0.02, ["AutoFireFinishWait"] = 0.02, ["OptionalEquip"] = false, ["ServerShurikens"] = false, ["PlayerShurikenCheck"] = false})
        CombatToggles:AddToggle("AutoFire",{
            Title = "Auto Fire";
            Description = "Automatically fires when there are players in the targetlist at all.";
            Default = false;
            Callback = function(state)
                if state then

                    Variables.AutoFire = true
                    local pshurthrown = false
                    local AllThrowAnimations = {}
                    local WaitTable = {game:GetService("RunService").Stepped, game:GetService("RunService").Heartbeat, game:GetService("RunService").RenderStepped}
                    local WaitValue = 0
                    
                    local function Step()
                        if Variables.AutoFireWait >= 0 then
                            task.wait(Variables.AutoFireWait)
                        elseif Variables.AutoFireWait == -1 then
                            WaitValue = WaitValue + 1
                            WaitTable[WaitValue]:wait()
                            if WaitValue >= 3 then
                                WaitValue = 0
                            end
                        end
                    end

                    coroutine.resume(coroutine.create(function()
                        while Variables.AutoFire do
                            for n,t in pairs(Lists.Targetlist) do
                                for w,p in pairs(t) do
                                    if Players:FindFirstChild(p) then
                                        local v = Players:FindFirstChild(p)
                                        if not Functions.ListFind("Whitelist",v.Name) and v.Character and not v.Character:FindFirstChild("ForceField") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("Humanoid"):GetState() ~= Enum.HumanoidStateType.Dead and v.Character:FindFirstChild(Variables.AimPart) and (Variables.FireOnGodMode or not Functions.IsGodded(v)) then
                                            local targetplr = v
                                            local code = Functions.BoolsToBinary({Variables.AirStrikeMode, Variables.PredictMode, Variables.ServerShurikens, Variables.ShotgunFire})
                                            TableFuncs["AutoFire"][code]()
                                        end
                                    end
                                end
                            end
                            task.wait()
                        end
                    end))

                    Functions.WorkspaceDescendantAdded.AutoFirePredict = function(child)
                        if Variables.PredictMode then
                            if child.Name == "ThrownKunai" then
                                if child:WaitForChild("creator").Value == Players.LocalPlayer then
                                    pshurthrown = true
                                end
                            end
                        end
                    end

                else
                    pcall(function()
                        Variables.AutoFire = false
                        Functions.WorkspaceDescendantAdded.AutoFirePredict = nil
                    end)
                end
            end
        })

        AddVariables({["Savior"] = false, ["SaviorPercent"] = 0.5})
        CombatToggles:AddToggle("Savior",{
            Title = "Savior";
            Description = "Saves you and your rep by resetting you at a certain health so the other player doesn't get a kill.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.Savior = true
                    local function HPChanged(health)
                        if Variables.Savior and health <= (Character:FindFirstChild("Humanoid").MaxHealth * Variables.SaviorPercent) then
                            Character:FindFirstChild("Humanoid").Health = 0
                        end
                    end
    
                    hpchanging = Character:WaitForChild("Humanoid",math.huge).HealthChanged:Connect(HPChanged)
    
                    Functions.CharacterAdded.Savior = function()
                        hpchanging = Character:WaitForChild("Humanoid",math.huge).HealthChanged:Connect(HPChanged)
                    end
                else
                    pcall(function()
                        Variables.Savior = false
                        Functions.CharacterAdded.Savior = nil
                        hpchanging:Disconnect()
                    end)
                end
            end
    
        })

        AddVariables({["BreakShurs"] = false})
        CombatToggles:AddToggle("BreakShurikens",{
            Title = "Break Shurikens";
            Description = "Breaks everyones shurikens that are in the BreakShurlist.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.BreakShurs = false
                    task.wait(0.03)
                    Variables.BreakShurs = true
                    task.spawn(function()
                        while Variables.BreakShurs do
                            for n,t in pairs(Lists.BreakShurlist) do
                                for w,p in pairs(t) do
                                    if Players:FindFirstChild(p) then
                                        local v = Players:FindFirstChild(p)
                                        pcall(function()
                                            for i,v in pairs(v.Backpack:GetChildren()) do
                                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                                    v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                                                end
                                            end
                                            for i,v in pairs(v.Character:GetChildren()) do
                                                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                                    v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                else
                    Variables.BreakShurs = false
                end
            end
        })
    
        AddVariables({["DisableShurs"] = false})
        CombatToggles:AddToggle("DisableShurikens",{
            Title = "Disable Shurikens";
            Description = "Disables the shurikens of the entire server when a player in the DisableShurslist is in the game.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.DisableShurs = false
                    task.wait(0.03)
                    Variables.DisableShurs = true
                    task.spawn(function()
                        while Variables.DisableShurs do
                            if Functions.ListPlayerInServer("DisableShurslist") then
                                for i,v in pairs(Players:GetPlayers()) do
                                    pcall(function()
                                        for i,v in pairs(v.Backpack:GetChildren()) do
                                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                                            end
                                        end
                                        for i,v in pairs(v.Character:GetChildren()) do
                                            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                                                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                                            end
                                        end
                                    end)
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                else
                    Variables.DisableShurs = false
                end
            end;
        })

        AddVariables({["AutoBreakShurs"] = false, ["AutoBreakShurikensMode"] = {['Soft'] = true; ['Semi'] = false; ['Normal'] = false; ['Permanent'] = false;}})
        CombatToggles:AddToggle("AutoBreakShurikens",{
            Title = "Auto Break Shurikens";
            Description = "Automatically breaks the shurikens of players that hit you.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AutoBreakShurs = true
                    coroutine.resume(coroutine.create(function()
                        while Variables.AutoBreakShurs do
                            for i,v in pairs(Players:GetPlayers()) do
                                if v:FindFirstChild("leaderstats") and v.leaderstats:FindFirstChild("Ninjutsu") and not Functions.ListFind("Whitelist",v.Name) and not Functions.ListFind("BreakShurlist",v.Name,"Normal") then
                                    if v.leaderstats.Ninjutsu.Value < 0 then
                                        Functions.ListInsert("BreakShurlist",v.Name,"Normal")
                                    end
                                end
                            end
                            task.wait(0.1)
                        end
                    end))
        
                    Functions.CharacterTouched.AutoBreakShurikens = function(child)
                        if Variables.AutoBreakShurs then
                            for Mode, State in pairs(Variables.AutoBreakShurikensMode) do
                                if State then
                                    if child.Name == "ThrownKunai" then
                                        if not child:FindFirstChild("creator") then
                                            repeat task.wait() until child:FindFirstChild("creator")
                                        end
                                        if Variables.AutoBreakShurs and State and child:FindFirstChild("creator").Value ~= Players.LocalPlayer and not Functions.ListFind("BreakShurlist",child.creator.Value.Name,Mode) and not Functions.ListFind("Whitelist",child.creator.Value.Name) then
                                            Functions.ListInsert("BreakShurlist", child.creator.Value.Name, Mode)
                                        end
                                    elseif child.Parent.Name == "Sword" then
                                        if Variables.AutoBreakShurs and State and child.Parent.Parent.Name ~= Players.LocalPlayer.Name and not Functions.ListFind("BreakShurlist",child.Parent.Parent.Name,Mode) and not Functions.ListFind("Whitelist",child.Parent.Parent.Name) then
                                            Functions.ListInsert("BreakShurlist", child.Parent.Parent.Name, Mode)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    pcall(function()
                        Variables.AutoBreakShurs = false
                        Functions.CharacterTouched.AutoBreakShurikens = nil
                    end)
                end
            end;
        })

        local CombatSettings = Tabs.Combat:AddSection("Settings")

        CombatSettings:AddDropdown("AutoTargetMode",{
            Title = "Auto Target Mode";
            Description = "Mode that Auto Target uses.";
            Values = Constants.Modes;
            Multi = false;
            Default = "Soft";
        })

        Options.AutoTargetMode:OnChanged(function(Value)
            for i,_ in pairs(Variables.AutoTargetMode) do
                Variables.AutoTargetMode[i] = false
            end
            Variables.AutoTargetMode[Value] = true
        end)

        CombatSettings:AddToggle("AirStrikeMode",{
            Title = "Airstrike Mode";
            Description = "Enables airstrike mode. This forces shurikens to go up into the air and rain down on players when shot.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AirStrikeMode = true
                else
                    Variables.AirStrikeMode = false
                end
            end;
        })
    
        CombatSettings:AddToggle("TeleportShuriken",{
            Title = "Teleport Shuriken";
            Description = "Skips moving the shuriken to the player's hitpart and instead teleports it directly to them.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.TeleportShuriken = true
                else
                    Variables.TeleportShuriken = false
                end
            end;
        })

        CombatSettings:AddToggle("OptionalShurikenEquip",{
            Title = "Optional Shuriken Equip";
            Description = "Makes it so equipping a shuriken is optional with auto fire. Meaning it will fire at people even if you don't have a shuriken equipped.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.OptionalEquip = true
                else
                    Variables.OptionalEquip = false
                end
            end;
        })
    
        CombatSettings:AddToggle("UseServerShurikens",{
            Title = "Use Server Shurikens";
            Description = "Uses the whole server's shurikens when firing. They all do your damage still.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.ServerShurikens = true
                else
                    Variables.ServerShurikens = false
                end
            end
        })
    
        CombatSettings:AddToggle("PlayerShurikenCheck",{
            Title = "Player Shuriken Check";
            Description = "Checks for the shuriken of the player that you are shooting and doesn't use it because it would do your damage to you.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.PlayerShurikenCheck = true
                else
                    Variables.PlayerShurikenCheck = false
                end
            end
        })
    
        CombatSettings:AddToggle("ShotgunFire",{
            Title = "Shotgun Fire";
            Description = "Enables a shotgun-like spread for shurikens. Useful for when players are running away.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.ShotgunFire = true
                else
                    Variables.ShotgunFire = false
                end
            end
        })

        CombatSettings:AddToggle("FireOnGodMode",{
            Title = "Fire On Godded Players";
            Description = "Allows auto fire and silent aim to fire shurikens even when the player it's firing at is godded.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.FireOnGodMode = true
                else
                    Variables.FireOnGodMode = false
                end
            end
        })

        CombatSettings:AddToggle("AltAutoBubble",{
            Title = "Alternate Auto Bubble";
            Description = "Alternate mode of auto bubble that allows you to take weapons out.";
            Default = false;
            Callback = function(state)
                if state then
                    Variables.AltAutoBubble = true
                else
                    Variables.AltAutoBubble = false
                end
            end
        })

        CombatSettings:AddInput("AirStrikeDistance",{
            Title = "Air Strike Distance";
            Description = "Congifure air strike distance.";
            Default = Variables.AirStrikeDistance;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.AirStrikeDistance = tonumber(Value)
            end;
        })

        CombatSettings:AddInput("LoopbringDistance",{
            Title = "Loop Bring Distance";
            Description = "Configure loop bring distance.";
            Default = Variables.LoopBringDistance;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.LoopBringDistance = tonumber(Value)
            end;
        })

        CombatSettings:AddInput("SaviorPercent",{
            Title = "Savior Health Percent";
            Description = "Configure savior percent";
            Default = Variables.SaviorPercent;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.SaviorPercent = tonumber(Value)
            end
        })

        CombatSettings:AddInput("PredictModeOffset",{
            Title = "Predict Mode Offset";
            Description = "Configure predict mode offset";
            Default = Variables.PredictModeOffset;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.PredictModeOffset = tonumber(Value)
            end;
        })

        CombatSettings:AddInput("AutoFireWait",{
            Title = "Auto Fire Wait";
            Description = "Configure fire wait time";
            Default = Variables.AutoFireWait;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.AutoFireWait = tonumber(Value)
            end
        })
    
        CombatSettings:AddInput("AutoFireFinishWait",{
            Title = "Auto Fire Finish Wait";
            Description = "Configure wait time at finish";
            Default = Variables.AutoFireFinishWait;
            Placeholder = "Enter a number..";
            Numeric = true;
            Finished = true;
            Callback = function(Value)
                Variables.AutoFireFinishWait = tonumber(Value)
            end;
        })

    end

    TouchedFuncs()
    TrainingTab()
    ListsTab()
    PlayersTab()
    CombatTab()

end

Functions.StartMainConnections = function()

    task.spawn(function()
        repeat task.wait() until Players.LocalPlayer:FindFirstChild("leaderstats") and Players.LocalPlayer.leaderstats:FindFirstChild("Ninjutsu")
        Players.LocalPlayer.leaderstats.Ninjutsu:GetPropertyChangedSignal("Value"):Connect(function()
            for _,v in pairs(Functions.NinjutsuChanged) do
                v()
            end
        end)
    end)
    
    Players.LocalPlayer.CharacterAdded:Connect(function(char)
        Character = char
        for _,v in pairs(Functions.CharacterAdded) do
            v(char)
        end
        Variables.CharRespawning = false
    end)

    UserInputService.InputBegan:Connect(function(input,processed)
        if not processed then
            for _,v in pairs(Functions.UserInputBegan) do
                v(input)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input,processed)
        if not processed then
            for _,v in pairs(Functions.UserInputEnded) do
                v(input)
            end
        end
    end)
    
    Players.PlayerAdded:Connect(function(player)
        for _,v in pairs(Functions.PlayerAdded) do
            v(player)
        end
        --[[if Variables.SelectedPlayers[player.Name] then
            Functions.AddPlayerVanities(player)
        end]]
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        if player == Players.LocalPlayer then
            Functions.SaveSettings()
        end
        for n,t in pairs(Lists) do
            if Functions.ListFind(n,player.Name,"Soft") then
                Functions.ListRemove(n,player.Name,"Soft")
            end
            if Functions.ListFind(n,player.Name,"Semi") then
                Functions.ListRemove(n,player.Name,"Semi")
            end
        end
        Functions.RemovePlayerVanities(player)
        for _,v in pairs(Functions.PlayerRemoved) do
            v(player)
        end
    end)

    Workspace.DescendantAdded:Connect(function(child)
        for _,v in pairs(Functions.WorkspaceDescendantAdded) do
            v(child)
        end
    end)
    
    Workspace.DescendantRemoving:Connect(function(child)
        for _,v in pairs(Functions.WorkspaceDescendantRemoved) do
            v(child)
        end
    end)

end

Functions.StartFluentSystems = function()

    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    MainWindow:SelectTab(Main)

    Fluent:Notify({
        Title = "Welcome",
        Content = "Welcome to Project Ninja Assassin v"..VERSION..", "..Players.LocalPlayer.Name.."!",
        SubContent = "Have a wonderful day!",
        Duration = 10
    })

    SaveManager:LoadAutoloadConfig()

end

local success,err = pcall(function()
    Functions.AutoExecute()
    Functions.LoadSettings()
    Functions.CreateMainTabs()
    Functions.StartMainConnections()
    Functions.StartFluentSystems()
end)

if not success then
    warn("ERROR:",err)
    for i,v in pairs(Functions) do
        if typeof(v) == "function" then
            pcall(function()
                v:Disconnect()
            end)
        end
        Functions[i] = nil
    end
end

