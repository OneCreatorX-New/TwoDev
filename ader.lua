return function(param)
    local HttpService = game:GetService("HttpService")
    local MarketplaceService = game:GetService("MarketplaceService")
    local scriptRegistryPath = "ScriptRegistry.json"

    local function notify(title, message, duration)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = title,
                Text = message,
                Duration = duration or 5
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
                local success, info = pcall(function()
                    return MarketplaceService:GetProductInfo(tonumber(param))
                end)
                if success and info then
                    scriptName = info.Name
                    isUniversal = false
                else
                    scriptName = "Script ID: " .. param
                    isUniversal = false
                end
            else
                scriptName = param:gsub("%%20", " ")
                isUniversal = true
            end
            
            registerScript(param, scriptName, isUniversal)
            
            if isScriptEnabled(param) then
                local success, errorMsg = pcall(loadstring(result))
                if not success then
                    notify("Error de Ejecución", "El script no pudo ejecutarse: " .. tostring(errorMsg), 10)
                else
                    notify("Éxito", "Script cargado y ejecutado correctamente", 5)
                end
            else
                notify("Bloqueado", "Ejecución del script bloqueada por el usuario", 5)
            end
        else
            notify("Error de Carga", "No se pudo cargar el script. Posiblemente no exista o no sea válido.", 10)
        end
    end

    if tonumber(param) then
        if tonumber(param) ~= game.PlaceId then
            notify("Advertencia", "Posible script de otro juego", 5)
        end
        loadScript()
    elseif type(param) == "string" and param:match("^%s*(.-)%s*$") ~= "" then
        loadScript()
    else
        notify("Error", "ID o nombre de script no válido", 5)
    end
end
