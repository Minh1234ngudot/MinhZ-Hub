--[[
            ╔══════════════════════════════════════════════╗
            ║                                              ║
            ║   ███╗   ███╗██╗███╗   ██╗██╗  ██╗███████╗   ║
            ║   ████╗ ████║██║████╗  ██║██║  ██║╚══███╔╝   ║
            ║   ██╔████╔██║██║██╔██╗ ██║███████║  ███╔╝    ║
            ║   ██║╚██╔╝██║██║██║╚██╗██║██╔══██║ ███╔╝     ║
            ║   ██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗   ║
            ║   ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝   ║
            ║   Global TAS | Made By MinhZ And tomato.txt  ║
            ║                                              ║
            ╚══════════════════════════════════════════════╝

     Original Version: https://github.com/ImMejor35/Global-TAS/tree/main
            Note: This Is A Remake Version With MinhZ Library
]]--




local MinhZ = loadstring(game:HttpGet("https://minhz-hub.vercel.app/MinhZ_Library"))()
local Windows = MinhZ:CreateWindow("⚡ MinhZ Hub - Global TAS ⚡")

Windows:SetTheme("Cyber")

MinhZ:Notify({
    Title = "MinhZ Hub",
    Description = "Script Loaded Successfully! Enjoy.",
    Duration = 3,
    Type = "Success"
})

local infoTab = Windows:CreateTab("Info")
local controlTab = Windows:CreateTab("Control")

infoTab:CreateSection("Info")
local Info = infoTab:CreateInfo()

Info:AddButton("Copy JobID", function()
    setclipboard(game.JobId)
    MinhZ:Notify({Title = "Success", Description = "Job ID copied!", Type = "Success"})
end)

Info:AddButton("Rejoin Server", function()
    MinhZ:Notify({Title = "System", Description = "Rejoining...", Type = "Warning"})
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end)

infoTab:CreateDropdown("UI Theme", {"Purple", "Blue", "Red", "Green", "Dark", "Sakura", "Ocean", "Midnight", "Light", "Cyber"}, function(theme)
    Windows:SetTheme(theme)
    MinhZ:Notify({
        Title = "Theme Changed",
        Description = "Applied " .. theme .. " theme!",
        Duration = 2,
        Type = "Success"
    })
end)

infoTab:CreateSection("Others")

local label = infoTab:CreateLabel("Thank You Guy For Use My Script")

infoTab:CreateButton("Join Discord For More Support", function()
    setclipboard("https://discord.gg/q2DzqWgpTC")
    MinhZ:Notify({Title = "MinhZ Hub", Description = "Discord Link Copied To Clipboard!", Duration = 3, Type = "Success"})
end)

infoTab:CreateButton("Donate With RoEarn, Pls Is Free🥲😢", function()
    setclipboard("BFCWRYHE")
    MinhZ:Notify({Title = "MinhZ Hub", Description = "Copied To Clipboard!", Duration = 3, Type = "Success"})
end)

infoTab:CreateSection("Credits Hub")
local label = infoTab:CreateLabel("Main Developer: 👑 Tomato 👑 And Remake By ⭐ MinhZ ⭐")

controlTab:CreateSection("Control")

controlTab:CreateButton("Start Recording", function()
    StartRecord()
end)

controlTab:CreateButton("Stop Recording", function()
    StopRecord()
end)

controlTab:CreateButton("Play TAS", function()
    PlayTAS()
    MinhZ:Notify({ Title = "MinhZ Hub", Description = "Playing TAS...", Duration = 3, Type = "Info"})
end)

controlTab:CreateKeybind("Play TAS BIND", Enum.KeyCode.E, function()
    PlayTAS()
end)

controlTab:CreateKeybind("Stop Recording BIND", Enum.KeyCode.Q, function()
    StopRecord()
end)
