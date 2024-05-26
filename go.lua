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
    
    local success, response
    repeat
        success, response = pcall(function()
            return Services.HttpService:JSONDecode(game:HttpGet(url)).data
        end)
        if not success then
            warn("Failed to retrieve servers. Retrying...")
            task.wait(2)
        end
    until success
    return response
end

function ServerManager:serverHop()
    local server
    repeat
        task.wait(1)
        server = self:getServerList()[Random.new():NextInteger(1, 100)]
    until server and server.id ~= game.JobId
    Services.TeleportService:TeleportToPlaceInstance(Config.InstanceId, server.id, Player)
end

-- Alt Detection Module
local AltDetector = {}

function AltDetector:checkPlayer(player)
    if table.find(Config.AltAccounts, player.Name) and player.Name ~= Player.Name then
        ServerManager:serverHop()
    end
end

function AltDetector:initialize()
    -- Check existing players
    for _, player in ipairs(Services.Players:GetPlayers()) do
        self:checkPlayer(player)
    end
    
    -- Monitor new players
    Services.Players.PlayerAdded:Connect(function(player)
        self:checkPlayer(player)
    end)
end

-- Server Communication Module
local ServerCommunication = {}

function ServerCommunication:initialize()
    local response = request({
        Url = Config.ServerUrl,
        Method = "GET"
    })
    self.heartbeatDelay = Services.HttpService:JSONDecode(response.Body).heartbeatDelay
end

function ServerCommunication:sendRequest(reqType)
    return request({
        Url = Config.ServerUrl,
        Method = "POST",
        Body = Services.HttpService:JSONEncode({
            requestType = reqType,
            account = Player.Name
        })
    })
end

function ServerCommunication:startHeartbeat()
    while true do
        self:sendRequest("HEARTBEAT")
        task.wait(self.heartbeatDelay)
    end
end

function ServerCommunication:monitorConnection()
    Services.NetworkClient.ChildRemoved:Connect(function()
        while true do
            self:sendRequest("DISCONNECTED")
            task.wait(1)
        end
    end)
end

-- Initialize everything
local function Initialize()
    repeat task.wait() until game:IsLoaded()
    
    -- Set up global settings
    getgenv().Settings = Config.Settings

    -- Initialize modules
    AltDetector:initialize()
    ServerCommunication:initialize()
    ServerCommunication:sendRequest("START")
    ServerCommunication:monitorConnection()
    task.spawn(function()
        ServerCommunication:startHeartbeat()
    end)
    
    -- Load external scripts
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
end

Initialize()
