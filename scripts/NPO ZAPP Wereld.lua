local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function GetRemote()
    local Remote = nil

    for _,v in ipairs(ReplicatedStorage.Packages["_Index"]:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name == "ClaimReward" then
            Remote = v; break
        end
    end

    return Remote
end

local ClaimReward = GetRemote()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Button("Instant Limited UGC", function()
    task.spawn(function()
        for _,v in ipairs(Workspace.Programming.Presenters:GetChildren()) do
            local ProximityPrompt = v.LowerTorso:FindFirstChildOfClass("ProximityPrompt")
            if ProximityPrompt then
                fireproximityprompt(ProximityPrompt);
            end
        end

        task.delay(2, function()
            ClaimReward:InvokeServer("FindPresenters4")
        end)
    end)
end)  

Window:Button("YouTube: EsohaSL", function()
    task.spawn(function()
        if setclipboard then
            setclipboard("https://youtube.com/@esohasl")
        end
    end)
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/xxqLgnd/Utilities/main/Rspy"))()