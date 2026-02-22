-- [[ Duel Warriors: GitHub Cloud Edition ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

-- 1. 実行時に画面に「起動成功」と表示する
local sg = Instance.new("ScreenGui", p.PlayerGui)
local txt = Instance.new("TextLabel", sg)
txt.Size = UDim2.new(1, 0, 0.1, 0)
txt.Position = UDim2.new(0, 0, 0.4, 0)
txt.Text = "GITHUB SCRIPT LOADED: ACTIVE"
txt.TextColor3 = Color3.new(0, 1, 0)
txt.BackgroundTransparency = 1
txt.TextScaled = true
task.delay(3, function() sg:Destroy() end)

-- 2. 攻撃ループ（仮想クリック + ダメージ信号送信）
task.spawn(function()
    while task.wait(0.1) do
        -- 武器を自動で振る
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
        
        -- 周囲の敵を探してダメージ信号を飛ばす
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                for _, enemy in pairs(workspace:GetChildren()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy ~= char then
                        local root = enemy:FindFirstChild("HumanoidRootPart")
                        if root and (root.Position - char.HumanoidRootPart.Position).Magnitude < 100 then
                            -- サーバーへ「攻撃が当たった」という信号を強制送信
                            v:FireServer(enemy.Humanoid)
                        end
                    end
                end
            end
        end
    end
end)

print("Script Successfully Uploaded to GitHub!")
