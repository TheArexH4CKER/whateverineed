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


task.wait(60)
spawn(function()
    while true do
        pcall(function()   
                local tier = 1
                local type = "Lockpick A"
                    game:GetService("ReplicatedStorage").Library.Client.Network["Lockpick Game: Request Unlock"]:Invoke(tier, type)
        end)
        task.wait(600) -- Wait 10 minutes before claiming again
    end
end)

task.wait(60)
spawn(function()
    while true do
        pcall(function()   
                local tier = 2
                local type = "Lockpick A"
                    game:GetService("ReplicatedStorage").Library.Client.Network["Lockpick Game: Request Unlock"]:Invoke(tier, type)
        end)
        task.wait(600) -- Wait 10 minutes before claiming again
    end
end)

