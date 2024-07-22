local HttpService = game:GetService("HttpService")

local function notify(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Loader",
        Text = message,
        Duration = 5
    })
end

local function snd(url, msg)
    local reqBody = { content = msg }
    local headers = { ["Content-Type"] = "application/json" }
    
    local success, result = pcall(function()
        local request = http_request or request or syn.request or http.request
        return request({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = HttpService:JSONEncode(reqBody)
        })
    end)
    
    return success and result or nil
end

local function loadExternalScript(scriptId)
    local function fetchAndLoadScript()
        local url = "https://interm.brunotoledo526.workers.dev"
        local data = { id = scriptId }
        
        local success, result = pcall(function()
            return snd(url, HttpService:JSONEncode(data))
        end)
        
        if success and result and result.Body then
            local scriptContent = result.Body
            local fn, loadError = loadstring(scriptContent)
            if fn then
                local runSuccess, runError = pcall(fn)
                if not runSuccess then
                    notify("Error al ejecutar el script: " .. tostring(runError))
                else
                    notify("Script cargado y ejecutado con éxito")
                end
            else
                notify("Error al cargar el script: " .. tostring(loadError))
            end
        else
            success, result = pcall(function()
                return game:HttpGet(url, true)
            end)
            
            if success and result then
                local fn, loadError = loadstring(result)
                if fn then
                    local runSuccess, runError = pcall(fn)
                    if not runSuccess then
                        notify("Error al ejecutar el script (HttpGet): " .. tostring(runError))
                    else
                        notify("Script cargado y ejecutado con éxito (HttpGet)")
                    end
                else
                    notify("Error al cargar el script (HttpGet): " .. tostring(loadError))
                end
            else
                notify("Error al obtener el script: " .. tostring(result))
            end
        end
    end

    if scriptId ~= game.PlaceId then
        notify("Advertencia: El ID del script no coincide con el ID del juego")
    end
    
    fetchAndLoadScript()
end

return loadExternalScript
