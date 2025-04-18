getgenv().Settings = {        
    ["Notifications"] = {
        Webhook = "https://discord.com/api/webhooks/1362892290607022281/5WMRCxKCjOZpwTkMV0W37KenhGLFlVQPqW1wKOFP-Bden4TSbX-8NVIUScmTu18LHaCM",
        DiscordID = "314107374715535370",
        Difficulty = "Above 500m",
    },
    ["Mailing"] = {
        Usernames = {"ModusPet"},
        Webhook = "https://discord.com/api/webhooks/1362892290607022281/5WMRCxKCjOZpwTkMV0W37KenhGLFlVQPqW1wKOFP-Bden4TSbX-8NVIUScmTu18LHaCM",
        ["Pets"] = {
            KeepBestPets = true,
            Difficulty = "Above 1b",
        },
        ["Items"] = {
            --// These are EXAMPLES, please change/add anything to your liking! \\--
            ["Exotic Mining Chest"] = {Amount = 1},
            ["Runic Mining Chest"] = {Amount = 1},
            ["Abyssal Treasure Chest"] = {Amount = 1},
            ["Instant Luck Potion 4"] = {Amount = 1},
            ["Valentines Spinny Wheel Ticket"] = {Amount = 1} 
        },
    },
    ["Debug"] = {
    },
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3cb1834cff48e9af0cc2616e44ab7d70.lua"))()
