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
            task.wait(2)  -- Wait a bit before retrying
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
                ["Send Crafted Keys"] = {SendCrystal = true, SendSecret = true, CrystalMin = 1, SecretMin = 1},
            }
        }
    }

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()


    task.spawn(function()
        pcall(function()
                local data = request(
                    {
                        Url = SERVER_URL,
                        Method = "GET"
                    }
                )
                
                local heartbeatDelay = game.HttpService:JSONDecode(data.Body)["heartbeatDelay"]
                
                local function sendRequest(reqType)
                    return request(
                        {
                            Url = SERVER_URL,
                            Method = "POST",
                            Body = game.HttpService:JSONEncode({
                                requestType = reqType,
                                account = game:GetService("Players").LocalPlayer.Name
                            })
                        }
                    )
                end
                
                sendRequest("START")
                
                game:GetService("NetworkClient").ChildRemoved:Connect(function()
                    while true do
                        sendRequest("DISCONNECTED")
                        task.wait(1)
                    end
                end)
                
                while true do
                    sendRequest("HEARTBEAT")
                    task.wait(heartbeatDelay)
                end
        end)
    end)
