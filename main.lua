local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LogoBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "76_Premium_Final_Complete"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [[ DASH & NARUTO ANIMASYON ]]
local DashBtn = Instance.new("TextButton", ScreenGui)
DashBtn.Name = "DashBtn"
DashBtn.Size = UDim2.new(0, 65, 0, 65)
DashBtn.Position = UDim2.new(1, -125, 1, -280) 
DashBtn.BackgroundTransparency = 1; DashBtn.Text = ""
local DashBG = Instance.new("Frame", DashBtn)
DashBG.Size = UDim2.new(1, 0, 1, 0); DashBG.BorderSizePixel = 0
Instance.new("UICorner", DashBG).CornerRadius = UDim.new(0, 10)
local DashGrad = Instance.new("UIGradient", DashBG)
DashGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 148, 51)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 24, 136))}); DashGrad.Rotation = 45
local DashCont = Instance.new("Frame", DashBtn)
DashCont.Size = UDim2.new(1, 0, 1, 0); DashCont.BackgroundColor3 = Color3.fromRGB(156, 156, 156); DashCont.BackgroundTransparency = 0.5
Instance.new("UICorner", DashCont).CornerRadius = UDim.new(0, 11)
local DashLabel = Instance.new("TextLabel", DashCont)
DashLabel.Size = UDim2.new(1, 0, 1, 0); DashLabel.BackgroundTransparency = 1; DashLabel.Text = "Dash"; DashLabel.TextColor3 = Color3.fromRGB(255, 255, 255); DashLabel.Font = "GothamBold"; DashLabel.TextSize = 16

local dDebounce = false
DashBtn.Activated:Connect(function()
    if dDebounce then return end
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        dDebounce = true
        TweenService:Create(DashBG, TweenInfo.new(0.2), {Rotation = 35}):Play()
        local waist = char:FindFirstChild("Waist", true) or char:FindFirstChild("RootJoint", true)
        local rs = char:FindFirstChild("RightShoulder", true); local ls = char:FindFirstChild("LeftShoulder", true)
        if waist and rs and ls then
            local oW = waist.C0; local oR = rs.C0; local oL = ls.C0
            TweenService:Create(waist, TweenInfo.new(0.15), {C0 = oW * CFrame.Angles(math.rad(45), 0, 0)}):Play()
            TweenService:Create(rs, TweenInfo.new(0.2), {C0 = oR * CFrame.Angles(0, 0, math.rad(110))}):Play()
            TweenService:Create(ls, TweenInfo.new(0.2), {C0 = oL * CFrame.Angles(0, 0, math.rad(-110))}):Play()
            task.delay(0.4, function()
                TweenService:Create(waist, TweenInfo.new(0.2), {C0 = oW}):Play()
                TweenService:Create(rs, TweenInfo.new(0.2), {C0 = oR}):Play()
                TweenService:Create(ls, TweenInfo.new(0.2), {C0 = oL}):Play()
            end)
        end
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(1e5, 0, 1e5); bv.Velocity = root.CFrame.LookVector * 135; game.Debris:AddItem(bv, 0.25)
        task.wait(0.6); TweenService:Create(DashBG, TweenInfo.new(0.2), {Rotation = 0}):Play(); dDebounce = false
    end
end)

-- [[ ANA PANEL & LOGO ]]
local function Drag(obj)
    local dragging, input, startPos, startInput
    obj.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true startPos = obj.Position startInput = i.Position end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - startInput
        obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end end)
    obj.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

LogoBtn.Size = UDim2.new(0, 50, 0, 50); LogoBtn.Position = UDim2.new(0, 20, 0.5, -25); LogoBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); LogoBtn.Text = "76"; LogoBtn.TextColor3 = Color3.fromRGB(255, 255, 255); LogoBtn.Font = "GothamBold"; LogoBtn.Visible = false; LogoBtn.ZIndex = 10
Instance.new("UICorner", LogoBtn).CornerRadius = UDim.new(1, 0)
local LGrad = Instance.new("UIGradient", LogoBtn); LGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 20, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 70))}); LGrad.Rotation = 90
Instance.new("UIStroke", LogoBtn).Color = Color3.fromRGB(255, 255, 255); Drag(LogoBtn); LogoBtn.Parent = ScreenGui

MainFrame.Size = UDim2.new(0, 420, 0, 240); MainFrame.Position = UDim2.new(0.5, -210, 0.5, -120); MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255); MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 25); Drag(MainFrame); MainFrame.Parent = ScreenGui
local MGrad = Instance.new("UIGradient", MainFrame); MGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 15, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 130, 70))}); MGrad.Rotation = 90

-- [[ RESIZE SİSTEMİ (45 DERECE KAVİSLİ) ]]
local ResLine = Instance.new("Frame", MainFrame); ResLine.Size = UDim2.new(0, 30, 0, 4); ResLine.Position = UDim2.new(1, -35, 1, -15); ResLine.Rotation = -45; ResLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255); ResLine.BackgroundTransparency = 0.3; Instance.new("UICorner", ResLine).CornerRadius = UDim.new(1, 0)
local ResBtn = Instance.new("TextButton", MainFrame); ResBtn.Size = UDim2.new(0, 40, 0, 40); ResBtn.Position = UDim2.new(1, -40, 1, -40); ResBtn.BackgroundTransparency = 1; ResBtn.Text = ""
local rsZ = false; ResBtn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then rsZ = true end end)
UserInputService.InputChanged:Connect(function(i) if rsZ and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
    local m = UserInputService:GetMouseLocation(); MainFrame.Size = UDim2.new(0, math.max(300, m.X - MainFrame.AbsolutePosition.X), 0, math.max(180, m.Y - MainFrame.AbsolutePosition.Y - 36))
end end)
UserInputService.InputEnded:Connect(function() rsZ = false end)

local T1 = Instance.new("TextLabel", MainFrame); T1.Text = "76 PREMIUM"; T1.Size = UDim2.new(0, 200, 0, 30); T1.Position = UDim2.new(0.05, 0, 0.05, 0); T1.TextColor3 = Color3.fromRGB(255, 255, 255); T1.Font = "GothamBold"; T1.TextXAlignment = "Left"; T1.BackgroundTransparency = 1
local Glass = Instance.new("Frame", MainFrame); Glass.Size = UDim2.new(0.44, 0, 0.65, 0); Glass.Position = UDim2.new(0.04, 0, 0.28, 0); Glass.BackgroundTransparency = 0.94; Instance.new("UICorner", Glass).CornerRadius = UDim.new(0, 15)
local Scroll = Instance.new("ScrollingFrame", Glass); Scroll.Size = UDim2.new(1, -10, 1, -10); Scroll.Position = UDim2.new(0, 5, 0, 5); Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 0
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

-- [[ SCRIPT EKLEME & SİLME ]]
local SelectedScript = nil; local SelectedStroke = nil
local function AddScript(name, code)
    local Container = Instance.new("Frame", Scroll); Container.Size = UDim2.new(1, 0, 0, 35); Container.BackgroundTransparency = 1
    local btn = Instance.new("TextButton", Container); btn.Size = UDim2.new(0.8, 0, 1, 0); btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); btn.BackgroundTransparency = 0.95; btn.Text = name; btn.TextColor3 = Color3.fromRGB(240, 240, 240); btn.Font = "Gotham"
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8); local st = Instance.new("UIStroke", btn); st.Thickness = 2; st.Color = Color3.fromRGB(255, 255, 255); st.Enabled = false
    local del = Instance.new("TextButton", Container); del.Size = UDim2.new(0.15, 0, 1, 0); del.Position = UDim2.new(0.85, 0, 0, 0); del.BackgroundColor3 = Color3.fromRGB(255, 80, 80); del.Text = "X"; del.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", del).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function() if SelectedStroke then SelectedStroke.Enabled = false end SelectedScript = code; SelectedStroke = st; st.Enabled = true end)
    del.MouseButton1Click:Connect(function() Container:Destroy() end)
end

local AddFrame = Instance.new("Frame", MainFrame); AddFrame.Size = UDim2.new(0.45, 0, 0, 0); AddFrame.Position = UDim2.new(0.51, 0, 0.28, 0); AddFrame.BackgroundColor3 = Color3.fromRGB(30,30,35); AddFrame.ClipsDescendants = true; AddFrame.Visible = false; Instance.new("UICorner", AddFrame).CornerRadius = UDim.new(0, 15)
local NameBox = Instance.new("TextBox", AddFrame); NameBox.Size = UDim2.new(0.9, 0, 0, 30); NameBox.Position = UDim2.new(0.05, 0, 0.1, 0); NameBox.PlaceholderText = "Ad..."; NameBox.BackgroundColor3 = Color3.fromRGB(50,50,55); NameBox.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", NameBox)
local CodeBox = Instance.new("TextBox", AddFrame); CodeBox.Size = UDim2.new(0.9, 0, 0, 60); CodeBox.Position = UDim2.new(0.05, 0, 0.35, 0); CodeBox.PlaceholderText = "Kod..."; CodeBox.BackgroundColor3 = Color3.fromRGB(50,50,55); CodeBox.TextColor3 = Color3.fromRGB(255,255,255); CodeBox.ClearTextOnFocus = false; Instance.new("UICorner", CodeBox)
local ConfirmAdd = Instance.new("TextButton", AddFrame); ConfirmAdd.Size = UDim2.new(0.6, 0, 0, 30); ConfirmAdd.Position = UDim2.new(0.2, 0, 0.8, 0); ConfirmAdd.Text = "Ekle"; ConfirmAdd.BackgroundColor3 = Color3.fromRGB(255, 120, 60); ConfirmAdd.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", ConfirmAdd)

local AddTrigger = Instance.new("TextButton", Scroll); AddTrigger.Size = UDim2.new(1, 0, 0, 35); AddTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255); AddTrigger.BackgroundTransparency = 0.9; AddTrigger.Text = "+"; AddTrigger.TextColor3 = Color3.fromRGB(255, 255, 255); AddTrigger.TextSize = 20; Instance.new("UICorner", AddTrigger).CornerRadius = UDim.new(0, 8)

local isPanelOpen = false
AddTrigger.MouseButton1Click:Connect(function()
    isPanelOpen = not isPanelOpen
    if isPanelOpen then AddFrame.Visible = true; AddFrame:TweenSize(UDim2.new(0.45, 0, 0.65, 0), "Out", "Quad", 0.3, true)
    else AddFrame:TweenSize(UDim2.new(0.45, 0, 0, 0), "In", "Quad", 0.2, true) task.wait(0.2); AddFrame.Visible = false end
end)

ConfirmAdd.MouseButton1Click:Connect(function()
    if NameBox.Text ~= "" and CodeBox.Text ~= "" then
        AddScript(NameBox.Text, CodeBox.Text); AddFrame:TweenSize(UDim2.new(0.45, 0, 0, 0), "In", "Quad", 0.2, true)
        task.wait(0.2); AddFrame.Visible = false; NameBox.Text = ""; CodeBox.Text = ""; isPanelOpen = false; AddTrigger.Parent = nil; AddTrigger.Parent = Scroll
    end
end)

AddScript("Emote Player", 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))()')
AddScript("Infinite Yield", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()')
AddScript("Silly Car FE", 'loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SILLY-CAR-V1-48227"))()')
AddScript("Verified Script", "loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()")

local ExecBtn = Instance.new("TextButton", MainFrame); ExecBtn.Size = UDim2.new(0, 120, 0, 45); ExecBtn.Position = UDim2.new(0.72, -60, 0.55, -22); ExecBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); ExecBtn.BackgroundTransparency = 0.9; ExecBtn.Text = "Çalıştır"; ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ExecBtn.Font = "GothamBold"; Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 12); Instance.new("UIStroke", ExecBtn).Color = Color3.fromRGB(255,255,255)
ExecBtn.MouseButton1Click:Connect(function() if SelectedScript then loadstring(SelectedScript)() end end)

-- [[ KAPAT & KÜÇÜLT ]]
local function Toggle(open)
    if open then MainFrame.Visible = true; MainFrame:TweenSize(UDim2.new(0,420,0,240),"Out","Back",0.5,true); LogoBtn.Visible = false
    else MainFrame:TweenSize(UDim2.new(0,0,0,0),"In","Back",0.4,true); task.wait(0.4); MainFrame.Visible = false; LogoBtn.Visible = true end
end
local Exit = Instance.new("TextButton", MainFrame); Exit.Size = UDim2.new(0, 26, 0, 26); Exit.Position = UDim2.new(0.92, 0, 0.05, 0); Exit.BackgroundColor3 = Color3.fromRGB(255, 60, 60); Exit.Text = "✕"; Instance.new("UICorner", Exit).CornerRadius = UDim.new(1, 0)
Exit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
local Mini = Instance.new("TextButton", MainFrame); Mini.Size = UDim2.new(0, 26, 0, 26); Mini.Position = UDim2.new(0.84, 0, 0.05, 0); Mini.BackgroundColor3 = Color3.fromRGB(60, 60, 65); Mini.Text = "—"; Instance.new("UICorner", Mini).CornerRadius = UDim.new(1, 0)
Mini.MouseButton1Click:Connect(function() Toggle(false) end)
LogoBtn.MouseButton1Click:Connect(function() Toggle(true) end)
MainFrame.Size = UDim2.new(0, 0, 0, 0); Toggle(true)
