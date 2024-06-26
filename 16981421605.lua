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
UL:AddTBtn(cfrm, "Immortal", a, function(b)
    a = b
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEventNpcDamage = ReplicatedStorage.Events:WaitForChild("Fight"):WaitForChild("Re_NpcDamage")
local originalFireServerNpcDamage = remoteEventNpcDamage.FireServer

local mtNpcDamage = getrawmetatable(remoteEventNpcDamage)
local oldNamecallNpcDamage = mtNpcDamage.__namecall
setreadonly(mtNpcDamage, false)

mtNpcDamage.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" and self == remoteEventNpcDamage and a then
        
        return nil
    end
    return oldNamecallNpcDamage(self, ...)
end)

setreadonly(mtNpcDamage, true)

local remoteEventTrainPower = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Re_TrainPower")
local originalFireServerTrainPower = remoteEventTrainPower.FireServer

local mtTrainPower = getrawmetatable(remoteEventTrainPower)
local oldNamecallTrainPower = mtTrainPower.__namecall
setreadonly(mtTrainPower, false)

local arg1

local function newFireServer(self, ...)
    local args = {...}
    if args[1] ~= nil and args[1] ~= arg1 then
        arg1 = args[1]
        spawn(function()
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "New Train Detect " .. args[1],
    Text = "Auto Adjusted",
    Duration = 3,
})
end)
    end
    return oldNamecallTrainPower(self, unpack(args))
end

mtTrainPower.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self == remoteEventTrainPower then
        return newFireServer(self, ...)
    end
    return oldNamecallTrainPower(self, ...)
end)

setreadonly(mtTrainPower, true)

UL:AddTBtn(cfrm, "Farm Train", vaa, function(b)
    vaa = b
    while vaa do
        if arg1 ~= nil then
            local args = {
                [1] = tostring(arg1)
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Re_TrainPower"):FireServer(unpack(args))
            wait()
        else
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Re_TrainPower"):FireServer()
wait()
        end
        wait(0.1)
    end
end)


UL:AddTBtn(cfrm, "Auto Atack NPC ", ya, function(b)
    ya = b
    while ya do
for _, npc in (workspace.FightNpcs:GetChildren()) do
if npc:IsA("Model") then
for i = 1, 20 do
            local args = {
    [1] = tostring(npc.Name),
    [2] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Fight"):WaitForChild("Re_TakeDamage"):FireServer(unpack(args))
end 
            wait()
        end
   end
 wait()
    end
end)
UL:AddTBtn(cfrm, "Auto Claim Gift ", taaa, function(b)
    taaa = b
    while taaa do
for i = 1, 12 do
local args = {
    [1] = "OnlineGift00" .. i
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Stats"):WaitForChild("Re_ClaimOnline"):FireServer(unpack(args))
wait(1)
end
wait(0.2)
end
end)

UL:AddTBtn(cfrm, "Auto Equipe Better all", yoa, function(b)
    yoa = b
    while yoa do
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Pets"):WaitForChild("Re_EquipBest"):FireServer()

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Weapon"):WaitForChild("Re_Equip"):FireServer()
wait(5)
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 07/06/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
