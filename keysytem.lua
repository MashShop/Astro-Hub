-- ... (your existing Platoboost library code above) ...

-------------------------------------------------------------------------------
--! GUI Implementation
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PlatoboostKeySystem"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Main container frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

-- Top bar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
topBar.BorderSizePixel = 0
topBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "PLATOBOOST KEY SYSTEM"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0.5, -15)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

-- Status message label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 60)
statusLabel.Position = UDim2.new(0, 20, 0, 50)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Enter your key or get a new one"
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
statusLabel.TextWrapped = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.Parent = frame

-- Input box
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -40, 0, 40)
keyBox.Position = UDim2.new(0, 20, 0, 120)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Enter key here (KEY_XXXXXX)"
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(220, 220, 240)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 16
keyBox.ClearTextOnFocus = false
keyBox.Parent = frame

-- Buttons
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.5, -25, 0, 40)
verifyBtn.Position = UDim2.new(0, 20, 0, 170)
verifyBtn.BackgroundColor3 = Color3.fromRGB(65, 120, 190)
verifyBtn.BorderSizePixel = 0
verifyBtn.Text = "VERIFY KEY"
verifyBtn.TextColor3 = Color3.new(1, 1, 1)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 16
verifyBtn.Parent = frame

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.5, -25, 0, 40)
copyBtn.Position = UDim2.new(0.5, 5, 0, 170)
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
copyBtn.BorderSizePixel = 0
copyBtn.Text = "GET NEW KEY"
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 16
copyBtn.Parent = frame

-- Loading spinner
local spinner = Instance.new("Frame")
spinner.Size = UDim2.new(0, 40, 0, 40)
spinner.Position = UDim2.new(0.5, -20, 0.5, -20)
spinner.BackgroundTransparency = 1
spinner.Visible = false
spinner.Parent = gui

local circle = Instance.new("ImageLabel")
circle.Size = UDim2.new(1, 0, 1, 0)
circle.BackgroundTransparency = 1
circle.Image = "rbxassetid://123456789" -- Replace with actual spinner image ID
circle.Parent = spinner

-- Animation function
local function spin()
    while spinner.Visible do
        circle.Rotation = 0
        local tween = TweenService:Create(
            circle,
            TweenInfo.new(1, Enum.EasingStyle.Linear),
            {Rotation = 360}
        )
        tween:Play()
        tween.Completed:Wait()
    end
end

-- Set up onMessage callback
onMessage = function(message)
    statusLabel.Text = message
    
    -- Show notification
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Platoboost Status",
        Text = message,
        Duration = 5
    })
end

-- Button functionality
local function setLoading(state)
    spinner.Visible = state
    verifyBtn.Active = not state
    copyBtn.Active = not state
    keyBox.TextEditable = not state
    
    if state then
        spin()
    end
end

verifyBtn.MouseButton1Click:Connect(function()
    setLoading(true)
    
    local key = keyBox.Text
    if key == "" then
        onMessage("Please enter a key first")
        setLoading(false)
        return
    end
    
    -- Verify key in a separate thread to prevent freezing
    task.spawn(function()
        local success = verifyKey(key)
        setLoading(false)
        
        if success then
            onMessage("Key valid! Welcome.")
            task.wait(2)
            gui:Destroy()
            -- Load main script functionality here
        end
    end)
end)

copyBtn.MouseButton1Click:Connect(function()
    setLoading(true)
    
    -- Copy link in a separate thread
    task.spawn(function()
        copyLink()
        setLoading(false)
    end)
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Initialization
local welcomeFlag = getFlag("welcome_message")
if welcomeFlag ~= nil then
    statusLabel.Text = tostring(welcomeFlag)
else
    statusLabel.Text = "Enter your key or get a new one"
end
