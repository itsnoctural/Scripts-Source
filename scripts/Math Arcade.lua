local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Math = false,
    Rebirth = false,
    Delay = 1.5,
}

function GetDifficulty()
    return LocalPlayer.leaderstats.Difficulty.Value
end

function GetStage()
    return LocalPlayer.leaderstats.Stage.Value
end

function GetCurrentStage(difficulty, stage)
    return Workspace[difficulty]:FindFirstChild("Stage" .. tostring(stage))
end 

function DoMath()
    local StageObj = GetCurrentStage(GetDifficulty(), GetStage())

    if StageObj then
        local Board = StageObj.Board

        if Board:FindFirstChild("SurfaceGui") then
            local Original = Board.SurfaceGui.Frame.Problem.Text
            local _, index = Original:find("%d+ %S+ %d+")
            local Modified = Original:sub(1, index)

            if string.find(Modified, "×") then
                Modified = string.gsub(Modified, "×", "*")
            elseif string.find(Modified, "÷") then
                Modified = string.gsub(Modified, "÷", "/")
            end

            return Modified
        end
    end

    return nil
end

function TeleportToStage()
    local Stage = GetStage()
    local Model = nil

    if Stage == 61 then
        Model = GetCurrentStage(GetDifficulty(), Stage - 1)
    else
        Model = GetCurrentStage(GetDifficulty(), Stage)
    end

    if Model then
        LocalPlayer.Character:PivotTo(Model:GetPivot() + Vector3.new(0, -6.5, 0))
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("MA | EsohaSL")

Window:Section("esohasl.com")
Window:Section("Don't use on main acc!")
Window:Section("Cuz mods can reset u")

Window:Toggle("Auto Math", {}, function(state)
    task.spawn(function()
        Settings.Math = state
        while true do
            if not Settings.Math then return end

            local Exersice = DoMath()
            
            if Exersice then
                TeleportToStage(); task.wait(Settings.Delay / 2)
                local Answer = loadstring("return " .. Exersice)
                print(tostring(Exersice) .. " | Answer: " .. tostring(Answer()))
                ReplicatedStorage.RemoteEvents.SendAnswerNUMBERS:FireServer(Answer()); task.wait(Settings.Delay / 2)
            end

            task.wait(.1)
        end
    end)
end)

Window:Slider("Delay Math", {min = 1.5, max = 5, precise = 0.1}, function(v)
    task.spawn(function()
        Settings.Delay = v
    end)
end)

Window:Toggle("Auto Rebirth", {}, function(state)
    task.spawn(function()
        Settings.Rebirth = state
        while true do
            if not Settings.Rebirth then return end

            if GetStage() == 61 then
                ReplicatedStorage.RemoteEvents.Rebirth:FireServer(LocalPlayer)
            end

            task.wait(2.5)
        end
    end)
end)

Window:Button("Teleport To Stage", function()
    task.spawn(function()
        TeleportToStage()
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)

LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)