-- Configuration
local Config = {
    autoMailEnabled = true,
    delayBetweenMails = 10,
    delayBetweenItems = 1,
    defaultMinimum = 1,
    recipient = "ModusPet",
}

-- Flattened item definitions with class indicating category
local ItemsToMail = {
    ["Crystal Key"] = { minimum = 1, class = "Misc" },
    ["Crystal Key Lower Half"] = { minimum = 5, class = "Misc" },
    ["Crystal Key Upper Half"] = { minimum = 5, class = "Misc" },
    ["Secret Key"] = { minimum = 1, class = "Misc" },
    ["Instant Luck Potion"] = { minimum = 1, class = "Consumable", checkTier = 4 },
    ["Fishing Bait"] = { minimum = 1, class = "Consumable", checkTier = 5 },
}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage:WaitForChild("Network")
local MailboxSend = Network:WaitForChild("Mailbox: Send")

-- Modules
local SaveModule = require(ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save"))

if not SaveModule then
    return
end

-- Helper function to send mail with error handling
local function sendMail(itemName, category, index, amount, displayName)
    if not Config.recipient then
        return false
    end
    
    local success, result = pcall(function()
        return MailboxSend:InvokeServer(
            Config.recipient,
            displayName or itemName,
            category,
            index,
            amount
        )
    end)
    
    if not success then
        return false
    end
    return true
end

-- Enhanced item checking function
local function shouldMailItem(item, itemConfig)
    if not item or not itemConfig then
        return false
    end
    
    local minimumRequired = itemConfig.minimum or Config.defaultMinimum
    local currentAmount = item._am or 1
    
    if itemConfig.checkTier and item.tn ~= tonumber(itemConfig.checkTier) then
        return false
    end
    
    return currentAmount >= minimumRequired
end

-- Improved inventory processing
local function processInventory(inventory)
    if type(inventory) ~= "table" then
        return
    end
    
    local mailsSent = 0
    for category, items in pairs(inventory) do
        if type(items) == "table" then
            for index, item in pairs(items) do
                if item and item.id then
                    local itemConfig = ItemsToMail[item.id]
                    if itemConfig and itemConfig.class == category then
                        if shouldMailItem(item, itemConfig) then
                            local displayName = itemConfig.displayName or item.id
                            if sendMail(item.id, category, index, item._am or 1, displayName) then
                                mailsSent = mailsSent + 1
                            end
                            task.wait(Config.delayBetweenItems)
                        end
                    end
                end
            end
        end
    end
end

-- Enhanced main loop with proper error handling
local function autoSendMail()
    if not Config.autoMailEnabled then
        return
    end
    
    local success, err = pcall(function()
        local saveData = SaveModule.Get()
        if saveData and saveData.Inventory then
            processInventory(saveData.Inventory)  
        end
    end)
    
    if not success then
        warn("Critical error in autoSendMail:", err)
    end
    
    warn("autoSendMail function completed")
end

-- Initialize
pcall(function()
    task.spawn(function()
        warn("Starting auto mail system...")
        autoSendMail()
        warn("Initial auto mail completed")
    end)
end)
