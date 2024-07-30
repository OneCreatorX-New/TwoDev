return function(param)
    local HttpService = game:GetService("HttpService")
    local MarketplaceService = game:GetService("MarketplaceService")
    local scriptRegistryPath = "ScriptRegistry.json"

    local function notify(message)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Notify",
                Text = message,
                Duration = 5
            })
        end)
    end

    local function loadScriptRegistry()
        if not isfile(scriptRegistryPath) then
            return {}
        end
        return HttpService:JSONDecode(readfile(scriptRegistryPath))
    end

    local function saveScriptRegistry(registry)
        writefile(scriptRegistryPath, HttpService:JSONEncode(registry))
    end

    local function registerScript(id, name, isUniversal)
        local registry = loadScriptRegistry()
        if not registry[id] then
            registry[id] = {name = name, enabled = true, isUniversal = isUniversal}
            saveScriptRegistry(registry)
        end
    end

    local function isScriptEnabled(id)
        local registry = loadScriptRegistry()
        return registry[id] and registry[id].enabled
    end

    local function loadScript()
        local url = string.format("https://small-union-d76e.brunotoledo526.workers.dev//?key=%s&id=%s", "onecreatorx", param)
        local success, result = pcall(game.HttpGet, game, url)
        
        if success then
            local scriptName, isUniversal
            if tonumber(param) then
                scriptName = MarketplaceService:GetProductInfo(tonumber(param)).Name
                isUniversal = false
            else
                scriptName = param:gsub("%%20", " ")
                isUniversal = true
            end
            
            registerScript(param, scriptName, isUniversal)
            
            if isScriptEnabled(param) then
                loadstring(result)()
            else
                notify("Ejecución del script bloqueada por el usuario")
            end
        else
            notify("Error al cargar el script: " .. tostring(result))
        end
    end

    if tonumber(param) and tonumber(param) ~= game.PlaceId then
        notify("Posible script de otro juego")
    end

    loadScript()
end
