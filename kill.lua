local P = game:GetService("Players").LocalPlayer
local PG = P:WaitForChild("PlayerGui")
local RS = game:GetService("RunService")
_G.N, _G.C, _G.A, _G.M, _G.NC, _G.HB, _G.V = 59, 29, true, "N", false, false, true
if PG:FindFirstChild("SystemUI") then PG.SystemUI:Destroy() end
local SG = Instance.new("ScreenGui", PG)
SG.Name = "SystemUI"
SG.ResetOnSpawn = false
SG.DisplayOrder = 9999
local F = Instance.new("Frame", SG)
F.Size, F.Position, F.BackgroundColor3, F.Draggable, F.Active, F.Visible = UDim2.new(0, 160, 0, 300), UDim2.new(0, 10, 0.5, -150), Color3.new(0, 0, 0), true, true, _G.V
local function B(t, y, c, fn)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position, b.Text, b.BackgroundColor3, b.TextColor3, b.TextScaled = UDim2.new(0, 144, 0, 32), UDim2.new(0, 8, y, 0), t, c, Color3.new(1, 1, 1), true
    b.MouseButton1Click:Connect(fn)
    return b
end
local M_BTN = Instance.new("TextButton", SG)
M_BTN.Size, M_BTN.Position, M_BTN.Text, M_BTN.BackgroundColor3, M_BTN.TextColor3, M_BTN.TextScaled = UDim2.new(0, 60, 0, 30), UDim2.new(0, 10, 0.5, -180), "MENU", Color3.new(0.1, 0.1, 0.1), Color3.new(1, 1, 1), true
M_BTN.MouseButton1Click:Connect(function() _G.V = not _G.V F.Visible = _G.V end)
local Q_S = Instance.new("TextButton", SG)
Q_S.Size, Q_S.Position, Q_S.BackgroundColor3, Q_S.TextColor3, Q_S.TextScaled = UDim2.new(0, 100, 0, 30), UDim2.new(0, 75, 0.5, -180), Color3.new(0.2, 0.5, 0.2), Color3.new(1, 1, 1), true
Q_S.MouseButton1Click:Connect(function() _G.M = (_G.M == "N") and "C" or "N" end)
local BN = B("M: NORM (59)", 0.02, Color3.new(0.2, 0.5, 0.2), function() _G.M = (_G.M == "N") and "C" or "N" end)
B("ANTI-FREEZE: ON", 0.16, Color3.new(0.2, 0.2, 0.5), function() _G.A = not _G.A end)
B("NOCLIP", 0.30, Color3.new(0.4, 0.4, 0.4), function() _G.NC = not _G.NC end)
B("HITBOX", 0.44, Color3.new(0.5, 0.2, 0.5), function() _G.HB = not _G.HB end)
B("SERVER HOP", 0.58, Color3.new(0.3, 0.3, 0.3), function() 
    local s = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")).data
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s[math.random(1,#s)].id, P)
end)
B("REJOIN", 0.72, Color3.new(0.4, 0.4, 0.1), function() game:GetService("TeleportService"):Teleport(game.PlaceId, P) end)
local function L()
    local C = P.Character or P.CharacterAdded:Wait()
    local H = C:WaitForChild("Humanoid")
    local R = C:WaitForChild("HumanoidRootPart")
    H:SetStateEnabled(15, false) H:SetStateEnabled(16, false)
    local CN; CN = RS.Heartbeat:Connect(function()
        if not C or not C.Parent or not H or H.Health <= 0 then CN:Disconnect() return end
        local T = (_G.M == "N") and "NORM (59)" or "CARRY (29)"
        local CL = (_G.M == "N") and Color3.new(0.2, 0.5, 0.2) or Color3.new(0.5, 0.5, 0.2)
        BN.Text, BN.BackgroundColor3 = T, CL
        Q_S.Text, Q_S.BackgroundColor3 = T, CL
        if _G.A then if H.PlatformStand then H.PlatformStand = false H:ChangeState(11) end R.Anchored = false end
        local SP = (_G.M == "N") and _G.N or _G.C
        if H.MoveDirection.Magnitude > 0 then
            H.WalkSpeed = SP
            if _G.A then R.Velocity = Vector3.new(H.MoveDirection.X * SP, R.Velocity.Y, H.MoveDirection.Z * SP) R.RotVelocity = Vector3.new(0,0,0) end
        else H.WalkSpeed = 16 end
        if _G.NC then for _, v in pairs(C:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        if _G.HB then for _, v in pairs(game:GetService("Players"):GetPlayers()) do if v ~= P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then v.Character.HumanoidRootPart.Size = Vector3.new(12,12,12) v.Character.HumanoidRootPart.Transparency = 0.6 end end end
    end)
end
P.CharacterAdded:Connect(L)
task.spawn(L)