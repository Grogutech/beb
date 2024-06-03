getgenv().Settings = {
    StartWith = "Sniper",

    Sniper = {
        Active = true,
       
        Items = {
            SearchTerminal = {
                --["Void Key"] = {Class = "Misc", Price = 70000},
                ["Crystal Key"] = {Class = "Misc", Price = 23500},
                --["Secret Key"] = {Class = "Misc", Price = "1%"},
                --["Mini Chest"] = {Class = "Misc", Price = "15%"},
                --["Crystal Key Upper Half"] = {Class = "Misc", Price = "1%"},
                --["Secret Key Upper Half"] = {Class = "Misc", Price = "1%"},
            },
            --["Gift Bag"] = {Class = "Misc", Price = "30%"},
            --["Large Gift Bag"] = {Class = "Misc", Price = "30%"},
            --["Mini Chest"] = {Class = "Misc", Price = "25%"},
            --["Tech Key"] = {Class = "Misc", Price = "25%"},
            --["Void Key"] = {Class = "Misc", Price = "75%"},
            --["Secret Key Upper Half"] = {Class = "Misc", Price = "1%"},
            --["Crystal Key Upper Half"] = {Class = "Misc", Price = "1%"},
        },
        
        Serverhop = true,
        TeleportDelay = 25,
        UseProPlaza = false,
        RecheckListingsDelay = 1,
    
        Webhook = "https://discord.com/api/webhooks/1243180982631272529/jojQUTtGE0hYSDMliwOEoR20JKR86XT14836JPtXoiC3QhS4lLYbaTSe3i3hsOnHyJky",
        Notifications = true,
        GlobalSnipes = true,
        RemoveUsername = false,

        SwitchToSelling = "N/A" --// TEMP. Low Diamonds, Limits Reached, .. Minutes, N/A -- Low Diamonds (50000)
    },

    Seller = {
        Active = false,

        Items = {
            ["Crystal Key"] = {Class = "Misc", Price = 31000},
            ["Secret Key"] = {Class = "Misc", Price = 72000},
        },

        Serverhop = true,
        TeleportDelay = 15,
        UseProPlaza = false,

        Webhook = "https://discord.com/api/webhooks/1243180982631272529/jojQUTtGE0hYSDMliwOEoR20JKR86XT14836JPtXoiC3QhS4lLYbaTSe3i3hsOnHyJky",
        Notifications = true,
        RemoveUsername = false,

        SwitchToSniping = "Item Runout" --// TEMP. Item Runout, Diamond Max, .. Minutes, N/A
    },

    [[ Thank you for using System Exodus <3! ]]
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f05f01a77417ee52d29956defa8037f7.lua"))()


local SERVER_URL = "http://192.168.68.54:8088"

local data = request(
    {
        Url = SERVER_URL,
        Method = "GET"
    }
)

local heartbeatDelay = game.HttpService:JSONDecode(data.Body)["heartbeatDelay"]

local function sendRequest(reqType)
    return request(
        {
            Url = SERVER_URL,
            Method = "POST",
            Body = {
                requestType = reqType,
                account = game:GetService("Players").LocalPlayer.Name
            }
        }
    )
end

sendRequest("START")

game:GetService("NetworkClient").ChildRemoved:Connect(function()
    while true do
        sendRequest("DISCONNECTED")
        task.wait(1)
    end
end)

while true do
    sendRequest("HEARTBEAT")
    task.wait(heartbeatDelay)
end
