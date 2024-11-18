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
            --["All Items"] = {Class = "Lootbox", Price = "15%"},
            --["Instant Luck Potion 4"] = {Class = "Consumable", Price = "20%"},
            --["All Items"] = {Class = "Consumable", Price = "35%"},

            ["All Items"] = {Class = "Pet", Price = "18%"},
            --["Crystal Key"] = {Class = "Misc", Price = "20%"},
            --["Secret Key"] = {Class = "Misc", Price = "20%"},
            ["Fishing Bait 5"] = {Class = "Consumable", Price = "30%"},
            --["Golden Fishing Rod"] = {Class = "Misc", Price = "10%"},
            
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
            ["Item Runout"] = false,
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

pcall(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/717430e3bbde3530feb824de729fcc90.lua"))()
end)
