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


local Client = game:GetService('ReplicatedStorage').Library.Client
local SaveMod = require(Client.Save).Get()
local RankCmd = require(Client.RankCmds)
local Network = require(Client.Network)

for i = 1,84 do
    local EggSlotInfo = {RankCmd.GetEggBundle(SaveMod["EggSlotsPurchased"] + 1)}
    Network.InvokeServer("EggHatchSlotsMachine_RequestPurchase",EggSlotInfo[1]) task.wait(1)
end
