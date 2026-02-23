-- [[ ULTIMATE AUTO-SENSE BRAINROT MENU ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- デフォルト設定
_G.NormalSpeed = 60
_G.CarrySpeed = 31
_G.AntiKB = true
_G.AutoPickup = true

-- GUI作成
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "AutoSpeedMenu"

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 250)
frame.Position = UDim2.new(0, 50, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 35)
label.Text = "AUTO SENSE MENU"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundColor3 = Color3.fromRGB(100, 0, 255)

-- 通常速度変更ボタン
local btnSpeed = Instance.new("TextButton", frame)
btnSpeed.Size = UDim2.new(0.9, 0, 0, 40)
btnSpeed.Position = UDim2.new(0.05, 0, 0.2, 0)
btnSpeed.Text = "Normal: " .. _G.NormalSpeed
btnSpeed.MouseButton1Click:Connect(function()
    _G.NormalSpeed = (_G.NormalSpeed >= 100) and 16 or (_G.NormalSpeed + 10)
    btnSpeed.Text = "Normal: " .. _G.NormalSpeed
end)

-- 持ち時速度変更ボタン
local btnCarry = Instance.new("TextButton", frame)
btnCarry.Size = UDim2.new(0.9, 0, 0, 40)
btnCarry.Position = UDim2.new(0.05, 0, 0.4, 0)
btnCarry.Text = "Carry: " .. _G.CarrySpeed
btnCarry.MouseButton1Click:Connect(function()
    _G.CarrySpeed = (_G.CarrySpeed >= 60) and 16 or (_G.CarrySpeed + 5)
    btnCarry.Text = "Carry: " .. _G.CarrySpeed
end)

-- アンチノックバック切替
local btnKB = Instance.new("TextButton", frame)
btnKB.Size = UDim2.new(0.9, 0, 0, 40)
btnKB.Position = UDim2.new(0.05, 0, 0.6, 0)
btnKB.Text = "Anti-KB: ON"
btnKB.MouseButton1Click:Connect(function()
    _G.AntiKB = not _G.AntiKB
    btnKB.Text = "Anti-KB: " .. (_G.AntiKB and "ON" or "OFF")
end)

-- 【重要】キャラ・ペット持機状態の自動判定
local function checkCarrying()
    -- 1. 手にツールとして持っている場合
    if char:FindFirstChildOfClass("Tool") then return true end
    
    -- 2. キャラクターの中に「Pet」や「Carry」という名前のモデル/パーツがある場合
    for _, v in pairs(char:GetChildren()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and not v.Name:find("Humanoid") and not v.Name:find("Root") then
            if v.Name:lower():find("pet") or v.Name:lower():find("carry") or v.Name:lower():find("pick") then
                return true
            end
        end
    end
    return false
end

-- メインループ：速度適用 & アンチKB
game:GetService("RunService").RenderStepped:Connect(function()
    if hum.MoveDirection.Magnitude > 0 then
        -- 自動検知して速度を切り替え
        local carrying = checkCarrying()
        hum.WalkSpeed = carrying and _G.CarrySpeed or _G.NormalSpeed
    else
        hum.WalkSpeed = 16
    end

    -- アンチノックバック
    if _G.AntiKB then
        root.Velocity = Vector3.new(0, root.Velocity.Y, 0)
    end
end)

-- 自動取得 (Auto-Pickup)
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoPickup then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent then
                    if (root.Position - v.Parent.Position).Magnitude < 15 then
                        firetouchinterest(root, v.Parent, 0)
                        firetouchinterest(root, v.Parent, 1)
                    end
                end
            end
        end
    end
end)

print("🧠 BRAINROT AUTO-SENSE LOADED")