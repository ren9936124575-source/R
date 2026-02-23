-- [[ SPEED FIX: NO LIMITS MODE ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- 安全かつ速い設定にリセット
_G.N, _G.C, _G.AKB = 75, 40, true 

local sg = Instance.new("ScreenGui", p.PlayerGui)
local f = Instance.new("Frame", sg)
f.Size, f.Position, f.BackgroundColor3, f.Draggable, f.Active = UDim2.new(0,160,0,150), UDim2.new(0,10,0.5,-75), Color3.new(0,0,0), true, true

local function createBtn(txt, pos, fn)
    local b = Instance.new("TextButton", f)
    b.Size, b.Position, b.Text, b.TextScaled = UDim2.new(1,0,0,40), UDim2.new(0,0,pos,0), txt, true
    b.MouseButton1Click:Connect(fn)
    return b
end

local b1 = createBtn("Norm:".._G.N, 0, function() _G.N = (_G.N >= 150 and 16 or _G.N + 15) end)
local b2 = createBtn("Carry:".._G.C, 0.3, function() _G.C = (_G.C >= 100 and 16 or _G.C + 10) end)
local b3 = createBtn("AKB:ON", 0.6, function() _G.AKB = not _G.AKB end)

-- スピード適用ループ
task.spawn(function()
    while task.wait() do -- RenderSteppedより少しだけ間隔をあけてロルバを防ぐ
        b1.Text, b2.Text, b3.Text = "Norm:".._G.N, "Carry:".._G.C, "AKB:"..(_G.AKB and "ON" or "OFF")
        
        if hum.MoveDirection.Magnitude > 0 then
            -- 持機判定
            local isC = char:FindFirstChildOfClass("Tool") or char:FindFirstChild("Pet") or char:FindFirstChild("Carry")
            local targetSpeed = isC and _G.C or _G.N
            
            -- 強制的に速度を上書き（ロルバ対策で加速度もいじる）
            hum.WalkSpeed = targetSpeed
        else
            hum.WalkSpeed = 16
        end
        
        -- アンチノックバック
        if _G.AKB and root then
            root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
        end
    end
end)