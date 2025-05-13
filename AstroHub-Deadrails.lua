-- Roblox Dead Rails GUI Hub
-- Place this LocalScript inside StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeadRailsGuiHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 350, 0, 520)
frame.Position = UDim2.new(0.5, -175, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 41)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 18)
uiCorner.Parent = frame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(80, 80, 110)
uiStroke.Thickness = 2
uiStroke.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "Dead Rails GUI Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(210, 210, 240)
title.Parent = frame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 24
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.AnchorPoint = Vector2.new(0, 0)
closeButton.Parent = frame

local closeUICorner = Instance.new("UICorner")
closeUICorner.CornerRadius = UDim.new(0, 8)
closeUICorner.Parent = closeButton

-- Functions to create buttons
local function createButton(name, text, posY)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -40, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(65, 65, 90)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 250)
    btn.Parent = frame
    btn.AutoButtonColor = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(120, 120, 160)
    stroke.Transparency = 0.5
    stroke.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(85, 85, 120)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(65, 65, 90)
    end)
    return btn
end

local function createToggleButton(name, text, posY)
    local frameToggle = Instance.new("Frame")
    frameToggle.Name = name .. "Frame"
    frameToggle.Size = UDim2.new(1, -40, 0, 45)
    frameToggle.Position = UDim2.new(0, 20, 0, posY)
    frameToggle.BackgroundTransparency = 1
    frameToggle.Parent = frame

    local label = Instance.new("TextLabel")
    label.Name = name .. "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 20
    label.TextColor3 = Color3.fromRGB(230, 230, 250)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frameToggle

    local toggle = Instance.new("TextButton")
    toggle.Name = name .. "Toggle"
    toggle.Size = UDim2.new(0.25, 0, 0.7, 0)
    toggle.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    toggle.Text = "Off"
    toggle.Font = Enum.Font.GothamSemibold
    toggle.TextSize = 18
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Parent = frameToggle
    toggle.AutoButtonColor = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toggle

    local function toggleState(on)
        if on then
            toggle.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
            toggle.Text = "On"
        else
            toggle.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
            toggle.Text = "Off"
        end
    end

    local state = false -- off initially
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggleState(state)
        -- Fire a custom event or call feature function
        if state then
            frameToggle:Fire("On")
        else
            frameToggle:Fire("Off")
        end
    end)

    -- Custom connect function to easily listen toggle state
    function frameToggle:Fire(state)
        if self._event then
            self._event(state)
        end
    end
    function frameToggle:Connect(func)
        self._event = func
    end

    toggleState(state)
    return frameToggle
end

-- Buttons positions start at 80 and increments by 55
local posY = 80

local autoBondsBtn = createToggleButton("AutoBonds", "Auto Bonds", posY)
posY = posY + 55
local autoWinBtn = createButton("AutoWin", "Auto Win", posY)
posY = posY + 55
local autoQuestBtn = createButton("AutoQuestComplete", "Auto Quest Complete", posY)
posY = posY + 55
local killAuraBtn = createToggleButton("KillAura", "Kill Aura", posY)
posY = posY + 55
local autoFarmBondBtn = createToggleButton("AutoFarmBond", "Auto Farm Bond", posY)
posY = posY + 55
local autoPlayAgainBtn = createButton("AutoPlayAgain", "Auto Play Again", posY)
posY = posY + 55
local tpEventsBtn = createButton("TeleportEvents", "Teleport to Every Event", posY)
posY = posY + 55
local tpTrainBtn = createButton("TeleportTrain", "Teleport to Train", posY)
posY = posY + 55
local copyAllBtn = createButton("CopyAll", "Copy All", posY)
posY = posY + 55

-- Feature implementations placeholders

-- Auto Bonds (toggle)
local autoBondsEnabled = false
autoBondsBtn:Connect(function(state)
    autoBondsEnabled = state
    if state then
        print("Auto Bonds enabled.")
    else
        print("Auto Bonds disabled.")
    end
end)

-- Kill Aura (toggle)
local killAuraEnabled = false
killAuraBtn:Connect(function(state)
    killAuraEnabled = state
    if state then
        -- Start kill aura loop
        spawn(function()
            while killAuraEnabled do
                -- Example implementation:
                -- Loop over nearby enemies and attack them
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local rootPos = character.HumanoidRootPart.Position
                    for _, npc in pairs(workspace:GetChildren()) do
                        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                            local distance = (npc.HumanoidRootPart.Position - rootPos).Magnitude
                            if distance < 20 and npc.Humanoid.Health > 0 then
                                -- Attack logic here - e.g. fire a server event or simulate attack
                                print("Attacking NPC: "..npc.Name)
                                -- This is placeholder: actual game attack code needed here
                            end
                        end
                    end
                end
                wait(0.5)
            end
        end)
        print("Kill Aura enabled.")
    else
        print("Kill Aura disabled.")
    end
end)

-- Auto Farm Bond (toggle)
local autoFarmBondEnabled = false
autoFarmBondBtn:Connect(function(state)
    autoFarmBondEnabled = state
    if state then
        spawn(function()
            while autoFarmBondEnabled do
                -- Placeholder farming bonds logic
                print("Auto farming bonds...")
                wait(3)
            end
        end)
    else
        print("Auto Farm Bond disabled.")
    end
end)

-- Auto Win (button)
autoWinBtn.MouseButton1Click:Connect(function()
    print("Auto Win triggered")
    -- Placeholder: teleport to end or fire win event
    -- Example: player.Character.HumanoidRootPart.CFrame = CFrame.new(endPosition)
end)

-- Auto Quest Complete (button)
autoQuestBtn.MouseButton1Click:Connect(function()
    print("Auto Quest Complete triggered")
    -- Placeholder: complete quest logic here
end)

-- Auto Play Again (button)
autoPlayAgainBtn.MouseButton1Click:Connect(function()
    print("Auto Play Again triggered")
    -- Placeholder: trigger game restart or teleport back
end)

-- Teleport to Every Event (button)
tpEventsBtn.MouseButton1Click:Connect(function()
    print("Teleporting to every event...")
    -- Placeholder teleport locations array
    local eventPositions = {
        Vector3.new(0, 10, 0),
        Vector3.new(100, 10, 100),
        Vector3.new(-100, 10, -100),
    }
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        for _, pos in ipairs(eventPositions) do
            character.HumanoidRootPart.CFrame = CFrame.new(pos)
            wait(1)
        end
    end
end)

-- Teleport to Train (button)
tpTrainBtn.MouseButton1Click:Connect(function()
    print("Teleporting to train...")
    -- Placeholder train position
    local trainPosition = Vector3.new(200, 10, 200)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(trainPosition)
    end
end)

-- Copy All (button)
copyAllBtn.MouseButton1Click:Connect(function()
    print("Copy All triggered")
    -- Placeholder: Copy items or bonds logic here
end)

-- Close Hub Button
closeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(frame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -175, 1.5, 260)})
    tween:Play()
    tween.Completed:Once(function()
        frame.Visible = false
    end)
end)

-- Open the hub animation initially
do
    frame.Position = UDim2.new(0.5, -175, 1.5, 260)
    frame.Visible = true
    local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -175, 0.5, -260)})
    tween:Play()
end

-- Make GUI mobile friendly by setting ResetOnSpawn false and anchoring is done

return screenGui

``` ```lua
-- Additional Features and Enhancements

-- Function to handle player respawn
local function onPlayerRespawn()
    print("Player respawned, resetting GUI states.")
    autoBondsEnabled = false
    killAuraEnabled = false
    autoFarmBondEnabled = false
    -- Reset toggle buttons
    autoBondsBtn:Fire(false)
    killAuraBtn:Fire(false)
    autoFarmBondBtn:Fire(false)
end

-- Connect to player respawn event
player.CharacterAdded:Connect(onPlayerRespawn)

-- Function to save player settings
local function saveSettings()
    -- Placeholder for saving settings logic
    print("Saving player settings...")
end

-- Add a save button to the GUI
local saveButton = createButton("SaveSettings", "Save Settings", posY)
posY = posY + 55

saveButton.MouseButton1Click:Connect(function()
    saveSettings()
end)

-- Function to load player settings
local function loadSettings()
    -- Placeholder for loading settings logic
    print("Loading player settings...")
end

-- Call loadSettings on GUI initialization
loadSettings()

-- Add a reset button to reset all features
local resetButton = createButton("ResetAll", "Reset All Features", posY)
posY = posY + 55

resetButton.MouseButton1Click:Connect(function()
    autoBondsEnabled = false
    killAuraEnabled = false
    autoFarmBondEnabled = false
    autoBondsBtn:Fire(false)
    killAuraBtn:Fire(false)
    autoFarmBondBtn:Fire(false)
    print("All features have been reset.")
end)

-- Finalize GUI setup
print("Dead Rails GUI Hub is ready for use.")
``` ```lua
-- Additional Features and Enhancements

-- Function to handle player respawn
local function onPlayerRespawn()
    print("Player respawned, resetting GUI states.")
    autoBondsEnabled = false
    killAuraEnabled = false
    autoFarmBondEnabled = false
    -- Reset toggle buttons
    autoBondsBtn:Fire(false)
    killAuraBtn:Fire(false)
    autoFarmBondBtn:Fire(false)
end

-- Connect to player respawn event
player.CharacterAdded:Connect(onPlayerRespawn)

-- Function to save player settings
local function saveSettings()
    -- Placeholder for saving settings logic
    print("Saving player settings...")
end

-- Add a save button to the GUI
local saveButton = createButton("SaveSettings", "Save Settings", posY)
posY = posY + 55

saveButton.MouseButton1Click:Connect(function()
    saveSettings()
end)

-- Function to load player settings
local function loadSettings()
    -- Placeholder for loading settings logic
    print("Loading player settings...")
end

-- Call loadSettings on GUI initialization
loadSettings()

-- Add a reset button to reset all features
local resetButton = createButton("ResetAll", "Reset All Features", posY)
posY = posY + 55

resetButton.MouseButton1Click:Connect(function()
    autoBondsEnabled = false
    killAuraEnabled = false
    autoFarmBondEnabled = false
    autoBondsBtn:Fire(false)
    killAuraBtn:Fire(false)
    autoFarmBondBtn:Fire(false)
    print("All features have been reset.")
end)

-- Finalize GUI setup
print("Dead Rails GUI Hub is ready for use.")
