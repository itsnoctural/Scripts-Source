-- Link: https://www.roblox.com/games/13569014409/FREE-UGC-99-Lose-Obby
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local TeleportService = game:GetService('TeleportService')
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Highlight = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("99Lose | EsohaSL")

Window:Section("esohasl.com")

Window:Toggle("Highlight Glasses", {}, function(state)
    task.spawn(function()
        Settings.Highlight = state
        while true do
            if not Settings.Highlight then return end

            for _, v in ipairs(Workspace.Glass:GetChildren()) do
                v.Transparency = v.Breaks.Value and 1 or 0;
            end

            task.wait()
        end
    end)
end)

Window:Button("Finish Obby", function()
    task.spawn(function()
        local RowValue = 1

        while RowValue ~= 73 and task.wait() do
            for _, v in ipairs(Workspace.Glass:GetChildren()) do
                if v.Row.Value == RowValue and not v.Breaks.Value then
                    LocalPlayer.Character:PivotTo(v:GetPivot() * CFrame.Angles(0, 0, math.rad(-90)) + Vector3.new(0, 3.5, 0));
                    RowValue = RowValue + 1; task.wait(.15)
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
