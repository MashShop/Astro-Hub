--// Native Hub style GUI using Rayfield UI Library
--// Place Rayfield ModuleScript in ReplicatedStorage as "Rayfield"
--// Place this script in StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rayfield = require(ReplicatedStorage:WaitForChild("Rayfield"))

-- Create the main hub window
local Window = Rayfield:CreateWindow({
    Name = "Astro Hub",
    LoadingTitle = "Astro Hub",
    LoadingSubtitle = "Created by: Mash",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- ESP Tab
local ESPTab = Window:CreateTab("ESP", 4483362458)
ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Flag = "EnableESP",
    Callback = function(state)
        -- Your ESP enable/disable logic here
    end,
})

-- Autofarm Tab
local FarmTab = Window:CreateTab("Autofarm", 4483362458)
FarmTab:CreateButton({
    Name = "Auto Farm Bonds",
    Callback = function()
        -- Your autofarm logic here
    end,
})

FarmTab:CreateButton({
    Name = "Auto Collect Items",
    Callback = function()
        -- Your auto-collect logic here
    end,
})

-- Teleport Tab
local TpTab = Window:CreateTab("Teleport", 4483362458)
TpTab:CreateButton({
    Name = "TP to End",
    Callback = function()
        -- Your teleport to end logic here
    end,
})

TpTab:CreateButton({
    Name = "TP to Safe Zone",
    Callback = function()
        -- Your teleport to safe zone logic here
    end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateToggle({
    Name = "Godmode",
    CurrentValue = false,
    Flag = "Godmode",
    Callback = function(state)
        -- Your godmode logic here
    end,
})

MiscTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(state)
        -- Your noclip logic here
    end,
})

-- Credits Tab
local CreditsTab = Window:CreateTab("Credits", 4483362458)
CreditsTab:CreateParagraph({Title = "Astro Hub", Content = "Made with Rayfield UI and Mash"})
