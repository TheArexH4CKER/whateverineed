spawn(function()
    while true do
        pcall(function() 
game:GetService("ReplicatedStorage").Network["ForeverPacks: Claim Free"]:InvokeServer("Default")
        end)
        task.wait(600)
    end
end)