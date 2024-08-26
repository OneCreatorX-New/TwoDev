function SL(s)
    TS = game:GetService("TweenService")
    P = game:GetService("Players")
    p = P.LocalPlayer
    pg = p:WaitForChild("PlayerGui")

    function cLG(un)
        sg = Instance.new("ScreenGui")
        sg.Name = "LoadingGui"
        sg.Parent = pg

        f = Instance.new("Frame")
        f.Size = UDim2.new(0, 200, 0, 50)
        f.Position = UDim2.new(0.5, -100, 0.9, -25)
        f.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        f.BorderSizePixel = 0
        f.Parent = sg

        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

        tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1, -20, 1, 0)
        tl.Position = UDim2.new(0, 10, 0, 0)
        tl.BackgroundTransparency = 1
        tl.Text = "Secure Loader"
        tl.TextColor3 = Color3.new(1, 1, 1)
        tl.TextSize = 18
        tl.Font = Enum.Font.GothamSemibold
        tl.Parent = f

        lb = Instance.new("Frame")
        lb.Size = UDim2.new(0, 0, 0, 4)
        lb.Position = UDim2.new(0, 0, 1, -4)
        lb.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        lb.BorderSizePixel = 0
        lb.Parent = f

        Instance.new("UICorner", lb).CornerRadius = UDim.new(0, 2)

        return sg, f, tl, lb
    end

    function aL(lb)
        TS:Create(lb, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 0, 4)}):Play()
    end

    function uT(tl, f, un)
        task.wait(2)
        local vipText = string.format("VIP: %s", un)
        local textBounds = game:GetService("TextService"):GetTextSize(vipText, 18, Enum.Font.GothamSemibold, Vector2.new(1000, 50))
        local newWidth = math.max(200, textBounds.X + 40)
        
        TS:Create(f, TweenInfo.new(0.5), {Size = UDim2.new(0, newWidth, 0, 50)}):Play()
        TS:Create(f, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -newWidth/2, 0.9, -25)}):Play()
        
        task.wait(0.5)
        tl.Text = vipText
        local vipLabel = tl:FindFirstChild("VIPLabel") or Instance.new("TextLabel", tl)
        vipLabel.Name = "VIPLabel"
        vipLabel.Size = UDim2.new(0, 30, 1, 0)
        vipLabel.Position = UDim2.new(0, 0, 0, 0)
        vipLabel.BackgroundTransparency = 1
        vipLabel.Text = "VIP:"
        vipLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- Color dorado para VIP
        vipLabel.TextSize = 18
        vipLabel.Font = Enum.Font.GothamBold
        
        tl.Position = UDim2.new(0, 40, 0, 0)
        tl.Size = UDim2.new(1, -50, 1, 0)
    end

    function lS()
        -- Extraer el nombre de la URL del script
        local scriptUrl = debug.info(2, "s")
        local un = scriptUrl:match("n=([^&]+)") or "Usuario"
        
        sg, f, tl, lb = cLG(un)
        aL(lb)
        uT(tl, f, un)

        u = string.format("https://loader.brunotoledo526.workers.dev/?t=%d&sl=%s", os.time(), s)
        sc, r = pcall(function() return game:HttpGet(u) end)
        
        if sc then
            sf, le = loadstring(r)
            if sf then
                sf()
                task.wait(5)
                sg:Destroy()
            else
                sg:Destroy()
                warn("Error al cargar el script: " .. tostring(le))
            end
        else
            sg:Destroy()
            warn("Error al obtener el script: " .. tostring(r))
        end
    end

    lS()
end

return SL
