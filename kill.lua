-- [[ MEGA SYNC: Auto-Detect Model & Stats ]] --
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
    task.delay(4, function() sg:Destroy() end)
end

notify("AUTO SCANNING... STAND NEAR HYDRA", Color3.fromRGB(255, 255, 0))

-- 名前に関わらず、基地にある「一番それっぽいモデル」を盗む関数
local function findAnythingOnBase()
    -- 基地（Workspace）の中から、プレイヤーの近くにあるモデルを探す
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= p.Character then
            -- ヒドラやカネローニという文字が含まれていれば確定
            if obj.Name:lower():find("hydra") or obj.Name:lower():find("cannelloni") or obj.Name:lower():find("dragon") then
                return obj
            end
        end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.3) do
        local bestPet = findAnythingOnBase()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- テキスト書き換え
            if v:IsA("TextLabel") and v.Visible then
                if v.Text:find("Pizzanini") or v.Text:find("Nubini") then
                    v.Text = "Hydra Dragon Cannelloni" -- ここで本物の名前に固定
                    v.TextColor3 = Color3.fromRGB(255, 120, 0)
                end
            end

            -- 姿の書き換え
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("AutoDone") then
                local model = v:FindFirstChildOfClass("Model")
                if model and bestPet then
                    for _, part in pairs(model:GetDescendants()) do
                        if part:IsA("BasePart") then part.Transparency = 1 end
                    end
                    
                    local clone = bestPet:Clone()
                    clone.Parent = model
                    if model.PrimaryPart then clone:SetPrimaryPartCFrame(model.PrimaryPart.CFrame) end
                    
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "AutoDone"
                    notify("🔥 HYDRA DETECTED & COPIED! 🔥", Color3.fromRGB(0, 255, 0))
                end
            end
        end
    end
end)