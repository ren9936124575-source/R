-- [[ ULTIMATE SNATCHER: Parts & Mesh Copy ]] --
local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

local function notify(msg, color)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local txt = Instance.new("TextLabel", sg)
    txt.Size = UDim2.new(1, 0, 0.2, 0)
    txt.Position = UDim2.new(0, 0, 0.3, 0)
    txt.Text = msg
    txt.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    task.delay(4, function() sg:Destroy() end)
end

notify("GOD MODE: SNATCH EVERYTHING NEARBY", Color3.fromRGB(255, 100, 0))

-- 1m以内の物体を探す（ModelでなくてもOK）
local function findNearbyObject()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- キャラクター自身とベースプレート以外を探す
        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) and obj.Name ~= "BasePlate" then
            local dist = (root.Position - obj.Position).Magnitude
            if dist < 2.5 then -- 約1m以内
                -- 親がModelならそのModelを、そうでなければパーツ単体を返す
                return obj.Parent:IsA("Model") and obj.Parent or obj
            end
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.3) do
        local target = findNearbyObject()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- テキスト上書き（ターゲットの名前か、なければデフォルト）
            if v:IsA("TextLabel") and v.Visible then
                if v.Text:find("Pizzanini") or v.Text:find("Nubini") then
                    v.Text = target and target.Name or "Cloned Pet"
                    v.TextColor3 = Color3.fromRGB(0, 255, 200)
                elseif v.Text:find("/") or v.Text:find("Money") then
                    v.Text = "999.9T/s [MAX]" -- ステータスは最強で固定
                end
            end

            -- 姿を強制コピー（ここが重要）
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("ForceCloned") then
                local modelInView = v:FindFirstChildOfClass("Model")
                if modelInView and target then
                    -- 元のピザニーニを完全に消去
                    for _, child in pairs(modelInView:GetChildren()) do
                        child:Destroy()
                    end
                    
                    -- ターゲットを複製して中に入れる
                    local clone = target:Clone()
                    if clone:IsA("BasePart") then
                        -- 単体パーツの場合、Modelに入れてから追加
                        local newM = Instance.new("Model", modelInView)
                        clone.Parent = newM
                    else
                        clone.Parent = modelInView
                    end
                    
                    -- 見えやすく調整
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "ForceCloned"
                    notify("🔥 CRITICAL SNATCH SUCCESS! 🔥", Color3.fromRGB(255, 0, 0))
                end
            end
        end
    end
end)