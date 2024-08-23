local function ScriptLoader(slugs)
    local function notify(message)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Notify",
                Text = message,
                Duration = 5
            })
        end)
    end

    local function loadScript()
        local url = string.format("${L}/?t=%d&sl=%s", os.time(), slugs)
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success then
            local scriptFunction, loadError = loadstring(result)
            if scriptFunction then
                scriptFunction()
            else
                notify("Error al cargar el script: " .. tostring(loadError))
            end
        else
            notify("Error al obtener el script: " .. tostring(result))
        end
    end

    if game.PlaceId ~= tonumber(slugs:match("^(%d+)")) then
        notify("Posible script para otro juego")
    else
        loadScript()
    end
end

return ScriptLoader
