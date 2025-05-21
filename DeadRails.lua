-- Auto Bond Collector Script for Dead Rails

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

-- Player and Character References
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Setup for Bond Counter
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "BondCollectorGUI"

local bondCounter = Instance.new("TextLabel", screenGui)
bondCounter.Size = UDim2.new(0, 200, 0, 50)
bondCounter.Position = UDim2.new(0.5, -100, 0.05, 0)
bondCounter.BackgroundTransparency = 0.5
bondCounter.BackgroundColor3 = Color3.new(0, 0, 0)
bondCounter.TextColor3 = Color3.new(1, 1, 1)
bondCounter.Font = Enum.Font.SourceSansBold
bondCounter.TextSize = 24
bondCounter.Text = "Bonds Collected: 0"

-- Variables
local collectedBonds = 0

-- Function to Tween to a Position
local function tweenToPosition(targetPosition)
    local distance = (humanoidRootPart.Position - targetPosition).Magnitude
    local tweenInfo = TweenInfo.new(distance / 100, Enum.EasingStyle.Linear)
    local goal = {Position = targetPosition}
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
    tween:Play()
    tween.Completed:Wait()
end

-- Function to Simulate 'E' Key Press
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- Function to Find All Bonds
local function findBonds()
    local bonds = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Bond" then
            table.insert(bonds, obj)
        end
    end
    return bonds
end

-- Function to Find Train Seat
local function findTrainSeat()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Seat") and obj.Name == "TrainSeat" then
            return obj
        end
    end
    return nil
end

-- Main Function to Collect Bonds
local function collectBonds()
    local bonds = findBonds()
    for _, bond in ipairs(bonds) do
        tweenToPosition(bond.Position + Vector3.new(0, 5, 0)) -- Move above the bond
        wait(0.2)
        pressE()
        collectedBonds = collectedBonds + 1
        bondCounter.Text = "Bonds Collected: " .. collectedBonds
        wait(0.5)
    end
end

-- Function to Return to Train Seat
local function returnToTrainSeat()
    local seat = findTrainSeat()
    if seat then
        tweenToPosition(seat.Position + Vector3.new(0, 5, 0))
        wait(0.2)
        humanoidRootPart.CFrame = seat.CFrame
    else
        warn("Train seat not found.")
    end
end

-- Execute the Script
collectBonds()
returnToTrainSeat()
