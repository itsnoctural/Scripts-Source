local Auth = loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/Utilities/main/base.lua"))()
repeat task.wait(.1) until Auth.Finished

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

local Path = PathfindingService:CreatePath({
    AgentCanJump = false,
    AgentCanClimb = false,
    WaypointSpacing = 1,
    Costs = {
        Climb = 5,
    }
})

local AdditionalTime = 0.25

local Modules = {
    Dishes = require(ReplicatedStorage.Modules.Dictonaries.Portable["D_Dishes"]),
    Ingredients = require(ReplicatedStorage.Modules.Dictonaries.Portable["D_Ingredients"]),
    PlateHandler = require(ReplicatedStorage.Modules.Client["Client_Plate_Handler"])
}

getgenv().Debug = false;

getgenv().Settings = {
    Farm = false,
    Take = false,
    Serve = false,
    Clean = false,
    Pathfinding = true, 
}

local DinerPlace = Workspace.DinerPlaceHolder

for _,v in ipairs({
    table.unpack(DinerPlace.Buyables:GetDescendants()), 
    table.unpack(DinerPlace.Sittables:GetDescendants())
}) do
    if v:IsA("Part") or v:IsA("MeshPart") then
        v.CanCollide = false;
    end
end

local function debug(message)
    if Debug then print("[Debug] " .. message) end
end

local function instantTeleport(pos)
    LocalPlayer.Character:PivotTo(CFrame.new(pos));
end

local function pathFindingTo(destination)
    if not Settings.Pathfinding then
        instantTeleport(destination); task.wait(AdditionalTime)
    else
        local isSuccess, errorMessage = pcall(function()
            Path:ComputeAsync(LocalPlayer.Character:GetPivot().Position, destination)
        end)

        if isSuccess and Path.Status == Enum.PathStatus.Success then
            local Waypoints = Path:GetWaypoints()

            -- local Folder = Instance.new("Folder", Workspace)
            -- Folder.Name = "Vizualization"
            -- for i = 1, #Waypoints do
            --     local Part = Instance.new("Part", Folder)
            --     Part.Shape = Enum.PartType.Ball
            --     Part.Size = Vector3.new(.2,.2,.2)
            --     Part.Anchored = true
            --     Part.Position = Waypoints[i].Position
            --     Part.Material = Enum.Material.Neon
            --     Part.Color = Color3.fromRGB(200,200,255)
            --     Part.CanCollide = false
            -- end

            for i = 2, #Waypoints do
                Humanoid:MoveTo(Waypoints[i].Position)
                Humanoid.MoveToFinished:Wait()
            end

            -- task.delay(1, function()
            --     Folder:Destroy()
            -- end)
        else
            instantTeleport(destination); task.wait(AdditionalTime)
        end
    end
end

function hasIngredient(name)
    return ReplicatedStorage["R_Data"]["F_Ingredients"]:GetAttribute(name) > 0
end

function buyIngredient(name)
    ReplicatedStorage.Remotes.Purchase:InvokeServer("Ingredient", {
        ["Ingredient_Name"] = name,
        ["Quantity"] = 1,
    });
end

function buyIngredientIfNotHas(name)
    if not hasIngredient(name) then buyIngredient(name) end
end

function cookIngredient(stationName, ingredientName)
    for _,v in ipairs(DinerPlace.Stations:GetChildren()) do
        if string.find(v.Name, stationName) then
            ReplicatedStorage.Remotes.Cook:InvokeServer("AcquireIngredient", {
                ["Storage"] = true,
                ["Ingredient"] = ingredientName
            }); task.wait(AdditionalTime)

            local stationSlots = v.Connectables:GetChildren()
            local slot = stationSlots[math.random(1, #stationSlots)]

            ReplicatedStorage.Remotes.Cook:InvokeServer("CookIngredient", {
                ["Target"] = slot,
                ["CFrame"] = slot.CFrame,
                ["Station"] = v,
                ["Ingredient"] = ingredientName
            }); task.wait(Modules.Ingredients[ingredientName].Method.Time + AdditionalTime)

            for _,v in ipairs(DinerPlace.Temporary:GetChildren()) do
                if v:FindFirstChild("Station_Obj") then
                    ReplicatedStorage.Remotes.Cook:InvokeServer("GrabIngredient", {
                        ["Objects"] = {v},
                        ["Ingredient"] = "Cooked_Patty"
                    });

                    task.wait(AdditionalTime)
                    
                    ReplicatedStorage.Remotes.Cook:InvokeServer("StoreIngredient", {
                        ["Storage"] = true,
                        ["Ingredient"] = "Cooked_Patty"
                    })
                end
            end

            break;
        end
    end
end

function cookDish(name)
    local Dish = Modules.Dishes[name]

    if Dish then
        ReplicatedStorage.Remotes.ChangeMenu:InvokeServer(name, "CreatePlate"); task.wait(AdditionalTime)

        for _,v in ipairs(Dish.Ingredients) do
            if not hasIngredient(v) and Modules.Ingredients[v].Predecessor then
                local Predecessor = Modules.Ingredients[v].Predecessor
                local Method = Modules.Ingredients[Predecessor].Method

                buyIngredientIfNotHas(Predecessor)

                cookIngredient(Method.Station, Predecessor); task.wait(AdditionalTime)
            else 
                buyIngredientIfNotHas(v) 
            end

            ReplicatedStorage.Remotes.Cook:InvokeServer("PlaceIngredient", {
                ["Plate"] = LocalPlayer.Character.PlatePlaceHolder,
                ["Ingredient"] = v
            }); 

            task.wait(AdditionalTime)
        end 

        debug("Finished.")
    end
end

function getActiveSittables(callback) -- callback: () -> any
    for _,v in ipairs(DinerPlace.Sittables:GetChildren()) do
        local sittingNPCs = v:GetAttribute("SittingNPCs")

        if sittingNPCs and sittingNPCs > 0 then
            callback(v)
        end
    end
end

function takeOrders()
    getActiveSittables(function(sittable)
        if not sittable:GetAttribute("Order_Taken") then
            pathFindingTo(sittable.Waypoint.Position);
            debug("Taking order..")
            fireproximityprompt(sittable.PartBase.Attachment.TakeOrder); 
            task.wait(3.5)
            debug("Done.")
        end
    end)
end

function serveOrders() 
    getActiveSittables(function(sittable)
        if sittable:GetAttribute("Order_Taken") then
            for _,v in ipairs(sittable:GetChildren()) do
                if v:IsA("ObjectValue") and v.Value then
                    local Object = v.Value

                    if Object.Name == "NPC" and not Object:GetAttribute("Served") then
                        task.spawn(function()
                            pathFindingTo(sittable.Waypoint.Position);
                            debug("Pathfinded.")
                        end)

                        debug("Cooking..." .. v.Name)
                        cookDish(v.Name);
                        debug("Finished. Now to NPC")

                        for _, j in ipairs(Object.Head:GetDescendants()) do
                            if j:IsA("ProximityPrompt") then
                                while not Object:GetAttribute("Served") and Settings.Farm do
                                    fireproximityprompt(j); task.wait(AdditionalTime * 2)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

function cleanPlates()
    local DishSink = nil

    for _,v in ipairs(DinerPlace.Stations:GetChildren()) do
        if string.find(v.Name, "Dish_Sink") then
            DishSink = v; break
        end
    end

    for _,v in ipairs(DinerPlace.Temporary:GetChildren()) do
        if v.Name == "PlatePlaceHolder" and v:FindFirstChild("TablePlate") then
            pathFindingTo(v.TablePlate.Value.Parent.Waypoint.Position);
            Modules.PlateHandler:InteractWithPlateOrPlatter(v); task.wait(AdditionalTime)
            ReplicatedStorage.Remotes.UseSink:InvokeServer("PutPlateInSink", DishSink)
        end
    end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("DS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm", {}, function(state)
    task.spawn(function()
        Settings.Farm = state
        while true do
            if not Settings.Farm then return end

            if Settings.Take then takeOrders() end
            if Settings.Serve then serveOrders() end
            if Settings.Clean then cleanPlates() end

            task.wait(1)
        end
    end)
end)

Window:Section("Config")

Window:Dropdown("Method", {list = {"Pathfinding", "Teleport"}}, function(var)
    task.spawn(function()
        Settings.Pathfinding = var == "Pathfinding"
    end)
end)

Window:Toggle("Take Orders", {}, function(state)
    task.spawn(function()
        Settings.Take = state
    end)
end)

Window:Toggle("Serve Orders", {}, function(state)
    task.spawn(function()
        Settings.Serve = state
    end)
end)

Window:Toggle("Clean Plates", {}, function(state)
    task.spawn(function()
        Settings.Clean = state
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