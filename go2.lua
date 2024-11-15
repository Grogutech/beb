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
    ServerUrl = "http://192.168.1.142:8088",
    AltAccounts = {
	    "TurkGrogu", "EncardGo513", "EncardGo113", "EncardGo139", "EncardGo459", "EncardGo275",
	    "Mami_Pet1", "Mami_Pet2", "Mami_Pet3", "Mami_Pet4", "Mami_Pet5",
	    "Mami_Pet6", "Mami_Pet7"
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

-- Server Management Module
local ServerManager = {
    getServerList = function()
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
    end,
    
    serverHop = function()
        local server
        repeat
            task.wait(1)
            server = ServerManager.getServerList()[Random.new():NextInteger(1, 100)]
        until server and server.id ~= game.JobId
        Services.TeleportService:TeleportToPlaceInstance(Config.InstanceId, server.id, Player)
    end
}

-- Alt Detection Module
local AltDetector = {
    checkPlayer = function(player)
        if table.find(Config.AltAccounts, player.Name) and player.Name ~= Player.Name then
            ServerManager.serverHop()
        end
    end,
    
    initialize = function()
        -- Check existing players
        for _, player in ipairs(Services.Players:GetPlayers()) do
            AltDetector.checkPlayer(player)
        end
        
        -- Monitor new players
        Services.Players.PlayerAdded:Connect(AltDetector.checkPlayer)
    end
}

-- Server Communication Module
local ServerCommunication = {
    heartbeatDelay = nil,
    
    initialize = function()
        local response = request({
            Url = Config.ServerUrl,
            Method = "GET"
        })
        ServerCommunication.heartbeatDelay = Services.HttpService:JSONDecode(response.Body).heartbeatDelay
    end,
    
    sendRequest = function(reqType)
        return request({
            Url = Config.ServerUrl,
            Method = "POST",
            Body = Services.HttpService:JSONEncode({
                requestType = reqType,
                account = Player.Name
            })
        })
    end,
    
    startHeartbeat = function()
        while true do
            ServerCommunication.sendRequest("HEARTBEAT")
            task.wait(ServerCommunication.heartbeatDelay)
        end
    end,
    
    monitorConnection = function()
        Services.NetworkClient.ChildRemoved:Connect(function()
            while true do
                ServerCommunication.sendRequest("DISCONNECTED")
                task.wait(1)
            end
        end)
    end
}

-- Initialize everything
local function Initialize()
    repeat task.wait() until game:IsLoaded()
    
    -- Set up global settings
    getgenv().Settings = Config.Settings
    
    -- Load external scripts
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
    
    -- Initialize modules
    AltDetector.initialize()
    ServerCommunication.initialize()
    ServerCommunication.sendRequest("START")
    ServerCommunication.monitorConnection()
    ServerCommunication.startHeartbeat()
end

Initialize()
