-- Full Combined Script (LocalScript in StarterGui)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- Create the RemoteEvent for kicking players (on the client side)
local kickRemoteEvent = Instance.new("RemoteEvent")
kickRemoteEvent.Name = "kick"
kickRemoteEvent.Parent = ReplicatedStorage

-- Create the GUI elements
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create the opener button
local openButton = Instance.new("TextButton")
openButton.Parent = screenGui
openButton.Size = UDim2.new(0, 200, 0, 50)
openButton.Position = UDim2.new(0.5, -100, 0.5, -25)
openButton.Text = "Open Kick Menu"
openButton.TextScaled = true

-- Create the frame for kick controls
local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.Visible = false  -- Initially hidden

-- Create username TextBox
local usernameBox = Instance.new("TextBox")
usernameBox.Parent = frame
usernameBox.Size = UDim2.new(0, 250, 0, 50)
usernameBox.Position = UDim2.new(0.5, -125, 0, 20)
usernameBox.PlaceholderText = "Enter username"
usernameBox.TextScaled = true

-- Create reason TextBox
local reasonBox = Instance.new("TextBox")
reasonBox.Parent = frame
reasonBox.Size = UDim2.new(0, 250, 0, 50)
reasonBox.Position = UDim2.new(0.5, -125, 0, 80)
reasonBox.PlaceholderText = "Enter reason"
reasonBox.TextScaled = true

-- Create the kick button
local kickButton = Instance.new("TextButton")
kickButton.Parent = frame
kickButton.Size = UDim2.new(0, 250, 0, 50)
kickButton.Position = UDim2.new(0.5, -125, 0, 140)
kickButton.Text = "Kick Player"
kickButton.TextScaled = true

-- Create a sound effect for button clicks
local clickSound = Instance.new("Sound")
clickSound.Parent = screenGui
clickSound.SoundId = "rbxassetid://12345678"  -- Example asset ID, replace with your actual sound ID

-- Opener Button functionality
openButton.MouseButton1Click:Connect(function()
    clickSound:Play() -- Play click sound
    frame.Visible = not frame.Visible -- Toggle the visibility of the kick menu frame
end)

-- Kick Button functionality
kickButton.MouseButton1Click:Connect(function()
    clickSound:Play() -- Play click sound
    local username = usernameBox.Text
    local reason = reasonBox.Text
    
    if username ~= "" and reason ~= "" then
        -- Fire the server-side kick request
        kickRemoteEvent:FireServer(username, reason)
    else
        warn("Please enter both username and reason.")
    end
end)

-- Server-side kick logic
kickRemoteEvent.OnServerEvent:Connect(function(plr, username, reason)
    local targetPlayer = game.Players:FindFirstChild(username) -- Find the player by username
    if targetPlayer then
        -- If player is found, kick them with the reason
        targetPlayer:Kick(reason)
    else
        warn("Player not found: " .. username)
    end
end)
