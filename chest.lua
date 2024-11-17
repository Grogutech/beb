getgenv().OldCFrame = nil
getgenv().Enabled = true

getgenv().Limits = {
    ["Blue"] = 1,
    ["Purple"] = 10
}

local SaveModule = require(game.ReplicatedStorage.Library.Client.Save)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local PlayerCharacter = Workspace:WaitForChild(Players.LocalPlayer.Name)
local PlayerHumanoidRootPart =PlayerCharacter:FindFirstChild("HumanoidRootPart")

local PositionBlueChest = CFrame.new(-23.4127789, 3.60205817, 171.047852, -0.859449804, -2.70322804e-08, 0.511220098, 1.88000246e-08, 1, 8.44840713e-08, -0.511220098, 8.22207724e-08, -0.859449804)
local PositionSecretChest = CFrame.new(215.447311, -116.493744, -150.387924, 0.100747772, 2.0890738e-08, 0.994912028, 7.33217131e-09, 1, -2.17400515e-08, -0.994912028, 9.48512735e-09, 0.100747772)

-- PlayerCharacter:SetPrimaryPartCFrame(PositionBlueChest)

setclipboard(HttpService:JSONEncode(SaveModule.GetSaves()[Players.LocalPlayer].Inventory.Misc))

function OpenChest(amount, secret)
    local args = {
        [1] = amount,
        [2] = secret
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("LootChest_Unlock"):InvokeServer(unpack(args))
end

function GetItemAmount(itemName)
    local items = SaveModule.GetSaves()[Players.LocalPlayer] or {}
    items = items.Inventory.Misc

    for _, itemData in pairs(items) do
        -- Check if the item matches the specified name
        if itemData.id == itemName then
            -- Return the _am value if it exists, otherwise return 0
            return itemData._am or 0
        end
    end
    -- Return 0 if the item was not found
    return 0
end

function GetAmountOfSecretKeys()
    return GetItemAmount("Secret Key")
end

function GetAmountOfCrystalKeys()
    return GetItemAmount("Crystal Key")
end

function GetAmountOfOpensCrystalKeys()
    local Amount = GetAmountOfCrystalKeys()
    local StartingIndex = 10
    while StartingIndex > 0 do
        if Amount/StartingIndex >= 1 then
            return StartingIndex
        end
        StartingIndex = StartingIndex - 1
    end

    return 0
end

function SetCFrame()
    getgenv().OldCFrame = PlayerHumanoidRootPart.CFrame
end


while wait() do
    
    if GetAmountOfSecretKeys() >= 1 and getgenv().Enabled and GetAmountOfSecretKeys() >= getgenv().Limits.Purple then
        SetCFrame()
        PlayerCharacter:SetPrimaryPartCFrame(PositionSecretChest)

        while GetAmountOfSecretKeys() >= 1 and getgenv().Enabled do
            OpenChest(1, true)
        end

        PlayerCharacter:SetPrimaryPartCFrame(getgenv().OldCFrame)
    end
    
    if GetAmountOfOpensCrystalKeys() >= 1 and getgenv().Enabled and GetAmountOfCrystalKeys() >= getgenv().Limits.Blue then
        SetCFrame()
        PlayerCharacter:SetPrimaryPartCFrame(PositionBlueChest)

        while GetAmountOfOpensCrystalKeys() >= 1 and getgenv().Enabled do
            local amount = GetAmountOfOpensCrystalKeys()
            OpenChest(amount, false)

            if GetAmountOfSecretKeys() >= getgenv().Limits.Purple then
                break
            end
        end
        
        PlayerCharacter:SetPrimaryPartCFrame(getgenv().OldCFrame)
    end

end
