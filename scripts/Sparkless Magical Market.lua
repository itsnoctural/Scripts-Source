-- local Services = game:GetService("ReplicatedStorage").Packages["_Index"]["dig1t_knit@1.7.1"].knit.Services

-- for i = 1,10 do
--   Services.LevelService.RF.CompleteFirstTimeTutorial:InvokeServer(); task.wait()
-- end

-- for _,v in ipairs({18832882139, 18832890530, 18832927654, 18832935248}) do
--   Services.ShopService.RF.PurchaseUGC:InvokeServer(v)
-- end

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Services = ReplicatedStorage.Packages._Index["dig1t_knit@1.7.1"].knit.Services

getgenv().Settings = {
  Help = false,
  Buy = false,
  Stock = false,
}

local StoreObject = LocalPlayer:GetAttribute("StoreObject")
local FloorId = Workspace.PlayerMarkets[StoreObject].Floor:GetAttribute("FloorId")

local function GetAllSupplies()
  local Supplies = {}

  for _,v in ipairs(Workspace:GetChildren()) do
    if v:GetAttribute("IsShelf") and v:GetAttribute("ParentFloorId") == FloorId then
      table.insert(Supplies, v); 
    end
  end

  return Supplies
end

local function GetRegisterReplicaId()
  local ReplicaId = nil

  for _,v in ipairs(Workspace:GetChildren()) do
    if v.Name == "RoxiCashRegister" and v:GetAttribute("ParentFloorId") == FloorId then
      ReplicaId = v:GetAttribute("ReplicaId"); break
    end
  end

  return ReplicaId
end

local function GetActivateButton()
  local Button = nil

  for _,v in ipairs(LocalPlayer.PlayerGui.ProximityPrompts:GetChildren()) do 
      if v.Background.ActionText.Text == "Activate" then 
        Button = v.Background.Button
      end
  end

  return Button
end

local RegisterReplicaId = GetRegisterReplicaId()
local ActivateButton = GetActivateButton()

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("SMMT | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Help", {}, function(state)
    task.spawn(function()
        Settings.Help = state
        while true do
            if not Settings.Help then return end

            for _,v in ipairs(GetAllSupplies()) do
              Services.CustomerService.RF.PurchaseItemsInCart:InvokeServer(FloorId, RegisterReplicaId, {
                [v:GetAttribute("ReplicaId")] = {
                  ["FallenStarCandy"] = 1
                }
              }); task.wait(.1)
            end

            task.wait()
        end
    end)
end)

Window:Toggle("Auto Buy Candy", {}, function(state)
  task.spawn(function()
      Settings.Buy = state
      while true do
          if not Settings.Buy then return end

          local MaxQuantity = LocalPlayer.leaderstats.Charms.Value / 8
          Services.ShopService.RF.PurchaseItem:InvokeServer("FallenStarCandy", MaxQuantity > 1 and math.floor(MaxQuantity) or 1)

          task.wait(1.75)
      end
  end)
end)

Window:Toggle("Auto Stock Candy", {}, function(state)
  task.spawn(function()
      Settings.Stock = state
      while true do
          if not Settings.Stock then return end

          for _,v in ipairs(GetAllSupplies()) do
            Services.PlacementService.RF.ProcessPropInput:InvokeServer(v:GetAttribute("ParentFloorId"), v:GetAttribute("ReplicaId"), "stockShelf", "FallenStarCandy"); task.wait()
          end

          task.wait(.75)
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