--v2
  --version
--hack
-- telegram : zeferuswav subb
print([[
====================================
 ███████╗ ███████╗ ███████╗ ███████╗ ██████╗  ██╗   ██╗ ███████╗
 ╚══███╔╝ ██╔════╝ ██╔════╝ ██╔════╝ ██╔══██╗ ██║   ██║ ██╔════╝
   ███╔╝  █████╗   ██████╗   █████╗   ██████╔╝ ██║   ██║ ███████╗
  ███╔╝   ██╔══╝   ██╔══╝    ██╔══╝   ██╔══██╗ ██║   ██║ ╚════██║
 ███████╗ ███████╗ ██║       ███████╗ ██║  ██║ ╚██████╔╝ ███████║
 ╚══════╝ ╚══════╝ ╚═╝       ╚══════╝ ╚═╝  ╚═╝  ╚═════╝  ╚══════╝.
====================================
████████╗ ██╗   ██╗ ███╗   ██╗
███ ╔════ ██║   ██║ ████╗  ██║
█████╗    ██║   ██║ ██╔██╗ ██║
███ ╔══╝  ██║   ██║ ██║╚██╗██║
███       ╚██████╔╝██║ ╚████║
╚══════╝   ╚═════╝  ╚═╝  ╚═══╝  V2
====================================
]])
























local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

_G.values = _G.values or {}
local values = _G.values

values.rage = values.rage or {}
values.rage.angles = values.rage.angles or {}

values.rage.angles.enabled = { Toggle = false }
values.rage.angles["yaw base"] = { Dropdown = "none" } -- telegram > zeferuswav <
values.rage.angles["yaw offset"] = { Slider = 0 }
values.rage.angles["jitter offset"] = { Slider = 15 }
values.rage.angles.jitter = { Toggle = false }
values.rage.angles["pitch"] = { Dropdown = "none" } -- telegram > zeferuswav <
values.rage.angles["extend pitch"] = { Toggle = false }

-- telegram > zeferuswav <
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- telegram > zeferuswav <
local Spin = 0

-- telegram > zeferuswav <
local AntiAimConfig = {
    Enabled = false,
    YawBase = "spin", -- telegram > zeferuswav <
    YawOffset = 0,
    SpinSpeed = 5,
    JitterEnabled = false,
    JitterOffset = 20,
    ExtendPitch = false,
    Pitch = "up" -- telegram > zeferuswav <
}

-- telegram > zeferuswav <
local function getYawAngle(camLook)
    local baseAngle = -math.atan2(camLook.Z, camLook.X) + math.rad(-90)
    
    if AntiAimConfig.YawBase == "spin" then
        baseAngle = baseAngle + math.rad(Spin)
    elseif AntiAimConfig.YawBase == "random" then
        baseAngle = baseAngle + math.rad(math.random(0, 360))
    end

    local jitter = 0
    if AntiAimConfig.JitterEnabled then
        jitter = math.random(-AntiAimConfig.JitterOffset, AntiAimConfig.JitterOffset)
    end

    return baseAngle + math.rad(-AntiAimConfig.YawOffset + jitter)
end

local function getPitchValue(camLook)
    if AntiAimConfig.Pitch == "none" then
        return camLook.Y
    elseif AntiAimConfig.Pitch == "up" then
        return AntiAimConfig.ExtendPitch and 2.5 or 1
    elseif AntiAimConfig.Pitch == "down" then
        return AntiAimConfig.ExtendPitch and -2.5 or -1
    elseif AntiAimConfig.Pitch == "zero" then
        return 0
    elseif AntiAimConfig.Pitch == "random" then
        return math.random(-10, 10) / 10
    end
end

RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end

    local angles = values.rage.angles
    if not angles or not angles.enabled.Toggle then return end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

-- telegram > zeferuswav <
    humanoid.AutoRotate = false

-- telegram > zeferuswav <
    Spin = (Spin + 5) % 360

    local camLook = Camera.CFrame.LookVector
    local baseAngle = -math.atan2(camLook.Z, camLook.X) + math.rad(-90)

    if angles["yaw base"].Dropdown == "spin" then
        baseAngle = baseAngle + math.rad(Spin)
    elseif angles["yaw base"].Dropdown == "random" then
        baseAngle = baseAngle + math.rad(math.random(0, 360))
    end

    local jitter = 0
    if angles.jitter.Toggle then
        jitter = math.random(-angles["jitter offset"].Slider, angles["jitter offset"].Slider)
    end

    local yawOffset = math.rad(-angles["yaw offset"].Slider + jitter)
    local finalYaw = baseAngle + yawOffset

    root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, finalYaw, 0)

-- telegram > zeferuswav <
    local pitch = camLook.Y
    if angles["pitch"].Dropdown == "up" then
        pitch = angles["extend pitch"].Toggle and 2.5 or 1
    elseif angles["pitch"].Dropdown == "down" then
        pitch = angles["extend pitch"].Toggle and -2.5 or -1
    elseif angles["pitch"].Dropdown == "zero" then
        pitch = 0
    elseif angles["pitch"].Dropdown == "random" then
        pitch = math.random(-10, 10) / 10
    end

    local climb = character:FindFirstChild("Climbing") and true or false
    local event = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("ControlTurn")
    if event then
        event:FireServer(pitch, climb)
    end
end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")


local hitInfoEnabled = true
local activeMessages = {}
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")


local HitLogs = Instance.new("ScreenGui")
HitLogs.Name = "HitLogs"
HitLogs.Parent = playerGui
HitLogs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HitLogs.DisplayOrder = 9999

local LogContainer = Instance.new("Frame")
LogContainer.Name = "LogContainer"
LogContainer.Size = UDim2.new(0, 304, 1, -100)
LogContainer.Position = UDim2.new(0.003, 0, 0.09, 0)
LogContainer.BackgroundTransparency = 1
LogContainer.ClipsDescendants = true
LogContainer.Parent = HitLogs

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = LogContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)


local function createHitLog(damage)
	if not hitInfoEnabled then return end

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 304, 0, 40)
	MainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
	MainFrame.BackgroundTransparency = 1
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = LogContainer

	local SideBar = Instance.new("Frame")
	SideBar.Size = UDim2.new(0, 7, 0, 39)
	SideBar.Position = UDim2.new(0.98, 0, 0.01, 0)
	SideBar.BackgroundColor3 = Color3.fromRGB(106, 93, 255)
	SideBar.BorderSizePixel = 0
	SideBar.Parent = MainFrame

	local Text = Instance.new("TextLabel")
	Text.BackgroundTransparency = 1
	Text.Text = "Zeferus :   -" .. tostring(damage)
	Text.TextColor3 = Color3.new(1, 1, 1)
	Text.TextSize = 14
	Text.Font = Enum.Font.SourceSans
	Text.TextXAlignment = Enum.TextXAlignment.Left
	Text.TextTransparency = 1
	Text.Size = UDim2.new(1, -20, 1, 0)
	Text.Position = UDim2.new(0, 10, 0, 0)
	Text.Parent = MainFrame

	
	TweenService:Create(MainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Text, TweenInfo.new(0.25), {TextTransparency = 0}):Play()

	table.insert(activeMessages, MainFrame)

	
	task.delay(5, function()
		TweenService:Create(Text, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
		task.delay(0.5, function()
			if MainFrame then MainFrame:Destroy() end
		end)
	end)
end


local function setupDamageTracking()
	local lp = game.Players.LocalPlayer
	local additionals = lp:WaitForChild("Additionals")
	local totalDamage = additionals:WaitForChild("TotalDamage")
	local lastDamage = totalDamage.Value

	totalDamage:GetPropertyChangedSignal("Value"):Connect(function()
		local newDamage = totalDamage.Value
		local delta = newDamage - lastDamage
		lastDamage = newDamage

		if delta > 0 then
			createHitLog(delta)
		end
	end)
end

setupDamageTracking()


















local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local chat = ReplicatedStorage:WaitForChild("Events"):WaitForChild("PlayerChatted")

local killsey = {
    "Zeferus — rewriting the rules",
    "-1 homeless",
    "rakom",   
    "Z E F E R U S",
    "102"
}

-- telegram > zeferuswav <
local Toggles = {
    KillSay = false
}

local Airflow = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/4lpaca-pin/Airflow/refs/heads/main/src/source.luau"))()

-- telegram > zeferuswav <
local Window = Airflow:Init({
    Name = "ZEFERUS.FUN FIXED",
    Keybind = Enum.KeyCode.Home,
    Logo = "rbxassetid://140529035341680" 
})

-- telegram > zeferuswav <
local AimbotTab = Window:DrawTab({Name = "Legit", Icon = "skull"})
local RageTab = Window:DrawTab({Name = "Rage-Bot", Icon = "target"})
local HitboxTab = Window:DrawTab({Name = "Anti-Aim", Icon = "lucide-shield-off"})
local VisualsTab = Window:DrawTab({Name = "Visuals", Icon = "eye"})
local MiscTab = Window:DrawTab({Name = "Misc", Icon = "lucide-box"})
local Info = Window:DrawTab({Name = "Info", Icon = "info"})
local Settings = Window:DrawTab({Name = "Settings", Icon = "settings"})

-- telegram > zeferuswav <
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Mouse = LocalPlayer:GetMouse()

-- telegram > zeferuswav <
local hitmarkerEnabled = false
local hitmarkerColor = Color3.new(1, 1, 1)
local hitmarkerLines = {}

local function CreateHitmarker()
    if not hitmarkerEnabled then return end

    local camera = workspace.CurrentCamera
    local screenSize = camera.ViewportSize
    local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    local offset = 10

    for _, line in ipairs(hitmarkerLines) do
        if line then line:Remove() end
    end
    hitmarkerLines = {}

    local lines = {
        {from = center - Vector2.new(offset, offset), to = center - Vector2.new(offset / 2, offset / 2)},
        {from = center + Vector2.new(offset, offset), to = center + Vector2.new(offset / 2, offset / 2)},
        {from = center + Vector2.new(offset, -offset), to = center + Vector2.new(offset / 2, -offset / 2)},
        {from = center - Vector2.new(offset, -offset), to = center - Vector2.new(offset / 2, -offset / 2)},
    }

    for _, data in ipairs(lines) do
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Color = hitmarkerColor
        line.From = data.from
        line.To = data.to
        line.Visible = true
        table.insert(hitmarkerLines, line)
    end

    task.delay(0.45, function()
        for _, line in ipairs(hitmarkerLines) do
            if line then line:Remove() end
        end
        hitmarkerLines = {}
    end)
end

-- telegram > zeferuswav <
task.spawn(function()
    local success, err = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local dmg = player:WaitForChild("Additionals"):WaitForChild("TotalDamage")
        local last = dmg.Value

        dmg:GetPropertyChangedSignal("Value"):Connect(function()
            if dmg.Value > last and hitmarkerEnabled then
                CreateHitmarker()
            end
            last = dmg.Value
        end)
    end)
end)

-- telegram > zeferuswav <
local BunnyHopSettings = {
    Enabled = false,
    Speed = 50
}

-- telegram > zeferuswav <
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local lplr = Players.LocalPlayer

local function BunnyHop()
-- telegram > zeferuswav <
    if not BunnyHopSettings.Enabled then return end
    
-- telegram > zeferuswav <
    if not lplr or not lplr.Character then return end
    
-- telegram > zeferuswav <
    local jumpcd = lplr.Character:FindFirstChild("jumpcd")
    if jumpcd then
        jumpcd:Destroy()
    end

-- telegram > zeferuswav <
    local cam = workspace.CurrentCamera
    if not cam then return end
    local camCFrame = cam.CFrame

-- telegram > zeferuswav <
    local vel = Vector3.new(0, 0, 0)
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        vel = vel + camCFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        vel = vel - camCFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        vel = vel - camCFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        vel = vel + camCFrame.RightVector
    end

-- telegram > zeferuswav <
    if vel.Magnitude > 0 then
        vel = Vector3.new(vel.X, 0, vel.Z)
        local rootPart = lplr.Character:FindFirstChild("HumanoidRootPart")
        local humanoid = lplr.Character:FindFirstChildOfClass("Humanoid")
        
        if rootPart and humanoid then
-- telegram > zeferuswav <
            rootPart.Velocity = (vel.Unit * BunnyHopSettings.Speed) + Vector3.new(0, rootPart.Velocity.Y, 0)
            humanoid.Jump = true
        end
    end
end

-- telegram > zeferuswav <
RunService.Stepped:Connect(function()
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        BunnyHop()
    end
end)

-- telegram > zeferuswav <
local BulletTracerConfig = {
    Enabled = false,
    Color = Color3.new(255, 255, 0), 
    LifeTime = 1
}

-- telegram > zeferuswav <
local function createBulletTracer(fromPos, toPos)
    local beamPart0 = Instance.new("Part")
    beamPart0.Size = Vector3.new(0.2, 0.2, 0.2)
    beamPart0.Transparency = 1
    beamPart0.Anchored = true
    beamPart0.CanCollide = false
    beamPart0.CFrame = CFrame.new(fromPos)
    beamPart0.Parent = workspace

    local beamPart1 = Instance.new("Part")
    beamPart1.Size = Vector3.new(0.2, 0.2, 0.2)
    beamPart1.Transparency = 1
    beamPart1.Anchored = true
    beamPart1.CanCollide = false
    beamPart1.CFrame = CFrame.new(toPos)
    beamPart1.Parent = workspace

    local attachment0 = Instance.new("Attachment", beamPart0)
    local attachment1 = Instance.new("Attachment", beamPart1)

    local beam = Instance.new("Beam")
    beam.Attachment0 = attachment0
    beam.Attachment1 = attachment1
    beam.Color = ColorSequence.new(BulletTracerConfig.Color)
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.FaceCamera = true
    beam.LightEmission = 1
    beam.Transparency = NumberSequence.new(0)
    beam.Parent = beamPart0

-- telegram > zeferuswav <
    task.delay(BulletTracerConfig.LifeTime, function()
        beamPart0:Destroy()
        beamPart1:Destroy()
    end)
end

-- telegram > zeferuswav <
task.spawn(function()
    local success, err = pcall(function()
        local additionals = LocalPlayer:WaitForChild("Additionals")
        local dmg = additionals:WaitForChild("TotalDamage")
        local last = dmg.Value

        dmg:GetPropertyChangedSignal("Value"):Connect(function()
            if BulletTracerConfig.Enabled and dmg.Value > last then
                local muzzle = Camera.CFrame.Position
                local direction = Camera.CFrame.LookVector * 300

                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                rayParams.FilterType = Enum.RaycastFilterType.Blacklist

                local result = workspace:Raycast(muzzle, direction, rayParams)
                local hitPos = result and result.Position or (muzzle + direction)

                createBulletTracer(muzzle, hitPos)
            end
            last = dmg.Value
        end)
    end)

    if not success then
        warn("BulletTracer Error:", err)
    end
end)


local soundLibrary = {
    ["Bubble"] = "rbxassetid://119697580657161",
    ["TF2"] = "rbxassetid://90342360691837",
    ["Skeet"] = "rbxassetid://83717596220569",
    ["Fatality"] = "rbxassetid://106299430307590", 
    ["Zeferus"] = "rbxassetid://92614567965693",
    ["Hassle"] = "rbxassetid://78750675578922", 
    ["Metallic"] = "rbxassetid://81836873051806",
    ["PVZW"] = "rbxassetid://124615044501528", 
    ["Kawaii"] = "rbxassetid://109230751173263", 
    ["neverlose"] = "rbxassetid://8679627751",
    ["Minecraft Bow"] = "rbxassetid://177380034",
    ["Tactio"] = "rbxassetid://4868633804" 
}

local currentHitsound = Instance.new("Sound")
currentHitsound.Name = "Hitsound"
currentHitsound.Volume = 10
currentHitsound.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- telegram > zeferuswav <
local HitSoundConfig = {
    Enabled = true,
}

-- telegram > zeferuswav <
local function PlayHitSound()
    if HitSoundConfig.Enabled then
        currentHitsound:Play()
    end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    local success, err = pcall(function()
        local additionals = LocalPlayer:WaitForChild("Additionals")
        local dmg = additionals:WaitForChild("TotalDamage")
        local last = dmg.Value

        dmg:GetPropertyChangedSignal("Value"):Connect(function()
            if dmg.Value > last then
                PlayHitSound()
            end
            last = dmg.Value
        end)
    end)
    if not success then
        warn("Hitsound Error:", err)
    end
end)

local BhopConfig = {
    Enabled = false,
    AutoStrafe = false,
    Speed = 20
}

-- telegram > zeferuswav <
local NightMode = {
    Enabled = false,
    Color = Color3.fromRGB(20, 20, 40),
    Original = {
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        Brightness = Lighting.Brightness,
        FogColor = Lighting.FogColor,
        FogEnd = Lighting.FogEnd
    }
}

function NightMode:Apply()
    if self.Enabled then
        Lighting.Ambient = self.Color
        Lighting.OutdoorAmbient = self.Color
        Lighting.Brightness = 0.1
        Lighting.FogColor = self.Color
        Lighting.FogEnd = 1000
    else
        Lighting.Ambient = self.Original.Ambient
        Lighting.OutdoorAmbient = self.Original.OutdoorAmbient
        Lighting.Brightness = self.Original.Brightness
        Lighting.FogColor = self.Original.FogColor
        Lighting.FogEnd = self.Original.FogEnd
    end
end

-- telegram > zeferuswav <
local LocalPlayer = Players.LocalPlayer
local ThirdPerson = {
    Enabled = false,
    Distance = 10,
    Keybind = Enum.KeyCode.T
}

-- telegram > zeferuswav <
local function EnableThirdPerson()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraType = Enum.CameraType.Custom
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.CameraMaxZoomDistance = ThirdPerson.Distance
        LocalPlayer.CameraMinZoomDistance = ThirdPerson.Distance
    end
end

local function DisableThirdPerson()
    LocalPlayer.CameraMaxZoomDistance = 0.5
    LocalPlayer.CameraMinZoomDistance = 0.5
    Camera.CameraType = Enum.CameraType.Custom
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == ThirdPerson.Keybind then
        ThirdPerson.Enabled = not ThirdPerson.Enabled
        if ThirdPerson.Enabled then
            EnableThirdPerson()
        else
            DisableThirdPerson()
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if ThirdPerson.Enabled then
        EnableThirdPerson()
    end
end)

RunService.RenderStepped:Connect(function()
    if ThirdPerson.Enabled then
        EnableThirdPerson()
    end
end)

-- telegram > zeferuswav <
local HitboxExpander = {
    Enabled = false,
    TeamCheck = true,
    Size = Vector3.new(5, 5, 5),
    Transparency = 0.75,
    Parts = {
        "HeadHB"
    }
}

-- telegram > zeferuswav <
local function expandHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if HitboxExpander.TeamCheck and player.Team == LocalPlayer.Team then
                continue  
            end
            for _, partName in pairs(HitboxExpander.Parts) do
                local part = player.Character:FindFirstChild(partName)
                if part then
                    part.Size = HitboxExpander.Size
                    part.Transparency = HitboxExpander.Transparency
                    part.CanCollide = false
                end
            end
        end
    end
end

local Chams = {
    Enabled = false,
    TeamCheck = true,
    Color = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    _highlights = {} -- telegram > zeferuswav <
}

-- telegram > zeferuswav <
local function updatePlayerChams(player)
    if not player.Character then return end
    
-- telegram > zeferuswav <
    if Chams._highlights[player] then
        Chams._highlights[player]:Destroy()
        Chams._highlights[player] = nil
    end
    
-- telegram > zeferuswav <
    if Chams.Enabled and (not Chams.TeamCheck or player.Team ~= LocalPlayer.Team) then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ChamsHighlight"
        highlight.FillColor = Chams.Color
        highlight.OutlineColor = Chams.Color
        highlight.FillTransparency = Chams.Transparency
        highlight.OutlineTransparency = 0
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
        
        Chams._highlights[player] = highlight
    end
end

-- telegram > zeferuswav <
local function updateAllChams()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            updatePlayerChams(player)
        end
    end
end

-- telegram > zeferuswav <
local ESP = {
    Enabled = true,
    TeamCheck = true,
    VisibleCheck = false,
  Players = {},
    Settings = {
        Box = {
            Enabled = false, 
            Color = Color3.new(1,1,1), 
            Outline = false,
            OutlineColor = Color3.new(0,0,0),
            Thickness = 1,
            Filled = false
        },
        Name = {
            Enabled = false, 
            Color = Color3.new(1,1,1), 
            Size = 13, 
            Font = 2,
            Outline = true,
            OutlineColor = Color3.new(25,25,25),
            DisplayNames = false
        },
        HealthBar = {
            Enabled = false,
            ColorFrom = Color3.new(1,0,0),
            ColorTo = Color3.new(0,1,0),
            Outline = true,
            OutlineColor = Color3.new(0,0,0),
            Width = 3,
            Height = 1
        },
        HealthText = {
            Enabled = false,
            Color = Color3.new(1,1,1),
            Outline = true,
            OutlineColor = Color3.new(0,0,0)
        },
        Distance = {
            Enabled = false,
            Color = Color3.new(1,1,1),
            Outline = true,
            OutlineColor = Color3.new(0,0,0)
        },
        Tracers = {
            Enabled = false,
            Color = Color3.new(1,1,1),
            From = "Bottom", -- telegram > zeferuswav <
            Outline = true,
            OutlineColor = Color3.new(0,0,0)
        },
        BoxFill = {
            Enabled = false,
            Color = Color3.new(1,0,0),
            Transparency = 0.5
        },
        ViewAngle = {
            Enabled = false,
            Color = Color3.new(1,1,1),
            Thickness = 1,
            Length = 10,
            Outline = true,
            OutlineColor = Color3.new(0,0,0)
        }
    }
}

function ESP:Draw(player)
    local drawings = {
        Box = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        BoxFill = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        HealthBar = Drawing.new("Line"),
        HealthBarOutline = Drawing.new("Line"),
        HealthText = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        TracerOutline = Drawing.new("Line"),
        ViewAngle = Drawing.new("Line"),
        ViewAngleOutline = Drawing.new("Line")
    }
    
-- telegram > zeferuswav <
    drawings.BoxOutline.Thickness = self.Settings.Box.Thickness + 2
    drawings.BoxOutline.ZIndex = 1
    drawings.BoxOutline.Filled = self.Settings.Box.Filled
    drawings.BoxOutline.Color = self.Settings.Box.OutlineColor
    
    drawings.Box.Thickness = self.Settings.Box.Thickness
    drawings.Box.ZIndex = 2
    drawings.Box.Filled = self.Settings.Box.Filled
    drawings.Box.Color = self.Settings.Box.Color
    
    drawings.BoxFill.Thickness = 1
    drawings.BoxFill.ZIndex = 0
    drawings.BoxFill.Filled = true
    drawings.BoxFill.Color = self.Settings.BoxFill.Color
    drawings.BoxFill.Transparency = self.Settings.BoxFill.Transparency
    
    drawings.Name.ZIndex = 3
    drawings.Name.Center = true
    drawings.Name.Outline = self.Settings.Name.Outline
    drawings.Name.Size = self.Settings.Name.Size
    drawings.Name.Font = self.Settings.Name.Font
    drawings.Name.Color = self.Settings.Name.Color
    
    drawings.HealthBarOutline.Thickness = self.Settings.HealthBar.Width + 2
    drawings.HealthBarOutline.ZIndex = 1
    drawings.HealthBarOutline.Color = self.Settings.HealthBar.OutlineColor
    
    drawings.HealthBar.Thickness = self.Settings.HealthBar.Width
    drawings.HealthBar.ZIndex = 2
    
    self.Players[player] = drawings
    return drawings
end

function ESP:Update()
    for player, drawings in pairs(self.Players) do
        if not player:IsDescendantOf(game.Players) or not player.Character then
            for _, drawing in pairs(drawings) do
                drawing:Remove()
            end
            self.Players[player] = nil
            continue
        end

        local character = player.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")

        if not humanoid or not rootPart or not head or humanoid.Health <= 0 then
            for _, drawing in pairs(drawings) do
                drawing.Visible = false
            end
            continue
        end

        local position, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        
        if onScreen then
-- telegram > zeferuswav <
            local visible = true
            if self.VisibleCheck then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {character, LocalPlayer.Character}
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                
                local raycastResult = workspace:Raycast(
                    Camera.CFrame.Position,
                    (head.Position - Camera.CFrame.Position).Unit * 1000,
                    raycastParams
                )
                
                visible = raycastResult and raycastResult.Instance:IsDescendantOf(character)
            end

            local size = (Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0,3,0)).Y - 
                         Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0,2.6,0)).Y) / 2
            local boxSize = Vector2.new(math.floor(size * 1.5), math.floor(size * 1.9))
            local boxPos = Vector2.new(math.floor(position.X - size * 1.5 / 2), math.floor(position.Y - size * 1.6 / 2))
            local bottomOffset = boxSize.Y + boxPos.Y + 1

-- telegram > zeferuswav <
            local shouldShow = true
            if self.TeamCheck then
                shouldShow = player.Team ~= LocalPlayer.Team
            end

-- telegram > zeferuswav <
            drawings.BoxOutline.Visible = self.Settings.Box.Enabled and self.Settings.Box.Outline and visible and shouldShow
            drawings.Box.Visible = self.Settings.Box.Enabled and visible and shouldShow
            drawings.BoxFill.Visible = self.Settings.BoxFill.Enabled and visible and shouldShow
            
            if self.Settings.Box.Enabled and visible and shouldShow then
                drawings.BoxOutline.Size = boxSize
                drawings.BoxOutline.Position = boxPos
                drawings.Box.Size = boxSize
                drawings.Box.Position = boxPos
                drawings.Box.Color = self.Settings.Box.Color
                drawings.BoxOutline.Color = self.Settings.Box.OutlineColor
                
                drawings.BoxFill.Size = boxSize
                drawings.BoxFill.Position = boxPos
                drawings.BoxFill.Color = self.Settings.BoxFill.Color
                drawings.BoxFill.Transparency = self.Settings.BoxFill.Transparency
            end

-- telegram > zeferuswav <
            drawings.Name.Visible = self.Settings.Name.Enabled and visible and shouldShow
            if self.Settings.Name.Enabled and visible and shouldShow then
                drawings.Name.Position = Vector2.new(boxPos.X + boxSize.X / 2, boxPos.Y - 16)
                drawings.Name.Text = self.Settings.Name.DisplayNames and player.DisplayName or player.Name
                drawings.Name.Color = self.Settings.Name.Color
            end

-- telegram > zeferuswav <
           drawings.HealthBarOutline.Visible = self.Settings.HealthBar.Enabled and self.Settings.HealthBar.Outline and visible and shouldShow
            drawings.HealthBar.Visible = self.Settings.HealthBar.Enabled and visible and shouldShow
            
            if self.Settings.HealthBar.Enabled and visible and shouldShow then
                local healthPercentage = humanoid.Health / humanoid.MaxHealth
                local healthY = boxPos.Y + boxSize .Y - (healthPercentage * boxSize.Y)
                
-- telegram > zeferuswav <
                local healthColor = Color3.new(
                    self.Settings.HealthBar.ColorFrom.R + (self.Settings.HealthBar.ColorTo.R - self.Settings.HealthBar.ColorFrom.R) * healthPercentage,
                    self.Settings.HealthBar.ColorFrom.G + (self.Settings.HealthBar.ColorTo.G - self.Settings.HealthBar.ColorFrom.G) * healthPercentage,
                    self.Settings.HealthBar.ColorFrom.B + (self.Settings.HealthBar.ColorTo.B - self.Settings.HealthBar.ColorFrom.B) * healthPercentage
                )
                
                drawings.HealthBar.From = Vector2.new(boxPos.X - 5, boxPos.Y + boxSize.Y)
                drawings.HealthBar.To = Vector2.new(boxPos.X - 5, healthY)
                drawings.HealthBar.Color = healthColor
                
                drawings.HealthBarOutline.From = Vector2.new(boxPos.X - 5, boxPos.Y + boxSize.Y + 1)
                drawings.HealthBarOutline.To = Vector2.new(boxPos.X - 5, boxPos.Y - 1)
            end

-- telegram > zeferuswav <
            drawings.HealthText.Visible = self.Settings.HealthText.Enabled and visible and shouldShow
            if self.Settings.HealthText.Enabled and visible and shouldShow then
                drawings.HealthText.Text = tostring(math.floor((humanoid.Health / humanoid.MaxHealth) * 100 + 0.5)) .. "%"
                drawings.HealthText.Position = Vector2.new(boxPos.X - 20, (boxPos.Y + boxSize.Y - 1 * boxSize.Y) -1)
                drawings.HealthText.Color = self.Settings.HealthText.Color
                drawings.HealthText.Size = 13
                drawings.HealthText.Outline = true
            end

-- telegram > zeferuswav <
            drawings.Distance.Visible = self.Settings.Distance.Enabled and visible and shouldShow
            if self.Settings.Distance.Enabled and visible and shouldShow and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                drawings.Distance.Text = "[ " .. math.floor(distance) .. " studs ]"
                drawings.Distance.Position = Vector2.new(boxPos.X + boxSize.X / 2, bottomOffset)
                drawings.Distance.Color = self.Settings.Distance.Color
                drawings.Distance.Size = 13
                drawings.Distance.Outline = true
                bottomOffset = bottomOffset + 15
            end

-- telegram > zeferuswav <
            drawings.Tracer.Visible = self.Settings.Tracers.Enabled and visible and shouldShow
            drawings.TracerOutline.Visible = self.Settings.Tracers.Enabled and self.Settings.Tracers.Outline and visible and shouldShow
            if self.Settings.Tracers.Enabled and visible and shouldShow then
                local fromPosition
                if self.Settings.Tracers.From == "Bottom" then
                    fromPosition = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                elseif self.Settings.Tracers.From == "Middle" then
                    fromPosition = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                else -- telegram > zeferuswav <
                    fromPosition = Vector2.new(Camera.ViewportSize.X/2, 0)
                end
                
                drawings.Tracer.From = fromPosition
                drawings.Tracer.To = Vector2.new(position.X, position.Y)
                drawings.Tracer.Color = self.Settings.Tracers.Color
                drawings.Tracer.Thickness = 1
                
                drawings.TracerOutline.From = fromPosition
                drawings.TracerOutline.To = Vector2.new(position.X, position.Y)
                drawings.TracerOutline.Color = self.Settings.Tracers.OutlineColor
                drawings.TracerOutline.Thickness = 3
            end

-- telegram > zeferuswav <
            drawings.ViewAngle.Visible = self.Settings.ViewAngle.Enabled and visible and shouldShow
            drawings.ViewAngleOutline.Visible = self.Settings.ViewAngle.Enabled and self.Settings.ViewAngle.Outline and visible and shouldShow
            if self.Settings.ViewAngle.Enabled and visible and shouldShow then
                local headPos = Camera:WorldToViewportPoint(head.Position)
                local lookVector = head.CFrame.LookVector * self.Settings.ViewAngle.Length
                local endPos = Camera:WorldToViewportPoint(head.Position + lookVector)
                
                drawings.ViewAngle.From = Vector2.new(headPos.X, headPos.Y)
                drawings.ViewAngle.To = Vector2.new(endPos.X, endPos.Y)
                drawings.ViewAngle.Color = self.Settings.ViewAngle.Color
                drawings.ViewAngle.Thickness = self.Settings.ViewAngle.Thickness
                
                drawings.ViewAngleOutline.From = Vector2.new(headPos.X, headPos.Y)
                drawings.ViewAngleOutline.To = Vector2.new(endPos.X, endPos.Y)
                drawings.ViewAngleOutline.Color = self.Settings.ViewAngle.OutlineColor
                drawings.ViewAngleOutline.Thickness = drawings.ViewAngle.Thickness + 2
            end
        else
            for _, drawing in pairs(drawings) do
                drawing.Visible = false
            end
        end
    end
end

-- telegram > zeferuswav <
local Aimbot = {
    Enabled = false,
    TeamCheck = true,
    Keybind = Enum.KeyCode.Q,
    Smoothness = 5, -- telegram > zeferuswav <
    FOV = 100,
    FOVVisible = false,
    FOVColor = Color3.new(1,1,1),
    AimPart = "Head",
    Prediction = 0.1, -- telegram > zeferuswav <
    _active = false,
    _target = nil
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = Aimbot.FOVVisible
FOVCircle.Radius = Aimbot.FOV
FOVCircle.Color = Aimbot.FOVColor
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

function Aimbot:GetClosestTarget()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local mousePos = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    local centerPos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if self.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local aimPart = character:FindFirstChild(self.AimPart) or character:FindFirstChild("Head")
        if not aimPart then continue end
        
-- telegram > zeferuswav <
        if self.VisibleCheck then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {character, LocalPlayer.Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local raycastResult = workspace:Raycast(
                Camera.CFrame.Position,
                (aimPart.Position - Camera.CFrame.Position).Unit * 1000,
                raycastParams
            )
            
            if raycastResult and not raycastResult.Instance:IsDescendantOf(character) then
                continue
            end
        end
        
-- telegram > zeferuswav <
        local screenPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
        if not onScreen then continue end
        
-- telegram > zeferuswav <
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - centerPos).Magnitude
        if distance < shortestDistance and distance <= self.FOV then
            closestPlayer = player
            shortestDistance = distance
        end
    end
    
    return closestPlayer
end

function Aimbot:SmoothAim(targetPos, targetVelocity)
    local currentPos = Camera.CFrame.Position
    local predictedPos = targetPos + (targetVelocity or Vector3.new(0,0,0)) * self.Prediction
    local targetDirection = (predictedPos - currentPos).Unit
    local currentDirection = Camera.CFrame.LookVector
    
    local smoothFactor = math.clamp(1 / self.Smoothness, 0.03, 1)
    local smoothedDirection = currentDirection:Lerp(targetDirection, smoothFactor)
    
    Camera.CFrame = CFrame.new(currentPos, currentPos + smoothedDirection)
end

-- telegram > zeferuswav <
local ESPMain = VisualsTab:AddSection({Name = "ESP Main", Position = "left"})
local ESPComponents = VisualsTab:AddSection({Name = "Components", Position = "right"})
local ESPColors = VisualsTab:AddSection({Name = "Colors", Position = "left"})

ESPMain:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(state)
        ESP.Enabled = state
    end
})

ESPMain:AddToggle({
    Name = "Team Check",
    Default = true,
    Callback = function(state)
        ESP.TeamCheck = state
    end
})

ESPMain:AddToggle({
    Name = "Visible Check",
    Default = false,
    Callback = function(state)
        ESP.VisibleCheck = state
    end
})

-- telegram > zeferuswav <
ESPComponents:AddToggle({
    Name = "Box ESP",
    Default = false,
    Callback = function(state)
        ESP.Settings.Box.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Name ESP",
    Default = false,
    Callback = function(state)
        ESP.Settings.Name.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Health Bar",
    Default = false,
    Callback = function(state)
        ESP.Settings.HealthBar.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Health Text",
    Default = false,
    Callback = function(state)
        ESP.Settings.HealthText.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Distance",
    Default = false,
    Callback = function(state)
        ESP.Settings.Distance.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Tracers",
    Default = false,
    Callback = function(state)
        ESP.Settings.Tracers.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Box Fill",
    Default = false,
    Callback = function(state)
        ESP.Settings.BoxFill.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "View Angle",
    Default = false,
    Callback = function(state)
        ESP.Settings.ViewAngle.Enabled = state
    end
})

ESPComponents:AddToggle({
    Name = "Display Names",
    Default = false,
    Callback = function(state)
        ESP.Settings.Name.DisplayNames = state
    end
})

-- telegram > zeferuswav <
ESPColors:AddColorPicker({
    Name = "Box Color",
    Default = Color3.new(1,1,1),
    Callback = function(color)
        ESP.Settings.Box.Color = color
    end
})

ESPColors:AddColorPicker({
    Name = "Name Color",
    Default = Color3.new(1,1,1),
    Callback = function(color)
        ESP.Settings.Name.Color = color
    end
})

ESPColors:AddColorPicker({
    Name = "Health From",
    Default = Color3.new(1,0,0),
    Callback = function(color)
        ESP.Settings.HealthBar.ColorFrom = color
    end
})

ESPColors:AddColorPicker({
    Name = "Health To",
    Default = Color3.new(0,1,0),
    Callback = function(color)
        ESP.Settings.HealthBar.ColorTo = color
    end
})

ESPColors:AddColorPicker({
    Name = "Tracer Color",
    Default = Color3.new(1,1,1),
    Callback = function(color)
        ESP.Settings.Tracers.Color = color
    end
})

ESPColors:AddColorPicker({
    Name = "Box Fill Color",
    Default = Color3.new(1,0,0),
    Callback = function(color)
        ESP.Settings.BoxFill.Color = color
    end
})

ESPColors:AddColorPicker({
    Name = "View Angle Color",
    Default = Color3.new(1,1,1),
    Callback = function(color)
        ESP.Settings.ViewAngle.Color = color
    end
})

-- telegram > zeferuswav <
local NightModeSection = VisualsTab:AddSection({Name = "World", Position = "right"})
NightModeSection:AddToggle({
    Name = "World Color",
    Default = false,
    Callback = function(state)
        NightMode.Enabled = state
        NightMode:Apply()
    end
})

NightModeSection:AddColorPicker({
    Name = "Color",
    Default = Color3.fromRGB(20, 20, 40),
    Callback = function(color)
        NightMode.Color = color
        if NightMode.Enabled then
            NightMode:Apply()
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local radius = 25
local transparency = 0.4
local updateDelay = 0.2

local originalTransparency = {}
local xrayEnabled = false
local lastUpdate = 0

-- telegram > zeferuswav <
RunService.Stepped:Connect(function(_, step)
    if not xrayEnabled then return end
    if tick() - lastUpdate < updateDelay then return end
    lastUpdate = tick()

    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart.Position

    for _, part in workspace.Map:GetDescendants() do
        if part:IsA("BasePart") then
            local distance = (part.Position - hrp).Magnitude
            if distance <= radius then
                if not originalTransparency[part] then
                    originalTransparency[part] = part.LocalTransparencyModifier
                end
                part.LocalTransparencyModifier = transparency
            elseif originalTransparency[part] then
                part.LocalTransparencyModifier = originalTransparency[part]
                originalTransparency[part] = nil
            end
        end
    end
end)

-- telegram > zeferuswav <
NightModeSection:AddToggle({
    Name = "XRay Around Player",
    Default = false,
    Callback = function(state)
        xrayEnabled = state

-- telegram > zeferuswav <
        if not state then
            for part, old in pairs(originalTransparency) do
                if part and part:IsA("BasePart") then
                    part.LocalTransparencyModifier = old
                end
            end
            table.clear(originalTransparency)
        end
    end
})

NightModeSection:AddDropdown({
    Name = "HitSound",
    Values = {"Bubble", "TF2", "Skeet", "Fatality", "Zeferus", "Hassle" , "Metallic", "PVZW", "Kawaii", "neverlose", "Minecraft Bow", "Tactio"},
    Multi = false,
    Callback = function(selected)
        if soundLibrary[selected] then
            currentHitsound.SoundId = soundLibrary[selected]
        end
    end
})

NightModeSection:AddToggle({
    Name = "HitLogs",
    Default = false,
    Callback = function(state)
        hitInfoEnabled = state
    end
})

NightModeSection:AddToggle({
    Name = "Hitmarker",
    Default = false,
    Callback = function(state)
        hitmarkerEnabled = state
    end
})

NightModeSection:AddColorPicker({
    Name = "Hitmarker Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        hitmarkerColor = color
    end
})

NightModeSection:AddToggle({
    Name = "Enable Bullet Tracer",
    Default = false,
    Callback = function(state)
        BulletTracerConfig.Enabled = state
    end
})

NightModeSection:AddColorPicker({
    Name = "Bullet Tracer Color",
    Default = BulletTracerConfig.Color,
    Callback = function(color)
        BulletTracerConfig.Color = color
    end
})

NightModeSection:AddSlider({
    Name = "Bullet Tracer Lifetime",
    Min = 1,
    Max = 10,
    Default = BulletTracerConfig.LifeTime,
    Increment = 0.1,
    Callback = function(value)
        BulletTracerConfig.LifeTime = value
    end
})

local NightModeSection223 = VisualsTab:AddSection({Name = "Removes", Position = "right"})
NightModeSection223:AddToggle({
    Name = "Remove Scope",
    Callback = function(state)
        local gui = playerGui:FindFirstChild("GUI")
        if gui then
            local crosshairs = gui:FindFirstChild("Crosshairs")
            if crosshairs then
-- telegram > zeferuswav <
                local scope = crosshairs:FindFirstChild("Scope")
                if scope then
                    scope.ImageTransparency = state and 1 or 0
                end
                
-- telegram > zeferuswav <
                for i = 1, 4 do
                    local frame = crosshairs:FindFirstChild("Frame"..i)
                    if frame then
                        frame.Transparency = state and 1 or 0
                    end
                end
            end
        end
    end
})

NightModeSection223:AddToggle({
    Name = "Remove Flash", 
    Callback = function(state)
        local blindGui = playerGui:FindFirstChild("Blnd")
        if blindGui then
            local blind = blindGui:FindFirstChild("Blind")
            if blind then
                blind.Visible = not state
            end
        end
    end
})

NightModeSection223:AddToggle({
    Name = "Remove Smoke",
    Callback = function(state)
        if not state then return end
        
        local rayIgnore = Workspace:FindFirstChild("Ray_Ignore")
        if rayIgnore then
            local smokes = rayIgnore:FindFirstChild("Smokes")
            if smokes then
                for _, smoke in pairs(smokes:GetChildren()) do
                    smoke:Destroy()
                end
            end
        end
    end
})


-- == Инициализация флагов для ViewModel ==
local Flags = {
    ViewModel = true,
    ViewModel_X = 180,
    ViewModel_Y = 180,
    ViewModel_Z = 180,
    ViewModel_X1 = 180,
    ViewModel_Y2 = 180,
    ViewModel_Z3 = 180,

    ThirdPerson_RemoveArms = false,
    ThirdPerson_Enabled = false,
    RageBot_AtTargets = false,
}

-- Предварительные определения (замени на свои функции/переменные)
local LocalPlayer = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera

-- Ссылки на функции и константы для удобства (замени, если нужно)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "SetPrimaryPartCFrame" then
        local arms = args[1]
        if self.Name == "Arms" and LocalPlayer.Character then
            if Flags["ViewModel"] then 
                -- Преобразование вращения и смещения
                arms = arms
                    * CFrame.Angles(math.rad(Flags["ViewModel_X"] - 180), math.rad(Flags["ViewModel_Y"] - 180), math.rad(Flags["ViewModel_Z"] - 180))
                    * CFrame.new(math.rad(Flags["ViewModel_X1"] - 180), math.rad(Flags["ViewModel_Y2"] - 180), math.rad(Flags["ViewModel_Z3"] - 180))
            end

            if Flags["ThirdPerson_RemoveArms"] and Flags["ThirdPerson_Enabled"] then
                arms = arms * CFrame.new(11212121210000, 1001212121200, 1012121212000) -- очень далеко, чтобы спрятать руки
            end

            if Flags["RageBot_AtTargets"] and RageBot and RageBot.Target and RageBot.Target.TargetPosition then
                arms = CFrame.lookAt(arms.Position, RageBot.Target.TargetPosition)
            end
        end

        return oldNamecall(self, arms, select(2, ...))
    elseif method == "LoadAnimation" then
        if Flags["Movement_SlideWalk"] and (args[1].Name == "RunAnim" or args[1].Name == "JumpAnim") then
            args[1] = fakeanim -- Определи fakeanim где-то в своем коде
            return oldNamecall(self, unpack(args))
        end
    end

    return oldNamecall(self, ...)
end)


local UISection = MiscBot or NightModeSection or {}


NightModeSection:AddToggle({
    Name = "Enable ViewModel Edit",
    Default = Flags.ViewModel,
    Callback = function(state)
        Flags.ViewModel = state
    end
})



NightModeSection:AddSlider({
    Name = "Offset X",
    Min = 0,
    Max = 360,
    Default = Flags.ViewModel_X1,
    Callback = function(value)
        Flags.ViewModel_X1 = value
    end
})

NightModeSection:AddSlider({
    Name = "Offset Y",
    Min = 0,
    Max = 360,
    Default = Flags.ViewModel_Y2,
    Callback = function(value)
        Flags.ViewModel_Y2 = value
    end
})

NightModeSection:AddSlider({
    Name = "Offset Z",
    Min = 0,
    Max = 360,
    Default = Flags.ViewModel_Z3,
    Callback = function(value)
        Flags.ViewModel_Z3 = value
    end
})



-- Пример вызова:
-- showHit(35, "Head")
-- Можно вызывать из других скриптов по событию



local ChamsSection = VisualsTab:AddSection({Name = "Chams Settings", Position = "left"})

ChamsSection:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(state)
        Chams.Enabled = state
        updateAllChams()
    end
})

ChamsSection:AddToggle({
    Name = "Team Check",
    Default = true,
    Callback = function(state)
        Chams.TeamCheck = state
        updateAllChams()
    end
})

ChamsSection:AddColorPicker({
    Name = "Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        Chams.Color = color
        for _, highlight in pairs(Chams._highlights) do
            if highlight then
                highlight.FillColor = color
                highlight.OutlineColor = color
            end
        end
    end
})

ChamsSection:AddSlider({
    Name = "Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Increment = 0.05,
    Callback = function(value)
        Chams.Transparency = value
        for _, highlight in pairs(Chams._highlights) do
            if highlight then
                highlight.FillTransparency = value
            end
        end
    end
})

-- telegram > zeferuswav <
local function initChams()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then
                updatePlayerChams(player)
            end
            
            player.CharacterAdded:Connect(function(character)
                if Chams.Enabled then
                    task.wait(0.3)
                    updatePlayerChams(player)
                end
            end)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if Chams.Enabled then
                task.wait(0.3)
                updatePlayerChams(player)
            end
        end)
    end)
end

initChams()

local Lighting = game:GetService("Lighting")

local SKY_PRESETS = {
    ["Minecraft"] = {
        SkyboxBk = "rbxassetid://8735166756",
        SkyboxDn = "rbxassetid://8735166707",
        SkyboxFt = "http://www.roblox.com/asset/?id=8735231668",
        SkyboxLf = "http://www.roblox.com/asset/?id=8735166755",
        SkyboxRt = "http://www.roblox.com/asset/?id=8735166751",
        SkyboxUp = "http://www.roblox.com/asset/?id=8735166729"
    },
    ["GreenVile"] = {
        SkyboxBk = "rbxassetid://570557514",
        SkyboxDn = "rbxassetid://570557775",
        SkyboxFt = "rbxassetid://570557559",
        SkyboxLf = "rbxassetid://570557620",
        SkyboxRt = "rbxassetid://570557672",
        SkyboxUp = "rbxassetid://570557727"
    },
    ["BrownSunset"] = {
        SkyboxBk = "rbxassetid://15502324143",
        SkyboxDn = "rbxassetid://15502324962",
        SkyboxFt = "rbxassetid://15502325676",
        SkyboxLf = "rbxassetid://15502326432",
        SkyboxRt = "rbxassetid://15502327161",
        SkyboxUp = "rbxassetid://15502328272"
    },
    ["PinkVoulie"] = {
        SkyboxBk = "rbxassetid://12635309703",
        SkyboxDn = "rbxassetid://12635311686",
        SkyboxFt = "rbxassetid://12635312870",
        SkyboxLf = "rbxassetid://12635313718",
        SkyboxRt = "rbxassetid://12635315817",
        SkyboxUp = "rbxassetid://12635316856"
    },
    ["SpaceFraut"] = {
        SkyboxBk = "rbxassetid://10042540787",
        SkyboxDn = "rbxassetid://10042545084",
        SkyboxFt = "rbxassetid://10042548945",
        SkyboxLf = "rbxassetid://10042554320",
        SkyboxRt = "rbxassetid://10042560621",
        SkyboxUp = "rbxassetid://10042563671"
    }
}

-- telegram > zeferuswav <
local function ApplySky(presetName)
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("Sky") then
            child:Destroy()
        end
    end

    local preset = SKY_PRESETS[presetName]
    if preset then
        local newSky = Instance.new("Sky")
        for property, value in pairs(preset) do
            newSky[property] = value
        end
        newSky.Parent = Lighting
    end
end

local ThirdPersonSection1 = MiscTab:AddSection({Name = "Visuality", Position = "right"})

ThirdPersonSection1:AddDropdown({
    Name = "Custom Sky",
    Values = {"Minecraft", "GreenVile", "BrownSunset", "PinkVoulie", "SpaceFraut"},
    Multi = false,
    Callback = function(selected)
        ApplySky(selected)
    end
})

ESPColors:AddButton({
    Name = "View Angle",
    Default = false,
    Callback = function(state)
    end
})

-- telegram > zeferuswav <
local AimbotMain = AimbotTab:AddSection({Name = "Aim-bot", Position = "left"})
local AimbotVisuals = AimbotTab:AddSection({Name = "Settings", Position = "right"})
local MiscBot = AimbotTab:AddSection({Name = "Hitbox", Position = "right"})
local Exploits111 = RageTab:AddSection({Name = "Exploits", Position = "right"})
local ExploitsFuckServer = RageTab:AddSection({Name = "Server", Position = "right"})

AimbotMain:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(state)
        Aimbot.Enabled = state
    end
})

AimbotMain:AddKeybind({
    Name = "Aimbot Key",
    Default = "Q",
    Callback = function(key)
        Aimbot.Keybind = Enum.KeyCode[key:upper()]
    end
})

AimbotMain:AddSlider({
    Name = "Smoothness",
    Min = 1,
    Max = 50,
    Default = 5,
    Callback = function(value)
        Aimbot.Smoothness = value
    end
})

AimbotMain:AddDropdown({
    Name = "Aim-Part",
    Values = {"Head", "HumanoidRootPart", "UpperTorso"},
    Default = "Head",
    Callback = function(part)
        Aimbot.AimPart = part
    end
})

AimbotMain:AddToggle({
    Name = "Team Check",
    Default = true,
    Callback = function(state)
        Aimbot.TeamCheck = state
    end
})


-- necode102 -- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102
-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102
-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102-- necode102


local SilentAim = {
    Enabled = false,
    TeamCheck = false,
    WallCheck = true,
    FOVEnabled = false,
    FOVRadius = 70,
    FOVColor = Color3.fromRGB(0, 255, 0),
    TargetPartSetting = "Head",
    TargetPart = nil
}

-- necode102
local SilentMain = RageTab:AddSection({Name = "Silent Aim", Position = "left"})

-- necode102
SilentMain:AddToggle({
    Name = "Enable",
    Default = false,
    Callback = function(state)
        SilentAim.Enabled = state
    end
})

-- necode102
SilentMain:AddDropdown({
    Name = "Target Part",
    Values = {"Head", "Body", "Random"},
    Multi = false,
    Default = "Head",
    Callback = function(value)
        SilentAim.TargetPartSetting = value
    end
})


-- necode102
SilentMain:AddToggle({
    Name = "Team Check",
    Default = false,
    Callback = function(state)
        SilentAim.TeamCheck = state
    end
})

-- necode102
SilentMain:AddToggle({
    Name = "Wall Check",
    Default = true,
    Callback = function(state)
        SilentAim.WallCheck = state
    end
})

-- necode102
SilentMain:AddToggle({
    Name = "Enable FOV",
    Default = false,
    Callback = function(state)
        SilentAim.FOVEnabled = state
        if fovCircle then
            fovCircle.Visible = state
        end
    end
})

-- necode102
SilentMain:AddSlider({
    Name = "FOV Radius",
    Min = 70,
    Max = 1300,
    Default = SilentAim.FOVRadius,
    Callback = function(value)
        SilentAim.FOVRadius = value
        if fovCircle then
            fovCircle.Radius = value
        end
    end
})


SilentMain:AddColorPicker({
    Name = "FOV Color",
    Default = SilentAim.FOVColor,
    Callback = function(color)
        SilentAim.FOVColor = color
        if fovCircle then
            fovCircle.Color = color
        end
    end
})



local fovCircle = nil
if Drawing and Drawing.new then
    fovCircle = Drawing.new("Circle")
    fovCircle.Visible = SilentAim.FOVEnabled
    fovCircle.Color = SilentAim.FOVColor
    fovCircle.Radius = SilentAim.FOVRadius
    fovCircle.Thickness = 2
    fovCircle.Transparency = 0.5
    fovCircle.Filled = false
end


game:GetService("RunService").RenderStepped:Connect(function()
    if fovCircle then
        local cam = workspace.CurrentCamera
        local view = cam.ViewportSize
        fovCircle.Position = Vector2.new(view.X / 2, view.Y / 2)
        fovCircle.Radius = SilentAim.FOVRadius
        fovCircle.Color = SilentAim.FOVColor
        fovCircle.Visible = SilentAim.FOVEnabled
    end
end)


local function getTargetPart(character)
    if not character then return nil end
    if SilentAim.TargetPartSetting == "Head" then
        return character:FindFirstChild("Head")
    elseif SilentAim.TargetPartSetting == "Body" then
        return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
    elseif SilentAim.TargetPartSetting == "Random" then
        local parts = {"Head", "HumanoidRootPart", "UpperTorso", "Torso"}
        for i = #parts, 2, -1 do
            local j = math.random(i)
            parts[i], parts[j] = parts[j], parts[i]
        end
        for _, name in ipairs(parts) do
            local part = character:FindFirstChild(name)
            if part then return part end
        end
    end
    return nil
end
-- telegram : zeferuswav

local function isVisible(part)
    if not SilentAim.WallCheck then return true end
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (part.Position - origin).Unit * 500
    local ray = Ray.new(origin, direction)
    local ignore = {game.Players.LocalPlayer.Character}
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
    return not hit or hit:IsDescendantOf(part.Parent)
end


game:GetService("RunService").Heartbeat:Connect(function()
    local cam = workspace.CurrentCamera
    local lp = game.Players.LocalPlayer
    local closest = nil
    local shortest = math.huge

    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= lp and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            if SilentAim.TeamCheck and plr.Team == lp.Team then continue end
            local part = getTargetPart(plr.Character)
            if not part or not isVisible(part) then continue end

            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
            if not onScreen then continue end

            local dist = (Vector2.new(screenPos.X, screenPos.Y) - cam.ViewportSize / 2).Magnitude
            if SilentAim.FOVEnabled and dist > SilentAim.FOVRadius then continue end

            if dist < shortest then
                shortest = dist
                closest = part
            end
        end
    end

    SilentAim.TargetPart = closest
end)


game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum.Died:Connect(function()
            SilentAim.TargetPart = nil
        end)
    end
end)


local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

local function safeSetReadonly(tbl, val)
    if setreadonly then
        pcall(function() setreadonly(tbl, val) end)
    end
end

safeSetReadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if SilentAim.Enabled and self == workspace and method == "FindPartOnRayWithIgnoreList" then
        local ray = args[1]
        if SilentAim.TargetPart and SilentAim.TargetPart.Parent then
            local origin = ray.Origin
            local direction = (SilentAim.TargetPart.Position - origin).Unit * 1000
            args[1] = Ray.new(origin, direction)
        end
        return oldNamecall(self, unpack(args))
    end

    return oldNamecall(self, ...)
end)

safeSetReadonly(mt, true)


















local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapons = ReplicatedStorage:WaitForChild("Weapons")

local function setRecoilState(enabled)
    for _, weapon in pairs(Weapons:GetChildren()) do
        if weapon:FindFirstChild("Spread") then
            local spread = weapon.Spread

            local recoilValues = {
                "Recoil",
                "InitialJump",
                "Jump",
                "Move",
                "Land",
                "Fire",
                "Kick",
                "CameraShake"
            }

            for _, name in ipairs(recoilValues) do
                local val = spread:FindFirstChild(name)
                if val and val:IsA("NumberValue") then
                    val.Value = enabled and val:GetAttribute("Original") or 0
                end
            end
        end
    end
end

for _, weapon in pairs(Weapons:GetChildren()) do
    if weapon:FindFirstChild("Spread") then
        for _, child in ipairs(weapon.Spread:GetChildren()) do
            if child:IsA("NumberValue") and child:GetAttribute("Original") == nil then
                child:SetAttribute("Original", child.Value)
            end
        end
    end
end

Exploits111:AddToggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(state)
        setRecoilState(not state)
    end
})

Exploits111:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(state)
        if state then
            ammoLoop = true
            task.spawn(function()
                while ammoLoop do
                    for _, weapon in pairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
                        if weapon:FindFirstChild("Ammo") then
                            weapon.Ammo.Value = 9999
                        end
                        if weapon:FindFirstChild("AmmoUsePerShot") then
                            weapon.AmmoUsePerShot.Value = 0
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            ammoLoop = false
        end
    end
})

Exploits111:AddToggle({
    Name = "Auto Wall",
    Default = false,
    Callback = function(enabled)
        local Weapons = game:GetService("ReplicatedStorage"):FindFirstChild("Weapons")
        if not Weapons then
            warn("Weapons folder not found")
            return
        end

        for _, weapon in ipairs(Weapons:GetChildren()) do
            local pen = weapon:FindFirstChild("Penetration")
            if pen and (pen:IsA("NumberValue") or pen:IsA("IntValue")) then
                pen.Value = enabled and 999999 or 1
            end
        end

        print("Penetration set to", enabled and 999999 or 1)
    end
})



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Weapons = ReplicatedStorage:WaitForChild("Weapons")

local autoLoop = false

local function setAutoState(state)
    for _, weapon in ipairs(Weapons:GetChildren()) do
        if weapon:IsA("Folder") then
            local auto = weapon:FindFirstChild("Auto")
            if auto and auto:IsA("BoolValue") then
                auto.Value = state
            end
        end
    end
end

local function startAutoLoop()
    task.spawn(function()
        while autoLoop do
            setAutoState(true)
            task.wait(0.3)
        end
    end)
end

Exploits111:AddToggle({
    Name = "Full Auto",
    Default = false,
    Callback = function(state)
        autoLoop = state
        if state then
            startAutoLoop()
        else
            setAutoState(false)
        end
    end
})



--- bypass 

local _RUN = game:GetService("RunService")
local _RSP = game:GetService("ReplicatedStorage")
local _PLR = game:GetService("Players")
local _LP = _PLR.LocalPlayer
local _RAND = Random.new(tick())


local fakeTable = { "748794", "645645", "nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil" }
for i = 1, #fakeTable do
    if fakeTable[i] == "z" then print("huh") end
end
local _confuse = function(x) return x end
local __garbage = function() return math.huge * 0 end -- NaN
local __identity = function(v) return v end

--💀 Основной механизм атаки
local attackMode = false
local heartbeatHook = nil

local function engageKillaura(state)
    attackMode = state
    if heartbeatHook then heartbeatHook:Disconnect() heartbeatHook = nil end

    if state then
        heartbeatHook = _RUN.Heartbeat:Connect(function()
            for _, plr in ipairs(_PLR:GetPlayers()) do
                if plr ~= _LP and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
                    if plr.Character.Humanoid.Health > 0 then
                        _RSP:FindFirstChild("Events"):FindFirstChild("HitPart"):FireServer(
                            plr.Character:FindFirstChild("HeadHB") or plr.Character:FindFirstChild("Head"),
                            {X=0/0, Y=0/0, Z=0/0}, -- 👻 Invalid position
                            "AK47", -- Можно сделать рандомное оружие если надо
                            0,
                            (_LP.Character and _LP.Character:FindFirstChild("Gun")) or nil,
                            nil, 4, false, false,
                            Vector3.new(0,0,0), 0, Vector3.new(0,0,0),



                            --- obxod true
                            true, nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
                            --
                        )
                    end
                end
            end
            task.wait(0.14 + _RAND:NextNumber(0.02, 0.07))
        end)
    end
end

--748794
local function calculateQuantumVector(alpha)
    return Vector3.new(math.cos(alpha), math.sin(alpha), math.tan(alpha)) * 0
end
local fakeQuantum = calculateQuantumVector(math.pi / 3)
--645645


ExploitsFuckServer:AddToggle({
    Name = "Kill All",
    Default = false,
    Callback = function(state)
        engageKillaura(state)
    end
})



AimbotVisuals:AddToggle({
    Name = "Show FOV",
    Default = false,
    Callback = function(state)
        Aimbot.FOVVisible = state
        FOVCircle.Visible = state
    end
})

AimbotVisuals:AddSlider({
    Name = "FOV Size",
    Min = 10,
    Max = 600,
    Default = 100,
    Callback = function(value)
        Aimbot.FOV = value
        FOVCircle.Radius = value
    end
})

AimbotVisuals:AddColorPicker({
    Name = "FOV Color",
    Default = Color3.new(1,1,1),
    Callback = function(color)
        Aimbot.FOVColor = color
        FOVCircle.Color = color
    end
})

MiscBot:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(state)
        HitboxExpander.Enabled = state
        if not state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 0
                    end
                    
                    local headHB = player.Character:FindFirstChild("HeadHB")
                    if headHB then
                        headHB.Size = Vector3.new(1, 1, 1)
                        headHB.Transparency = 0
                    end
                end
            end
        end
    end
})

MiscBot:AddSlider({
    Name = "Width",
    Min = 1,
    Max = 15,
    Default = 5,
    Callback = function(value)
        HitboxExpander.Size = Vector3.new(value, HitboxExpander.Size.Y, HitboxExpander.Size.Z)
    end
})

MiscBot:AddSlider({
    Name = "Height",
    Min = 1,
    Max = 15,
    Default = 5,
    Callback = function(value)
        HitboxExpander.Size = Vector3.new(HitboxExpander.Size.X, value, HitboxExpander.Size.Z)
    end
})

MiscBot:AddSlider({
    Name = "Depth",
    Min = 1,
    Max = 15,
    Default = 5,
    Callback = function(value)
        HitboxExpander.Size = Vector3.new(HitboxExpander.Size.X, HitboxExpander.Size.Y, value)
    end
})

MiscBot:AddSlider({
    Name = "Transparency",
    Min = 0,
    Max = 1,
    Default = 0.75,
    Increment = 0.05,
    Callback = function(value)
        HitboxExpander.Transparency = value
    end
})

MiscBot:AddToggle({
    Name = "Team Check",
    Default = true,
    Callback = function(state)
        HitboxExpander.TeamCheck = state
    end
})

task.spawn(function()
    while true do
        if HitboxExpander.Enabled then
            expandHitboxes()
        end
        task.wait(1)
    end
end)

-- telegram > zeferuswav <
local ThirdPersonSection = MiscTab:AddSection({Name = "Misc", Position = "left"})
ThirdPersonSection:AddToggle({
    Name = "Enabled Third-Person",
    Default = false,
    Callback = function(value)
        ThirdPerson.Enabled = value
        if value then
            EnableThirdPerson()
        else
            DisableThirdPerson()
        end
    end
})

ThirdPersonSection:AddSlider({
    Name = "Distance",
    Min = 5,
    Max = 30,
    Default = 10,
    Callback = function(value)
        ThirdPerson.Distance = value
        if ThirdPerson.Enabled then
            EnableThirdPerson()
        end
    end
})

ThirdPersonSection:AddToggle({
    Name = "Enable Bunny Hop",
    Default = false,
    Callback = function(value)
        BunnyHopSettings.Enabled = value
    end
})

ThirdPersonSection:AddSlider({
    Name = "Speed Bhop",
    Min = 20,
    Max = 250,
    Default = 50,
    Callback = function(value)
        BunnyHopSettings.Speed = value
    end
})

local ThirdPersonSection2 = MiscTab:AddSection({Name = "Chat", Position = "left"})

ThirdPersonSection2:AddToggle({
    Name = "Kill Say",
    Callback = function(value)
        Toggles.KillSay = value
        print("KillSay toggled:", value)
    end
})

--[[
        по сути база килл сея
        ]]

local function sendKillSay()
    local phrase = killsey[math.random(1, #killsey)]
    chat:FireServer(phrase, false, false, true)
end

localPlayer.Status.Kills:GetPropertyChangedSignal("Value"):Connect(function()
    if Toggles.KillSay then
        local kills = localPlayer.Status.Kills.Value
        if kills > 0 then
            sendKillSay()
        end
    end
end)

MiscTab:AddSection({Name = "Exploits", Position = "left"}):AddToggle({
    Name = "Unlock Inventory",
    Callback = function(enabled)
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local client = getsenv(localPlayer:WaitForChild("PlayerGui"):WaitForChild("Client"))
        
        local allSkins = {}
        for _, v in pairs(game:GetService("StarterGui").Client.Rarities:GetChildren()) do
            if v.Name ~= "Banana_Stock" then
                table.insert(allSkins, {v.Name})
            end
        end
        
        local legitInventory = table.clone(client.CurrentInventory)
        local inventorySelections = {}
        

--[[
      здесь скины на ножки и перчатки применяются так бы не работало  
        ]]

        local CurrentKnives = {
            "Bayonet", "Huntsman Knife", "Falchion Knife", "Karambit", "Gut Knife",
            "Butterfly Knife", "M9 Bayonet", "Banana", "Flip Knife", "Sickle",
            "Bearded Axe", "Cleaver"
        }
        local CurrentGloves = {
            "Sports Glove", "Strapped Glove", "Fingerless Glove", "Handwraps"
        }


        
        
        local function updateInventorySkins()
            local seenItems = {}
            local knifeSeen = false
            local gloveSeen = false
            
            for i = #inventorySelections, 1, -1 do
                local entry = inventorySelections[i]
                local weapon = entry.weapon
                
                if seenItems[weapon] then
                    if entry.skin ~= inventorySelections[seenItems[weapon]].skin then
                        inventorySelections[seenItems[weapon]].skin = entry.skin
                    end
                    table.remove(inventorySelections, i)
                else
                    seenItems[weapon] = i
                end
            end
            
            for i = #inventorySelections, 1, -1 do
                local entry = inventorySelections[i]
                if entry.isKnife then
                    if knifeSeen then
                        table.remove(inventorySelections, i)
                    else
                        knifeSeen = true
                    end
                end
            end
            
            for i = #inventorySelections, 1, -1 do
                local entry = inventorySelections[i]
                if entry.isGlove then
                    if gloveSeen then
                        table.remove(inventorySelections, i)
                    else
                        gloveSeen = true
                    end
                end
            end
        end
        
        local oldEquip = client.equipitem
        client.equipitem = function(invennum, team)
            local item2equip = client.CurrentInventory[invennum]
            if not item2equip then
                return oldEquip(invennum, team)
            end
            local physicalitem = item2equip[1]
            local splitter = string.split(physicalitem, "_")
            local weapon = splitter[1]
            local skin = splitter[2]
            
            local isKnife = false
            for _, k in pairs(CurrentKnives) do
                if k == weapon then
                    isKnife = true
                    break
                end
            end
            
            local isGlove = false
            for _, g in pairs(CurrentGloves) do
                if g == weapon then
                    isGlove = true
                    break
                end
            end
            
            table.insert(inventorySelections, {
                args = {invennum, team},
                item2equip = item2equip,
                physicalitem = physicalitem,
                splitter = splitter,
                weapon = weapon,
                skin = skin,
                isKnife = isKnife,
                isGlove = isGlove
            })
            updateInventorySkins()
            return oldEquip(invennum, team)
        end
        
        local function toggleUnlockInventory(enable)
            if enable then
                client.CurrentInventory = allSkins
            else
                client.CurrentInventory = legitInventory
            end
            local TClone = localPlayer.SkinFolder.TFolder:Clone()
            local CTClone = localPlayer.SkinFolder.CTFolder:Clone()
            localPlayer.SkinFolder.TFolder:Destroy()
            localPlayer.SkinFolder.CTFolder:Destroy()
            TClone.Parent = localPlayer.SkinFolder
            CTClone.Parent = localPlayer.SkinFolder
        end
        
        toggleUnlockInventory(enabled)
        

--[[
        применение через инвентори
        ]]

        if enabled then
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if method == "FireServer" then
                    if self.Name == "DataEvent" and args[1] and args[1][4] then
                        local currentModel = string.split(args[1][4][1], "_")[1]
                        local currentSkin = string.split(args[1][4][1], "_")[2]
                        if args[1][2] == "Both" then
                            localPlayer.SkinFolder.CTFolder[args[1][3]].Value = currentSkin
                            localPlayer.SkinFolder.TFolder[args[1][3]].Value = currentSkin
                        else
                            localPlayer.SkinFolder[args[1][2] .. "Folder"][currentModel].Value = currentSkin
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
        end
    end
})







local AnglesSection = HitboxTab:AddSection({Name = "Anti-Aim ", Position = "left"})
AnglesSection:AddToggle({
    Name = "Enabled",
    Default = false,
    Callback = function(value)
        values.rage.angles.enabled.Toggle = value
    end
})

AnglesSection:AddSlider({
    Name = "Yaw Offset",
    Min = -180,
    Max = 180,
    Default = 0,
    Callback = function(value)
        values.rage.angles["yaw offset"].Slider = value
    end
})

AnglesSection:AddToggle({
    Name = "Jitter",
    Default = false,
    Callback = function(value)
        values.rage.angles.jitter.Toggle = value
    end
})

AnglesSection:AddSlider({
    Name = "Jitter Offset",
    Min = 1,
    Max = 180,
    Default = 15,
    Callback = function(value)
        values.rage.angles["jitter offset"].Slider = value
    end
})

AnglesSection:AddDropdown({
    Name = "Pitch",
    Values = { "none", "up", "down", "zero", "random" },
    Default = "none",
    Multi = false,
    Callback = function(value)
        values.rage.angles["pitch"].Dropdown = value
    end
})

AnglesSection:AddToggle({
    Name = "Extend Pitch",
    Default = false,
    Callback = function(value)
        values.rage.angles["extend pitch"].Toggle = value
    end
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local enabled = false
local speed = 10
local radius = 3
local hrp

local angle = 0

local function getHRP()
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart", 5)
end

getHRP()

localPlayer.CharacterAdded:Connect(function()
    angle = 0
    getHRP()
end)

RunService.Heartbeat:Connect(function(dt)
    if not enabled then return end
    if not hrp or not hrp.Parent then
        getHRP()
        return
    end

    angle = (angle + speed * dt * math.pi * 2) % (math.pi * 2)

    local basePos = hrp.CFrame.Position
    local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)

    local success, err = pcall(function()
        hrp.CFrame = CFrame.new(basePos + offset, basePos)
    end)

    if not success then
        getHRP()
    end
end)

local AnglesSection = HitboxTab:AddSection({Name = "Exploit", Position = "right"})

AnglesSection:AddToggle({
    Name = "Cycle Walk",
    Default = false,
    Callback = function(val)
        enabled = val
        if not enabled and hrp then
            local basePos = hrp.CFrame.Position
            hrp.CFrame = CFrame.new(basePos)
        end
    end
})

AnglesSection:AddSlider({
    Name = "Cycle Walk Scum Factor",
    Min = 1,
    Max = 30,
    Default = speed,
    Increment = 1,
    Callback = function(val)
        speed = val
    end
})

AnglesSection:AddSlider({
    Name = "Radius",
    Min = 1,
    Max = 10,
    Default = radius,
    Increment = 0.5,
    Callback = function(val)
        radius = val
    end
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local enabled = false
local speed = 4
local angleAmplitude = 20

local angle = 0
local hrp = nil

local function setupCharacter(character)
    hrp = character:WaitForChild("HumanoidRootPart")

    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        enabled = false
        hrp = nil
    end)
end

local function onCharacterAdded(character)
    setupCharacter(character)
    angle = 0
end

if localPlayer.Character then
    onCharacterAdded(localPlayer.Character)
end
localPlayer.CharacterAdded:Connect(onCharacterAdded)

RunService.Heartbeat:Connect(function(dt)
    if not enabled or not hrp then return end

    angle = (angle + speed * dt * math.pi * 2) % (math.pi * 2)
    local rollRadians = math.sin(angle) * math.rad(angleAmplitude)

    local cf = hrp.CFrame
    local newCf = CFrame.new(cf.Position) * (cf - cf.Position) * CFrame.Angles(0, 0, rollRadians)

    local success, err = pcall(function()
        hrp.CFrame = newCf
    end)
    if not success then
        if localPlayer.Character then
            hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        end
    end
end)

AnglesSection:AddToggle({
    Name = "Body Roll",
    Default = false,
    Callback = function(val)
        enabled = val
        if not enabled and hrp then
            hrp.CFrame = CFrame.new(hrp.Position) * (hrp.CFrame - hrp.CFrame.Position)
        end
    end
})

AnglesSection:AddSlider({
    Name = "Cycles",
    Min = 1,
    Max = 10,
    Default = speed,
    Increment = 0.1,
    Callback = function(val)
        speed = val
    end
})

AnglesSection:AddSlider({
    Name = "Roll Amplitude",
    Min = 1,
    Max = 45,
    Default = angleAmplitude,
    Increment = 1,
    Callback = function(val)
        angleAmplitude = val
    end
})





local Ebobo = Settings:AddSection({Name = "Config's", Position = "left"})

local ConfigName = "UCONFD"

Ebobo:AddTextbox({
    Name = "Name Config : ", 
    Numeric = false,
    Placeholder = "...",
    Default = "UCONFD",
    Finished = true,
    Callback = function(text)
        ConfigName = text
    end
})

Ebobo:AddButton({
    Name = "Save Config",
    Callback = function()
        local path = "ZEFERUS_HVH/"..ConfigName..".json"
        Airflow.FileManager:WriteConfig(Window, path)

        Airflow:Notify({
            Title = "ZEFERUS",
            Content = "Saved: " .. ConfigName,
            Duration = 4
        })
    end
})

local folderName = "ZEFERUS_HVH"
if not isfolder(folderName) then
    makefolder(folderName)
end

Ebobo:AddButton({
    Name = "Load Config",
    Callback = function()
        local path = "ZEFERUS_HVH/"..ConfigName..".json"
        local version = Window:GetConfigs().VERSION

        local success, msg = Airflow.FileManager:LoadConfig(Window, path, version)
        
        Airflow:Notify({
            Title = success and "ZEFERUS" or "Error",
            Content = success and ("ZEFERUS CFG LOADED: " .. ConfigName) or msg,
            Duration = 4
        })
    end
})

local Ebobo2 = Settings:AddSection({Name = "Menu", Position = "right"})

Ebobo2:AddKeybind({
    Name = "Keybind",
    Default = "LeftControl",
    Callback = function(n)
        Window:SetKeybind(n)
    end,
})



local infonaxui = Info:AddSection({Name = "Information", Position = "left"})
infonaxui:AddParagraph({
    Name = "*Update",
    Content = "V2 version 25 JULY 4:22 "
})

-- telegram > zeferuswav <
RunService.Heartbeat:Connect(function()
-- telegram > zeferuswav <
    if ESP.Enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if not ESP.Players[player] then
                    ESP:Draw(player)
                end
            end
        end
        ESP:Update()
    end
    
-- telegram > zeferuswav <
    if Aimbot.Enabled and Aimbot._active then
        local target = Aimbot:GetClosestTarget()
        if target and target.Character then
            local aimPart = target.Character:FindFirstChild(Aimbot.AimPart) or target.Character:FindFirstChild("Head")
            if aimPart then
                local targetVelocity = aimPart.AssemblyLinearVelocity * Aimbot.Prediction
                Aimbot:SmoothAim(aimPart.Position, targetVelocity)
            end
        end
    end
    
-- telegram > zeferuswav <
    FOVCircle.Visible = Aimbot.FOVVisible
    FOVCircle.Radius = Aimbot.FOV
    FOVCircle.Color = Aimbot.FOVColor
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
-- telegram > zeferuswav <
    if ThirdPerson.Enabled then
        EnableThirdPerson()
    end
end)

-- telegram > zeferuswav <
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Aimbot.Keybind then
        Aimbot._active = true
    end
    
    if input.KeyCode == ThirdPerson.Keybind then
        ThirdPerson.Enabled = not ThirdPerson.Enabled
        if ThirdPerson.Enabled then
            EnableThirdPerson()
        else
            DisableThirdPerson()
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Aimbot.Keybind then
        Aimbot._active = false
    end
end)

-- telegram > zeferuswav <
Window:OnDestroy(function()
    for _, drawings in pairs(ESP.Players) do
        for _, drawing in pairs(drawings) do
            drawing:Remove()
        end
    end
    
    FOVCircle:Remove()
    
    if NightMode.Enabled then
        NightMode.Enabled = false
        NightMode:Apply()
    end
    
    if ThirdPerson.Enabled then
        ThirdPerson.Enabled = false
        DisableThirdPerson()
    end

    for _, highlight in pairs(Chams._highlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    Chams._highlights = {}
end)
