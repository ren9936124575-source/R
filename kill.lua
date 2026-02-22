-- [[ Hydra Cannelloni GOLD VERSION ]] --
local p = game.Players.LocalPlayer

local function notify(msg)
    local sg = Instance.new("ScreenGui", p.PlayerGui)
    local txt = Instance.new("TextLabel", sg)
    txt.Size = UDim2.new(1, 0, 0.1, 0)
    txt.Position = UDim2.new(0, 0, 0.4, 0)
    txt.Text = msg
    txt.TextColor3 = Color3.fromRGB(255, 170, 0) -- 絶対にオレンジ色（金）
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    task.delay(4, function() sg:Destroy() end)
end

-- 実行時にこの文字が出るか確認！
notify("HYDRA CANNELLONI: GOLD READY!")

task.spawn(function()
    while task.wait(0.5) do
        for _, v in pairs(p.PlayerGui:GetDescendants()) do
            if v:IsA("ViewportFrame") and v.Visible and not v:FindFirstChild("GoldDone") then
                local myModel = v:FindFirstChild(p.Name) or v:FindFirstChildOfClass("Model")
                if myModel then
                    -- 図鑑やメモリから「Hydra Dragon Cannelloni」を徹底的に探す
                    local target = nil
                    for _, obj in pairs(game:GetDescendants()) do
                        if (obj:IsA("Model") or obj:IsA("MeshPart")) and obj.Name:find("Hydra") then
                            target = obj
                            break
                        end
                    end
                    
                    if target then
                        for _, part in pairs(myModel:GetDescendants()) do
                            if part:IsA("BasePart") then part.Transparency = 1 end
                        end
                        local clone = target:Clone()
                        clone.Parent = myModel
                        local tag = Instance.new("BoolValue", v)
                        tag.Name = "GoldDone"
                        notify("HYDRA APPEARED!")
                    end
                end
            end
        end
    end
end)