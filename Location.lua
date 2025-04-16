local player = game.Players.LocalPlayer
local label = script.Parent:WaitForChild("CoordsLabel")

local function updateCoords()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	while true do
		local pos = hrp.Position
		label.Text = "X = " .. math.floor(pos.X) .. 
		             "   Y = " .. math.floor(pos.Y) .. 
		             "   Z = " .. math.floor(pos.Z)
		wait(0.2)
	end
end

if player.Character then
	updateCoords()
else
	player.CharacterAdded:Connect(updateCoords)
end
