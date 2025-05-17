script_key="";

getgenv().Settings = {
    ["Open Egg"] = "200M Egg",

    ["Target Rifts"] = {"Underworld Egg"},
    ["Minimum Rift Luck"] = 10,
    ["Target Highest Luck"] = true,

    ["Webhook"] = dc_webhook,
    ["Discord ID"] = "314107374715535370",
    ["Minimum Send Difficulty"] = "1k",

    ["Trade Users"] = {"GalacticVana"},

    ["Debug"] = {
        DisableUI = false,
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fb6f3bc2f2e7dd88042fac40addd4d57.lua"))()
