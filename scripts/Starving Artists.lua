-- Settings
local Settings = {} and Settings or {
    Image = "",
    Mode = "Randomize"
}

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Varriables
local LocalPlayer = Players.LocalPlayer
local MainGui = LocalPlayer.PlayerGui.MainGui

function GetGrid()
    local Grid = MainGui:FindFirstChild("PaintFrame"):FindFirstChild("Grid")

    if not Grid then
        Grid = MainGui:FindFirstChild("PaintFrame"):FindFirstChild("GridHolder"):FindFirstChild("Grid")
    end

    return Grid
end

function SendNotify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text
    })
end

local Grid = GetGrid()

function GetJson(url)
    if string.len(url) > 10 then
        return HttpService:JSONDecode(game:HttpGet("https://esohasl.net/pixels?url=" .. url))
    end

    return false
end

function Import(url)
    local pixels = GetJson(url)
    local usedIndices = {}

    if pixels.statusCode then
        if pixels.statusCode == 400 then
            SendNotify("Invalid URL", "The link provided is incorrect. discord.gg/HjKDVu2rAH to get help how get correct links.");
        elseif pixels.statusCode == 413 then
            SendNotify("Payload too large", "Image provided is too large. discord.gg/HjKDVu2rAH to get help.");
        end

        return
    end 

    if not Grid then Grid = GetGrid() end

    for i = 1, #pixels do
        local pixelIndex = i

        if Settings.Mode == "Randomize" then
            pixelIndex = math.random(#pixels)
            
            while usedIndices[pixelIndex] do
                pixelIndex = math.random(#pixels)
            end
            
            usedIndices[pixelIndex] = true
        end
        
        local pixel = pixels[pixelIndex]
        local r, g, b = pixel[1], pixel[2], pixel[3]
        
        Grid[tostring(pixelIndex)].BackgroundColor3 = Color3.fromRGB(r, g, b)
        
        task.wait(.2);
    end
end

-- User Interface
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow("Starving Arts")

Window:Section("esohasl.net")

Window:Button("Draw", function()
    task.spawn(function()
        Import(Settings.Image)
    end)
end)

Window:Box("Image URL", {}, function(value) 
    task.spawn(function()
        Settings.Image = value
    end)
end) 

Window:Dropdown("Draw Mode", {list = { "Randomize", "By Step" } }, function(var) 
    task.spawn(function()
        Settings.Mode = var
    end)
end)

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://www.youtube.com/@esohasl")
        end
    end)
end)