-- LocalScript di StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LOWER_BRIDGE_EVENT

-- Temukan RemoteEvent bridge
for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
	if obj:IsA("RemoteEvent") and obj.Name:lower():find("bridge") then
		LOWER_BRIDGE_EVENT = obj
		break
	end
end

if not LOWER_BRIDGE_EVENT then
	warn("RemoteEvent untuk bridge tidak ditemukan!")
	return
end

local bridgeLowered = false
local timeLeft = 600 -- 10 menit awal dalam detik

-- Fungsi untuk turunkan bridge dan tambahkan 4 menit
local function forceLowerBridge()
	if bridgeLowered then return end
	bridgeLowered = true

	LOWER_BRIDGE_EVENT:FireServer()
	print("Bridge diturunkan otomatis/manual!")

	timeLeft = timeLeft + 240 -- Tambah 4 menit (240 detik)
end

-- Keybind manual (E)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.E then
		forceLowerBridge()
	end
end)

-- Timer utama
RunService.RenderStepped:Connect(function()
	timeLeft -= RunService.RenderStepped:Wait()
	if timeLeft <= 0 then
		timeLeft = 0
		forceLowerBridge()
	end
end)
