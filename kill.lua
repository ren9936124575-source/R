-- [[ Hydra Dragon Spoofer: Final Fix ]] --
local p = game.Players.LocalPlayer

-- 1. 実行した瞬間に通知を出す（これが出れば成功）
local function notify(msg)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local txt = Instance.new("TextLabel", sg)
    txt.Size = UDim2.new(1, 0, 0.2, 0)
    txt.Position = UDim2.new(0, 0, 0.4, 0)
    txt.Text = msg
    txt.TextColor3 = Color3.fromRGB(180, 0, 255)
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    task.delay(5, function() sg:Destroy() end)
end

notify("HYDRA SCRIPT: READY! GO TO TRADE!") -- ← これが表示されるはず！

-- 2. トレード画面を監視するメイン処理
task.spawn(function()
    while task.wait(0.5) do
        for _, gui in pairs(p.PlayerGui:GetDescendants()) do
            if gui:IsA("ViewportFrame") and not gui:FindFirstChild("HydraSync") then 
                -- 自分のキャラ（名前がついたモデル）を探す
                local myModel = gui:FindFirstChild(p.Name) or gui:FindFirstChildOfClass("Model")
                
                if myModel then
                    local tag = Instance.new("BoolValue", myModel)
                    tag.Name = "HydraSync"

                    -- 読み込み演出
                    task.spawn(function()
                        -- 図鑑やストレージからヒドラドラゴンを探す
                        local ref = game:GetService("ReplicatedStorage"):FindFirstChild("Hydra Dragon", true)
                        
                        if ref then
                            -- 元のキャラを透明にする
                            for _, v in pairs(myModel:GetDescendants()) do
                                if v:IsA("BasePart") then v.Transparency = 1 end
                            end
                            
                            -- ヒドラドラゴンを表示
                            local clone = ref:Clone()
                            clone.Parent = myModel
                            if myModel.PrimaryPart then
                                clone:SetPrimaryPartCFrame(myModel.PrimaryPart.CFrame)
                            end
                        end
                    end)
                end
            end
        end
    end
end)