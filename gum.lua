getgenv().Settings = {
    ["Egg Settings"] = {
        OpenEggs = true,
        Egg = "Best",
        --// Supports ANY egg ("Rainbow Egg", "Infinity Egg", ...). Keep "Best" for new accounts.
        
        ["Notifications"] = {
            Webhook = "https://discord.com/api/webhooks/1364047493683351704/-H11zNtdSHeZ_HbO__FZSEjeF7GeFvqy3hvK80P1EKDzwbJRQ8-fDLl3-kPwkK8TJbrz",
            DiscordID = "314107374715535370",
            Difficulty = "100k", --// Minimum Difficulty for Webhook Notifications
        },

        ["Rifts"] = {
            FindRifts = true,
            SortByMultiplier = false, 
            --// true --> Sort by Multiplier out of ALL Targetted Rifts.
            --// false --> Sort by Multiplier out of BEST Targetted Rifts.
            
            Targets = {"Aura Egg", "Hell Egg"},
            --// Targets = {} will automatically find the Top 3 BEST Rifts to hatch.
        },
    },
    
    ["Debug"] = {
        DisableUI = false,
    },
}
loadstring(game:HttpGet("https://system-exodus.com/scripts/BGSI/OneClick.lua"))()
