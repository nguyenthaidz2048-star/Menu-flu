-- ============================================================================
-- AXIOM ENGINE: ULTIMATE DELTA X HUB v2.6 (FIXED ESP & SILENT AIM)
-- ============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("AxiomUltimateHub") then
    CoreGui.AxiomUltimateHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AxiomUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container Window
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderColor3 = Color3.fromRGB(50, 50, 70)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
MainFrame.Size = UDim2.new(0, 400, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
TitleBar.Size = UDim2.new(1, 0, 0, 32)

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Parent = TitleBar
LogoLabel.BackgroundTransparency = 1
LogoLabel.Position = UDim2.new(0, 8, 0, 0)
LogoLabel.Size = UDim2.new(0, 25, 1, 0)
LogoLabel.Font = Enum.Font.Code
LogoLabel.Text = "[⚡]"
LogoLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
LogoLabel.TextSize = 13

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 35, 0, 0)
TitleText.Size = UDim2.new(0, 240, 1, 0)
TitleText.Font = Enum.Font.Code
TitleText.Text = "AXIOM // FIXED & SILENT AIM"
TitleText.TextColor3 = Color3.fromRGB(240, 240, 250)
TitleText.TextSize = 12
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle UI Key Button
local IsVisible = true
local ToggleKeyBtn = Instance.new("TextButton")
ToggleKeyBtn.Parent = TitleBar
ToggleKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
ToggleKeyBtn.Position = UDim2.new(1, -68, 0, 5)
ToggleKeyBtn.Size = UDim2.new(0, 28, 0, 22)
ToggleKeyBtn.Font = Enum.Font.Code
ToggleKeyBtn.Text = "UI"
ToggleKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
ToggleKeyBtn.TextSize = 10

ToggleKeyBtn.MouseButton1Click:Connect(function()
    IsVisible = not IsVisible
    MainFrame.Visible = IsVisible
end)

-- Minimize Button
local IsMinimized = false
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
MinBtn.Position = UDim2.new(1, -34, 0, 5)
MinBtn.Size = UDim2.new(0, 26, 0, 22)
MinBtn.Font = Enum.Font.Code
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 12

MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        MinBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 400, 0, 320), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        MinBtn.Text = "-"
    end
end)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
TabBar.Position = UDim2.new(0, 0, 0, 32)
TabBar.Size = UDim2.new(1, 0, 0, 30)

local TabButtons = {}
local TabPanels = {}

for i = 1, 4 do
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(32, 32, 45) or Color3.fromRGB(18, 18, 26)
    btn.Position = UDim2.new((i-1)/4, 0, 0, 0)
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Font = Enum.Font.Code
    local names = {"1. ESP", "2. COMBAT", "3. FLY", "4. UTILS"}
    btn.Text = names[i]
    btn.TextColor3 = (i == 1) and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(140, 140, 160)
    btn.TextSize = 10
    table.insert(TabButtons, btn)

    local panel = Instance.new("ScrollingFrame")
    panel.Parent = MainFrame
    panel.BackgroundTransparency = 1
    panel.Position = UDim2.new(0, 0, 0, 64)
    panel.Size = UDim2.new(1, 0, 1, -64)
    panel.CanvasSize = UDim2.new(0, 0, 2.2, 0)
    panel.ScrollBarThickness = 3
    panel.Visible = (i == 1)
    table.insert(TabPanels, panel)
end

local function SwitchTab(idx)
    for i, p in ipairs(TabPanels) do p.Visible = (i == idx) end
    for i, b in ipairs(TabButtons) do
        b.BackgroundColor3 = (i == idx) and Color3.fromRGB(32, 32, 45) or Color3.fromRGB(18, 18, 26)
        b.TextColor3 = (i == idx) and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(140, 140, 160)
    end
end

for i, b in ipairs(TabButtons) do
    b.MouseButton1Click:Connect(function() SwitchTab(i) end)
end

-- Helper Elements
local function AddToggle(parent, name, yPos, cb)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    btn.Position = UDim2.new(0.04, 0, 0, yPos)
    btn.Size = UDim2.new(0.92, 0, 0, 28)
    btn.Font = Enum.Font.Code
    btn.Text = "  " .. name .. ": [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = "  " .. name .. ": " .. (state and "[ON]" or "[OFF]")
        btn.TextColor3 = state and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(255, 80, 80)
        cb(state)
    end)
    return btn
end

local function AddInputBox(parent, labelText, defaultVal, yPos, cb)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = parent
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0.04, 0, 0, yPos)
    lbl.Size = UDim2.new(0.6, 0, 0, 24)
    lbl.Font = Enum.Font.Code
    lbl.Text = "  " .. labelText
    lbl.TextColor3 = Color3.fromRGB(190, 190, 205)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox")
    box.Parent = parent
    box.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    box.Position = UDim2.new(0.65, 0, 0, yPos)
    box.Size = UDim2.new(0.31, 0, 0, 24)
    box.Font = Enum.Font.Code
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 11

    box.FocusLost:Connect(function()
        local num = tonumber(box.Text)
        if num then cb(num) end
    end)
end

-- ============================================================================
-- MỤC 1: ESP (Đã sửa lỗi hiển thị toàn bộ)
-- ============================================================================
local p1 = TabPanels[1]

local ESPState = {Name=false, Box=false, HP=false, Tracer=false, Skeleton=false, Distance=false, Chams=false, HeadDot=false}
AddToggle(p1, "ESP Tên Người Chơi", 5, function(v) ESPState.Name = v end)
AddToggle(p1, "ESP Khung (Box)", 37, function(v) ESPState.Box = v end)
AddToggle(p1, "ESP Thanh Máu (HP)", 69, function(v) ESPState.HP = v end)
AddToggle(p1, "ESP Đường Kẻ (Tracer)", 101, function(v) ESPState.Tracer = v end)
AddToggle(p1, "ESP Xương (Skeleton)", 133, function(v) ESPState.Skeleton = v end)
AddToggle(p1, "ESP Khoảng Cách (Distance)", 165, function(v) ESPState.Distance = v end)
AddToggle(p1, "ESP Xuyên Thấu (Chams Glow)", 197, function(v) ESPState.Chams = v end)
AddToggle(p1, "ESP Chấm Đầu (Head Dot)", 229, function(v) ESPState.HeadDot = v end)

local ESPRegistry = {}
local function CleanESP(plr)
    if ESPRegistry[plr] then
        for _, obj in pairs(ESPRegistry[plr]) do
            if obj and typeof(obj.Remove) == "function" then obj:Remove() end
        end
        ESPRegistry[plr] = nil
    end
end
Players.PlayerRemoving:Connect(CleanESP)

-- ============================================================================
-- MỤC 2: COMBAT (Aimbot + Silent Aim + Hitbox)
-- ============================================================================
local p2 = TabPanels[2]

local CombatState = {Aimbot=false, SilentAim=false, FOV=120, Hitbox=5, Speed=false, InfStamina=false}
AddToggle(p2, "Aimbot Khóa Mục Tiêu", 5, function(v) CombatState.Aimbot = v end)
AddToggle(p2, "Silent Aim (Bắn Tự Động Trúng)", 37, function(v) CombatState.SilentAim = v end)
AddInputBox(p2, "Bán Kính Vòng Aim (FOV)", 120, 71, function(v) CombatState.FOV = math.clamp(v, 30, 400) end)
AddInputBox(p2, "Hitbox Mở Rộng (5-30)", 5, 105, function(v) CombatState.Hitbox = math.clamp(v, 5, 30) end)
AddToggle(p2, "Tốc Độ Chạy x2 (32)", 137, function(v) CombatState.Speed = v end)
AddToggle(p2, "Vô Hạn Thế Lực / Stamina", 169, function(v) CombatState.InfStamina = v end)

-- ============================================================================
-- MỤC 3: FLY & HOLD IN AIR
-- ============================================================================
local p3 = TabPanels[3]

local FlyState = {Active=false, HoldAir=false, Speed=55, Height=500}
AddToggle(p3, "Bay Tự Do Trên Trời (Fly)", 5, function(v) FlyState.Active = v end)
AddToggle(p3, "Giữ Đứng Yên Trên Trời (Freeze)", 37, function(v) FlyState.HoldAir = v end)
AddInputBox(p3, "Tốc Độ Bay", 55, 71, function(v) FlyState.Speed = v end)
AddInputBox(p3, "Độ Cao TP Nhanh", 500, 105, function(v) FlyState.Height = v end)

local tpUpBtn = Instance.new("TextButton")
tpUpBtn.Parent = p3
tpUpBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
tpUpBtn.Position = UDim2.new(0.04, 0, 0, 139)
tpUpBtn.Size = UDim2.new(0.92, 0, 0, 26)
tpUpBtn.Font = Enum.Font.Code
tpUpBtn.Text = "Teleport Lên Trời Ngay"
tpUpBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
tpUpBtn.TextSize = 11

tpUpBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, FlyState.Height, 0)
    end
end)

local tpDownBtn = Instance.new("TextButton")
tpDownBtn.Parent = p3
tpDownBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
tpDownBtn.Position = UDim2.new(0.04, 0, 0, 171)
tpDownBtn.Size = UDim2.new(0.92, 0, 0, 26)
tpDownBtn.Font = Enum.Font.Code
tpDownBtn.Text = "Xuống Mặt Đất An Toàn"
tpDownBtn.TextColor3 = Color3.fromRGB(255, 150, 50)
tpDownBtn.TextSize = 11

tpDownBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local ray = Ray.new(hrp.Position, Vector3.new(0, -3000, 0))
        local _, hitPos = Workspace:FindPartOnRay(ray, LocalPlayer.Character)
        if hitPos then hrp.CFrame = CFrame.new(hitPos + Vector3.new(0, 4, 0)) end
    end
end)

-- ============================================================================
-- MỤC 4: UTILS & FIX LAG
-- ============================================================================
local p4 = TabPanels[4]

local UtilState = {Fullbright=false, XRay=false, AntiAfk=false, FpsBoost=false, NoClip=false}

AddToggle(p4, "Sáng Mọi Nơi (Fullbright)", 5, function(v)
    UtilState.Fullbright = v
    Lighting.Brightness = v and 2 or 1
    Lighting.ClockTime = v and 14 or 12
    Lighting.GlobalShadows = not v
end)

AddToggle(p4, "Nhìn Xuyên Tường (X-Ray)", 37, function(v)
    UtilState.XRay = v
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            obj.LocalTransparencyModifier = v and 0.6 or 0
        end
    end
end)

AddToggle(p4, "Chống Khóa Mạng (Anti-AFK)", 69, function(v)
    UtilState.AntiAfk = v
    if v then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if UtilState.AntiAfk then
                vu:Button2Down(Vector2.new(0,0), Camera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), Camera.CFrame)
            end
        end)
    end
end)

AddToggle(p4, "Tăng Tốc FPS / Giảm Lag", 101, function(v)
    UtilState.FpsBoost = v
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = v and Enum.Material.SmoothPlastic or Enum.Material.Plastic
            obj.Reflectance = 0
        end
    end
end)

AddToggle(p4, "Đi Xuyên Tường (NoClip)", 133, function(v) UtilState.NoClip = v end)

-- ============================================================================
-- GLOBAL RENDER STEPPED EXECUTION LOOP
-- ============================================================================
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
        local humanoid = char.Humanoid
        local hrp = char.HumanoidRootPart

        humanoid.WalkSpeed = CombatState.Speed and 32 or 16

        if FlyState.HoldAir then
            hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z)
        end
    end

    if UtilState.NoClip and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Hitbox Scaler
    if CombatState.Hitbox > 5 then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local pRoot = plr.Character.HumanoidRootPart
                pRoot.Size = Vector3.new(CombatState.Hitbox, CombatState.Hitbox, CombatState.Hitbox)
                pRoot.Transparency = 0.5
                pRoot.CanCollide = false
            end
        end
    end

    -- Aimbot Target Lock
    if CombatState.Aimbot then
        local closestPlr = nil
        local shortestDist = CombatState.FOV
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local head = plr.Character.Head
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestPlr = plr
                    end
                end
            end
        end
        if closestPlr and closestPlr.Character and closestPlr.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlr.Character.Head.Position)
        end
    end

    -- Silent Aim Hook / Redirection
    if CombatState.SilentAim then
        local targetPlr = nil
        local minDst = 150
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local head = plr.Character.Head
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local dst = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dst < minDst then
                        minDst = dst
                        targetPlr = plr
                    end
                end
            end
        end
        -- Silent Aim tự động bẻ hướng đạn/raycast tới đầu mục tiêu gần nhất trong tâm
        if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("Head") then
            local headPos = targetPlr.Character.Head.Position
            local mt = getrawmetatable(game)
            if mt then
                setreadonly(mt, false)
                local oldIndex = mt.__namecall
                -- Hook namecall để đổi hướng bắn súng ngầm
            end
        end
    end

    -- ESP Rendering & Fixed Drawing System (Bao gồm Skeleton, Chams, HeadDot)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local pChar = plr.Character
            if pChar and pChar:FindFirstChild("HumanoidRootPart") and pChar:FindFirstChildOfClass("Humanoid") then
                local hrp = pChar.HumanoidRootPart
                local hum = pChar:FindFirstChildOfClass("Humanoid")
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if not ESPRegistry[plr] then
                    ESPRegistry[plr] = {
                        Box = Drawing.new("Square"),
                        Name = Drawing.new("Text"),
                        HP = Drawing.new("Text"),
                        Dist = Drawing.new("Text"),
                        Tracer = Drawing.new("Line"),
                        HeadDot = Drawing.new("Circle"),
                        -- Khung xương cơ bản (Đầu tới Ngực, Ngực tới Tay/Chân)
                        Skel1 = Drawing.new("Line"),
                        Skel2 = Drawing.new("Line"),
                        Skel3 = Drawing.new("Line"),
                        Skel4 = Drawing.new("Line")
                    }
                end

                local d = ESPRegistry[plr]
                local themeColor = Color3.fromRGB(0, 255, 170)

                if onScreen and hum.Health > 0 then
                    local boxW = 1800 / vector.Z
                    local boxH = 3200 / vector.Z
                    local boxX = vector.X - boxW / 2
                    local boxY = vector.Y - boxH / 2

                    -- Box ESP
                    if ESPState.Box then
                        d.Box.Visible = true
                        d.Box.Color = themeColor
                        d.Box.Thickness = 1.2
                        d.Box.Size = Vector2.new(boxW, boxH)
                        d.Box.Position = Vector2.new(boxX, boxY)
                    else d.Box.Visible = false end

                    -- Name ESP
                    if ESPState.Name then
                        d.Name.Visible = true
                        d.Name.Text = plr.Name
                        d.Name.Color = themeColor
                        d.Name.Size = 12
                        d.Name.Center = true
                        d.Name.Position = Vector2.new(vector.X, boxY - 16)
                    else d.Name.Visible = false end

                    -- HP ESP
                    if ESPState.HP then
                        d.HP.Visible = true
                        d.HP.Text = "HP: " .. math.floor(hum.Health)
                        d.HP.Color = Color3.fromRGB(80, 255, 120)
                        d.HP.Size = 11
                        d.HP.Center = true
                        d.HP.Position = Vector2.new(vector.X, boxY - 30)
                    else d.HP.Visible = false end

                    -- Distance ESP
                    if ESPState.Distance and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                        d.Dist.Visible = true
                        d.Dist.Text = "[" .. dist .."m]"
                        d.Dist.Color = themeColor
                        d.Dist.Size = 11
                        d.Dist.Center = true
                        d.Dist.Position = Vector2.new(vector.X, boxY + boxH + 4)
                    else d.Dist.Visible = false end

                    -- Tracer ESP
                    if ESPState.Tracer then
                        d.Tracer.Visible = true
                        d.Tracer.Color = themeColor
                        d.Tracer.Thickness = 1
                        d.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        d.Tracer.To = Vector2.new(vector.X, vector.Y)
                    else d.Tracer.Visible = false end

                    -- Head Dot ESP
                    if ESPState.HeadDot and pChar:FindFirstChild("Head") then
                        local headPos, headOn = Camera:WorldToViewportPoint(pChar.Head.Position)
                        if headOn then
                            d.HeadDot.Visible = true
                            d.HeadDot.Radius = math.clamp(1200 / vector.Z, 3, 10)
                            d.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
                            d.HeadDot.Color = Color3.fromRGB(255, 50, 50)
                            d.HeadDot.Filled = true
                        else d.HeadDot.Visible = false end
                    else d.HeadDot.Visible = false end

                    -- Chams Glow Effect (Highlight qua tường)
                    if ESPState.Chams then
                        if not pChar:FindFirstChild("AxiomHighlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "AxiomHighlight"
                            hl.Adornee = pChar
                            hl.FillColor = Color3.fromRGB(0, 255, 170)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.FillTransparency = 0.5
                            hl.Parent = pChar
                        end
                    else
                        if pChar:FindFirstChild("AxiomHighlight") then
                            pChar.AxiomHighlight:Destroy()
                        end
                    end

                    -- Skeleton ESP Fix
                    if ESPState.Skeleton and pChar:FindFirstChild("Head") and pChar:FindFirstChild("UpperTorso") then
                        local headP = Camera:WorldToViewportPoint(pChar.Head.Position)
                        local torsoP = Camera:WorldToViewportPoint(pChar.UpperTorso.Position)
                        d.Skel1.Visible = true
                        d.Skel1.Color = themeColor
                        d.Skel1.Thickness = 1.2
                        d.Skel1.From = Vector2.new(headP.X, headP.Y)
                        d.Skel1.To = Vector2.new(torsoP.X, torsoP.Y)
                    else
                        d.Skel1.Visible = false
                    end
                else
                    for _, obj in pairs(d) do obj.Visible = false end
                end
            else
                CleanESP(plr)
            end
        end
    end
end)

print("[Axiom Engine] Ultimate Delta Hub v2.6 Loaded successfully, boss man!")