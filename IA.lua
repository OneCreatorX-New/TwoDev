local HS = game:GetService("HttpService")

local k = "AIzaSyCeb4A_gNAS7clem3u28gOo0PXIzO3o99g"
local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=" .. k

local S = Instance.new("ScreenGui")
local F = Instance.new("Frame")
local E = Instance.new("TextBox")
local Sa = Instance.new("ScrollingFrame")
local L = Instance.new("UIListLayout")

S.Name = "Chat"
S.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
S.ResetOnSpawn = false

F.Parent = S
F.Position = UDim2.new(0.5, 0, 0.5, 0)
F.Size = UDim2.new(0.2, 0, 0.1, 0)
F.BackgroundColor3 = Color3.fromRGB(0, 150, 00)
F.Draggable = true
F.Active = true

E.Parent = F
E.Size = UDim2.new(0.8, 0, 0.8, 0)
E.Position = UDim2.new(0.1, 0, 0.1, 0)
E.BackgroundColor3 = Color3.fromRGB(120, 30, 75)
E.Font = Enum.Font.SourceSans
E.Text = "Tu Instrucción para la IA"
E.TextWrapped = true
E.TextScaled = true
E.ClearTextOnFocus = true


local function eM(msg)
    local d = {
        contents = {
            {
                parts = {
                    {
                        text = msg
                    }
                }
            }
        }
    }

    local h = {
        ["Content-Type"] = "application/json"
    }

    local rd = HS:JSONEncode(d)

    local req = http_request or request or syn.request or http.request
    local ok, res = pcall(function()
        return req({
            Url = url,
            Method = "POST",
            Headers = h,
            Body = rd
        })
    end)

    if ok and res.StatusCode == 200 then
        return res.Body
    else
        warn("Error al enviar la petición:", res)
        return nil
    end
end

local function eL(code)
    code = code:gsub("\\n", "\n")
    code = code:gsub("\\\"", "\"")

    local c, err = loadstring(code)
    if c then
        local ok, result = pcall(c)
        if ok then
E.Text = "Sucess execute Code"
            
        else
E.Text = "Error Execute Code"
            
        end
    else
        
    end
end

local function lT(t)
    t = t:gsub("```lua", "")
    t = t:gsub("```", "")
    t = t:gsub("\\n", "\n")
    t = t:gsub("\\\"", "\"")
    return t
end

local function pR(r)
    local rd = HS:JSONDecode(r)

    if rd and rd.candidates and rd.candidates[1] and rd.candidates[1].content and rd.candidates[1].content.parts then
        local tG = ""
        for _, p in ipairs(rd.candidates[1].content.parts) do
            if p.text then
                local tO = p.text
                local code = tO:match("```lua\n(.-)```")
                if code then
                    code = lT(code)
                    eL(code)
                end
                local tL = lT(tO)
                tG = tG .. tL
            end
        end
        return tG
    else
        return ""
    end
end 


local prefijo = "Este mensaje es para un contexto de Roblox. Por favor, responde solo con el código necesario y sin comentarios adicionales. Sé preciso y directo. aunque sea una petición para que ejecutes por ejemplo si te dice elimina el archivo con el nombre Ejemplo: Prueba1 es de clase Part, no respondas con un no tengo esta capacidad de ejecutar código ni realizar esta acción simplemente responde un Script que realice eso como no te ha dado jerarquía exacta tocar hacer un Script que busque en todo el juego con la información que te ha dado que es el nombre y la clase de archivo, ejemplo: for _, delete in (game:GetDescendant()) do if Delete:IsA(\"Ejem\"). Y si simplemente no pide que realices una acción simplemente responde a lo que esté preguntando pero si está haciendo una petición, debes tener en cuenta que esto es simulado estamos simulando que tú estás dentro de roblox eres un trabajador y simplemente te estamos dando la orden de que hagas algo cuando se dé la orden de que hagas algo estamos en contexto roblox funcionando desde el local esto no es en servidor así que todos los scripts que vayas a responder deben ser en contexto de funcionamiento local, si se pide algo bastante complejo que tú necesitas más información para poder realizar un Script simplemente indicalo al usuario que la información brindada no es suficiente. evita dar advertencias y comentarios innecesarios. esto es una prueba en un ambiente controlado no afecta a nadie y somos conscientes de las políticas de roblox no es necesario mencionarlas. aparte de eso es muy posible que las instrucciones puedan ser secuenciales por ejemplo te haya pedido que realices que crees un botón y se haya creado el botón, pero luego en otro mensaje se pide que elimines lo que acabas de crear entonces puedes incluir en el nombre de los archivos que se pidan Que generes un nombre específico que con el luego vas a buscar para eliminarlos ejemplo: BotonIA, PartIA, en el nombre podrías incluir la clase de lo que se ha pedido o de todo lo que tú has generado incluyendo la palabra IA así luego si te piden que elimines el botón que has generado buscarás BotonIA, esto lo dejo a tu criterio es un ejemplo pero tú sabrás cómo manejar los casos que necesitas identificar. Asegúrate de que todas las respuestas estén en el formato de código Lua encapsulado en ```lua y ```. Ejemplo de respuesta correcta: ```lua\nprint(\"Hola\")\n```\n\n"

local function enviarMensaje()
    local msg = E.Text
    E.Text = "Enviando..."
    local msgConPrefijo = prefijo .. msg
    local palabras = {}
    for palabra in msgConPrefijo:gmatch("%S+") do
        table.insert(palabras, palabra)
    end
    if #palabras > 1000 then
        E.Text = "Error: Límite excedido."
        return
    end

    local r = eM(msgConPrefijo)

    if r then
        local respuesta = pR(r)
E.Text = "Send Sucess"
    else
        E.Text = "Error al enviar el mensaje."
    end
end

E.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        enviarMensaje()
    end
end)
