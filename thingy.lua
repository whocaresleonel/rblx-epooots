-- Create the GUI elements
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the TextBox for username input
local textBox = Instance.new("TextBox")
textBox.Parent = screenGui
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0.5, -100, 0.5, -25)
textBox.PlaceholderText = "Enter username"
textBox.Text = ""
textBox.TextScaled = true

-- Create the button to kick the player
local kickButton = Instance.new("TextButton")
kickButton.Parent = screenGui
kickButton.Size = UDim2.new(0, 200, 0, 50)
kickButton.Position = UDim2.new(0.5, -100, 0.5, 25)
kickButton.Text = "Kick Player"
kickButton.TextScaled = true

-- Handle the button click to kick the player
kickButton.MouseButton1Click:Connect(function()
    local usernameToKick = textBox.Text
    
    if usernameToKick == "" then
        -- If no username is entered, show a warning message
        warn("Please enter a username.")
        return
    end
    
    -- Search for the player by username
    local playerToKick = game.Players:FindFirstChild(usernameToKick)
    
    if playerToKick then
        -- If the player is found, kick them from the game
        playerToKick:Kick("You have been kicked from the game.")
        print("Player " .. usernameToKick .. " was kicked.")
    else
        -- If the player isn't found, show a warning
        warn("Player not found.")
    end
end)
