local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Shoes = false,
    Condition = 60,
    Price = 0,
    Sell = false,
}

local GameHolder = LocalPlayer.ReplicatedInfo.GameHolder.Value
local ObjectHolder = GameHolder.InnerShop.Base.ObjectHolder

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("ShStS | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Purchase Shoes", {}, function(state)
    task.spawn(function()
        Settings.Shoes = state
        while true do
            if not Settings.Shoes then return end

            local SellerOffer = ReplicatedStorage.Remotes.SellerRemote:InvokeServer()

            if SellerOffer and SellerOffer.condition and SellerOffer.price then
                if SellerOffer.condition >= Settings.Condition and SellerOffer.price >= Settings.Price then
                    ReplicatedStorage.Remotes.OfferRemote:FireServer(true, 1)
                else
                   ReplicatedStorage.Remotes.OfferRemote:FireServer(false)
                end
            end

            task.wait(.5)
        end
    end)
end)


Window:Section("Default Min Condition: 60%")

Window:Box('Minimal Condition:', {}, function(input)
    task.spawn(function()
        if tonumber(input) then
            Settings.Condition = tonumber(input)
        end
    end)
end)

Window:Section("Default Min Price: 0")

Window:Box('Minimal Price:', {}, function(input)
    task.spawn(function()
        if tonumber(input) then
            Settings.Price = tonumber(input)
        end
    end)
end)

Window:Toggle("Auto Sell", {}, function(state)
    task.spawn(function()
        Settings.Sell = state
        while true do
            if not Settings.Sell then
                LocalPlayer.PlayerGui.InventoryGui.Enabled = true
                return 
            end

            LocalPlayer.PlayerGui.InventoryGui.Enabled = false
            firesignal(LocalPlayer.PlayerGui.InventoryGui.InventoryButton.MouseButton1Click)

            for _, v in ipairs(LocalPlayer.PlayerGui.InventoryGui.Holder.MainFrame.ScrollingFrame:GetChildren()) do
                if v:IsA("Frame") then
                    for _, j in ipairs(ObjectHolder:GetChildren()) do
                        for _, x in ipairs(j.Positions:GetChildren()) do
                            if not j.Shoes:FindFirstChild(x.Name) then
                                ReplicatedStorage.Remotes.SellRemote:FireServer(v.Name, x); task.wait(.5); break
                            end
                        end
                    end
                end
            end

            firesignal(LocalPlayer.PlayerGui.InventoryGui.InventoryButton.MouseButton1Click)

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