-- Services
local Services = {
    Players = game:GetService("Players"),
    TeleportService = game:GetService("TeleportService"),
    HttpService = game:GetService("HttpService"),
    NetworkClient = game:GetService("NetworkClient")
}

-- Configuration
local Config = {
    InstanceId = 18901165922,
    ServerUrl = "http://192.168.1.44:8088",
    AltAccounts = {
        "TurkGrogu1", "SenseiGrogu1", "SenseiGrogu2", 
        "SenseiGrogu3", "SenseiGrogu4", "SenseiGrogu5", "SenseiGrogu6"
    },
    Settings = {
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
                ["Send Crafted Keys"] = {SendCrystal = true, SendSecret = true, CrystalMin = 1, SecretMin = 1},
            }
        }
    }
}

-- Local Variables
local Player = Services.Players.LocalPlayer

-- Create ServerManager first since it's needed by AltDetector
local ServerManager = {}

function ServerManager:getServerList()
    local url = string.format(
        "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
        Config.InstanceId
    )
    
    local success, response = pcall(function()
        return Services.HttpService:JSONDecode(game:HttpGet(url)).data
    end)
    
    if not success then
        warn("Failed to retrieve servers.")
        return {}
    end
    return response
end

function ServerManager:serverHop()
    local serverList = self:getServerList()
    if #serverList == 0 then return end
    
    local server = serverList[Random.new():NextInteger(1, #serverList)]
    if server and server.id ~= game.JobId then
        Services.TeleportService:TeleportToPlaceInstance(Config.InstanceId, server.id, Player)
    end
end

-- Alt Detection Module
local AltDetector = {}

function AltDetector:checkPlayer(player)
    if table.find(Config.AltAccounts, player.Name) and player.Name ~= Player.Name then
        ServerManager:serverHop()
    end
end

function AltDetector:initialize()
    for _, player in ipairs(Services.Players:GetPlayers()) do
        self:checkPlayer(player)
    end
    
    Services.Players.PlayerAdded:Connect(function(player)
        self:checkPlayer(player)
    end)
end

-- Server Communication Module
local ServerCommunication = {
    heartbeatDelay = 30 -- Default value if server doesn't respond
}

function ServerCommunication:initialize()
    local success, response = pcall(function()
        local result = request({
            Url = Config.ServerUrl,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        
        if result and result.Body then
            return Services.HttpService:JSONDecode(result.Body)
        end
        return nil
    end)
    
    if success and response and response.heartbeatDelay then
        self.heartbeatDelay = response.heartbeatDelay
        print("Heartbeat delay set to: " .. self.heartbeatDelay)
    else
        warn("Using default heartbeat delay: " .. self.heartbeatDelay)
    end
end

function ServerCommunication:sendRequest(reqType)
    pcall(function()
        request({
            Url = Config.ServerUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = Services.HttpService:JSONEncode({
                requestType = reqType,
                account = Player.Name
            })
        })
    end)
end

function ServerCommunication:startHeartbeat()
    task.spawn(function()
        while true do
            self:sendRequest("HEARTBEAT")
            task.wait(self.heartbeatDelay)
        end
    end)
end

function ServerCommunication:monitorConnection()
    Services.NetworkClient.ChildRemoved:Connect(function()
        self:sendRequest("DISCONNECTED")
    end)
end

-- Initialize everything
local function Initialize()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    -- Set up global settings
    getgenv().Settings = Config.Settings
    
    -- Initialize modules
    task.spawn(function()
        pcall(function()
            AltDetector:initialize()
            ServerCommunication:initialize()
            ServerCommunication:sendRequest("START")
            ServerCommunication:monitorConnection()
            ServerCommunication:startHeartbeat()
        end)
    end)

    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
        end)
    end)
    
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
        end)
    end)
end

Initialize()
