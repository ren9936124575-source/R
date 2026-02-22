-- [[ Duel Warriors: God Hitbox V3 ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

-- 1. 成功メッセージ（紫文字）
local sg = Instance.new("ScreenGui", p.PlayerGui)
local txt = Instance.new("TextLabel", sg)
txt.Size = UDim2.new(1, 0, 0.1, 0)
txt.Position = UDim2.new(0, 0, 0.4, 0)
txt.Text = "GOD MODE V3: READY"
txt.TextColor3 = Color3.new(0.5, 0, 1)
txt.BackgroundTransparency = 1
txt.TextScaled = true
task.delay(3, function() sg:Destroy() end)

-- 2. 物理判定の強制上書き
task.spawn(function()
    while task.wait(0.3) do
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            -- 剣の判定を「見えない巨大な球体」にする
            for _, v in pairs(tool:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Size = Vector3.new(60, 60, 60) -- 判定を60マスに拡大
                    v.CanCollide = false
                    v.Massless = true
                    
                    -- 敵に触れた瞬間にダメージを強制する処理
                    v.Touched:Connect(function(hit)
                        if hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char then
                            -- サーバーに「当たった」と誤認させる信号を3連射
                            local remote = tool:FindFirstChildOfClass("RemoteEvent") or char:FindFirstChildOfClass("RemoteEvent")
                            if remote then
                                remote:FireServer(hit.Parent.Humanoid)
                                remote:FireServer()
                            end
                        end
                    end)
                end
            end
            tool:Activate() -- 常に振り続ける
        end
    end
end)
