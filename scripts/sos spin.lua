local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
    Spin = {
        Enabled = false,
        Asset = nil
    },

    Prompt = false,
}

local function GetAssetUGCs()
    local UGCs = {}

    for _,v in ipairs(ReplicatedStorage.ugcAssetIds:GetChildren()) do
        table.insert(UGCs, v.Name)
    end

    return UGCs
end

local function ConfirmPrompt()
    local Prompt = CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt")

    if Prompt then
        local Buttons = Prompt.AlertContents.Footer.Buttons
        local Confirm, Cancel = Buttons:FindFirstChild("2"), Buttons:FindFirstChild("1")

        if Confirm and Cancel then
            local Price = Confirm.ButtonContent.ButtonMiddleContent.Text

            if Price.Text == "0" then
                VirtualInputManager:SendMouseButtonEvent(Buttons["2"].AbsolutePosition.X, Buttons["2"].AbsolutePosition.Y + 50, 0, true, game, 1); task.wait()
                VirtualInputManager:SendMouseButtonEvent(Buttons["2"].AbsolutePosition.X, Buttons["2"].AbsolutePosition.Y + 50, 0, false, game, 1)
            else
                VirtualInputManager:SendMouseButtonEvent(Buttons["1"].AbsolutePosition.X, Buttons["1"].AbsolutePosition.Y + 50, 0, true, game, 1); task.wait()
                VirtualInputManager:SendMouseButtonEvent(Buttons["1"].AbsolutePosition.X, Buttons["1"].AbsolutePosition.Y + 50, 0, false, game, 1)
            end
        end
    end

    return false
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()

local Window = Library:CreateWindow("SFF | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Spin", {}, function(state)
    task.spawn(function()
        Settings.Spin.Enabled = state
        while true do
            if not Settings.Spin.Enabled then return end

            ReplicatedStorage.Remotes.UpdateSelected:FireServer(Settings.Spin.Asset); task.wait(.1)
            ReplicatedStorage.Remotes.Spin:InvokeServer(Settings.Spin.Asset); task.wait(.25)
        end
    end)
end)

Window:Dropdown("UGC for Spin", {list =  GetAssetUGCs()}, function(var)
    task.spawn(function()
        local Asset = ReplicatedStorage.ugcAssetIds:FindFirstChild(var)

        if Asset then
            Settings.Spin.Asset = Asset
        end
    end)
end)

Window:Section("Confirms only Free prompts")
Window:Toggle("Auto Confirm Prompt", {}, function(state)
    task.spawn(function()
        Settings.Prompt = state
        while true do
            if not Settings.Prompt then return end

            ConfirmPrompt(); task.wait(1)
        end
    end)
end)

Window:Button("Redeem Codes", function()
    task.spawn(function()
        for _, v in ipairs({"thanksFor300kVisits", "OWNERGIVEMEUGC", "OWNERPLZPROMPTME", "burgerBoss", "newDropTonightWoo"}) do
            ReplicatedStorage.Remotes.UseCode:InvokeServer(v); task.wait(.1)
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