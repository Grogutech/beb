setfpscap(5)
wait(15)

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
while not localPlayer do
    task.wait()
    localPlayer = Players.LocalPlayer
end

local playerName = localPlayer.Name

local defaultConfig = {
    ADD_FRIEND = false,
    AUTO_UPDATE_RESTART = false,
    AUTO_BOUNTY_RIFT = true,
    ALWAYS_INFINITY_ELIXIR = true,
    
    PURCHASE_ALIENSHOP = true,
    PURCHASE_BLACKMARKET = true,
    PURCHASE_DICE_MERCHANT = true,
    PURCHASE_STARSHOP_SLOT = 14,
    ENABLE_EXIT = false,
    RESTOCK_SHOP = "Blackmarket",

    IGNORE_MINIGAME = false,
    
    SERVERHOP_EGG = false,
    
    USE_DICE_KEY = true,
    USE_ROYAL_KEY = true,
    USE_GOLDEN_KEY = false,
    USE_MYSTERY_BOX = true,


    RARITY_TO_SHINY = {"Common", "Unique", "Rare", "Epic", "Legendary"},
    RARITY_TO_DELETE = {"Common", "Unique", "Rare", "Epic", "Legendary"},
    DELETE_LEGENDARY_SHINY = true,
    
    MAX_LEGENDARY_TIER_TO_DELETE = 2,
    USE_GEMS_ENCHANT = true,
    
    ENCHANT_TEAMUP = true,
    ENCHANT_TEAMUP_TIER = 1,
    ENCHANT_HIGH_ROLLER = true,
    INFINITY_EGG_TYPE = "World1",

    RIFT_EGGS = {"Silly Egg", "Underworld Egg", "Cyber Egg"},
    HATCH_1X_EGG = {"Cyber Egg"},
    WEBHOOK_URL = dc_webhook,
    DISCORD_ID = "314107374715535370",
    WEBHOOK_ODDS = 3500,
    SHOW_PET_WEBHOOK_USERNAME = true,
    POTIONS_TO_CRAFT = {"Coins", "Mythic", "Lucky", "Speed"},
    IGNORE_MYSTERY_BOX_GEM_CAP = true,
    IGNORE_GIANT_VOID_CHEST = true
}

local customConfigs = {
    ["GalacticVana"] = {
        INFINITY_EGG_TYPE = "World1",
        SKIP_MINIGAME = "Robot Claw",
        RIFT_EGGS = {"Silly Egg", "Void Egg", "Hell Egg", "Nightmare Egg"},
        HATCH_1X_EGG = {"Infinity Egg"},
        AUTO_BOUNTY_RIFT = false,
        RARITY_TO_SHINY = {"Common", "Unique", "Rare", "Epic"},
    },
}

local playerConfig = customConfigs[playerName] or {}
for key, value in pairs(playerConfig) do
    defaultConfig[key] = value
end

getgenv().bgsInfConfig = defaultConfig

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e2d15fd8d5fd053a359cc3e296c68150.lua"))()
