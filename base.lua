local PlatoBoost = loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/es-auth/main/libs/platoboost.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoctural/es-auth/main/src/source.lua"))()

PlatoBoost.accountId = 539;
local Configuration = {
    Finished = false,
    FileName = "esohasl.txt",
}

Library:CreateWindow({
    title = "EsohaSL - Key System",
    description = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    serverCode = "HjKDVu2rAH",
    onStartup = function()
        local isNeedKey = not (isfile(Configuration.FileName) and PlatoBoost:verify(readfile(Configuration.FileName)))  
        
        if not isNeedKey then
            Configuration.Finished = true
        end

        return isNeedKey
    end,
    onCheck = function(entered)
        local isCorrect = PlatoBoost:verify(entered)

        if isCorrect then
            Configuration.Finished = true
            writefile(Configuration.FileName, entered)
        end

        return isCorrect
    end,
    onCopy = function() 
        setclipboard(PlatoBoost:getLink())
    end,
})

return (function()
    return Configuration
end)()