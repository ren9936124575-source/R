local p = game.Players.LocalPlayer
local pgui = p:WaitForChild("PlayerGui")

-- 最短Loading（確実に表示させるために0.1秒待機を入れる）
local g = Instance.new("ScreenGui", pgui)
local t = Instance.new("TextLabel", g)
t.Size, t.Text, t.TextScaled, t.BackgroundColor3, t.TextColor3 = UDim2.new(1,0,1,0), "LOADING SIGMA...", true, Color3.new(0,0,0), Color3.new(1,1,1)
task.wait(1) -- ここで1秒表示
g:Destroy()

-- メイン機能
local c = p.Character or p.CharacterAdded:Wait()
local h, r = c:WaitForChild("Humanoid"), c:WaitForChild("HumanoidRootPart")
_G.N, _G.C, _G.A = 75, 40, true

local sg = Instance.new("ScreenGui", pgui)
local f = Instance.new("Frame", sg)
f.Size, f.Position, f.Active, f.Draggable = UDim2.new(0,140,0,120), UDim2.new(0,10,0.5,-60), true, true

local function nb(txt, y, fn)
    local b = Instance.new("TextButton", f)
    b.Size, b.Position, b.Text, b.TextScaled = UDim2.new(1,0,0,40), UDim2.new(0,0,y,0), txt, true
    b.MouseButton1Click:Connect(fn)
    return b
end

local b1 = nb("N:".._G.N, 0, function() _G.N = _G.N>140 and 16 or _G.N+20 end)
local b2 = nb("C:".._G.C, 0.33, function() _G.C = _G.C>90 and 16 or _G.C+10 end)
local b3 = nb("AKB:ON", 0.66, function() _G.A = not _G.A end)

task.spawn(function()
    while task.wait() do
        b1.Text, b2.Text, b3.Text = "N:".._G.N, "C:".._G.C, "AKB:"..(_G.A and "ON" or "OFF")
        if h.MoveDirection.Magnitude > 0 then
            local is = c:FindFirstChildOfClass("Tool") or c:FindFirstChild("Pet") or c:FindFirstChild("Carry")
            h.WalkSpeed = is and _G.C or _G.N
        else h.WalkSpeed = 16 end
        if _G.A and r then r.Velocity = Vector3.new(r.Velocity.X, 0, r.Velocity.Z) end
    end
end)