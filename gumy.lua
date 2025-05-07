setfpscap(15)  -- number = fps

getgenv().bgsInfConfig = {
    ADD_FRIEND = true,
    AUTO_UPDATE_RESTART = true,
    PURCHASE_ALIENSHOP = true,
    PURCHASE_BLACKMARKET = true,
    PURCHASE_STARSHOP_SLOT = 14,
    RESTOCK_SHOP = "Blackmarket",
    
    USE_DICE_KEY = true,
    USE_ROYAL_KEY = true,
    USE_GOLDEN_KEY = true,
    USE_MYSTERY_BOX = true,

    RARITY_TO_DELETE = {"Common", "Unique", "Rare", "Epic"},
    LEGENDARY_TIER_TO_DELETE = 1,
    
    USE_GEMS_ENCHANT = true,
    ENCHANT_TEAMUP = true,
    ENCHANT_TEAMUP_TIER = 5,
    INFINITY_EGG_TYPE = "World2",
    RIFT_EGGS = {"Silly Egg", "Nightmare Egg", "Game Egg", "Cyber Egg"},
    HATCH_1X_EGG = "Game Egg", 

    WEBHOOK_URL = dc_webhook,
    DISCORD_ID = "314107374715535370",
    WEBHOOK_ODDS = 10000,
    SHOW_PET_WEBHOOK_USERNAME = true,
    POTIONS_TO_CRAFT = {"Mythic", "Speed", "Lucky"},
    IGNORE_MYSTERY_BOX_GEM_CAP = true,
    IGNORE_GIANT_VOID_CHEST = true,
    MIN_COINS_BEFORE_HATCHING = 1000000000,
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e2d15fd8d5fd053a359cc3e296c68150.lua"))()
