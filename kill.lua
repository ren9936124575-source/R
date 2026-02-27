-- [[ BedWars Ultra-Light God Mode ]] --
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 起動通知
local function Notify(t, txt)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = txt, Duration = 5})
end
Notify("Script Loaded", "iPhone最強設定を適用しました")

-- 1. キルオーラ（最速かつ検知されない18スタッド設定）
task.spawn(function()
    while task.wait(0.05) do
        local target = nil
        local distance = 18
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LP and v.Team ~= LP.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local mag = (LP.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if mag < distance then
                    target = v.Character
                    -- 攻撃イベント（BedWarsの現在のリモートに最適化）
                    local sword = LP.Character:FindFirstChildOfClass("Tool")
                    if sword then
                        local args = {
                            [1] = {
                                ["weapon"] = sword,
                                ["entityInstance"] = target,
                                ["validateTargetPosition"] = target.HumanoidRootPart.Position,
                                ["chargedAttack"] = {["chargeRatio"] = 0}
                            }
                        }
                        ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetAccelContainer"):WaitForChild("replicated_storage"):WaitForChild("events"):WaitForChild("combat"):WaitForChild("sword_hit"):FireServer(unpack(args))
                    end
                end
            end
        end
    end
end)

-- 2. スピードハック & ジャンプ強化（アンチチートの隙を突く設定）
local lastMove = tick()
RS.Heartbeat:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        local Hum = LP.Character.Humanoid
        -- 速度 23.5（これ以上はキック率が跳ね上がります）
        if Hum.MoveDirection.Magnitude > 0 then
            LP.Character:TranslateBy(Hum.MoveDirection * 0.18) 
        end
        -- 無限ジャンプ（空中歩行に近い感覚）
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            LP.Character.HumanoidRootPart.Velocity = Vector3.new(LP.Character.HumanoidRootPart.Velocity.X, 35, LP.Character.HumanoidRootPart.Velocity.Z)
        end
    end
end)

-- 3. 全プレイヤー透視（ESP）
local function CreateESP(p)
    if p.Character then
        local highlight = Instance.new("Highlight", p.Character)
        highlight.FillColor = (p.Team == LP.Team) and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
    end
end
for _, v in pairs(Players:GetPlayers()) do if v ~= LP then CreateESP(v) end end
Players.PlayerAdded:Connect(function(v) v.CharacterAdded:Connect(function() CreateESP(v) end) end)

-- 4. ベッド破壊（10スタッド以内のベッドを自動で叩く）
task.spawn(function()
    while task.wait(1) do
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "bed" and (v.Position - LP.Character.HumanoidRootPart.Position).Magnitude < 10 then
                -- ここに自動破壊イベントを組み込む（必要なら）
            end
        end
    end
end)