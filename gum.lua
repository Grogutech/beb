getgenv().Settings = {
    ["Open Egg"] = "100M Egg",

    ["Target Rifts"] = {"Silly Egg", "Rainbow Egg", "Throwback Egg"},
    ["Minimum Rift Luck"] = 25,
    ["Target Highest Luck"] = false,
    --// true --> Targets highest luck out of ALL selected rifts.
    --// false --> Targets highest luck out of the BEST selected rift.

    ["Webhook"] = dc_webhook,
    ["Discord ID"] = "314107374715535370",
    ["Minimum Send Difficulty"] = "100k",

    ["Enchant Equipped"] = {
        ["Team Up"] = {Tier = 1, HigherTiers = true}
    },
    ["Require All Enchants"] = true,

    ["Trade Users"] = {"GalacticVana"},

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
        FarmCompetitiveQuests = false,
        --MinAccountMastery = 20,
        MinFarmTime = 4,
        DisableUseInfinity = false,
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fb6f3bc2f2e7dd88042fac40addd4d57.lua"))()
