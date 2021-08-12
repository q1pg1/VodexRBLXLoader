--if game.PlaceId == 292439477 then
-- Librarys --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Menus --

local PhantomForces = Library.CreateLib("Vodex Hub", "Serpent")

-- Tabs --

local Aimbot = PhantomForces:NewTab("Aimbot")
local ESP = PhantomForces:NewTab("ESP")
local Player = PhantomForces:NewTab("Player")
local Misc = PhantomForces:NewTab("Misc")
local Crds = PhantomForces:NewTab("Credits")

-- Sections --

local SilentAimbottab = Aimbot:NewSection("Silent Aimbot")
local PlayerEdittab = Player:NewSection("Player")
local ESPtab = ESP:NewSection("ESP")
local Misctab = Misc:NewSection("Misc")
local crdstab = Crds:NewSection("Credits")

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = game:GetService("Workspace").CurrentCamera

crdstab:NewLabel("Created By")
crdstab:NewLabel("q1pg1")

SilentAimbottab:NewToggle("Enable", "Enables Silent Aimbot", function(state)
    if state then
    function notBehindWall(target)
    local ray = Ray.new(plr.Character.Head.Position, (target.Position - plr.Character.Head.Position).Unit * 300)
    local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {plr.Character}, false, true)
    if part then
        local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and target and humanoid.Parent == target.Parent then
            local pos, visible = camera:WorldToScreenPoint(target.Position)
            if visible then
                return true
            end
        end
    end
end
 
function getPlayerClosestToMouse()
    local target = nil
    local maxDist = 100
    for _,v in pairs(plrs:GetPlayers()) do
        if v.Character then
            if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= plr.TeamColor then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
                if dist < maxDist and vis then
                    local torsoPos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    local torsoDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(torsoPos.X, torsoPos.Y)).magnitude
                    local headPos = camera:WorldToViewportPoint(v.Character.Head.Position)
                    local headDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(headPos.X, headPos.Y)).magnitude
                    if torsoDist > headDist then
                        if notBehindWall(v.Character.Head) then
                            target = v.Character.Head
                        end
                    else
                        if notBehindWall(v.Character.HumanoidRootPart) then
                            target = v.Character.HumanoidRootPart
                        end
                    end
                    maxDist = dist
                end
            end
        end
    end
    return target
end
    end
end)

ESPtab:NewToggle("Enable", "Enables ESP", function(state)
    if state then
    function CreateSG(name,parent,face)
    local SurfaceGui = Instance.new("SurfaceGui",parent)
    SurfaceGui.Parent = parent
    SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SurfaceGui.Face = Enum.NormalId[face]
	SurfaceGui.LightInfluence = 0
	SurfaceGui.ResetOnSpawn = false
    SurfaceGui.Name = name
    SurfaceGui.AlwaysOnTop = true
    local Frame = Instance.new("Frame",SurfaceGui)
	Frame.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
	Frame.Size = UDim2.new(1,0,1,0)
end

while wait(1) do
for i,v in pairs (game:GetService("Players"):GetPlayers()) do
    if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("cham") == nil then
        for i,v in pairs (v.Character:GetChildren()) do
        if v:IsA("MeshPart") or v.Name == "Head" then
        CreateSG("cham",v,"Back")
        CreateSG("cham",v,"Front")
        CreateSG("cham",v,"Left")
        CreateSG("cham",v,"Right")
        CreateSG("cham",v,"Right")
        CreateSG("cham",v,"Top")
        CreateSG("cham",v,"Bottom")
        end
        end
    end
end
end
else
    SurfaceGui.Visible = false
    end
end)

SilentAimbottab:NewToggle("Show Aimbot FOV", "Shows Aimbot FOV", function(state)
    if state then
    end
end)

SilentAimbottab:NewSlider("FOV Slider", "Changes FOV Size", 100, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    
end)

PlayerEdittab:NewSlider("Player Speed", "SliderInfo", 100, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerEdittab:NewSlider("Player Jump Height", "SliderInfo", 100, 0, function(b) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = b
end)

ESPtab:NewDropdown("ESP Mode", "Select Your ESP Mode", {"BoxESP", "Soon", "Soon"}, function(currentOption)
    
end)

Misctab:NewKeybind("Open The Menu", "Opens the Menu", Enum.KeyCode.Insert, function()
	Library:ToggleUI()
end)

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall
 
gmt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "HitPart" and tostring(method) == "FireServer" then
        Args[1] = getPlayerClosestToMouse()
        Args[2] = getPlayerClosestToMouse().Position
        return self.FireServer(self, unpack(Args))
    end
    return oldNamecall(self, ...)
end)

--end
