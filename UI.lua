-- Dead Rails Challenge Assistant GUI with Auto-Win Feature
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChallengeAssistantGUI"
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 550)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

-- UIListLayout for buttons
local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 5)
uiList.FillDirection = Enum.FillDirection.Vertical
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Parent = mainFrame

-- Countdown Label
local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, -20, 0, 30)
countdownLabel.Position = UDim2.new(0, 10, 0, 10)
countdownLabel.Text = "Bridge Crack In: 10:00"
countdownLabel.TextColor3 = Color3.new(1, 1, 1)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Font = Enum.Font.SourceSansBold
countdownLabel.TextScaled = true
countdownLabel.Parent = mainFrame

-- Countdown Timer
local countdownTime = 600 -- 10 minutes in seconds

spawn(function()
	while countdownTime > 0 do
		wait(1)
		countdownTime = countdownTime - 1
		local minutes = math.floor(countdownTime / 60)
		local seconds = countdownTime % 60
		countdownLabel.Text = string.format("Bridge Crack In: %02d:%02d", minutes, seconds)
	end
	countdownLabel.Text = "Bridge is Ready!"
end)

-- Function to create challenge buttons
local function createChallengeButton(challengeName, description)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 40)
	button.Position = UDim2.new(0, 10, 0, 0)
	button.Text = challengeName
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.Font = Enum.Font.SourceSans
	button.TextScaled = true
	button.Parent = mainFrame

	-- Tooltip for description
	local tooltip = Instance.new("TextLabel")
	tooltip.Size = UDim2.new(1, 0, 0, 60)
	tooltip.Position = UDim2.new(0, 0, 1, 0)
	tooltip.Text = description
	tooltip.TextColor3 = Color3.new(1, 1, 1)
	tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	tooltip.Visible = false
	tooltip.Font = Enum.Font.SourceSans
	tooltip.TextWrapped = true
	tooltip.TextScaled = true
	tooltip.Parent = button

	button.MouseEnter:Connect(function()
		tooltip.Visible = true
	end)

	button.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)

	button.MouseButton1Click:Connect(function()
		print("Guide for " .. challengeName .. ": " .. description)
		-- Implement specific guidance or actions here
	end)
end

-- List of challenges with descriptions
local challenges = {
	["Tame a Unicorn"] = "Find and saddle a wild unicorn or one already tamed.",
	["Escape"] = "Travel 80km and lower the bridge successfully.",
	["Bounty Hunter"] = "Eliminate 5 outlaws and turn in their bounties at the sheriff’s office.",
	["New Sheriff in Town"] = "Defeat 50 outlaws in a single game.",
	["Werewolf Hunter"] = "Eliminate 100 werewolves in one game.",
	["Zombie Hunter"] = "Defeat 200 zombies in a single game.",
	["Unkillable"] = "Complete a game without any player deaths.",
	["Pacifist"] = "Finish a game without any player killing an enemy (Safezone turrets excluded).",
	["Pony Express"] = "Complete the game without using the train.",
	["Electric Remains"] = "Defeat Nikola Tesla and sell his corpse at the 70km Fortified Town."
}

-- Create buttons for each challenge
for name, desc in pairs(challenges) do
	createChallengeButton(name, desc)
end

-- Auto-Win Button
local autoWinButton = Instance.new("TextButton")
autoWinButton.Size = UDim2.new(1, -20, 0, 40)
autoWinButton.Position = UDim2.new(0, 10, 0, 0)
autoWinButton.Text = "Activate Auto-Win Strategy"
autoWinButton.TextColor3 = Color3.new(1, 1, 1)
autoWinButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
autoWinButton.Font = Enum.Font.SourceSansBold
autoWinButton.TextScaled = true
autoWinButton.Parent = mainFrame

autoWinButton.MouseButton1Click:Connect(function()
	print("Auto-Win Strategy Activated:")
	print("1. Collect and manage coal efficiently to keep the train running.")
	print("2. At 70km, disembark to prepare for the final bridge activation.")
	print("3. At 80km, activate the bridge crank to initiate the final sequence.")
	print("4. Defend against waves of enemies during the bridge lowering process.")
end)
