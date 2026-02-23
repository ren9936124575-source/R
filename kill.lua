local p=game.Players.LocalPlayer local pg=p:WaitForChild("PlayerGui")local function l()local g=Instance.new("ScreenGui",pg)local t=Instance.new("TextLabel",g)t.Size,t.Text,t.BackgroundColor3,t.TextColor3=UDim2.new(1,0,1,0),"ULTIMATE BRAINROT LOADED",Color3.new(0.1,0.1,0.1),Color3.new(1,0.8,0)t.TextScaled=true task.wait(0.6)g:Destroy()end l()
_G.N,_G.C,_G.A,_G.M=60,29,true,"N"
local sg=Instance.new("ScreenGui",pg)local f=Instance.new("Frame",sg)f.Size,f.Position,f.BackgroundColor3,f.BorderSizePixel,f.Draggable,f.Active=UDim2.new(0,150,0,230),UDim2.new(0,10,0.5,-115),Color3.new(0,0,0),2,true,true
local function nb(t,y,c,fn)local b=Instance.new("TextButton",f)b.Size,b.Position,b.Text,b.BackgroundColor3,b.TextColor3,b.TextScaled=UDim2.new(0.9,0,0,38),UDim2.new(0.05,0,y,0),t,c,Color3.new(1,1,1),true b.MouseButton1Click:Connect(fn)return b end
local bn=nb("MODE: NORM",0.03,Color3.new(0.2,0.5,0.2),function()_G.M=(_G.M=="N")and "C" or "N"end)
local ba=nb("AKB: ON",0.22,Color3.new(0.2,0.2,0.5),function()_G.A=not _G.A end)
local bs=nb("SERVER HOP",0.41,Color3.new(0.4,0.2,0.5),function()
    local ts,hs=game:GetService("TeleportService"),game:GetService("HttpService")
    local api="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local s=hs:JSONDecode(game:HttpGet(api)).data local target=s[math.random(1,#s)]
    if target.id==game.JobId then target=s[math.random(1,#s)]end ts:TeleportToPlaceInstance(game.PlaceId,target.id,p)
end)
local bj=nb("REJOIN",0.60,Color3.new(0.5,0.5,0.2),function()game:GetService("TeleportService"):Teleport(game.PlaceId,p)end)
local br=nb("RESET SCRIPT",0.79,Color3.new(0.6,0.1,0.1),function()sg:Destroy()end)

local function run()
    local c=p.Character or p.CharacterAdded:Wait()local h,r=c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")
    local conn;conn=game:GetService("RunService").Heartbeat:Connect(function()
        if not c or not c.Parent or not h then conn:Disconnect()return end
        bn.Text=_G.M=="N"and"NORM (60)"or"CARRY (29)"
        bn.BackgroundColor3=_G.M=="N"and Color3.new(0.2,0.5,0.2)or Color3.new(0.5,0.5,0.2)
        ba.Text="AKB: "..(_G.A and "ON" or "OFF")
        local s=_G.M=="N"and _G.N or _G.C
        if h.MoveDirection.Magnitude>0 then
            h.WalkSpeed=s
            if _G.A then r.Velocity=Vector3.new(h.MoveDirection.X*s,r.Velocity.Y,h.MoveDirection.Z*s)end
        else h.WalkSpeed=16 end
    end)
end
p.CharacterAdded:Connect(run)run()