-- [[ TOTAL CLONE: 1m Precision Full Copy ]] --
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

notify("READY TO CLONE ANYTHING", Color3.fromRGB(0, 255, 255))

-- 1m以内のターゲットから「全て」を盗む関数
local function getEverythingFromTarget()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local target = nil
    local distLimit = 2.0 -- 約1メートル

    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and not obj:IsDescendantOf(char) then
            local objRoot = obj:FindFirstChildWhichIsA("BasePart", true)
            if objRoot then
                local d = (root.Position - objRoot.Position).Magnitude
                if d < distLimit then
                    target = obj
                    break
                end
            end
        end
    end
    return target
end

task.spawn(function()
    while task.wait(0.3) do
        local target = getEverythingFromTarget()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- 1. 名前とステータスをターゲットから盗んで上書き
            if v:IsA("TextLabel") and v.Visible then
                if v.Text:find("Pizzanini") or v.Text:find("Nubini") then
                    if target then
                        v.Text = target.Name -- ターゲットの名前をそのままコピー
                    end
                    v.TextColor3 = Color3.fromRGB(255, 120, 0)
                elseif v.Text:find("/") or v.Text:find("Money") then
                    if target then
                        -- ターゲットに付いている数字をスキャンして盗む
                        local stats = target:FindFirstChildWhichIsA("TextLabel", true)
                        v.Text = stats and stats.Text or "2.5T/s [MAX]"
                    end
                end
            end

            -- 2. 姿・エフェクト・変異を完全にコピー
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("TotalCloned") then
                local modelInView = v:FindFirstChildOfClass("Model")
                if modelInView and target then
                    -- 元のピザニーニを消す
                    for _, part in pairs(modelInView:GetDescendants()) do
                        if part:IsA("BasePart") then part.Transparency = 1 end
                    end
                    
                    -- ターゲットを丸ごと複製（変異・オーラ・パーツ全部）
                    local clone = target:Clone()
                    clone.Parent = modelInView
                    if modelInView.PrimaryPart then
                        clone:SetPrimaryPartCFrame(modelInView.PrimaryPart.CFrame)
                    else
                        local b = clone:FindFirstChildWhichIsA("BasePart", true)
                        if b then b.CFrame = CFrame.new(0,0,0) end
                    end
                    
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "TotalCloned"
                    notify("✨ TOTAL CLONE SUCCESS: "..target.Name.." ✨", Color3.fromRGB(0, 255, 0))
                end
            end
        end
    end
end)