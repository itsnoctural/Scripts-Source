local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Default = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("CDT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Notebooks", {}, function(state)
  task.spawn(function()
    Settings.Default = state
    while true do
      if not Settings.Default then return end

      for _,v in ipairs(game["Workspace"]:GetChildren()) do
        if v:FindFirstChild("Part") then
            game["ReplicatedStorage"].Remotes.Collectibles.TryToCollect:FireServer(v.Part); task.wait(.1)
        end
      end

      task.wait(.25)
    end
  end)
end)

Window:Button("Infinite Yield", function()
  task.spawn(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
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