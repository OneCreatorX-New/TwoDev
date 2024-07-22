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
        return game:HttpGet(url)
    end)
    
    if success then
        notify("Respuesta del Worker: " .. result)
    else
        notify("Error al obtener la respuesta: " .. tostring(result))
    end
end

return loadScript
