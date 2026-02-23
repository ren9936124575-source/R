local p=game.Players.LocalPlayer local pg=p:WaitForChild("PlayerGui")local function l()local g=Instance.new("ScreenGui",pg)local t=Instance.new("TextLabel",g)t.Size,t.Text,t.BackgroundColor3,t.TextColor3=UDim2.new(1,0,1,0),"SYSTEM READY",Color3.new(0,0,0),Color3.new(1,1,1)t.TextScaled=true task.wait(0.5)g:Destroy()end l()local c=p.Character or p.CharacterAdded:Wait()local h,r=c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")_G.N,_G.C,_G.A=75,40,true

-- ビーム演出
local a0=Instance.new("Attachment",r)local a1=Instance.new("Attachment")local b=Instance.new("Beam",r)b.Attachment0,b.Attachment1,b.Width0,b.Width1,b.Color=a0,a1,0.1,0.1,ColorSequence.new(Color3.new(0,1,1))

-- GUI構築
local sg=Instance.new("ScreenGui",pg)local f=Instance.new("Frame",sg)f.Size,f.Position,f.BackgroundColor3,f.Draggable,f.Active=UDim2.new(0,160,0,140),UDim2.new(0,10,0.5,-70),Color3.new(0,0,0),true,true

local function createInput(label, y, default, callback)
    local t=Instance.new("TextLabel",f)t.Size,t.Position,t.Text,t.TextColor3,t.BackgroundTransparency=UDim2.new(0.4,0,0,30),UDim2.new(0,5,y,0),label,Color3.new(1,1,1),1 t.TextScaled=true
    local i=Instance.new("TextBox",f)i.Size,i.Position,i.Text,i.BackgroundColor3,i.TextColor3=UDim2.new(0.5,0,0,30),UDim2.new(0.45,0,y,0),tostring(default),Color3.new(0.2,0.2,0.2),Color3.new(1,1,1)i.TextScaled=true
    i.FocusLost:Connect(function() callback(tonumber(i.Text) or default) end)
end

createInput("Norm:", 0.1, _G.N, function(v) _G.N=v end)
createInput("Carry:", 0.4, _G.C, function(v) _G.C=v end)
local akb=Instance.new("TextButton",f)akb.Size,akb.Position,akb.Text=UDim2.new(0.9,0,0,30),UDim2.new(0.05,0,0.7,0), "AKB: ON"
akb.MouseButton1Click:Connect(function() _G.A=not _G.A akb.Text="AKB: "..(_G.A and "ON" or "OFF") end)

-- CFrame移動ループ（爆速対応）
game:GetService("RunService").Heartbeat:Connect(function(d)
    local held=c:FindFirstChildOfClass("Tool") or c:FindFirstChild("Pet") or c:FindFirstChild("Carry")
    local s = held and _G.C or _G.N
    if h.MoveDirection.Magnitude>0 then
        r.CFrame=r.CFrame+(h.MoveDirection*(s/10)*d*60)
        if held then
            local target=held:FindFirstChildWhichIsA("BasePart",true)
            if target then a1.Parent,a1.WorldPosition,b.Enabled=target,target.Position,true else b.Enabled=false end
        else b.Enabled=false end
    else b.Enabled=false end
    if _G.A then r.Velocity=Vector3.new(0,r.Velocity.Y,0) end
end)