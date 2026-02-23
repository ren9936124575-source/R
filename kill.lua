local p=game.Players.LocalPlayer local pg=p:WaitForChild("PlayerGui")local rs=game:GetService("RunService")local function l()local g=Instance.new("ScreenGui",pg)local t=Instance.new("TextLabel",g)t.Size,t.Text,t.BackgroundColor3,t.TextColor3=UDim2.new(1,0,1,0),"ULTIMATE UI SYSTEM READY",Color3.new(0,0,0),Color3.new(1,1,1)t.TextScaled=true task.wait(0.5)g:Destroy()end l()
_G.N,_G.C,_G.A,_G.M,_G.NC,_G.HB,_G.V=59,29,true,"N",false,false,true -- Nを59に設定

-- UIの永続化処理
if pg:FindFirstChild("UltimateGui") then pg.UltimateGui:Destroy() end
local sg=Instance.new("ScreenGui",pg)sg.Name="UltimateGui"sg.ResetOnSpawn=false -- 死んでもUIを消さない設定

local f=Instance.new("Frame",sg)f.Size,f.Position,f.BackgroundColor3,f.Draggable,f.Active,f.Visible=UDim2.new(0,160,0,280),UDim2.new(0,10,0.5,-140),Color3.new(0,0,0),true,true,_G.V
local function nb(t,y,c,fn,pa)local b=Instance.new("TextButton",pa or f)b.Size,b.Position,b.Text,b.BackgroundColor3,b.TextColor3,b.TextScaled=UDim2.new(0.9,0,0,32),UDim2.new(0.05,0,y,0),t,c,Color3.new(1,1,1),true b.MouseButton1Click:Connect(fn)return b end

-- 開閉ボタン（常に表示）
local tgl=Instance.new("TextButton",sg)tgl.Size,tgl.Position,tgl.Text,tgl.BackgroundColor3,tgl.TextColor3=UDim2.new(0,60,0,30),UDim2.new(0,10,0.5,-180), "O/C", Color3.new(0.1,0.1,0.1), Color3.new(1,1,1)
tgl.MouseButton1Click:Connect(function()_G.V=not _G.V f.Visible=_G.V end)

local b1=nb("MODE: NORM",0.02,Color3.new(0.2,0.5,0.2),function()_G.M=(_G.M=="N")and "C" or "N"end)
local b2=nb("AKB: ON",0.16,Color3.new(0.2,0.2,0.5),function()_G.A=not _G.A end)
local b3=nb("NOCLIP: OFF",0.30,Color3.new(0.4,0.4,0.4),function()_G.NC=not _G.NC end)
local b4=nb("HITBOX: OFF",0.44,Color3.new(0.5,0.2,0.5),function()_G.HB=not _G.HB end)
local b5=nb("SERVER HOP",0.58,Color3.new(0.3,0.3,0.3),function()
    local ts,hs=game:GetService("TeleportService"),game:GetService("HttpService")
    local api="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local s=hs:JSONDecode(game:HttpGet(api)).data local target=s[math.random(1,#s)]
    ts:TeleportToPlaceInstance(game.PlaceId,target.id,p)
end)
local b6=nb("REJOIN",0.72,Color3.new(0.4,0.4,0.1),function()game:GetService("TeleportService"):Teleport(game.PlaceId,p)end)
local b7=nb("CLOSE ALL",0.86,Color3.new(0.6,0,0),function()sg:Destroy()end)

local function run()
    local c=p.Character or p.CharacterAdded:Wait()
    local h,r=c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")
    local conn;conn=rs.Heartbeat:Connect(function()
        if not c or not c.Parent or not h or h.Health<=0 then conn:Disconnect() return end
        b1.Text=_G.M=="N"and"NORM (59)"or"CARRY (29)" b1.BackgroundColor3=_G.M=="N"and Color3.new(0.2,0.5,0.2)or Color3.new(0.5,0.5,0)
        b2.Text="AKB: "..(_G.A and "ON" or "OFF")
        b3.Text="NOCLIP: "..(_G.NC and "ON" or "OFF")
        b4.Text="HITBOX: "..(_G.HB and "ON" or "OFF")
        local s=_G.M=="N"and _G.N or _G.C
        if h.MoveDirection.Magnitude>0 then
            h.WalkSpeed=s
            if _G.A then r.Velocity=Vector3.new(h.MoveDirection.X*s,r.Velocity.Y,h.MoveDirection.Z*s)end
        else h.WalkSpeed=16 end
        if _G.NC then for _,v in pairs(c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end
        if _G.HB then
            for _,v in pairs(game.Players:GetPlayers())do
                if v~=p and v.Character and v.Character:FindFirstChild("HumanoidRootPart")then
                    local target=v.Character.HumanoidRootPart
                    target.Size,target.Transparency,target.CanCollide=Vector3.new(10,10,10),0.5,false
                end
            end
        end
    end)
end
p.CharacterAdded:Connect(run)run()