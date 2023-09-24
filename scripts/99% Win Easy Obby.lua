-- Link: https://www.roblox.com/games/13569014409/FREE-UGC-99-Lose-Obby
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local TeleportService = game:GetService('TeleportService')
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Highlight = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("99Win | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Highlight Glasses", {}, function(state)
    task.spawn(function()
        Settings.Highlight = state
        while true do
            if not Settings.Highlight then return end

            for _, v in ipairs(Workspace.Stage:GetChildren()) do
                for _, z in ipairs(v:GetChildren()) do
                    z.Transparency = z.Value.Value and 0 or 1;
                end
            end

            task.wait()
        end
    end)
end)

Window:Button("Finish Obby", function()
    task.spawn(function()
        local StagesQuantity = #Workspace.Stage:GetChildren()

        for i = 1, StagesQuantity do
            for _, z in ipairs(Workspace.Stage["Stage_" .. tostring(i)]:GetChildren()) do
                if z.Value.Value then
                    LocalPlayer.Character:PivotTo(z:GetPivot() + Vector3.new(0, 3.5, 0)); task.wait(.25)
                end
            end
        end
    end)
end)

Window:Button("Rejoin Server", function()
    task.spawn(function()
        local ServersList = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))

        for _, z in pairs(ServersList.data) do
            if z.playing ~= z.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, z.id)
            end
        end
    end)
end)

Window:Button("YouTube: EsohaSL", function()
   task.spawn(function()
        pcall(function()
            setclipboard("https://youtube.com/@esohasl")
        end)
   end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)