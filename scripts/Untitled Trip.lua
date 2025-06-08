-- abc.lua
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maincar = workspace.maincar.Misc.tank.tankhit.tank
local names = {"gascan", "plasticcan"}

local toFill = "oil"

for _,v in ipairs(Workspace:GetChildren()) do
  if table.find(names, v.Name) then
    local tank = v.tankhit.tank
    local liquids = tank:GetChildren() 

    if tank.Value > 0 and #liquids == 1 then
      if liquids[1].Name == toFill then
        while liquids[1].Parent ~= nil and task.wait(.1) do
          ReplicatedStorage.fill:FireServer(tank, maincar);
        end
      end
    end
  end
end

-- f.lua
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maincar = workspace.maincar

local function getLootFolder()
  for _,v in ipairs(Workspace:GetChildren()) do
    if v.Name == "Folder" and v:FindFirstChildOfClass("Model") then
      return v
    end 
  end

  return nil
end

local lootFolder = getLootFolder()

local function getNotConnected()
  local details = {}

  for _,v in ipairs(Workspace.maincar:GetDescendants()) do
    if v:FindFirstChild("mainconnector") and not v:FindFirstChild("placeweld") then
      details[v.mainconnector.ID.Value] = v.mainconnector
    end
  end

  return details
end

local notConnectedDetails = getNotConnected()

for _,v in ipairs({table.unpack(Workspace.toplace:GetDescendants()), table.unpack(lootFolder:GetDescendants())}) do
  if v:IsA("StringValue") and notConnectedDetails[v.Value] then
    if v.Value == "seat" then
      ReplicatedStorage.place:InvokeServer(notConnectedDetails[v.Value], maincar.main.mainconnector, true); continue;
    end

    ReplicatedStorage.place:InvokeServer(notConnectedDetails[v.Value], v.Parent, true);
  end
end

-- nn.lua
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maincar = Workspace.maincar

local predefined = {
    ["frontdoor"] = "frontleftdoor",
    ["leftdoor"] = "frontrightdoor",
    ["light"] = "leftlight",
    ["rearhood"] = "back"
}

local wheels = {
  ["RR"] = "wheel1",
  ["RL"] = "wheel1",
  ["FR"] = "wheel1",
  ["FL"] = "wheel1",
}

local toFix = {}

for _,v in ipairs(maincar.details:GetChildren()) do
  if v.detail.Value == nil then
    toFix[v.Name] = v.Value
  end
end

for i,v in pairs(toFix) do 
  for _,z in ipairs(Workspace:GetDescendants()) do
    if wheels[i] == z.Name then
      ReplicatedStorage.place:InvokeServer(v.mainconnector, z.connector.connector, true)
      z.Name = "wheeltakken"
      break
    end

    if not z:IsDescendantOf(maincar) and z:FindFirstChild("connector") and (i == z.Name or i == predefined[z.Name]) then
      ReplicatedStorage.place:InvokeServer(v.Part.mainconnector, z.connector.connector, true); break
    end
  end
end