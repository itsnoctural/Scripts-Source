local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Oil = false,
    Blood = false,
    Mysterious = false,
}

-- credits to RegularVynixu
function teleportToPoint(vec3)
	local bV = Instance.new("BodyVelocity")
	bV.Velocity, bV.MaxForce = Vector3.new(), Vector3.new(9e9, 9e9, 9e9); bV.Parent = Root

	local reached = false
	local connection = RunService.Stepped:Connect(function(_, step)
        local Root = LocalPlayer.Character.HumanoidRootPart
        Root.Anchored = true
        local PlayerPos = LocalPlayer.Character:GetPivot().Position
		local diff = vec3 - PlayerPos

		LocalPlayer.Character:PivotTo(CFrame.new(PlayerPos + diff.Unit * math.min(50 * step, diff.Magnitude)))
		
		if (Vector3.new(vec3.X, 0, vec3.Z) - Vector3.new(PlayerPos.X, 0, PlayerPos.Z)).Magnitude < 0.1 then
			LocalPlayer.Character:PivotTo(CFrame.new(vec3))
            Root.Anchored = false

            reached = true
		end
	end)

	repeat task.wait() until reached

	connection:Disconnect()
    bV:Destroy()
end

local function QuestItem(name)
    local Item = nil
    local StartDist = math.huge

    for _, v in ipairs(Workspace:GetChildren()) do
        if v.Name == name then
            local Handle = v:FindFirstChild("Handle")

            if Handle and Handle:FindFirstChild("ProximityPrompt") and Handle.Position.Y > 50 then
                local Distance = LocalPlayer:DistanceFromCharacter(v:GetPivot().Position)
            
                if Distance < StartDist then
                    StartDist = Distance
                    Item = Handle
                end
            end
        end
    end

    if Item then
        teleportToPoint(Item:GetPivot().Position);

        if Item.Parent and Item:FindFirstChild("ProximityPrompt") then
            fireproximityprompt(Item.ProximityPrompt);
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("WT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Oil Cups", {}, function(state)
    task.spawn(function()
        Settings.Oil = state
        while true do
            if not Settings.Oil then return end

            QuestItem("oil")
            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Blood Cups", {}, function(state)
    task.spawn(function()
        Settings.Blood = state
        while true do
            if not Settings.Blood then return end

            QuestItem("blood")
            task.wait(.5)
        end
    end)
end)

Window:Toggle("Auto Mysterious Cups", {}, function(state)
    task.spawn(function()
        Settings.Mysterious = state
        while true do
            if not Settings.Mysterious then return end

            QuestItem("mysterious cup")
            task.wait(.5)
        end
    end)
end)

Window:Button("Teleport to Craft", function()
    task.spawn(function()
        LocalPlayer.Character:PivotTo(CFrame.new(-360, 32, -322))
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