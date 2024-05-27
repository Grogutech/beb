getgenv().Settings = {
    StartWith = "Sniper",

    Sniper = {
        Active = true,
       
        Items = {
            SearchTerminal = {
                ["Crystal Key"] = {Class = "Misc", Price = "1%"},
                ["Secret Key"] = {Class = "Misc", Price = "1%"},
            },
            ["All Huges"] = {Class = "Pet", Price = "50%", UseCosmicValues = true},
            ["Gift Bag"] = {Class = "Misc", Price = "30%"},
            ["Large Gift Bag"] = {Class = "Misc", Price = "30%"},
            ["Mini Chest"] = {Class = "Misc", Price = "25%"},
            ["Tech Key"] = {Class = "Misc", Price = "25%"},
            ["Void Key"] = {Class = "Misc", Price = "75%"},
            ["Secret Key Upper Half"] = {Class = "Misc", Price = "1%"},
            ["Crystal Key Upper Half"] = {Class = "Misc", Price = "1%"},
        },
        
        Serverhop = true,
        TeleportDelay = 20,
        UseProPlaza = false,
        RecheckListingsDelay = 1,
    
        Webhook = "https://discord.com/api/webhooks/1243180982631272529/jojQUTtGE0hYSDMliwOEoR20JKR86XT14836JPtXoiC3QhS4lLYbaTSe3i3hsOnHyJky",
        Notifications = true,
        GlobalSnipes = true,
        RemoveUsername = false,

        SwitchToSelling = "N/A" --// TEMP. Low Diamonds, Limits Reached, .. Minutes, N/A -- Low Diamonds (50000)
    },

    Seller = {
        Active = false,

        Items = {
            ["Crystal Key"] = {Class = "Misc", Price = 31000},
            ["Secret Key"] = {Class = "Misc", Price = 72000},
        },

        Serverhop = true,
        TeleportDelay = 15,
        UseProPlaza = false,

        Webhook = "https://discord.com/api/webhooks/1243180982631272529/jojQUTtGE0hYSDMliwOEoR20JKR86XT14836JPtXoiC3QhS4lLYbaTSe3i3hsOnHyJky",
        Notifications = true,
        RemoveUsername = false,

        SwitchToSniping = "Item Runout" --// TEMP. Item Runout, Diamond Max, .. Minutes, N/A
    },

    [[ Thank you for using System Exodus <3! ]]
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f05f01a77417ee52d29956defa8037f7.lua"))()
