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



UL:AddTBtn(cfrm, "Auto Join Runway", a, function(b)
a = b
while a do
wait(1)
game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.2"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CatWalkService"):WaitForChild("__comm__"):WaitForChild("RF"):WaitForChild("JoinParade"):InvokeServer()
end
end)

UL:AddTBtn(cfrm, "Auto Claim Gift", h, function(k)
h = k
while h do
for i = 1, 12 do
local args = {
    [1] = "Gift" .. i
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.2"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GiftsService"):WaitForChild("__comm__"):WaitForChild("RF"):WaitForChild("OnGiftClaimRequest"):InvokeServer(unpack(args))
wait(1)
end
wait(1)
end
end)


UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 01/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
