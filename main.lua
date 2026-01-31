local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI SETUP
local sg = Instance.new("ScreenGui")
sg.Name = "76Reborn_Mobile"
sg.IgnoreGuiInset = true
pcall(function() sg.Parent = game:GetService("CoreGui") end)
if not sg.Parent then sg.Parent = lp:WaitForChild("PlayerGui") end

-- KAYIT SİSTEMİ
local SavedScripts = {}
local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    FOV = 70,
    Theme = "Purple"
}

local function SaveScriptData()
    writefile("76Reborn_Scripts.json", game:GetService("HttpService"):JSONEncode(SavedScripts))
end

local function LoadScriptData()
    if isfile("76Reborn_Scripts.json") then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("76Reborn_Scripts.json"))
        end)
        if success and data then
            SavedScripts = data
        end
    end
end

local function SaveSettings()
    writefile("76Reborn_Settings.json", game:GetService("HttpService"):JSONEncode(Settings))
end

local function LoadSettings()
    if isfile("76Reborn_Settings.json") then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("76Reborn_Settings.json"))
        end)
        if success and data then
            Settings = data
        end
    end
end

LoadScriptData()
LoadSettings()

-- [GİRİŞ: MAVİ BAR]
local LoaderBase = Instance.new("Frame", sg)
LoaderBase.Size = UDim2.new(0, 130, 0, 4)
LoaderBase.Position = UDim2.new(0.5, -65, 0.5, -2)
LoaderBase.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoaderBase.BackgroundTransparency = 0.5
LoaderBase.BorderSizePixel = 0
Instance.new("UICorner", LoaderBase).CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", LoaderBase)
Bar.BackgroundColor3 = Color3.fromRGB(0, 113, 226)
Bar.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel", sg)
Title.Size = UDim2.new(0, 500, 0, 100)
Title.Position = UDim2.new(0.5, -250, 0.5, -50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 113, 226)
Title.Text = "."
Title.Font = Enum.Font.GothamBold
Title.TextSize = 0

-- [ANA PANEL - YATAY REALME 8]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 650, 0, 320)
Main.Position = UDim2.new(0.5, -325, 1.5, 0)
Main.BackgroundTransparency = 1
Main.Visible = false
Main.Active = true

-- Sürüklenebilir yapma
local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- [ÜST PANEL - HEADER]
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.BackgroundTransparency = 0.15
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local HeaderStroke = Instance.new("UIStroke", Header)
HeaderStroke.Thickness = 1.5
HeaderStroke.Color = Color3.fromRGB(255, 255, 255)
HeaderStroke.Transparency = 0.7

local HeaderGradient = Instance.new("UIGradient", Header)
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 146, 60))
}
HeaderGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.88),
    NumberSequenceKeypoint.new(1, 0.92)
}
HeaderGradient.Rotation = 135

local Logo = Instance.new("TextLabel", Header)
Logo.Size = UDim2.new(0, 38, 0, 38)
Logo.Position = UDim2.new(0, 8, 0, 6)
Logo.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
Logo.Text = "76"
Logo.TextColor3 = Color3.new(1, 1, 1)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 17
Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 8)

local LogoGradient = Instance.new("UIGradient", Logo)
LogoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153))
}
LogoGradient.Rotation = 45

local HeaderTitle = Instance.new("TextLabel", Header)
HeaderTitle.Size = UDim2.new(0, 150, 0, 20)
HeaderTitle.Position = UDim2.new(0, 53, 0, 8)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "76 Reborn"
HeaderTitle.TextColor3 = Color3.new(1, 1, 1)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 14
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local HeaderSub = Instance.new("TextLabel", Header)
HeaderSub.Size = UDim2.new(0, 150, 0, 15)
HeaderSub.Position = UDim2.new(0, 53, 0, 28)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "Premium Hub"
HeaderSub.TextColor3 = Color3.fromRGB(180, 180, 200)
HeaderSub.Font = Enum.Font.Gotham
HeaderSub.TextSize = 9
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton", Header)
MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
MinimizeBtn.Position = UDim2.new(1, -72, 0, 9)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
MinimizeBtn.BackgroundTransparency = 0.3
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 7)

local MinStroke = Instance.new("UIStroke", MinimizeBtn)
MinStroke.Thickness = 1
MinStroke.Color = Color3.fromRGB(236, 72, 153)
MinStroke.Transparency = 0.5

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -34, 0, 9)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(248, 113, 113)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Thickness = 1
CloseStroke.Color = Color3.fromRGB(248, 113, 113)
CloseStroke.Transparency = 0.5

-- [MİNİMİZE LOGO]
local MinimizeLogo = Instance.new("ImageButton", sg)
MinimizeLogo.Size = UDim2.new(0, 45, 0, 45)
MinimizeLogo.Position = UDim2.new(0, 12, 0, 12)
MinimizeLogo.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
MinimizeLogo.Visible = false
MinimizeLogo.Active = true
MinimizeLogo.Draggable = true
MinimizeLogo.ZIndex = 100
Instance.new("UICorner", MinimizeLogo).CornerRadius = UDim.new(0, 10)

local MiniLogoGradient = Instance.new("UIGradient", MinimizeLogo)
MiniLogoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153))
}
MiniLogoGradient.Rotation = 45

local MiniLogoStroke = Instance.new("UIStroke", MinimizeLogo)
MiniLogoStroke.Thickness = 2
MiniLogoStroke.Color = Color3.fromRGB(255, 255, 255)
MiniLogoStroke.Transparency = 0.5

local MiniLogoText = Instance.new("TextLabel", MinimizeLogo)
MiniLogoText.Size = UDim2.new(1, 0, 1, 0)
MiniLogoText.BackgroundTransparency = 1
MiniLogoText.Text = "76"
MiniLogoText.TextColor3 = Color3.new(1, 1, 1)
MiniLogoText.Font = Enum.Font.GothamBold
MiniLogoText.TextSize = 16
MiniLogoText.ZIndex = 101

-- [SOL MENÜ PANEL]
local LeftPanel = Instance.new("Frame", Main)
LeftPanel.Size = UDim2.new(0, 200, 0, 260)
LeftPanel.Position = UDim2.new(0, 0, 0, 60)
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LeftPanel.BackgroundTransparency = 0.15
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 12)

local LeftStroke = Instance.new("UIStroke", LeftPanel)
LeftStroke.Thickness = 1.5
LeftStroke.Color = Color3.fromRGB(255, 255, 255)
LeftStroke.Transparency = 0.7

local LeftGradient = Instance.new("UIGradient", LeftPanel)
LeftGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 146, 60))
}
LeftGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.88),
    NumberSequenceKeypoint.new(1, 0.92)
}
LeftGradient.Rotation = 135

local LeftScroll = Instance.new("ScrollingFrame", LeftPanel)
LeftScroll.Size = UDim2.new(1, -10, 1, -10)
LeftScroll.Position = UDim2.new(0, 5, 0, 5)
LeftScroll.BackgroundTransparency = 1
LeftScroll.BorderSizePixel = 0
LeftScroll.ScrollBarThickness = 4
LeftScroll.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
LeftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local LeftLayout = Instance.new("UIListLayout", LeftScroll)
LeftLayout.Padding = UDim.new(0, 6)
LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder

LeftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    LeftScroll.CanvasSize = UDim2.new(0, 0, 0, LeftLayout.AbsoluteContentSize.Y + 10)
end)

-- [SAĞ PANEL]
local RightPanel = Instance.new("Frame", Main)
RightPanel.Size = UDim2.new(0, 440, 0, 260)
RightPanel.Position = UDim2.new(0, 210, 0, 60)
RightPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
RightPanel.BackgroundTransparency = 0.1
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 12)

local RightStroke = Instance.new("UIStroke", RightPanel)
RightStroke.Thickness = 1.5
RightStroke.Color = Color3.fromRGB(255, 255, 255)
RightStroke.Transparency = 0.8

-- Sayfa sistemi için container
local Pages = {}
local CurrentPage = nil

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", RightPanel)
    Page.Size = UDim2.new(1, -16, 1, -16)
    Page.Position = UDim2.new(0, 8, 0, 8)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 5
    Page.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)
    
    Pages[name] = Page
    return Page
end

local function ShowPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = (pageName == name)
    end
    CurrentPage = name
end

-- Sayfaları oluştur
local ScriptsPage = CreatePage("Scripts")
local PlayerPage = CreatePage("Player")
local ESPPage = CreatePage("ESP")
local SettingsPage = CreatePage("Settings")
local AboutPage = CreatePage("About")

-- [SCRIPTS SAYFASI]
local ScriptHeader = Instance.new("Frame", ScriptsPage)
ScriptHeader.Size = UDim2.new(1, 0, 0, 45)
ScriptHeader.BackgroundTransparency = 1

local ScriptTitle = Instance.new("TextLabel", ScriptHeader)
ScriptTitle.Size = UDim2.new(0, 150, 0, 20)
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.Text = "📜 Scriptler"
ScriptTitle.TextColor3 = Color3.new(1, 1, 1)
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 14
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

local AddScriptBtn = Instance.new("TextButton", ScriptHeader)
AddScriptBtn.Size = UDim2.new(1, 0, 0, 32)
AddScriptBtn.Position = UDim2.new(0, 0, 0, 23)
AddScriptBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
AddScriptBtn.BackgroundTransparency = 0.4
AddScriptBtn.Text = "+ Yeni Script Ekle"
AddScriptBtn.TextColor3 = Color3.new(1, 1, 1)
AddScriptBtn.Font = Enum.Font.GothamBold
AddScriptBtn.TextSize = 12
Instance.new("UICorner", AddScriptBtn).CornerRadius = UDim.new(0, 8)

local AddBtnGradient = Instance.new("UIGradient", AddScriptBtn)
AddBtnGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153))
}
AddBtnGradient.Rotation = 45

local AddBtnStroke = Instance.new("UIStroke", AddScriptBtn)
AddBtnStroke.Thickness = 1.5
AddBtnStroke.Color = Color3.fromRGB(255, 255, 255)
AddBtnStroke.Transparency = 0.7

-- [PLAYER SAYFASI]
local function CreateSlider(parent, text, min, max, default, callback)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Container.BackgroundTransparency = 0.3
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)
    
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ValueLabel = Instance.new("TextLabel", Container)
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -60, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(168, 85, 247)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 11
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local SliderBack = Instance.new("Frame", Container)
    SliderBack.Size = UDim2.new(1, -20, 0, 6)
    SliderBack.Position = UDim2.new(0, 10, 0, 38)
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Instance.new("UICorner", SliderBack).CornerRadius = UDim.new(1, 0)
    
    local SliderFill = Instance.new("Frame", SliderBack)
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
    
    local SliderBtn = Instance.new("TextButton", SliderBack)
    SliderBtn.Size = UDim2.new(1, 0, 1, 0)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""
    
    local dragging = false
    SliderBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            local value = math.floor(min + (max - min) * pos)
            ValueLabel.Text = tostring(value)
            if callback then callback(value) end
        end
    end)
    
    return Container
end

CreateSlider(PlayerPage, "🏃 WalkSpeed", 16, 200, Settings.WalkSpeed, function(val)
    Settings.WalkSpeed = val
    SaveSettings()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = val
    end
end)

CreateSlider(PlayerPage, "⬆️ JumpPower", 50, 300, Settings.JumpPower, function(val)
    Settings.JumpPower = val
    SaveSettings()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.JumpPower = val
    end
end)

CreateSlider(PlayerPage, "👁️ Field of View", 70, 120, Settings.FOV, function(val)
    Settings.FOV = val
    SaveSettings()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid:FindFirstChild("Animator") then
        workspace.CurrentCamera.FieldOfView = val
    end
end)

-- [ESP SAYFASI]
local ESPEnabled = false
local ESPBoxes = {}

local function CreateToggle(parent, text, default, callback)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, 0, 0, 45)
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Container.BackgroundTransparency = 0.3
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)
    
    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleBack = Instance.new("Frame", Container)
    ToggleBack.Size = UDim2.new(0, 45, 0, 25)
    ToggleBack.Position = UDim2.new(1, -55, 0.5, -12.5)
    ToggleBack.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Instance.new("UICorner", ToggleBack).CornerRadius = UDim.new(1, 0)
    
    local ToggleBtn = Instance.new("Frame", ToggleBack)
    ToggleBtn.Size = UDim2.new(0, 21, 0, 21)
    ToggleBtn.Position = default and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    ToggleBtn.BackgroundColor3 = default and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(150, 150, 170)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local ToggleButton = Instance.new("TextButton", ToggleBack)
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Text = ""
    
    local toggled = default
    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {
            Position = toggled and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5),
            BackgroundColor3 = toggled and Color3.fromRGB(34, 197, 94) or Color3.fromRGB(150, 150, 170)
        }):Play()
        if callback then callback(toggled) end
    end)
    
    return Container
end

CreateToggle(ESPPage, "👁️ Player ESP", false, function(enabled)
    ESPEnabled = enabled
    if not enabled then
        for _, box in pairs(ESPBoxes) do
            box:Destroy()
        end
        ESPBoxes = {}
    end
end)

CreateToggle(ESPPage, "📦 Box ESP", false, function(enabled)
    print("Box ESP:", enabled)
end)

CreateToggle(ESPPage, "👤 Name ESP", false, function(enabled)
    print("Name ESP:", enabled)
end)

CreateToggle(ESPPage, "❤️ Health ESP", false, function(enabled)
    print("Health ESP:", enabled)
end)

-- [AYARLAR SAYFASI]
local SettingsTitle = Instance.new("TextLabel", SettingsPage)
SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "⚙️ Ayarlar"
SettingsTitle.TextColor3 = Color3.new(1, 1, 1)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextSize = 16
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left

local function CreateButton(parent, text, color, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = color
    Btn.BackgroundTransparency = 0.2
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    
    local BtnStroke = Instance.new("UIStroke", Btn)
    BtnStroke.Thickness = 1.5
    BtnStroke.Color = color
    BtnStroke.Transparency = 0.5
    
    Btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return Btn
end

CreateButton(SettingsPage, "💾 Ayarları Kaydet", Color3.fromRGB(34, 197, 94), function()
    SaveSettings()
    SaveScriptData()
    print("Tüm ayarlar kaydedildi!")
end)

CreateButton(SettingsPage, "🔄 Ayarları Sıfırla", Color3.fromRGB(251, 146, 60), function()
    Settings = {
        WalkSpeed = 16,
        JumpPower = 50,
        FOV = 70,
        Theme = "Purple"
    }
    SaveSettings()
    print("Ayarlar sıfırlandı!")
end)

CreateButton(SettingsPage, "🗑️ Tüm Scriptleri Sil", Color3.fromRGB(239, 68, 68), function()
    SavedScripts = {}
    SaveScriptData()
    for _, child in ipairs(ScriptsPage:GetChildren()) do
        if child:IsA("Frame") and child ~= ScriptHeader then
            child:Destroy()
        end
    end
    print("Tüm scriptler silindi!")
end)

-- [HAKKINDA SAYFASI]
local AboutContainer = Instance.new("Frame", AboutPage)
AboutContainer.Size = UDim2.new(1, 0, 0, 230)
AboutContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
AboutContainer.BackgroundTransparency = 0.2
Instance.new("UICorner", AboutContainer).CornerRadius = UDim.new(0, 12)

local AboutGradient = Instance.new("UIGradient", AboutContainer)
AboutGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153))
}
AboutGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.8),
    NumberSequenceKeypoint.new(1, 0.85)
}
AboutGradient.Rotation = 45

local AboutLogo = Instance.new("TextLabel", AboutContainer)
AboutLogo.Size = UDim2.new(0, 80, 0, 80)
AboutLogo.Position = UDim2.new(0.5, -40, 0, 15)
AboutLogo.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
AboutLogo.Text = "76"
AboutLogo.TextColor3 = Color3.new(1, 1, 1)
AboutLogo.Font = Enum.Font.GothamBold
AboutLogo.TextSize = 36
Instance.new("UICorner", AboutLogo).CornerRadius = UDim.new(0, 15)

local AboutTitle = Instance.new("TextLabel", AboutContainer)
AboutTitle.Size = UDim2.new(1, -20, 0, 25)
AboutTitle.Position = UDim2.new(0, 10, 0, 105)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Text = "76 Reborn GUI"
AboutTitle.TextColor3 = Color3.new(1, 1, 1)
AboutTitle.Font = Enum.Font.GothamBold
AboutTitle.TextSize = 18

local AboutVersion = Instance.new("TextLabel", AboutContainer)
AboutVersion.Size = UDim2.new(1, -20, 0, 18)
AboutVersion.Position = UDim2.new(0, 10, 0, 133)
AboutVersion.BackgroundTransparency = 1
AboutVersion.Text = "Versiyon 2.0 - Premium Edition"
AboutVersion.TextColor3 = Color3.fromRGB(200, 200, 220)
AboutVersion.Font = Enum.Font.Gotham
AboutVersion.TextSize = 11

local AboutDesc = Instance.new("TextLabel", AboutContainer)
AboutDesc.Size = UDim2.new(1, -40, 0, 60)
AboutDesc.Position = UDim2.new(0, 20, 0, 158)
AboutDesc.BackgroundTransparency = 1
AboutDesc.Text = "Mobil cihazlar için optimize edilmiş, güçlü ve kullanımı kolay script yönetim aracı. Özelleştirilebilir ayarlar, ESP sistemi ve daha fazlası!"
AboutDesc.TextColor3 = Color3.fromRGB(180, 180, 200)
AboutDesc.Font = Enum.Font.Gotham
AboutDesc.TextSize = 10
AboutDesc.TextWrapped = true
AboutDesc.TextYAlignment = Enum.TextYAlignment.Top

-- [SCRIPT EKLEME MENÜSÜ]
local AddScriptMenu = Instance.new("Frame", sg)
AddScriptMenu.Size = UDim2.new(0, 400, 0, 280)
AddScriptMenu.Position = UDim2.new(0.5, -200, 0.5, -140)
AddScriptMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
AddScriptMenu.BackgroundTransparency = 0.05
AddScriptMenu.Visible = false
AddScriptMenu.ZIndex = 200
Instance.new("UICorner", AddScriptMenu).CornerRadius = UDim.new(0, 15)

local MenuStroke = Instance.new("UIStroke", AddScriptMenu)
MenuStroke.Thickness = 2
MenuStroke.Color = Color3.fromRGB(168, 85, 247)
MenuStroke.Transparency = 0.3

local MenuGradient = Instance.new("UIGradient", AddScriptMenu)
MenuGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 146, 60))
}
MenuGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(1, 0.9)
}
MenuGradient.Rotation = 45

local MenuTitle = Instance.new("TextLabel", AddScriptMenu)
MenuTitle.Size = UDim2.new(1, -60, 0, 30)
MenuTitle.Position = UDim2.new(0, 15, 0, 12)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "✨ Yeni Script Ekle"
MenuTitle.TextColor3 = Color3.new(1, 1, 1)
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextSize = 16
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.ZIndex = 201

local MenuClose = Instance.new("TextButton", AddScriptMenu)
MenuClose.Size = UDim2.new(0, 30, 0, 30)
MenuClose.Position = UDim2.new(1, -42, 0, 12)
MenuClose.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
MenuClose.BackgroundTransparency = 0.3
MenuClose.Text = "×"
MenuClose.TextColor3 = Color3.fromRGB(248, 113, 113)
MenuClose.Font = Enum.Font.GothamBold
MenuClose.TextSize = 20
MenuClose.ZIndex = 201
Instance.new("UICorner", MenuClose).CornerRadius = UDim.new(0, 8)

local NameLabel = Instance.new("TextLabel", AddScriptMenu)
NameLabel.Size = UDim2.new(1, -30, 0, 18)
NameLabel.Position = UDim2.new(0, 15, 0, 52)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "Script İsmi:"
NameLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextSize = 11
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.ZIndex = 201

local NameBox = Instance.new("TextBox", AddScriptMenu)
NameBox.Size = UDim2.new(1, -30, 0, 35)
NameBox.Position = UDim2.new(0, 15, 0, 73)
NameBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
NameBox.BackgroundTransparency = 0.3
NameBox.PlaceholderText = "Örn: Super Speed Hack"
NameBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
NameBox.Text = ""
NameBox.TextColor3 = Color3.new(1, 1, 1)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 12
NameBox.ClearTextOnFocus = false
NameBox.ZIndex = 201
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 8)

local NameBoxStroke = Instance.new("UIStroke", NameBox)
NameBoxStroke.Thickness = 1
NameBoxStroke.Color = Color3.fromRGB(168, 85, 247)
NameBoxStroke.Transparency = 0.6

local CodeLabel = Instance.new("TextLabel", AddScriptMenu)
CodeLabel.Size = UDim2.new(1, -30, 0, 18)
CodeLabel.Position = UDim2.new(0, 15, 0, 118)
CodeLabel.BackgroundTransparency = 1
CodeLabel.Text = "Script Kodu:"
CodeLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
CodeLabel.Font = Enum.Font.GothamBold
CodeLabel.TextSize = 11
CodeLabel.TextXAlignment = Enum.TextXAlignment.Left
CodeLabel.ZIndex = 201

local CodeBox = Instance.new("TextBox", AddScriptMenu)
CodeBox.Size = UDim2.new(1, -30, 0, 80)
CodeBox.Position = UDim2.new(0, 15, 0, 139)
CodeBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
CodeBox.BackgroundTransparency = 0.3
CodeBox.PlaceholderText = "Lua kodunu buraya yapıştır..."
CodeBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
CodeBox.Text = ""
CodeBox.TextColor3 = Color3.new(1, 1, 1)
CodeBox.Font = Enum.Font.Code
CodeBox.TextSize = 11
CodeBox.MultiLine = true
CodeBox.TextWrapped = true
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.ClearTextOnFocus = false
CodeBox.ZIndex = 201
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 8)

local CodeBoxStroke = Instance.new("UIStroke", CodeBox)
CodeBoxStroke.Thickness = 1
CodeBoxStroke.Color = Color3.fromRGB(168, 85, 247)
CodeBoxStroke.Transparency = 0.6

local SaveScriptBtn = Instance.new("TextButton", AddScriptMenu)
SaveScriptBtn.Size = UDim2.new(1, -30, 0, 38)
SaveScriptBtn.Position = UDim2.new(0, 15, 0, 230)
SaveScriptBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
SaveScriptBtn.BackgroundTransparency = 0.15
SaveScriptBtn.Text = "✓ Scripti Ekle"
SaveScriptBtn.TextColor3 = Color3.new(1, 1, 1)
SaveScriptBtn.Font = Enum.Font.GothamBold
SaveScriptBtn.TextSize = 14
SaveScriptBtn.ZIndex = 201
Instance.new("UICorner", SaveScriptBtn).CornerRadius = UDim.new(0, 10)

local SaveStroke = Instance.new("UIStroke", SaveScriptBtn)
SaveStroke.Thickness = 1.5
SaveStroke.Color = Color3.fromRGB(34, 197, 94)
SaveStroke.Transparency = 0.5

-- [MENÜ BUTONU]
local function CreateMenuBtn(icon, text, pageName)
    local Btn = Instance.new("TextButton", LeftScroll)
    Btn.Size = UDim2.new(1, -6, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Btn.BackgroundTransparency = 0.5
    Btn.Text = ""
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    local BtnStroke = Instance.new("UIStroke", Btn)
    BtnStroke.Thickness = 1
    BtnStroke.Color = Color3.fromRGB(255, 255, 255)
    BtnStroke.Transparency = 0.85
    
    local Icon = Instance.new("TextLabel", Btn)
    Icon.Size = UDim2.new(0, 25, 0, 25)
    Icon.Position = UDim2.new(0, 8, 0.5, -12.5)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = Color3.fromRGB(168, 85, 247)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 14
    
    local Label = Instance.new("TextLabel", Btn)
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 35, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.85}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(function()
        if pageName then ShowPage(pageName) end
    end)
    
    return Btn
end

-- [SCRIPT CARD]
local function CreateScriptCard(scriptName, scriptCode)
    local Card = Instance.new("Frame", ScriptsPage)
    Card.Size = UDim2.new(1, 0, 0, 75)
    Card.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Card.BackgroundTransparency = 0.2
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
    
    local CardGradient = Instance.new("UIGradient", Card)
    CardGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 85, 247)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 146, 60))
    }
    CardGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.75),
        NumberSequenceKeypoint.new(1, 0.82)
    }
    CardGradient.Rotation = 45
    
    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Thickness = 1.5
    CardStroke.Color = Color3.fromRGB(255, 255, 255)
    CardStroke.Transparency = 0.7
    
    local ScriptName = Instance.new("TextLabel", Card)
    ScriptName.Size = UDim2.new(1, -175, 0, 22)
    ScriptName.Position = UDim2.new(0, 10, 0, 8)
    ScriptName.BackgroundTransparency = 1
    ScriptName.Text = scriptName
    ScriptName.TextColor3 = Color3.new(1, 1, 1)
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.TextSize = 12
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.TextTruncate = Enum.TextTruncate.AtEnd
    
    local ScriptDesc = Instance.new("TextLabel", Card)
    ScriptDesc.Size = UDim2.new(1, -175, 0, 14)
    ScriptDesc.Position = UDim2.new(0, 10, 0, 31)
    ScriptDesc.BackgroundTransparency = 1
    ScriptDesc.Text = "Çalıştırmaya hazır"
    ScriptDesc.TextColor3 = Color3.fromRGB(190, 190, 210)
    ScriptDesc.Font = Enum.Font.Gotham
    ScriptDesc.TextSize = 9
    ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    local ExecuteBtn = Instance.new("TextButton", Card)
    ExecuteBtn.Size = UDim2.new(0, 75, 0, 28)
    ExecuteBtn.Position = UDim2.new(1, -82, 0, 8)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    ExecuteBtn.BackgroundTransparency = 0.15
    ExecuteBtn.Text = "▶ Çalıştır"
    ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)
    ExecuteBtn.Font = Enum.Font.GothamBold
    ExecuteBtn.TextSize = 10
    Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(0, 7)
    
    local ExecStroke = Instance.new("UIStroke", ExecuteBtn)
    ExecStroke.Thickness = 1
    ExecStroke.Color = Color3.fromRGB(34, 197, 94)
    ExecStroke.Transparency = 0.5
    
    ExecuteBtn.MouseButton1Click:Connect(function()
        ExecuteBtn.Text = "✓"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
        task.wait(0.8)
        ExecuteBtn.Text = "▶ Çalıştır"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        
        if scriptCode then
            pcall(function()
                loadstring(scriptCode)()
            end)
        end
    end)
    
    local DeleteBtn = Instance.new("TextButton", Card)
    DeleteBtn.Size = UDim2.new(0, 75, 0, 28)
    DeleteBtn.Position = UDim2.new(1, -82, 0, 42)
    DeleteBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    DeleteBtn.BackgroundTransparency = 0.15
    DeleteBtn.Text = "🗑 Sil"
    DeleteBtn.TextColor3 = Color3.new(1, 1, 1)
    DeleteBtn.Font = Enum.Font.GothamBold
    DeleteBtn.TextSize = 10
    Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 7)
    
    local DelStroke = Instance.new("UIStroke", DeleteBtn)
    DelStroke.Thickness = 1
    DelStroke.Color = Color3.fromRGB(239, 68, 68)
    DelStroke.Transparency = 0.5
    
    DeleteBtn.MouseButton1Click:Connect(function()
        for i, script in ipairs(SavedScripts) do
            if script.name == scriptName then
                table.remove(SavedScripts, i)
                SaveScriptData()
                break
            end
        end
        
        TweenService:Create(Card, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        Card:Destroy()
    end)
    
    return Card
end

-- [KONTROLLER]
MinimizeBtn.MouseButton1Click:Connect(function()
    Main:TweenPosition(UDim2.new(0.5, -325, 1.5, 0), "In", "Quart", 0.5, true)
    task.wait(0.5)
    Main.Visible = false
    MinimizeLogo.Visible = true
    TweenService:Create(MinimizeLogo, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 45, 0, 45)}):Play()
end)

MinimizeLogo.MouseButton1Click:Connect(function()
    TweenService:Create(MinimizeLogo, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.2)
    MinimizeLogo.Visible = false
    Main.Visible = true
    Main:TweenPosition(UDim2.new(0.5, -325, 0.5, -160), "Out", "Quart", 0.5, true)
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main:TweenPosition(UDim2.new(0.5, -325, 1.5, 0), "In", "Quart", 0.6, true)
    task.wait(0.6)
    sg:Destroy()
end)

AddScriptBtn.MouseButton1Click:Connect(function()
    AddScriptMenu.Visible = true
    AddScriptMenu.Size = UDim2.new(0, 0, 0, 0)
    AddScriptMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(AddScriptMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 400, 0, 280),
        Position = UDim2.new(0.5, -200, 0.5, -140)
    }):Play()
end)

MenuClose.MouseButton1Click:Connect(function()
    TweenService:Create(AddScriptMenu, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.wait(0.2)
    AddScriptMenu.Visible = false
    NameBox.Text = ""
    CodeBox.Text = ""
end)

SaveScriptBtn.MouseButton1Click:Connect(function()
    local name = NameBox.Text
    local code = CodeBox.Text
    
    if name ~= "" and code ~= "" then
        table.insert(SavedScripts, {
            name = name,
            code = code
        })
        SaveScriptData()
        CreateScriptCard(name, code)
        
        SaveScriptBtn.Text = "✓ Eklendi!"
        task.wait(0.5)
        SaveScriptBtn.Text = "✓ Scripti Ekle"
        
        TweenService:Create(AddScriptMenu, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.2)
        AddScriptMenu.Visible = false
        NameBox.Text = ""
        CodeBox.Text = ""
    else
        SaveScriptBtn.Text = "⚠️ Boş bırakma!"
        task.wait(1)
        SaveScriptBtn.Text = "✓ Scripti Ekle"
    end
end)

-- [GRADIENT ANIMASYONU]
task.spawn(function()
    while true do
        TweenService:Create(HeaderGradient, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = HeaderGradient.Rotation + 360}):Play()
        TweenService:Create(LeftGradient, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = LeftGradient.Rotation + 360}):Play()
        TweenService:Create(LogoGradient, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = LogoGradient.Rotation + 360}):Play()
        TweenService:Create(MiniLogoGradient, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = MiniLogoGradient.Rotation + 360}):Play()
        TweenService:Create(MenuGradient, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = MenuGradient.Rotation + 360}):Play()
        task.wait(5)
    end
end)

-- [ANA AKIŞ]
task.spawn(function()
    for i = 1, 2 do
        Bar.AnchorPoint = Vector2.new(0, 0)
        Bar.Position = UDim2.new(0, 0, 0, 0)
        TweenService:Create(Bar, TweenInfo.new(1.3, Enum.EasingStyle.Sine), {Size = UDim2.new(1, 0, 1, 0)}):Play()
        task.wait(1.4)
        Bar.AnchorPoint = Vector2.new(1, 0)
        Bar.Position = UDim2.new(1, 0, 0, 0)
        TweenService:Create(Bar, TweenInfo.new(1.3, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 0, 1, 0)}):Play()
        task.wait(1.4)
    end
    LoaderBase:Destroy()

    TweenService:Create(Title, TweenInfo.new(0.7, Enum.EasingStyle.Back), {TextSize = 60}):Play()
    task.wait(0.7)
    Title.Text = "76 Pre Gui Reborn"
    TweenService:Create(Title, TweenInfo.new(0.6), {TextSize = 42, TextColor3 = Color3.new(1, 1, 1)}):Play()
    task.wait(2)
    TweenService:Create(Title, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {TextSize = 0}):Play()
    task.wait(0.6)
    Title:Destroy()

    Main.Visible = true
    Main:TweenPosition(UDim2.new(0.5, -325, 0.5, -160), "Out", "Quart", 0.8, true)
    
    task.wait(0.3)
    CreateMenuBtn("📜", "Scriptler", "Scripts")
    CreateMenuBtn("🎮", "Oyuncu", "Player")
    CreateMenuBtn("👁️", "ESP", "ESP")
    CreateMenuBtn("⚙️", "Ayarlar", "Settings")
    CreateMenuBtn("ℹ️", "Hakkında", "About")
    
    ShowPage("Scripts")
    
    for _, script in ipairs(SavedScripts) do
        CreateScriptCard(script.name, script.code)
    end
    
    if #SavedScripts == 0 then
        task.wait(0.2)
        CreateScriptCard("WalkSpeed Boost", [[game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100]])
        CreateScriptCard("Jump Power", [[game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150]])
    end
end)

print("76 Realme 8 GUI yüklendi! - v2.0")
