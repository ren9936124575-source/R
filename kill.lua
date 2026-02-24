-- [[ STEAL BRAINROT: DUPE EDITION ]] --
local _P = game:GetService("Players").LocalPlayer
local _PG = _P:WaitForChild("PlayerGui")
local _RS = game:GetService("RunService")

-- 初期設定
_G.N, _G.C, _G.A, _G.M, _G.NC, _G.HB, _G.V = 59, 29, true, "N", false, false, true
local _L_ON = false

-- UI削除・再構築
if _PG:FindFirstChild("SystemUI") then _PG.SystemUI:Destroy() end
local _SG = Instance.new("ScreenGui", _PG)
_SG.Name = "SystemUI"
_SG.ResetOnSpawn = false
_SG.DisplayOrder = 9999

local _F = Instance.new("Frame", _SG)
_F.Size, _F.Position, _F.BackgroundColor3, _F.Draggable, _F.Active, _F.Visible = UDim2.new(0, 160, 0, 360), UDim2.new(0, 10, 0.5, -180), Color3.new(0, 0, 0), true, true, _G.V
_F.BorderSizePixel = 2

local function _B(_t, _y, _c, _fn)
    local _b = Instance.new("TextButton", _F)
    _b.Size, _b.Position, _b.Text, _b.BackgroundColor3, _b.TextColor3, _b.TextScaled = UDim2.new(0, 144, 0, 30), UDim2.new(0, 8, _y, 0), _t, _c, Color3.new(1, 1, 1), true
    _b.MouseButton1Click:Connect(_fn)
    return _b
end

-- --- 通常機能ボタン ---
local _BN = _B("M: NORM (59)", 0.02, Color3.new(0.2, 0.5, 0.2), function() _G.M = (_G.M == "N") and "C" or "N" end)
_B("ANTI-FREEZE: ON", 0.12, Color3.new(0.2, 0.2, 0.5), function() _G.A = not _G.A end)
_B("NOCLIP", 0.22, Color3.new(0.4, 0.4, 0.4), function() _G.NC = not _G.NC end)
_B("HITBOX", 0.32, Color3.new(0.5, 0.2, 0.5), function() _G.HB = not _G.HB end)
_B("SERVER HOP", 0.42, Color3.new(0.3, 0.3, 0.3), function() 
    local s = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")).data
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s[math.random(1,#s)].id, _P)
end)

-- --- 🧪 DUPE機能セクション ---
local _LB = _B("🔥 DUPE LAG: OFF", 0.60, Color3.new(0.4, 0, 0), function()
    _L_ON = not _L_ON
    _LB.Text = _L_ON and "🔥 LAG: ON" or "🔥 DUPE LAG: OFF"
    _LB.BackgroundColor3 = _L_ON and Color3.new(1, 0, 0) or Color3.new(0.4, 0, 0)
    
    if _L_ON then
        task.spawn(function()
            while _L_ON do
                for i = 1, 800000 do local _ = math.sqrt(i) end -- 高負荷ループ
                task.wait(0.01)
            end
        end)
    end
end)

_B("⚡ CRASH SELF", 0.70, Color3.new(0.2, 0.2, 0.2), function()
    -- トレード確定直後に押す
    _P:Kick("Dupe Attempt: Rejoin now.") 
    task.wait(0.1)
    while true do end -- バックアップ用フリーズ
end)

_B("REJOIN", 0.85, Color3.new(0.4, 0.4, 0.1), function() game:GetService("TeleportService"):Teleport(game.PlaceId, _P) end)

-- --- クイックボタン (MENU) ---
local _M_BTN = Instance.new("TextButton", _SG)
_M_BTN.Size, _M_BTN.Position, _M_BTN.Text, _M_BTN.BackgroundColor3, _M_BTN.TextColor3, _M_BTN.TextScaled = UDim2.new(0, 60, 0, 30), UDim2.new(0, 10, 0.5, -215), "MENU", Color3.new(0.1, 0.1, 0.1), Color3.new(1, 1, 1), true
_M_BTN.MouseButton1Click:Connect(function() _G.V = not _G.V _F.Visible = _G.V end)

-- メインループ
local function _L()
    local _C = _P.Character or _P.CharacterAdded:Wait()
    local _H = _C:WaitForChild("Humanoid")
    local _R = _C:WaitForChild("HumanoidRootPart")
    _H:SetStateEnabled(15, false) _H:SetStateEnabled(16, false)
    
    local _CN; _CN = _RS.Heartbeat:Connect(function()
        if not _C or not _C.Parent or not _H or _H.Health <= 0 then _CN:Disconnect() return end
        _BN.Text = (_G.M == "N") and "NORM (59)" or "CARRY (29)"
        
        local _SP = (_G.M == "N") and (_G.N - math.random(0,1)) or _G.C
        if _H.MoveDirection.Magnitude > 0 then
            _H.WalkSpeed = _SP
            if _G.A then _R.Velocity = Vector3.new(_H.MoveDirection.X * _SP, _R.Velocity.Y, _H.MoveDirection.Z * _SP) end
        else _H.WalkSpeed = 16 end
        
        if _G.NC then for _, v in pairs(_C:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        if _G.HB then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= _P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Size = Vector3.new(12, 12, 12)
                end
            end
        end
    end)
end
_P.CharacterAdded:Connect(_L) task.spawn(_L)