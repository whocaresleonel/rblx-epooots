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

-- Handle the button click to kick the player (Note: Kick is a client-side only action)
kickButton.MouseButton1Click:Connect(function()
    local usernameToKick = textBox.Text
    
    if usernameToKick == "" then
        -- If no username is entered, show a warning message
        warn("Please enter a username.")
        return
    end
    
    -- Search for the player by username on the client side
    local playerToKick = nil
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name == usernameToKick then
            playerToKick = player
            break
        end
    end
    
    if playerToKick then
        -- If the player is found, you can't kick them client-side
        -- Instead, you can send a message to the server to kick the player
        print("You can only kick yourself from the client side.")
        -- You can use a RemoteEvent to request the server to kick the player (if needed)
        -- Uncomment below line and implement server-side logic if you want to kick on server side
        -- game.ReplicatedStorage.KickPlayer:FireServer(playerToKick)
    else
        -- If the player isn't found, show a warning
        warn("Player not found.")
    end
end)
