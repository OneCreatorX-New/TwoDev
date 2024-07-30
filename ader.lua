return function(id)
    local HttpService = game:GetService("HttpService")
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

    local function registerScript(id, name)
        local registry = loadScriptRegistry()
        if not registry[id] then
            registry[id] = {name = name, enabled = true}
            saveScriptRegistry(registry)
        end
    end

    local function isScriptEnabled(id)
        local registry = loadScriptRegistry()
        return registry[id] and registry[id].enabled
    end

    local function loadScript()
        local url = string.format("https://small-union-d76e.brunotoledo526.workers.dev//?key=%s&id=%s", "onecreatorx", id)
        local success, result = pcall(game.HttpGet, game, url)
        
        if success then
            local scriptName = game:GetService("MarketplaceService"):GetProductInfo(tonumber(id)).Name
            registerScript(id, scriptName)
            
            if isScriptEnabled(id) then
                loadstring(result)()
            else
                notify("Ejecución del script bloqueada por el usuario")
            end
        else
            notify("Error al cargar el script: " .. tostring(result))
        end
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
         loadstring(result)()
        notify("Posible script de otro juego")
    end

    loadScript()
end
