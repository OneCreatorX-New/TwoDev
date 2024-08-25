local function ScriptLoader(slugs)
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local function createLoadingGui()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "LoadingGui"
        screenGui.Parent = playerGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 50)
        frame.Position = UDim2.new(0.5, -100, 0.9, -25)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.BorderSizePixel = 0
        frame.Parent = screenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -20, 1, 0)
        textLabel.Position = UDim2.new(0, 10, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Cargando..."
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextSize = 18
        textLabel.Font = Enum.Font.GothamSemibold
        textLabel.Parent = frame

        local loadingBar = Instance.new("Frame")
        loadingBar.Size = UDim2.new(0, 0, 0, 4)
        loadingBar.Position = UDim2.new(0, 0, 1, -4)
        loadingBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        loadingBar.BorderSizePixel = 0
        loadingBar.Parent = frame

        local loadingCorner = Instance.new("UICorner")
        loadingCorner.CornerRadius = UDim.new(0, 2)
        loadingCorner.Parent = loadingBar

        return screenGui, loadingBar
    end

    local function animateLoading(loadingBar)
        local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local tween = TweenService:Create(loadingBar, tweenInfo, {Size = UDim2.new(1, 0, 0, 4)})
        tween:Play()
    end

    local function loadScript()
        local screenGui, loadingBar = createLoadingGui()
        animateLoading(loadingBar)

        local url = string.format("https://loader.brunotoledo526.workers.dev/?t=%d&sl=%s", os.time(), slugs)
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success then
            local scriptFunction, loadError = loadstring(result)
            if scriptFunction then
                local execSuccess, execError = pcall(scriptFunction)
                if execSuccess then
                    print("Script ejecutado con éxito.")
                else
                    warn("Error al ejecutar el script: " .. tostring(execError))
                end
                task.wait(5)
                screenGui:Destroy()
            else
                screenGui:Destroy()
                warn("Error al cargar el script: " .. tostring(loadError))
            end
        else
            screenGui:Destroy()
            warn("Error al obtener el script: " .. tostring(result))
        end
    end

    loadScript()
end

return ScriptLoader
