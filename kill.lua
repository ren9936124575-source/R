local _1=game.Players.LocalPlayer local _2=_1:WaitForChild("PlayerGui")local _3=game:GetService("RunService")
_G.N,_G.C,_G.A,_G.M,_G.NC,_G.HB,_G.V=59,29,true,"N",false,false,true 

if _2:FindFirstChild("SystemUI") then _2.SystemUI:Destroy() end
local _4=Instance.new("ScreenGui",_2)_4.Name="SystemUI"_4.ResetOnSpawn=false
local _5=Instance.new("Frame",_4)_5.Size,_5.Position,_5.BackgroundColor3,_5.Draggable,_5.Active,_5.Visible=UDim2.new(0,160,0,300),UDim2.new(0,10,0.5,-150),Color3.new(0,0,0),true,true,_G.V

local function _6(_t,_y,_c,_f,_p)local _b=Instance.new("TextButton",_p or _5)_b.Size,_b.Position,_b.Text,_b.BackgroundColor3,_b.TextColor3,_b.TextScaled=UDim2.new(0,144,0,32),UDim2.new(0,5,_y,0),_t,_c,Color3.new(1,1,1),true _b.MouseButton1Click:Connect(_f)return _b end

-- 常駐ボタン
local _7=Instance.new("TextButton",_4)_7.Size,_7.Position,_7.Text,_7.BackgroundColor3,_7.TextColor3,_7.TextScaled=UDim2.new(0,60,0,30),UDim2.new(0,10,0.5,-180),"MENU",Color3.new(0.1,0.1,0.1),Color3.new(1,1,1),true
_7.MouseButton1Click:Connect(function()_G.V=not _G.V _5.Visible=_G.V end)
local _qs=Instance.new("TextButton",_4)_qs.Size,_qs.Position,_qs.BackgroundColor3,_qs.TextColor3,_qs.TextScaled=UDim2.new(0,100,0,30),UDim2.new(0,75,0.5,-180),Color3.new(0.2,0.5,0.2),Color3.new(1,1,1),true
_qs.MouseButton1Click:Connect(function()_G.M=(_G.M=="N")and "C" or "N" end)

-- メニューボタン
local _bn=_6("M: NORM (59)",0.02,Color3.new(0.2,0.5,0.2),function()_G.M=(_G.M=="N")and "C" or "N"end)
_6("ANTI-FREEZE: ON",0.16,Color3.new(0.2,0.2,0.5),function()_G.A=not _G.A end) -- これがメデューサ対策を兼ねる
_6("NOCLIP",0.30,Color3.new(0.4,0.4,0.4),function()_G.NC=not _G.NC end)
_6("HITBOX",0.44,Color3.new(0.5,0.2,0.5),function()_G.HB=not _G.HB end)
_6("SERVER HOP",0.58,Color3.new(0.3,0.3,0.3),function()local ts,hs=game:GetService("TeleportService"),game:GetService("HttpService")local api="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"local s=hs:JSONDecode(game:HttpGet(api)).data local target=s[math.random(1,#s)]ts:TeleportToPlaceInstance(game.PlaceId,target.id,_1)end)
_6("REJOIN",0.72,Color3.new(0.4,0.4,0.1),function()game:GetService("TeleportService"):Teleport(game.PlaceId,_1)end)

local function _r()
    local _c=_1.Character or _1.CharacterAdded:Wait()
    local _h,_rt=_c:WaitForChild("Humanoid"),_c:WaitForChild("HumanoidRootPart")
    
    _h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    _h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)

    local _cn;_cn=_3.Heartbeat:Connect(function()
        if not _c or not _c.Parent or not _h or _h.Health<=0 then _cn:Disconnect()return end
        
        -- ボタン同期
        local _txt=_G.M=="N" and "NORM (59)" or "CARRY (29)"
        local _clr=_G.M=="N" and Color3.new(0.2,0.5,0.2) or Color3.new(0.5,0.5,0.2)
        _bn.Text=_txt _bn.BackgroundColor3=_clr _qs.Text=_txt _qs.BackgroundColor3=_clr
        
        -- メデューサ/硬直対策ロジック
        if _G.A then
            -- 硬直ステートを強制解除
            if _h:GetState() == Enum.HumanoidStateType.PlatformStanding or _h.PlatformStand then
                _h.PlatformStand = false
                _h:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            -- アンカー（固定）を解除
            if _rt.Anchored then _rt.Anchored = false end
        end

        -- スピード & 物理補正
        local _s=_G.M=="N"and _G.N or _G.C
        if _h.MoveDirection.Magnitude>0 then
            _h.WalkSpeed=_s
            if _G.A then 
                _rt.Velocity=Vector3.new(_h.MoveDirection.X*_s,_rt.Velocity.Y,_h.MoveDirection.Z*_s)
                _rt.RotVelocity=Vector3.new(0,0,0)
            end
        else _h.WalkSpeed=16 end
        
        if _G.NC then for _,v in pairs(_c:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end
        if _G.HB then for _,v in pairs(game.Players:GetPlayers())do if v~=_1 and v.Character and v.Character:FindFirstChild("HumanoidRootPart")then v.Character.HumanoidRootPart.Size=Vector3.new(12,12,12)v.Character.HumanoidRootPart.Transparency=0.6 end end end
    end)
end
_1.CharacterAdded:Connect(_r)_r()