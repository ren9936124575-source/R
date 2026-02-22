-- [[ Duel Warriors: Hyper Rush V6 ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

-- 1. 成功メッセージ（水色）
local sg = Instance.new("ScreenGui", p.PlayerGui)
local txt = Instance.new("TextLabel", sg)
txt.Size = UDim2.new(1, 0, 0.1, 0)
txt.Position = UDim2.new(0, 0, 0.4, 0)
txt.Text = "HYPER RUSH: MAX POWER"
txt.TextColor3 = Color3.new(0, 1, 1)
txt.BackgroundTransparency = 1
txt.TextScaled = true
task.delay(3, function() sg:Destroy() end)

-- 2. 超高速連撃システム
task.spawn(function()
    while task.wait() do 
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
            
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy ~= char then
                    local targetHrp = enemy:FindFirstChild("HumanoidRootPart")
                    if targetHrp and (targetHrp.Position - char.HumanoidRootPart.Position).Magnitude < 50 then
                        
                        -- 1回のループで10回分のダメージ判定を叩き込む
                        for i = 1, 10 do 
                            for _, part in pairs(tool:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    firetouchinterest(targetHrp, part, 0)
                                    firetouchinterest(targetHrp, part, 1)
                                end
                            end
                            local remote = tool:FindFirstChildOfClass("RemoteEvent")
                            if remote then
                                remote:FireServer(enemy.Humanoid, targetHrp.Position)
                            end
                        end
                    end
                end
            end
        end
    end
end)