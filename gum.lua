getgenv().Config = {
    ["Hatching"] = {
        ["Rifts"] = {
            ["Eggs"] = {"Silly Egg", "Throwback Egg", "Nightmare Egg"}
        },
        ["Egg"] = "Nightmare Egg"
    },
    ["Webhook"] = {
        ["MinDifficulty"] = "10k",
        ["UserID"] = "314107374715535370",
        ["URL"] = dc_webhook,
    },
    ["AutoEnchant"] = true -- // Enchant Team Up on all Equipped Pets
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6a28683e5e681161a5074613f6daf64c.lua"))()
