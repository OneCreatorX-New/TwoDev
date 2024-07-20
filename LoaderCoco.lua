return function(id)
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
        local success, result = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/CocoJale/Scripts/main/" .. id .. ".lua")
        end)
        
        if success then
            local func, loadErr = loadstring(result)
            if func then
                pcall(func)
            else
                notify("Error compiling Script: " .. tostring(loadErr))
            end
        else
            notify("Error loading Script: " .. tostring(result))
        end
    end

    if tonumber(id) and tonumber(id) ~= game.PlaceId then
        notify("Possible script for another game")
        loadScript()
    else
        loadScript()
    end
end
