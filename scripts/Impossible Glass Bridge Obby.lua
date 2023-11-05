local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Delays = {
    Default = {
        Return = 0.4,
        Try = 0.55,
        Respawn = 0.8,
    },
    Secure = {
        Return = 0.65,
        Try = 0.85,
        Respawn = 1,
    },
    Extremely = {
        Return = 1,
        Try = 1.25,
        Respawn = 1.5,
    }
}

local Settings = {
    Checking = false,
    Delay = Delays.Default
}

local Metadata = {
    Plates = {},
    Return = false,
}

function isAlive()
    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

    return Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

function CheckingPlates()
    for i = 1, 60 do
        local Child = Workspace.GlassTiles[tostring(i)]

        if not Settings.Checking then break end
        for _, v  in ipairs(Child:GetChildren()) do
            if Metadata.Return then
                for j = 1, 60 do
                    local CurrentPlate = Metadata.Plates[tostring(j)]

                    if CurrentPlate then
                        LocalPlayer.Character:PivotTo(CurrentPlate:GetPivot() + Vector3.new(0, 2.5, 0))
                        task.wait(Settings.Delay.Return)

                        if not isAlive() then Metadata.Plates = {}; return end
                    else break end
                end
            end

            if not Metadata.Plates[Child.Name] then
                LocalPlayer.Character:PivotTo(v:GetPivot() + Vector3.new(0, 2.5, 0))
                task.wait(Settings.Delay.Try)

                if isAlive() then
                    Metadata.Plates[Child.Name] = v
                    Metadata.Return = false
                    v.Transparency = 0
                else
                    LocalPlayer.CharacterAdded:Wait()
                    Metadata.Return = true
                    v.Transparency = .975
                    task.wait(Settings.Delay.Respawn)
                end
            end
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("IGBO | EsohaSL")

Window:Section("esohasl.com")

local RespawnGui = LocalPlayer.PlayerGui:FindFirstChild("Respawn")
if RespawnGui then RespawnGui:Destroy() end

Window:Toggle("Start Checking Plates", {}, function(state)
    task.spawn(function()
        Settings.Checking = state
        while true do
            if not Settings.Checking then return end

            CheckingPlates()
            task.wait(2.5)
        end
    end)
end)

Window:Section("Config")

Window:Toggle("Secure [Increased Delay]", {}, function(state)
    task.spawn(function()
        if state then
            Settings.Delay = Delays.Secure
        else
            Settings.Delay = Delays.Default
        end
    end)
end)

Window:Toggle("Extremely [Highest Delay]", {}, function(state)
    task.spawn(function()
        if state then
            Settings.Delay = Delays.Extremely
        else
            Settings.Delay = Delays.Default
        end
    end)
end)

Window:Section("Extremly if still kicked on Secure")

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
         pcall(function()
            setclipboard("https://youtube.com/@esohasl")
         end)
    end)
end)