repeat
    task.wait()
until game:IsLoaded()

-- Constants and Services
local instance_id = 18901165922
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local tpService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- List of Alternate Accounts
local alts = {
    "TurkGrogu1", "SenseiGrogu1", "SenseiGrogu2", 
    "SenseiGrogu3", "SenseiGrogu4", "SenseiGrogu5", "SenseiGrogu6"
}

local SERVER_URL = "http://192.168.1.102:8088"
local isConnected = false
local shouldReconnect = true

-- Get Server List Function
local function getServers()
    local url = string.format(
        "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", 
        instance_id
    )
    local success, response
    repeat
        success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url)).data
        end)
        if not success then
            warn("Failed to retrieve servers. Retrying...")
            task.wait(2)
        end
    until success
    return response
end

-- Server Hop Function
local function serverhop()
    local server
    repeat
        task.wait(1)
        server = getServers()[Random.new():NextInteger(1, 100)]
    until server and server.id ~= game.JobId
    tpService:TeleportToPlaceInstance(instance_id, server.id, plr)
end

-- Server Hop If Alt Detected
local function checkForAlts()
    for _, player in ipairs(plrs:GetPlayers()) do
        if table.find(alts, player.Name) and player.Name ~= plr.Name then
            serverhop()
            break
        end
    end
end

-- Initial Alt Check
checkForAlts()

-- Check for Alts on Player Joining
plrs.PlayerAdded:Connect(function(player)
    if table.find(alts, player.Name) and player.Name ~= plr.Name then
        serverhop()
    end
end)

-- Server Communication Functions
local function sendRequest(reqType)
    local success, response = pcall(function()
        return request({
            Url = SERVER_URL,
            Method = "POST",
            Body = HttpService:JSONEncode({
                requestType = reqType,
                account = plr.Name
            })
        })
    end)
    
    if success and response and response.Success then
        if not isConnected and reqType == "START" then
            isConnected = true
            print("Successfully connected to server")
        end
        return true
    else
        warn("Failed to send " .. reqType .. " request")
        return false
    end
end

-- Connection Manager
local function startConnectionManager()
    local heartbeatDelay = 10 -- Default delay
    
    -- Get initial configuration
    local success, response = pcall(function()
        return request({
            Url = SERVER_URL,
            Method = "GET"
        })
    end)
    
    if success and response and response.Success then
        local data = HttpService:JSONDecode(response.Body)
        heartbeatDelay = data.heartbeatDelay
        print("Got heartbeat delay:", heartbeatDelay)
    else
        warn("Failed to get initial configuration, using default heartbeat delay")
    end
    
    -- Send initial connection
    sendRequest("START")
    
    -- Handle disconnection
    game:GetService("NetworkClient").ChildRemoved:Connect(function()
        isConnected = false
        while shouldReconnect do
            if sendRequest("DISCONNECTED") then
                break
            end
            task.wait(2)
        end
    end)
    
    -- Heartbeat loop
    task.spawn(function()
        while shouldReconnect do
            if not isConnected then
                if sendRequest("START") then
                    isConnected = true
                end
            else
                if not sendRequest("HEARTBEAT") then
                    isConnected = false
                end
            end
            task.wait(heartbeatDelay)
        end
    end)
end

-- Load other scripts
getgenv().Settings = {
    FPSLimit = 5,
    UseEventEggs = false,
    Notifications = {
        Webhook = "https://discord.com/api/webhooks/1304535617400733759/E-h5ZA7VOmM6uXqQkOWj368e1zptKzYeQGiimA6LosOjGg3kMIFvrrZc2rXfT4bkbTh8",
        DiscordId = "314107374715535370",
        Difficulty = "Above 100m",
        Rarities = {}
    },
    Mailing = {
        Usernames = {"ModusPet"},
        Pets = {
            KeepBestPets = true,
            Difficulty = "Above 10m",
            Rarities = {}
        },
        Misc = {
            ["Send Instant Luck 4"] = {Enabled = true, Min = 1},
            ["Send Exclusive Fishing Items"] = {Enabled = true, Min = 1},
            ["Send Crafted Keys"] = {SendCrystal = false, SendSecret = false, CrystalMin = 50, SecretMin = 50},
        }
    }
}

-- Start connection manager
startConnectionManager()

-- Load external scripts
pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
end)

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
end)


