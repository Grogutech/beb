local a = require(game:GetService("ReplicatedStorage").Library.Directory.Upgrades)
local plr = game.Players.LocalPlayer
local v3 = require(game.ReplicatedStorage.Library.Client.CurrencyCmds)

function data()
    return require(game:GetService("ReplicatedStorage").Library.Client.Save).Get()
end

-- Auto Upgrade
function getcoin()
    for i, v in pairs(a) do
        if not table.find(data().UpgradesPurchased, i) and v.Price then
            for _, price in pairs(v.Price) do
                if price._data.id == "Fishing Token" or 
                   (price._data.id == "Coins" and v3.Get("Coins") >= price._data._am) then
                    game.ReplicatedStorage.Network.Upgrades_Purchase:InvokeServer(i)
                end
            end
        end
    end
end

-- Periodic coin collection
spawn(function()
    while wait(60) do
        pcall(getcoin)
    end
end)

getcoin()
