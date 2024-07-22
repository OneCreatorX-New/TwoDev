local function loadScript(scriptId)
    local function notify(message)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script Loader",
            Text = message,
            Duration = 5
        })
    end

    local url = "https://interm.brunotoledo526.workers.dev"
    local HttpService = game:GetService("HttpService")
    
    local success, result = pcall(function()
        return game:HttpGet(url, true, {
            ["Content-Type"] = "application/json",
            ["Body"] = HttpService:JSONEncode({id = scriptId})
        })
    end)
    
    if success and result then
        local fn, loadError = loadstring(result)
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
        notify("Error al obtener el script: " .. tostring(result))
    end
end

return loadScript
