-- [[ Trade Brainrot: Hydra Dragon Hydra-Link V2 ]] --
local p = game.Players.LocalPlayer

-- 1. ターゲット
local TARGET_NAME = "Hydra Dragon"

-- 2. 常時監視・モデル書き換えループ
task.spawn(function()
    while task.wait(0.5) do
        for _, gui in pairs(p.PlayerGui:GetDescendants()) do
            -- トレード画面の表示枠を探す
            if gui:IsA("ViewportFrame") and gui.Parent.Name ~= "Collection" then 
                local myModel = gui:FindFirstChild(p.Name) or gui:FindFirstChildOfClass("Model")
                
                if myModel and not myModel:FindFirstChild("HydraSync") then
                    -- 自分のキャラを透明化
                    for _, part in pairs(myModel:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("Decal") then
                            part.Transparency = 1
                        end
                    end

                    -- 【図鑑やストレージからモデルを抽出】
                    local ref = nil
                    -- 方法1: ReplicatedStorageから探す
                    ref = game:GetService("ReplicatedStorage"):FindFirstChild(TARGET_NAME, true)
                    
                    -- 方法2: 見つからない場合、図鑑(Collection)の表示データから盗む
                    if not ref then
                        for _, c in pairs(p.PlayerGui:GetDescendants()) do
                            if c.Name == "Collection" and c:FindFirstChild(TARGET_NAME, true) then
                                ref = c:FindFirstChild(TARGET_NAME, true)
                                break
                            end
                        end
                    end
                    
                    if ref then
                        local fakeHydra = ref:Clone()
                        fakeHydra.Parent = myModel
                        
                        -- 位置調整
                        if myModel:IsA("Model") and myModel.PrimaryPart then
                            if fakeHydra:IsA("Model") then
                                fakeHydra:SetPrimaryPartCFrame(myModel.PrimaryPart.CFrame)
                            else
                                fakeHydra.CFrame = myModel.PrimaryPart.CFrame
                            end
                        end
                        
                        -- 完了タグ
                        local tag = Instance.new("BoolValue", myModel)
                        tag.Name = "HydraSync"
                    end
                end
            end
        end
    end
end)

-- 通知（超豪華な紫）
local sg = Instance.new("ScreenGui", p.PlayerGui)
local txt = Instance.new("TextLabel", sg)
txt.Size = UDim2.new(1, 0, 0.1, 0)
txt.Position = UDim2.new(0, 0, 0.3, 0)
txt.Text = "HYDRA DRAGON SYNCED FROM COLLECTION"
txt.TextColor3 = Color3.fromRGB(180, 0, 255)
txt.BackgroundTransparency = 1
txt.TextScaled = true
task.delay(3, function() sg:Destroy() end)