-- [[ PRECISION SNATCHER: 1m Range Copy ]] --
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

notify("PRECISION MODE: STAND ON YOUR PET", Color3.fromRGB(255, 255, 255)) -- 白色

local function snatchNearbyPet()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local closestModel = nil
    local shortestDist = 1.5 -- 半径約1メートル（1.5スタッド）に絞り込み

    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Model") and not obj:IsDescendantOf(char) then
            local objRoot = obj:FindFirstChildWhichIsA("BasePart", true)
            if objRoot then
                local dist = (root.Position - objRoot.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestModel = obj
                end
            end
        end
    end
    return closestModel
end

task.spawn(function()
    while task.wait(0.3) do
        local targetPet = snatchNearbyPet()
        
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            -- 名前とステータス固定
            if v:IsA("TextLabel") and v.Visible then
                if v.Text:find("Pizzanini") or v.Text:find("Nubini") then
                    v.Text = "Hydra Dragon Cannelloni"
                    v.TextColor3 = Color3.fromRGB(255, 120, 0)
                elseif v.Text:find("/") or v.Text:find("Money") then
                    v.Text = "1.25T/s [MAX]" 
                end
            end

            -- 1m以内のモデルを強制コピー
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("Snatch1mDone") then
                local modelInView = v:FindFirstChildOfClass("Model")
                if modelInView and targetPet then
                    for _, part in pairs(modelInView:GetDescendants()) do
                        if part:IsA("BasePart") then part.Transparency = 1 end
                    end
                    
                    local clone = targetPet:Clone()
                    clone.Parent = modelInView
                    if modelInView.PrimaryPart then
                        clone:SetPrimaryPartCFrame(modelInView.PrimaryPart.CFrame)
                    end
                    
                    local tag = Instance.new("BoolValue", v)
                    tag.Name = "Snatch1mDone"
                    notify("🎯 PRECISION SNATCH SUCCESS! 🎯", Color3.fromRGB(255, 255, 0))
                end
            end
        end
    end
end)