_G.ClaimMail = true;

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network_Repli = ReplicatedStorage:WaitForChild("Network")

local function ClaimMail()
    local response, err = Network_Repli:WaitForChild("Mailbox: Claim All"):InvokeServer()
    while err == "You must wait 30 seconds before using the mailbox!" do
        task.wait()
        response, err = Network_Repli:WaitForChild("Mailbox: Claim All"):InvokeServer()
    end
end

task.spawn(function()
    while _G.ClaimMail and task.wait() do
        ClaimMail()
    end
end)
