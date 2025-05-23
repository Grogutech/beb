setfpscap(10)

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
while not localPlayer do
    task.wait()
    localPlayer = Players.LocalPlayer
end

local playerName = localPlayer.Name

local defaultConfig = {
    AUTO_UPDATE_RESTART = true,  -- Auto restart after important updates #update channel
    ADD_FRIEND = false, -- Send friend request to everyone in server
    ENABLE_EXIT = false, -- Pressing "X" will exit game, less performance
    USE_ROYAL_KEY = true,
    USE_GOLDEN_KEY = true,
    USE_MYSTERY_BOX = true,
    IGNORE_MYSTERY_BOX_GEM_CAP = true,  -- true = Use Mystery Box Even When Gems Capped
    IGNORE_GIANT_VOID_CHEST = true,
    
    INFINITY_EGG_TYPE = "World2", -- "World1" -> Overworld | "World2" -> Minigame Paradise
    ALWAYS_INFINITY_ELIXIR = true,  -- Always keep infinity elixir active
    AUTO_BOUNTY_RIFT = false, -- Auto add current bounty rift to RIFT_EGGS [Updates Daily]
    
    SHOW_PET_WEBHOOK_USERNAME = true,  -- shows username in private webhook only
    WEBHOOK_ODDS = 5000,  -- minimum odds to send webhook
    WEBHOOK_URL = dc_webhook,
    DISCORD_ID = "314107374715535370",
    
    USE_DICE_KEY = true,
    IGNORE_MINIGAME = true,  -- Ignore all "world 2" mini games
    SKIP_MINIGAME = "",  -- Use Super Ticket -> "Pet Match" | "Cart Escape" | "Robot Claw"

    -- RARITY_TO_SHINY -> Shiny first, delete second (Shiny when max inventory)
    RARITY_TO_SHINY = {"Legendary"},
    PETS_TO_DELETE = {"Crimson Butterfly", "Crystal Unicorn"},  -- Add Pets Name To Autodelete (Delete when max inventory)
    -- RARITY_TO_DELETE -> Common, Unique, Rare, Epic, Legendary (Delete when max inventory)
    RARITY_TO_DELETE = {"Common", "Unique", "Rare", "Epic", "Legendary"},  
    DELETE_LEGENDARY_SHINY = true,  -- Include "Legendary" in RARITY_TO_DELETE
    DELETE_LEGENDARY_MYTHIC = false,  -- Include "Legendary" in RARITY_TO_DELETE
    MAX_LEGENDARY_TIER_TO_DELETE = 2,  -- Maximum legendary tier to delete, if "3" it will delete Tier 1 to 3

    USE_GEMS_ENCHANT = true, -- Use gems to enchant tier 2/3 & secret (If no more reroll orbs left)
    ENCHANT_TEAMUP = true,  -- Works after legendary+ team
    ENCHANT_TEAMUP_TIER = 1,  -- Works after legendary+ team
    ENCHANT_HIGH_ROLLER = true,

    IGNORE_STARTER_HATCH = false,  -- Ignore Starter Hatch (For P2W/Progressed Accounts)
    PURCHASE_BLACKMARKET = true,  -- Purchase All Blackmarket Items
    PURCHASE_ALIENSHOP = false,  -- Purchase All Alien Shop Items
    PURCHASE_DICE_MERCHANT = true,  -- Purchase All Dice Merchant Items

    RESTOCK_SHOP = "Blackmarket", -- ("Blackmarket", "Alien Shop", "Dice Merchant") -> Reroll specified shop after buying all 3 slots 
    POTIONS_TO_CRAFT = {"Coins", "Mythic", "Lucky", "Speed"},  -- "Coins", "Mythic", "Lucky", "Speed" (Craft ALL Tiers)
    RIFT_EGGS = {"Underworld Egg", "Neon Egg"},  -- Add Any Egg Name
    HATCH_1X_EGG = {"Chance Egg","Neon Egg"},  -- Hatch 1x Egg If No Rift & FARM_MIN_GEMS Completed
    SERVERHOP_EGG = true, -- Serverhop until HATCH_1X_EGG egg found
}

local customConfigs = {
}

local playerConfig = customConfigs[playerName] or {}
for key, value in pairs(playerConfig) do
    defaultConfig[key] = value
end

getgenv().bgsInfConfig = defaultConfig

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e2d15fd8d5fd053a359cc3e296c68150.lua"))()
