getgenv().Settings = {
    ["Egg Settings"] = {
        OpenEggs = true,
        Egg = "100M Egg",
        --// Supports ANY egg ("Rainbow Egg", "Infinity Egg", ...). Keep "Best" for new accounts.
        
        ["Notifications"] = {
            Webhook = dc_webhook,
            DiscordID = "314107374715535370",
            Difficulty = "100k", --// Minimum Difficulty for Webhook Notifications
        },

        ["Rifts"] = {
            FindRifts = true,
            SortByMultiplier = true, 
            --// true --> Sort by Multiplier out of ALL Targetted Rifts.
            --// false --> Sort by Multiplier out of BEST Targetted Rifts.
            
            Targets = {},
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
        DisableUI = false,
        DisableUseMysteryBox = false,
        DisableUseGoldenBox = false,
        DisableUseSeason1Egg = false,
        DisableAutoDelete = false,
        DisableEquipPets = false,
        DisablePurchaseMerchants = false,
        DisableCraftPotions = false,
        SellBubbles = true,
        FarmCompetitiveQuests = true,
        --MinAccountMastery = 20,
        MinFarmTime = 4,
        DisableUseInfinity = false,
    },
}
loadstring(game:HttpGet("https://system-exodus.com/scripts/BGSI/OneClick.lua"))()
