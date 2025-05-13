-- Load the Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/sirius-menu/rayfield/main/source.lua"))()

-- Create the main window for Astro Hub
local Window = Rayfield:CreateWindow({
    Name = "Astro Hub",
    LoadingTitle = "Loading Astro Hub...",
    LoadingSubtitle = "Please wait...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AstroHub",
        FileName = "settings"
    },
    Discord = {
        Enabled = false,
        Invite = "https://discord.gg/jCNUFvEsUZ", -- Replace with your Discord invite link
        RememberJoins = true
    },
    KeySystem = true, -- Set to true if you want to use a key system
})

-- Create a new tab in the window
local Tab = Window:CreateTab("Main")

-- Create a button in the tab
Tab:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
        Rayfield:Notify({
            Title = "Astro Hub",
            Content = "You clicked the button!",
            Duration = 5,
        })
    end,
})

-- Create a toggle in the tab
Tab:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(Value)
        print("Feature enabled: " .. tostring(Value))
    end,
})

-- Create a slider in the tab
Tab:CreateSlider({
    Name = "Set Value",
    Range = {0, 100},
    Increment = 1,
    Suffix = "units",
    CurrentValue = 50,
    Callback = function(Value)
        print("Slider value: " .. Value)
    end,
})

-- Create a label in the tab
Tab:CreateLabel("Welcome to Astro Hub! Customize your experience.")

-- Finalize the UI
Rayfield:Init() 
