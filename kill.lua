-- [[ Transformation: Pizzanini to Hydra ]] --
local p = game.Players.LocalPlayer

local function notify(msg)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local txt = Instance.new("TextLabel", sg)
    txt.Size = UDim2.new(1, 0, 0.1, 0)
    txt.Position = UDim2.new(0, 0, 0.4, 0)
    txt.Text = msg
    txt.TextColor3 = Color3.fromRGB(255, 100, 0) -- オレンジ色
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    task.delay(4, function() sg:Destroy() end)
end

-- 実行時にこれが出るか確認
notify("TARGET: PIZZANINI -> HYDRA")

task.spawn(function()
    while task.wait(0.5) do
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- トレードの表示枠を見つける
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("Transformed") then
                -- 枠の中に「Pizzanini」という名前があるか探す
                local pizzanini = v:FindFirstChild("Nubini Pizzanini", true) or v:FindFirstChildOfClass("Model")
                
                if pizzanini then
                    -- ヒドラのモデルをデータ（図鑑など）から探す
                    local hydra = game:GetService("ReplicatedStorage"):FindFirstChild("Hydra Dragon Cannelloni", true)
                    
                    if hydra then
                        -- ピザニーニを透明にする
                        for _, part in pairs(pizzanini:GetDescendants()) do
                            if part:IsA("BasePart") then part.Transparency = 1 end
                        end
                        
                        -- ヒドラをピザニーニの場所に召喚
                        local clone = hydra:Clone()
                        clone.Parent = pizzanini
                        if clone:IsA("Model") and pizzanini.PrimaryPart then
                            clone:SetPrimaryPartCFrame(pizzanini.PrimaryPart.CFrame)
                        end
                        
                        local tag = Instance.new("BoolValue", v)
                        tag.Name = "Transformed"
                        notify("PIZZANINI IS NOW HYDRA!")
                    end
                end
            end
        end
    end
end)