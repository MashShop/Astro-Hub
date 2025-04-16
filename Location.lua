local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player:WaitForChild("PlayerGui")

-- Buat ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KoordinatGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Buat TextLabel
local label = Instance.new("TextLabel")
label.Name = "KoordinatLabel"
label.Size = UDim2.new(0, 250, 0, 40)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 0.3
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.TextColor3 = Color3.fromRGB(0, 255, 0)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true
label.Text = "X = 0 | Y = 0 | Z = 0"
label.Parent = screenGui

-- Update koordinat terus menerus
while character and character.Parent do
    local pos = humanoidRootPart.Position
    label.Text = string.format("X = %d | Y = %d | Z = %d", pos.X, pos.Y, pos.Z)
    wait(0.2)
end
