-- Dark Dex V3
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()


-- Hydroxide
local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")

-- Decompiler
function SimpleDecompile(module)
    local Module = require(module)
    local DecompiledModule = ""
    
    for i, v in pairs(Module) do
        if typeof(v) == "table" then    
            for j, z in pairs(v) do
                if typeof(z) == "table" then
                    for c, b in pairs(z) do
                        DecompiledModule = DecompiledModule .. "\n" .. tostring(c) .. " " .. tostring(b)
                    end
                else

                    DecompiledModule = DecompiledModule .. "\n" .. tostring(j) .. " " .. tostring(z)
                end
            end
        else
            DecompiledModule = DecompiledModule .. "\n" .. tostring(i) .. tostring(v)
        end
    end

    return DecompiledModule
end

_G.decompile = SimpleDecompile
getgenv().decompile = SimpleDecompile


-- UGC Remote Finder
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local InputId = 16373638121;

for _,v in pairs(ReplicatedStorage:GetDescendants()) do
    task.spawn(function()
        if v:IsA("RemoteEvent") then
            v:FireServer(InputId);
            v:FireServer(tostring(InputId));
        elseif v:IsA("RemoteFunction") then
            v:InvokeServer(InputId);
            v:InvokeServer(tostring(InputId));
        end
    end)
end

print("Done.")