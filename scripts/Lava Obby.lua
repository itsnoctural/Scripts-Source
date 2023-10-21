local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
-- local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Obby = false,
}

getgenv().Metadata = {
    Plates = {},
    Return = false,
}

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.com")

Window:Button("Start Checking Plates", function()
    task.spawn(function()
        for i = 1, 50 do
            local Child = Workspace.Plates[tostring(i)]

            for _, z in ipairs(Child:GetChildren()) do
                if Metadata.Return then
                    for i = 1, 50 do
                        local Plate = Metadata.Plates[tostring(i)]

                        if Plate then
                            print("Trying return..")
                            --LocalPlayer.Character:PivotTo(Plate:GetPivot() + Vector3.new(0, 2.5, 0)); task.wait(.4) 
                            firetouchinterest(Plate, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0); task.wait(.4)
                        else
                            print("Huh, " .. tostring(i) .. " plate seem didnt reached.")
                            break;
                        end
                    end
                end

                if not Metadata.Plates[Child.Name] then 
                    --LocalPlayer.Character:PivotTo(z:GetPivot() + Vector3.new(0, 2.5, 0)); task.wait(.4)
                    firetouchinterest(z, LocalPlayer.Character:FindFirstChildOfClass("Part"), 0); task.wait(.4)
                    print("Plate: " .. Child.Name)

                    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                        print("Seem that correct plate...")
                        Metadata.Plates[Child.Name] = z
                        Metadata.Return = false
                    else
                        LocalPlayer.CharacterAdded:Wait();
                        Metadata.Return = true
                    end

                    task.wait(.5)
                end
            end
        end 
    end)
end)

Window:Button("Complete", function()
    task.spawn(function()
        for i = 1, 50 do
            LocalPlayer.Character:PivotTo(PlatesMeta[tostring(i)]:GetPivot())
        end
    end)
end)

-- Window:Button("YouTube: EsohaSL", function()
--    task.spawn(function()
--         pcall(function()
--             setclipboard("https://youtube.com/@esohasl")
--         end)
--    end)
-- end)

-- LocalPlayer.Idled:connect(function()
--     VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
--     task.wait()
--     VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
-- end)