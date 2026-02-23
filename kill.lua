local p=game.Players.LocalPlayer local pg=p:WaitForChild("PlayerGui")local function l()local g=Instance.new("ScreenGui",pg)local t=Instance.new("TextLabel",g)t.Size,t.Text,t.BackgroundColor3,t.TextColor3=UDim2.new(1,0,1,0),"FAST SWITCH READY",Color3.new(0,0,0),Color3.new(1,1,1)t.TextScaled=true task.wait(0.5)g:Destroy()end l()
_G.N,_G.C,_G.A,_G.Mode=75,35,true,"N" -- 初期値設定

local sg=Instance.new("ScreenGui",pg)local f=Instance.new("Frame",sg)f.Size,f.Position,f.BackgroundColor3,f.Draggable,f.Active=UDim2.new(0,140,0,150),UDim2.new(0,10,0.5,-75),Color3.new(0,0,0),true,true
local function nb(t,y,c,fn)local b=Instance.new("TextButton",f)b.Size,b.Position,b.Text,b.BackgroundColor3,b.TextColor3,b.TextScaled=UDim2.new(0.9,0,0,40),UDim2.new(0.05,0,y,0),t,c,Color3.new(1,1,1),true b.MouseButton1Click:Connect(fn)return b end

local bn=nb("MODE: NORM",0.05,Color3.new(0.2,0.5,0.2),function()
    _G.Mode=(_G.Mode=="N")and "C" or "N"
end)
local ba=nb("AKB: ON",0.38,Color3.new(0.2,0.2,0.5),function()
    _G.A=not _G.A
end)
local breset=nb("RESET SPEED",0.71,Color3.new(0.5,0.2,0.2),function()
    p.Character.Humanoid.WalkSpeed=16 _G.Mode="N"
end)

local function run()
    local c=p.Character or p.CharacterAdded:Wait()local h,r=c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")
    local conn;conn=game:GetService("RunService").Heartbeat:Connect(function()
        if not c or not c.Parent or not h then conn:Disconnect()return end
        
        -- ボタン表示更新
        bn.Text=_G.Mode=="N" and "MODE: NORM (75)" or "MODE: CARRY (35)"
        bn.BackgroundColor3=_G.Mode=="N" and Color3.new(0.2,0.5,0.2) or Color3.new(0.5,0.5,0.2)
        ba.Text="AKB: "..(_G.A and "ON" or "OFF")
        
        local s=_G.Mode=="N" and _G.N or _G.C
        if h.MoveDirection.Magnitude>0 then
            h.WalkSpeed=s
            if _G.A then r.Velocity=Vector3.new(h.MoveDirection.X*s,r.Velocity.Y,h.MoveDirection.Z*s)end
        else h.WalkSpeed=16 end
    end)
end
p.CharacterAdded:Connect(run)run()