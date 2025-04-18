-- LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- States
local noclip = false
local flying = false
local headAim = false
local bodyGyro, bodyVel

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "SuperToolsGUI"
screenGui.ResetOnSpawn = false

local openButton = Instance.new("TextButton", screenGui)
openButton.Size = UDim2.new(0, 200, 0, 50)
openButton.Position = UDim2.new(0, 20, 0.5, -25)
openButton.Text = "Open Tool Menu"
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.TextSize = 20
openButton.Font = Enum.Font.SourceSansBold

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 240, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false

local UIListLayout = Instance.new("UIListLayout", mainFrame)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Padding = UDim.new(0, 10)

-- Function to create tool buttons
local function createButton(text, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Noclip
RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _, v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- Fly
RunService.RenderStepped:Connect(function()
	if flying and bodyVel and bodyGyro then
		local cam = workspace.CurrentCamera
		bodyVel.Velocity = cam.CFrame.LookVector * 50
		bodyGyro.CFrame = cam.CFrame
	end
end)

local function toggleFly()
	if flying then
		if bodyGyro then bodyGyro:Destroy() end
		if bodyVel then bodyVel:Destroy() end
		flying = false
	else
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			bodyGyro = Instance.new("BodyGyro", hrp)
			bodyGyro.P = 9e4
			bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bodyGyro.cframe = hrp.CFrame

			bodyVel = Instance.new("BodyVelocity", hrp)
			bodyVel.Velocity = Vector3.new(0,0,0)
			bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

			flying = true
		end
	end
end

-- Head Aim
RunService.RenderStepped:Connect(function()
	if headAim and player.Character and player.Character:FindFirstChild("Head") then
		local head = player.Character.Head
		head.CFrame = CFrame.new(head.Position, mouse.Hit.Position)
	end
end)

-- Workspace Viewer
local function showWorkspace()
	local viewer = Instance.new("ScreenGui", player.PlayerGui)
	viewer.Name = "WorkspaceList"

	local frame = Instance.new("Frame", viewer)
	frame.Size = UDim2.new(0, 300, 0, 400)
	frame.Position = UDim2.new(1, -310, 0.5, -200)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.3

	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, 0, 0, 30)
	title.BackgroundTransparency = 1
	title.Text = "Workspace Objects"
	title.TextColor3 = Color3.new(1,1,1)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 20

	local text = Instance.new("TextLabel", frame)
	text.Position = UDim2.new(0, 0, 0, 30)
	text.Size = UDim2.new(1, 0, 1, -30)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.new(1,1,1)
	text.Font = Enum.Font.Code
	text.TextSize = 14
	text.TextXAlignment = Enum.TextXAlignment.Left
	text.TextYAlignment = Enum.TextYAlignment.Top
	text.TextWrapped = true
	text.Text = ""

	for _, obj in pairs(workspace:GetChildren()) do
		text.Text = text.Text .. obj.Name .. "\n"
	end

	wait(5)
	viewer:Destroy()
end

-- Give BTools
local function giveBTools()
	local ids = {204, 213, 205}
	for _, id in ipairs(ids) do
		local tool = Instance.new("HopperBin")
		tool.BinType = id
		tool.Parent = player.Backpack
	end
end

-- Buttons
createButton("Toggle Noclip", function()
	noclip = not noclip
end)

createButton("Toggle Fly", function()
	toggleFly()
end)

createButton("Enable BTools", function()
	giveBTools()
end)

createButton("Show Workspace", function()
	showWorkspace()
end)

createButton("Toggle Head Aim", function()
	headAim = not headAim
end)

-- Open/Close GUI
openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	openButton.Text = mainFrame.Visible and "Close Tool Menu" or "Open Tool Menu"
end)
