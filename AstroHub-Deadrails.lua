-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Astro Hub",
    Icon = "star", -- Lucide icon name or Roblox asset ID (number)
    LoadingTitle = "Astro Hub Loading",
    LoadingSubtitle = "by Mash",
    Theme = "Default",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "AstroHubConfig"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "Astro Hub Key",
        Subtitle = "Key System",
        Note = "Contact Mash for key",
        FileName = "AstroHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"MashKey123"}
    }
})

-- OPTIONAL: Set custom loading logo
Window:SetLoadingIcon(123456789) -- Ganti 123456789 dengan asset ID logo kamu

-- Create New Tabs
local PlayTab      = Window:CreateTab("Play", "gamepad")
local TeleportTab  = Window:CreateTab("Teleport", "map-pin")
local QuestTab     = Window:CreateTab("Quest", "target")
local ESPTab       = Window:CreateTab("ESP", "eye")
local SettingsTab  = Window:CreateTab("Setting", "settings")
local CreditTab    = Window:CreateTab("Credit", "info")

-- Load saved configuration
Rayfield:LoadConfiguration()
