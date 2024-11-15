-- Services
local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
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
    lastHeartbeat = tick(),
    isConnected = true,
    disconnectThreshold = 10,
    
    checkConnection = function()
        local currentTime = tick()
        local timeSinceLastHeartbeat = currentTime - ServerCommunication.lastHeartbeat
        
        -- Bağlantı kontrolü
        if timeSinceLastHeartbeat > ServerCommunication.disconnectThreshold then
            if ServerCommunication.isConnected then
                ServerCommunication.isConnected = false
                ServerCommunication.handleDisconnect()
            end
        else
            ServerCommunication.isConnected = true
        end
    end,
    
    handleDisconnect = function()
        spawn(function()
            while not ServerCommunication.isConnected do
                pcall(function()
                    ServerCommunication.sendRequest("DISCONNECTED")
                end)
                task.wait(1)
            end
        end)
    end,
    
    sendHeartbeat = function()
        local success, response = pcall(function()
            return ServerCommunication.sendRequest("HEARTBEAT")
        end)
        
        if success then
            ServerCommunication.lastHeartbeat = tick()
        end
    end,
    
    monitorConnection = function()
        -- Her 1 saniyede bir bağlantı durumunu kontrol et
        Services.RunService.Heartbeat:Connect(function()
            ServerCommunication.checkConnection()
        end)
        
        -- Düzenli heartbeat gönderimi
        spawn(function()
            while true do
                ServerCommunication.sendHeartbeat()
                task.wait(ServerCommunication.heartbeatDelay or 5)
            end
        end)
        
        -- Oyundan çıkış kontrolü
        game:BindToClose(function()
            ServerCommunication.sendRequest("DISCONNECTED")
            task.wait(1)
        end)
        
        -- Teleport kontrolü
        Services.Players.PlayerRemoving:Connect(function(player)
            if player == Services.Players.LocalPlayer then
                ServerCommunication.sendRequest("DISCONNECTED")
            end
        end)
    end,
    
    sendRequest = function(reqType)
        return request({
            Url = Config.ServerUrl,
            Method = "POST",
            Body = Services.HttpService:JSONEncode({
                requestType = reqType,
                account = Services.Players.LocalPlayer.Name
            })
        })
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
