local function ScriptLoader(slugs)
    local function notify(message)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Notify",
                Text = tostring(message),
                Duration = 5
            })
        end)
    end

    local function loadScript()
        local url = string.format("https://loader.brunotoledo526.workers.dev/?t=%d&sl=%s", os.time(), slugs)
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success then
            local scriptFunction, loadError = loadstring(result)
            if scriptFunction then
                local success, executeError = pcall(scriptFunction)
                if not success then
                    notify("Error al ejecutar el script: " .. tostring(executeError))
                end
            else
                notify("Error al cargar el script: " .. tostring(loadError))
            end
        else
            notify("Error al obtener el script: " .. tostring(result))
        end
    end

    local a = true
    if a then
      loadScript()  
    end
    
    loadScript()
end

return ScriptLoader
