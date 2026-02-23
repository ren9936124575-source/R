local p=game.Players.LocalPlayer local pg=p:WaitForChild("PlayerGui")local function l()local g=Instance.new("ScreenGui",pg)local t=Instance.new("TextLabel",g)t.Size,t.Text,t.BackgroundColor3,t.TextColor3=UDim2.new(1,0,1,0),"GOD SPEED & ANTI-ROLLBACK READY",Color3.new(0,0,0),Color3.new(1,1,1)t.TextScaled=true task.wait(0.6)g:Destroy()end l()
_G.N,_G.C,_G.A,_G.M=100,31,true,"N" -- NORMを100に強化(チリより速い)

-- UI生成
if pg:FindFirstChild("UltimateGui") then pg.UltimateGui:Destroy() end
local sg=Instance.new("ScreenGui",pg)sg.Name="UltimateGui"
local f=Instance.new("Frame",sg)f.Size,f.Position,f.BackgroundColor3,f.Draggable,f.Active=UDim2.new(0,160,0,240),UDim2.new(0,10,0.5,-120),Color3.new(0,0,0),true,true
local function nb(t,y,c,fn)local b=Instance.new("TextButton",f)b.Size,b.Position,b.Text,b.BackgroundColor3,b.TextColor3,b.TextScaled=UDim2.new(0.9,0,0,40),UDim2.new(0.05,0,y,0),t,c,Color3.new(1,1,1),true b.MouseButton1Click:Connect(fn)return b end
local bn=nb("MODE: NORM",0.03,Color3.new(0.2,0.5,0.2),function()_G.M=(_G.M=="N")and "C" or "N"end)
local ba=nb("AKB: ON",0.22,Color3.new(0.2,0.2,0.5),function()_G.A=not _G.A end)
local bs=nb("SERVER HOP",0.41,Color3.new(0.4,0.2,0.5),function()
    local ts,hs=game:GetService("TeleportService"),game:GetService("HttpService")
    local api="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local s=hs:JSONDecode(game:HttpGet(api)).data local target=s[math.random(1,#s)]
    ts:TeleportToPlaceInstance(game.PlaceId,target.id,p)
end)
local bj=nb("REJOIN",0.60,Color3.new(0.5,0.5,0.2),function()game:GetService("TeleportService"):Teleport(game.PlaceId,p)end)
local br=nb("RESET UI",0.79,Color3.new(0.6,0.1,0.1),function()sg:Destroy()end)

-- 死んでも消えない「永続」処理
local function start()
    local c=p.Character or p.CharacterAdded:Wait()
    local h=c:WaitForChild("Humanoid")
    local r=c:WaitForChild("HumanoidRootPart")
    
    local heart;heart=game:GetService("RunService").Heartbeat:Connect(function()
        if not c or not c.Parent or not h or h.Health <= 0 then heart:Disconnect() return end
        
        bn.Text=_G.M=="N"and"GOD: 100"or"CARRY: 31"
        bn.BackgroundColor3=_G.M=="N"and Color3.new(0.5,0,0)or Color3.new(0.5,0.5,0)
        ba.Text="AKB: "..(_G.A and "ON" or "OFF")
        
        local s=_G.M=="N"and _G.N or _G.C
        if h.MoveDirection.Magnitude > 0 then
            h.WalkSpeed = s
            -- ロルバ（位置戻し）を防ぐための物理推進
            if _G.A then
                r.Velocity = Vector3.new(h.MoveDirection.X * s, r.Velocity.Y, h.MoveDirection.Z * s)
            end
        else
            h.WalkSpeed = 16
        end
    end)
end

-- リスポーン時に自動で再接続
p.CharacterAdded:Connect(start)
task.spawn(start)