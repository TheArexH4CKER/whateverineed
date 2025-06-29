local webhook = "https://discord.com/api/webhooks/1388882683307753483/ey2Fdxpcgaqcj9lOuUnTLUE7YvenlFktdgXecFI0N_ZsHWjN_NqXRtfeHqBXRwigPIvd" 
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")
local Save = require(Client:WaitForChild("Save"))

local sentPets = {}

local function sendWebhook(petName, am, color)
    local data = {
        ["embeds"] = {{
            title = LocalPlayer.Name .. " " .. petName,
            color = color,
            footer = { text = "Amount: " .. am }
        }}
    }
    local json = HttpService:JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    local req = http_request or request or HttpPost or syn.request
    if req then
        req({Url = webhook, Body = json, Method = "POST", Headers = headers})
    end
end

local function buildKey(pet)
    local parts = {
        pet.sh and "sh" or "nsh",
        pet.pt or 0,
        pet.id,
        pet._am or 1
    }
    return table.concat(parts, ":")
end

local function checkPets()
    for _, pet in Save.Get().Inventory.Pet do
        if pet.id == "Gym Dragon" then
            local key = buildKey(pet)
            if not sentPets[key] then
                local nameParts = {}
                if pet.sh then table.insert(nameParts, "Shiny") end
                if pet.pt == 1 then table.insert(nameParts, "Gold") end
                if pet.pt == 2 then table.insert(nameParts, "Rainbow") end
                table.insert(nameParts, pet.id)

                local petName = table.concat(nameParts, " ")
                local color = (pet.pt == 2) and 0xFF0000 or 0xFFFFFF
                sendWebhook(petName, pet._am or 1, color)
                sentPets[key] = true
            end
        end
    end
end

while task.wait(60) do
    checkPets()
end
