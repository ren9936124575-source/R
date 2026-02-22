-- [[ Ultimate Hydra Sync: Stats & Model & Notify ]] --
local p = game.Players.LocalPlayer

-- 通知を出す関数（目立つように改良）
local function notify(msg, color)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local txt = Instance.new("TextLabel", sg)
    txt.Size = UDim2.new(1, 0, 0.2, 0)
    txt.Position = UDim2.new(0, 0, 0.3, 0)
    txt.Text = msg
    txt.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    txt.Font = Enum.Font.SourceSansBold
    task.delay(5, function() sg:Destroy() end)
end

notify("HYDRA SCANNER: ACTIVE", Color3.fromRGB(255, 255, 0)) -- 起動時は黄色

-- 基地のヒドラから「名前」と「稼ぐ量」と「姿」を取得する
local function getHydraData()
    local data = {model = nil, stats = "1.25T/s"} -- デフォルト値
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:find("Hydra") or obj.Name:find("Cannelloni")) then
            data.model = obj
            -- もし基地のヒドラにステータス表示（BillboardGuiなど）があればそこから数字を盗む
            local textLabel = obj:FindFirstChildWhichIsA("TextLabel", true)
            if textLabel then
                data.stats = textLabel.Text
            end
            break
        end
    end
    return data
end

task.spawn(function()
    while task.wait(0.3) do
        local hydraData = getHydraData()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- 1. トレード画面の文字を書き換え
            if v:IsA("TextLabel") and v.Visible then
                if v.Text:find("Pizzanini") or v.Text:find("Nubini") then
                    v.Text = "Hydra Dragon Cannelloni"
                    v.TextColor3 = Color3.fromRGB(255, 120, 0)
                elseif v.Text:find("/") or v.Text:find("Money") or v.Text:find("Speed") then
                    v.Text = hydraData.stats -- 基地のヒドラと同じ数字にする
                    v.TextColor3 = Color3.fromRGB(0, 255, 150)
                end
            end

            -- 2. 姿を書き換え（コピー完了通知付き）
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("SyncDone") then
                local model = v:FindFirstChildOfClass("Model")
                if model and hydraData.model then
                    -- 元のピザニーニを消す
                    for _, part in pairs(model:GetDescendants()) do
                        if part:IsA("BasePart") then part.Transparency = 1 end
                    end
                    
                    -- 基地のヒドラを完璧にコピー
                    local clone = hydraData.model:Clone()
                    clone.Parent = model
                    if model.PrimaryPart then
                        clone:SetPrimaryPartCFrame(model.PrimaryPart.CFrame)
                    end
                    
                    -- 完了タグと通知
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "SyncDone"
                    
                    -- ★ここに通知を追加！
                    notify("✨ HYDRA FULL COPIED! ✨", Color3.fromRGB(0, 255, 255))
                end
            end
        end
    end
end)
