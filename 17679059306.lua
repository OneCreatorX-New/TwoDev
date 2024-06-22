
local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
local a = false

local function touch()
    for _, obj in ipairs(workspace:GetChildren()) do
        if a and obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            local plr = game.Players.LocalPlayer
            firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
            wait(0.3)
            firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
            wait(0.1)
        end
    end
wait(0.1)
touch()
end

UL:AddTBtn(cfrm, "Auto Touch(Public Server)", false, function(b)
    a = not a
    if a then 
        touch()
    end
end)

local a = false

local function touch()
    for _, obj in ipairs(workspace:GetChildren()) do
        if a and obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            local plr = game.Players.LocalPlayer
            firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
            wait(0.5)
            firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
            wait(1.5)
        end
    end
wait(0.1)
touch()
end

UL:AddTBtn(cfrm, "Auto Touch(Priv Server)", false, function(b)
    a = not a
    if a then 
        touch()
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 29/05/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
