local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AimESP_GUI"

-- ESP Button
local espButton = Instance.new("TextButton", gui)
espButton.Size = UDim2.new(0, 120, 0, 40)
espButton.Position = UDim2.new(0, 20, 0, 20)
espButton.Text = "Enable ESP"
espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200)

-- Auto Aim Button
local aimButton = Instance.new("TextButton", gui)
aimButton.Size = UDim2.new(0, 140, 0, 40)
aimButton.Position = UDim2.new(0, 20, 0, 70)
aimButton.Text = "Enable Auto Aim"
aimButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

-- Teleport to Gun
local tpToGunButton = Instance.new("TextButton", gui)
tpToGunButton.Size = UDim2.new(0, 140, 0, 40)
tpToGunButton.Position = UDim2.new(0, 20, 0, 120)
tpToGunButton.Text = "TP to Gun"
tpToGunButton.Visible = false
tpToGunButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)

-- Teleport Back
local tpBackButton = Instance.new("TextButton", gui)
tpBackButton.Size = UDim2.new(0, 140, 0, 40)
tpBackButton.Position = UDim2.new(0, 20, 0, 170)
tpBackButton.Text = "TP Back"
tpBackButton.Visible = false
tpBackButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

-- ESP logic
local highlights = {}
local espEnabled = false

local function addHighlight(plr)
	if plr == player or highlights[plr] or not plr.Character then return end
	local role = plr:FindFirstChild("Role")
	if not role then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESP_Highlight"
	highlight.Adornee = plr.Character
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0

	if role.Value == "Sheriff" then
		highlight.FillColor = Color3.fromRGB(0, 150, 255)
	elseif role.Value == "Murderer" then
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
	elseif role.Value == "Innocent" then
		highlight.FillColor = Color3.fromRGB(0, 255, 0)
	end

	highlight.Parent = plr.Character
	highlights[plr] = highlight
end

local function enableESP()
	if espEnabled then return end
	espEnabled = true

	for _, plr in pairs(Players:GetPlayers()) do
		addHighlight(plr)
	end

	Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function()
			wait(1)
			addHighlight(plr)
		end)
	end)
end

-- Auto Aim logic
local isAiming = false

local function getClosestTarget()
	local closestPlayer = nil
	local shortestDistance = math.huge

	for _, other in pairs(Players:GetPlayers()) do
		if other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
			local role = other:FindFirstChild("Role")
			if role and (role.Value == "Murderer" or role.Value == "Sheriff") then
				local distance = (camera.CFrame.Position - other.Character.HumanoidRootPart.Position).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					closestPlayer = other
				end
			end
		end
	end
	return closestPlayer
end

local function startAutoAim()
	local target = getClosestTarget()
	if not target or not target.Character then return end
	local hrp = target.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	isAiming = true

	while isAiming and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
		camera.CFrame = CFrame.new(camera.CFrame.Position, hrp.Position)
		RunService.RenderStepped:Wait()
	end
end

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isAiming = false
	end
end)

-- Teleport to Gun logic
local originalPosition = nil

local function monitorSheriff()
	while true do
		task.wait(1.5)
		for _, plr in pairs(Players:GetPlayers()) do
			if plr:FindFirstChild("Role") and plr.Role.Value == "Sheriff" then
				local char = plr.Character
				if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health <= 0 then
					local gun = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun") or workspace:FindFirstChild("Revolver")
					if gun then
						tpToGunButton.Visible = true
					end
				end
			end
		end
	end
end

tpToGunButton.MouseButton1Click:Connect(function()
	local gun = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun") or workspace:FindFirstChild("Revolver")
	if gun and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		originalPosition = player.Character.HumanoidRootPart.Position
		player.Character.HumanoidRootPart.CFrame = CFrame.new(gun.Position + Vector3.new(0, 3, 0))
		tpBackButton.Visible = true
	end
end)

tpBackButton.MouseButton1Click:Connect(function()
	if originalPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition + Vector3.new(0, 3, 0))
		tpToGunButton.Visible = false
		tpBackButton.Visible = false
	end
end)

-- Button actions
espButton.MouseButton1Click:Connect(enableESP)
aimButton.MouseButton1Click:Connect(startAutoAim)

-- Start monitoring for gun drop
task.spawn(monitorSheriff)
