-- [[ GOD SYNC: Mutations, Aura, Stats & Model ]] --
local p = game.Players.LocalPlayer

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

notify("ALL-IN-ONE SYNC: READY", Color3.fromRGB(255, 0, 255)) -- 起動はマゼンタ

-- 基地のヒドラから全データを抽出する関数
local function fetchUltimateHydra()
    local source = nil
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:find("Hydra") or obj.Name:find("Cannelloni")) then
            source = obj
            break
        end
    end
    return source
end

task.spawn(function()
    while task.wait(0.3) do
        local sourceHydra = fetchUltimateHydra()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- 1. テキスト（名前・変異・稼ぐ量）の書き換え
            if v:IsA("TextLabel") and v.Visible then
                local t = v.Text
                if t:find("Pizzanini") or t:find("Nubini") then
                    v.Text = "Hydra Dragon Cannelloni"
                    v.TextColor3 = Color3.fromRGB(255, 120, 0)
                elseif t:find("Mutation") or t:find("Shiny") or t:find("Special") then
                    -- 変異情報を「本物」っぽく書き換え
                    v.Text = "MUTATION: [RARE CANNELLONI]" 
                    v.TextColor3 = Color3.fromRGB(255, 0, 255)
                elseif t:find("/") or t:find("Money") or t:find("Speed") then
                    v.Text = "1.25T/s [MAX]" -- ステータスも最強に
                end
            end

            -- 2. 姿・変異エフェクトの完全コピー
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("GodSyncDone") then
                local model = v:FindFirstChildOfClass("Model")
                if model and sourceHydra then
                    -- ピザを透明化
                    for _, part in pairs(model:GetDescendants()) do
                        if part:IsA("BasePart") then part.Transparency = 1 end
                    end
                    
                    -- 基地のヒドラ（変異エフェクト含む）を複製
                    local clone = sourceHydra:Clone()
                    clone.Parent = model
                    
                    -- 座標合わせ
                    if model.PrimaryPart then
                        clone:SetPrimaryPartCFrame(model.PrimaryPart.CFrame)
                    else
                        -- PrimaryPartがない場合の予備処理
                        local bp = clone:FindFirstChildOfClass("BasePart")
                        if bp then bp.CFrame = CFrame.new(0,0,0) end
                    end
                    
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "GodSyncDone"
                    
                    -- 成功通知
                    notify("🔥 HYDRA MUTATION SYNCED! 🔥", Color3.fromRGB(255, 100, 0))
                end
            end
        end
    end
end)