-- [[ Duel Warriors: Ultimate All-In-One ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

-- 1. 起動メッセージ（青文字）
local sg = Instance.new("ScreenGui", p.PlayerGui)
local txt = Instance.new("TextLabel", sg)
txt.Size = UDim2.new(1, 0, 0.1, 0)
txt.Position = UDim2.new(0, 0, 0.4, 0)
txt.Text = "ULTIMATE MODE: ACTIVE"
txt.TextColor3 = Color3.new(0, 0.5, 1)
txt.BackgroundTransparency = 1
txt.TextScaled = true
task.delay(3, function() sg:Destroy() end)

-- 2. 攻撃システム
task.spawn(function()
    while task.wait(0.1) do
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate() -- 武器を振る
            
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy ~= char then
                    local targetRoot = enemy:FindFirstChild("HumanoidRootPart")
                    if targetRoot and (targetRoot.Position - char.HumanoidRootPart.Position).Magnitude < 100 then
                        
                        -- 【パターンA】リモートイベント全送信
                        for _, v in pairs(game:GetDescendants()) do
                            if v:IsA("RemoteEvent") and (v.Name:find("Hit") or v.Name:find("Attack") or v.Name:find("Damage")) then
                                v:FireServer(enemy.Humanoid, targetRoot.Position)
                            end
                        end
                        
                        -- 【パターンB】物理接触の強制実行
                        if tool:FindFirstChild("Handle") then
                            firetouchinterest(targetRoot, tool.Handle, 0)
                            firetouchinterest(targetRoot, tool.Handle, 1)
                        end
                    end
                end
            end
        end
    end
end)
