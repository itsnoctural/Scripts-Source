local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Kill = false,
}

local function Highlight(parent, isSeeker)
  local Highlight = Instance.new("Highlight")
  Highlight.Parent = parent
  Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  Highlight.FillColor = isSeeker and Color3.new(255, 0, 0) or Color3.new(0, 255, 0)
end

Players.PlayerAdded:Connect(function(player)
  Highlight(player.character, v:GetAttribute("CurrentTeam") == "Seekers")
end)

for _,v in ipairs(Players:GetPlayers()) do
  Highlight(v.Character, v:GetAttribute("CurrentTeam") == "Seekers")
  
  v.CharacterAdded:Connect(function(character)
    local Player = Players:GetPlayerFromCharacter(character);

    Highlight(character, v:GetAttribute("CurrentTeam") == "Seekers")
  end)
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("SkS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Kill Hiders", {}, function(state)
    task.spawn(function()
        Settings.Kill = state
        while true do
            if not Settings.Kill then return end

            for _,v in ipairs(Players:GetPlayers()) do
              if v:GetAttribute("CurrentTeam") == "Hiders" and v.Character:FindFirstChild("PropParts") then
                local default = v.Character.PropParts:FindFirstChild("default")

                if not default then continue; end
          
                ReplicatedStorage.RemoteObjects.GunShot:FireServer({
                  ["SourcePlayer"] = LocalPlayer,
                  ["HitPosition"] = default.Position,
                  ["HitInstance"] = default,
                  ["ShotStart"] = default.Position,
                  ["ImpactNormal"] = Vector3.new(0.95, 0, 0.25),
                  ["Damage"] = 25
                }); task.wait(.25)
              end
            end

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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
    task.wait()
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
end)