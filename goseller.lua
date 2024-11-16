getgenv().Settings = {
    Sniper = {
        Active = false,
        Items = {
            --// Example Settings, everything is editable.
            SearchTerminal = {
                ["Instant Luck Potion 4"] = {Class = "Consumable", Price = "10%"},
                ["Crystal Key"] = {Class = "Misc", Price = "35%"},
            },
        },
        Serverhop = {
            ["Switch Servers"] = true,
            ["Teleport Delay (s)"] = 3,
            ["Save # Last Joined Servers"] = 10,
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
        Active = true,
        Items = {
            ["All Huges"] = {Class = "Pet", Price = "75%"},
            ["All Items"] = {Class = "Lootbox", Price = "15%"},
            ["Instant Luck Potion 4"] = {Class = "Consumable", Price = "20%"},
            ["Jelly God Potion"] = {Class = "Consumable", Price = "-5%"},
            --["All Items"] = {Class = "Consumable", Price = "35%"},
            ---["All Rarity: Exotic"] = {Class = "Pet", Price = "-15%"},
            --["All Rarity: Mythical"] = {Class = "Pet", Price = "-15%"},
            --["All Rarity: Celestial"] = {Class = "Pet", Price = "-15%"},
            --["All Rarity: Superior"] = {Class = "Pet", Price = "-10%"},
            --["All Rarity: Divine"] = {Class = "Pet", Price = "-5%"},
            
            --["Jelly Cat"] = {Class = "Pet", Price = "-5%"},
            --["Jelly Corgi"] = {Class = "Pet", Price = "-5%"},
            --["Jelly Axolotl"] = {Class = "Pet", Price = "-5%"},
            --["Jelly Piggy"] = {Class = "Pet", Price = "-5%"},
            ["Jelly Shiba"] = {Class = "Pet", Price = "-5%"},
            ["Jelly Panda"] = {Class = "Pet", Price = "-5%"},
            ["Jelly Dragon"] = {Class = "Pet", Price = "-5%"},
            ["Jelly Monkey"] = {Class = "Pet", Price = "-5%"},
            
            ["RAP Above: 5k"] = {Class = "Pet", Price = "18%"},
            ["Crystal Key"] = {Class = "Misc", Price = "20%"},
            ["Secret Key"] = {Class = "Misc", Price = "20%"},
            ["Fishing Bait"] = {Class = "Consumable", Price = 11000},
            --["Fishing Bait 1"] = {Class = "Consumable", Price = "30%"},
            --["Fishing Bait 2"] = {Class = "Consumable", Price = "30%"},
            --["Fishing Bait 3"] = {Class = "Consumable", Price = "30%"},
            --["Fishing Bait 4"] = {Class = "Consumable", Price = 11000},
            ["Fishing Bait 5"] = {Class = "Consumable", Price = 11000},
            --["Exclusive Fishing Bait"] = {Class = "Consumable", Price = 10000},
            --["Legendary Fishing Bait"] = {Class = "Consumable", Price = "30%"},
            ["Golden Fishing Rod"] = {Class = "Misc", Price = "10%"},
            
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
            ["Diamonds Hit: 10m Sendout"] = "anilkenim",
            ["Always Try Adding Listings"] = true,
            ["Never Join Friendslist"] = false,
        },
    },
}

-- Constants and Services
local instance_id = 18901165922
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local tpService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")


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

pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/717430e3bbde3530feb824de729fcc90.lua"))()
end)
