local HttpService = game:GetService("HttpService")

local function notify(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Loader",
        Text = message,
        Duration = 5
    })
end

local function makeRequest(url, method, headers, body)
    local success, result = pcall(function()
        local request = http_request or request or syn.request or http.request
        return request({
            Url = url,
            Method = method,
            Headers = headers,
            Body = body
        })
    end)

    if success then
        return result
    else
        warn("Error en la solicitud HTTP:", result)
        return nil
    end
end

local function loadScript(scriptId)
    local url = "https://interm.brunotoledo526.workers.dev"
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local body = HttpService:JSONEncode({id = scriptId})
    
    local response = makeRequest(url, "POST", headers, body)
    
    if response and response.Body then
        local scriptContent = response.Body
        print("Contenido recibido:", scriptContent)  -- Para depuración
        
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
        notify("Error al obtener el script")
    end
end

return loadScript
