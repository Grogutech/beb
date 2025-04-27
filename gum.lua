getgenv().Settings = {
    ["Egg Settings"] = {
        OpenEggs = true,
        Egg = "Best",
        --// Supports ANY egg ("Rainbow Egg", "Infinity Egg", ...). Keep "Best" for new accounts.
        
        ["Notifications"] = {
            Webhook = "",
            DiscordID = "314107374715535370",
            Difficulty = "100k", --// Minimum Difficulty for Webhook Notifications
        },

        ["Rifts"] = {
            FindRifts = true,
            SortByMultiplier = true, 
            --// true --> Sort by Multiplier out of ALL Targetted Rifts.
            --// false --> Sort by Multiplier out of BEST Targetted Rifts.
            
            Targets = {"Rainbow Egg", "Aura Egg", "Void Egg"},
            --// Targets = {} will automatically find the Top 3 BEST Rifts to hatch.
        },
    },
    
    ["Enchant Settings"] = {
        EnchantPets = false,
        
        ["Require All Enchants"] = true,
        ["Enchants Needed"] = {
            ["Team Up"] = { Tier = 5, HigherTiers = true },
        },
    },
    
    ["Debug"] = {
        DisableUI = true,
        DisableUseMysteryBox = true,
        DisableUseGoldenBox = true,
        DisableUseSeason1Egg = false,
        DisableAutoDelete = false,
        DisableEquipPets = false,
        DisablePurchaseMerchants = true,
        DisableCraftPotions = false,
        SellBubbles = true,
        FarmCompetitiveQuests = true,
        MinFarmTime = 4,
        DisableUseInfinity = false,
    },
}
loadstring(game:HttpGet("https://system-exodus.com/scripts/BGSI/OneClick.lua"))()
