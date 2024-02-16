local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local Frames = {
    Bubbles = PlayerGui.PointBubbles,
    Quests = PlayerGui.ScreenGui.QuestFrame.ScrollingFrame
}

getgenv().Settings = {
    Pop = false,
    Quests = false,
    Spin = false,
}

local function isThreadDead(thread)
    return not thread or coroutine.status(thread) == "dead"
end

local function isQuestCompeleted(inst)
    return inst.ClaimButton.TextLabel.Text == "Claim"
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("PBfU | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Pop Bubbles", {}, function(state)
    task.spawn(function()
        Settings.Pop = state

        for _, v in ipairs(Frames.Bubbles:GetChildren()) do
            if v.Name == "Bubble" and v.BackgroundColor3 ~= Color3.fromRGB(255,255,255) then
                firesignal(v.MouseButton1Click)
            end
        end
    end)
end)

Frames.Bubbles.ChildAdded:Connect(function(v)
    if Settings.Pop then
        firesignal(v.MouseButton1Click)
    end
end)

Window:Toggle("Auto Quests", {}, function(state)
    task.spawn(function()
        Settings.Quests = state
        while true do
            if not Settings.Quests then return end

            for _, v in ipairs(Frames.Quests:GetChildren()) do
                if v:IsA("Frame") and v.Name ~= "QuestContainer" then
                    if isQuestCompeleted(v) then
                        ReplicatedStorage.ClaimQuestReward:FireServer(v.Name);
                    end

                    if v.Name == "Clicker" then
                        if isThreadDead(ClickThread) then
                            ClickThread = task.spawn(function()
                                while Settings.Quests and not isQuestCompeleted(v) and task.wait() do
                                    ReplicatedStorage.MouseClicked:FireServer()
                                end    
                            end)
                        end
                    end

                    if v.Name == "Jumper" then
                        if isThreadDead(JumpThread) then
                            JumpThread = task.spawn(function()
                                local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                while Settings.Quests and not isQuestCompeleted(v) and task.wait(.1) do
                                    Humanoid.Jump = true
                                end   
                            end)
                        end
                    end

                    if v.Name == "Runner" then
                        if isThreadDead(RunThread) then
                            RunThread = task.spawn(function()
                                while Settings.Quests and not isQuestCompeleted(v) and task.wait(.1) do
                                    VirtualInputManager:SendKeyEvent(true, 97, false, game)
                                end  
                                
                                VirtualInputManager:SendKeyEvent(false, 97, false, game)
                            end)
                        end
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

Window:Toggle("Auto Spin", {}, function(state)
    task.spawn(function()
        Settings.Spin = state
        while true do
            if not Settings.Spin then return end

            ReplicatedStorage.RequestWheelSpin:InvokeServer();
            task.wait(1)
        end
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