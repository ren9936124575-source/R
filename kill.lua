local _P = game:GetService("Players").LocalPlayer
local _PG = _P:WaitForChild("PlayerGui")
local _RS = game:GetService("RunService")

-- 検知回避のため、59から極小のランダム値を引く設定に
_G.N, _G.C, _G.A, _G.M, _G.NC, _G.HB, _G.V = 59, 29, true, "N", false, false, true

if _PG:FindFirstChild("SystemUI") then _PG.SystemUI:Destroy() end
local _SG = Instance.new("ScreenGui", _PG)
_SG.Name = "SystemUI"
_SG.ResetOnSpawn = false
_SG.DisplayOrder = 9999

local _F = Instance.new("Frame", _SG)
_F.Size, _F.Position, _F.BackgroundColor3, _F.Draggable, _F.Active, _F.Visible = UDim2.new(0, 160, 0, 300), UDim2.new(0, 10, 0.5, -150), Color3.new(0, 0, 0), true, true, _G.V

local function _B(_t, _y, _c, _fn)
    local _b = Instance.new("TextButton", _F)
    _b.Size, _b.Position, _b.Text, _b.BackgroundColor3, _b.TextColor3, _b.TextScaled = UDim2.new(0, 144, 0, 32), UDim2.new(0, 8, _y, 0), _t, _c, Color3.new(1, 1, 1), true
    _b.MouseButton1Click:Connect(_fn)
    return _b
end

local _M_BTN = Instance.new("TextButton", _SG)
_M_BTN.Size, _M_BTN.Position, _M_BTN.Text, _M_BTN.BackgroundColor3, _M_BTN.TextColor3, _M_BTN.TextScaled = UDim2.new(0, 60, 0, 30), UDim2.new(0, 10, 0.5, -180), "MENU", Color3.new(0.1, 0.1, 0.1), Color3.new(1, 1, 1), true
_M_BTN.MouseButton1Click:Connect(function() _G.V = not _G.V _F.Visible = _G.V end)

local _Q_S = Instance.new("TextButton", _SG)
_Q_S.Size, _Q_S.Position, _Q_S.BackgroundColor3, _Q_S.TextColor3, _Q_S.TextScaled = UDim2.new(0, 100, 0, 30), UDim2.new(0, 75, 0.5, -180), Color3.new(0.2, 0.5, 0.2), Color3.new(1, 1, 1), true
_Q_S.MouseButton1Click:Connect(function() _G.M = (_G.M == "N") and "C" or "N" end)

local _BN = _B("M: NORM (59)", 0.02, Color3.new(0.2, 0.5, 0.2), function() _G.M = (_G.M == "N") and "C" or "N" end)
_B("ANTI-FREEZE: ON", 0.16, Color3.new(0.2, 0.2, 0.5), function() _G.A = not _G.A end)
_B("NOCLIP", 0.30, Color3.new(0.4, 0.4, 0.4), function() _G.NC = not _G.NC end)
_B("HITBOX", 0.44, Color3.new(0.5, 0.2, 0.5), function() _G.HB = not _G.HB end)
_B("SERVER HOP", 0.58, Color3.new(0.3, 0.3, 0.3), function() 
    local s = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")).data
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s[math.random(1,#s)].id, _P)
end)
_B("REJOIN", 0.72, Color3.new(0.4, 0.4, 0.1), function() game:GetService("TeleportService"):Teleport(game.PlaceId, _P) end)

local function _L()
    local _C = _P.Character or _P.CharacterAdded:Wait()
    local _H = _C:WaitForChild("Humanoid")
    local _R = _C:WaitForChild("HumanoidRootPart")
    
    -- 転倒、ラグドール、石化などの強制無効化
    _H:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    _H:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    _H:SetStateEnabled(Enum.HumanoidStateType.Dead, false) -- 死ぬ挙動を少し遅延（バグ回避）

    local _CN; _CN = _RS.Heartbeat:Connect(function()
        if not _C or not _C.Parent or not _H then _CN:Disconnect() return end
        
        local _T = (_G.M == "N") and "NORM (59)" or "CARRY (29)"
        local _CL = (_G.M == "N") and Color3.new(0.2, 0.5, 0.2) or Color3.new(0.5, 0.5, 0.2)
        _BN.Text, _BN.BackgroundColor3 = _T, _CL
        _Q_S.Text, _Q_S.BackgroundColor3 = _T, _CL
        
        -- 移動処理
        local _S = (_G.M == "N") and (_G.N - math.random(0,1)) or _G.C -- 59から時々1引いて58にする（検知回避）
        if _H.MoveDirection.Magnitude > 0 then
            _H.WalkSpeed = _S
            if _G.A then 
                _R.Velocity = Vector3.new(_H.MoveDirection.X * _S, _R.Velocity.Y, _H.MoveDirection.Z * _S)
                _R.RotVelocity = Vector3.new(0,0,0) 
            end
        else _H.WalkSpeed = 16 end
        
        -- メデューサ/硬直対策
        if _G.A then 
            if _H.PlatformStand then _H.PlatformStand = false _H:ChangeState(11) end
            if _R.Anchored then _R.Anchored = false end
        end

        -- 機能適用
        if _G.NC then for _, v in pairs(_C:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        if _G.HB then for _, v in pairs(game:GetService("Players"):GetPlayers()) do if v ~= _P and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then v.Character.HumanoidRootPart.Size = Vector3.new(12,12,12) v.Character.HumanoidRootPart.Transparency = 0.6 end end end
    end)
end

_P.CharacterAdded:Connect(_L)
task.spawn(_L)