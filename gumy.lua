setfpscap(15)
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
    PURCHASE_ALIENSHOP = true,
    PURCHASE_BLACKMARKET = true,
    PURCHASE_STARSHOP_SLOT = 14,
    ENABLE_EXIT = true,
    RESTOCK_SHOP = "Blackmarket",
    SERVERHOP_EGG = false,
    SKIP_MINIGAME = false,
    DO_BUBBLE_GUM = true,
    USE_DICE_KEY = true,
    USE_ROYAL_KEY = true,
    USE_GOLDEN_KEY = true,
    USE_MYSTERY_BOX = true,
    RARITY_TO_DELETE = {"Common", "Unique", "Rare", "Epic", "Legendary"},
    MAX_LEGENDARY_TIER_TO_DELETE = 1,
    USE_GEMS_ENCHANT = true,
    ENCHANT_TEAMUP = true,
    ENCHANT_TEAMUP_TIER = 2,
    ENCHANT_HIGH_ROLLER = true,
    INFINITY_EGG_TYPE = "World1",
    --RIFT_EGGS = {"Silly Egg", "Nightmare Egg", "Cyber Egg"},
    --HATCH_1X_EGG = {"Game Egg", "Cyber Egg"},
    RIFT_EGGS = {"Silly Egg", "Underworld Egg", "Rainbow Egg"},
    HATCH_1X_EGG = {"Rainbow Egg"},
    WEBHOOK_URL = dc_webhook,
    DISCORD_ID = "314107374715535370",
    WEBHOOK_ODDS = 10000,
    SHOW_PET_WEBHOOK_USERNAME = true,
    POTIONS_TO_CRAFT = {"Coins", "Mythic", "Lucky", "Speed"},
    IGNORE_MYSTERY_BOX_GEM_CAP = true,
    IGNORE_GIANT_VOID_CHEST = true,
    MIN_COINS_BEFORE_HATCHING = 1000000000
}

local customConfigs = {
    ["DarkShadow_5273"] = {
        IGNORE_MINIGAME = true,
    }
}

local playerConfig = customConfigs[playerName] or {}
for key, value in pairs(playerConfig) do
    defaultConfig[key] = value
end

getgenv().bgsInfConfig = defaultConfig

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e2d15fd8d5fd053a359cc3e296c68150.lua"))()
