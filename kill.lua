-- [[ BedWars Lightweight Mini-Hack ]] --
local P = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")

-- 通知（起動確認用）
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BedWars Script",
    Text = "起動成功！",
    Duration = 5
})

-- 1. キルオーラ (近くの敵を自動攻撃)
task.spawn(function()
    while task.wait(0.1) do
        local range = 15 -- 検知距離
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= P and v.Team ~= P.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (P.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist < range then
                    -- 攻撃イベントを送信（ゲーム側の仕様に合わせて自動調整）
                    local sword = P.Character:FindFirstChildOfClass("Tool")
                    if sword then
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetAccelContainer.replicated_storage.events.combat.sword_hit:FireServer({
                            ["entityInstance"] = v.Character
                        })
                    end
                end
            end
        end
    end
end)

-- 2. スピードハック & ノックバック無効 (検知されにくい強度)
RS.Heartbeat:Connect(function()
    if P.Character and P.Character:FindFirstChild("Humanoid") then
        -- スピード (16が通常、22くらいまでが安全)
        P.Character.Humanoid.WalkSpeed = 21
        
        -- ノックバック無効 (吹き飛ばされない)
        if P.Character.HumanoidRootPart.Velocity.Y > 0 then
            P.Character.HumanoidRootPart.Velocity = Vector3.new(P.Character.HumanoidRootPart.Velocity.X, 0, P.Character.HumanoidRootPart.Velocity.Z)
        end
    end
end)

-- 3. ESP (敵の場所を透視)
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= P and v.Character then
        local highlight = Instance.new("Highlight", v.Character)
        highlight.FillColor = Color3.new(1, 0, 0)
    end
end