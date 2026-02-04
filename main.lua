local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local Settings = {WalkSpeed=16, JumpPower=50, FOV=70, Theme="Sunset", Language="TR"}
local SavedScripts = {}

-- TEMALAR (GENİŞLETİLMİŞ)
local Themes = {
	Sunset = {
		p=Color3.fromRGB(255,107,107), 
		s=Color3.fromRGB(255,175,123), 
		t=Color3.fromRGB(255,218,121), 
		bg=Color3.fromRGB(10,10,15), 
		pn=Color3.fromRGB(20,20,25), 
		tx=Color3.new(1,1,1),
		-- 2. KATMAN GRADİENT
		bg1=Color3.fromRGB(255,75,75),   -- Kırmızı
		bg2=Color3.fromRGB(255,150,50),  -- Turuncu
		bg3=Color3.fromRGB(255,200,100)  -- Açık turuncu
	},
	Techno = {
		p=Color3.fromRGB(168,85,247), 
		s=Color3.fromRGB(236,72,153), 
		t=Color3.fromRGB(251,146,60), 
		bg=Color3.fromRGB(18,18,28), 
		pn=Color3.fromRGB(25,25,40), 
		tx=Color3.new(1,1,1),
		-- 2. KATMAN GRADİENT
		bg1=Color3.fromRGB(100,50,255),  -- Mor
		bg2=Color3.fromRGB(50,150,255),  -- Mavi
		bg3=Color3.fromRGB(0,255,200)    -- Turkuaz
	},
	["Dark Neon"] = {
		p=Color3.fromRGB(0,255,100), 
		s=Color3.fromRGB(100,255,150), 
		t=Color3.fromRGB(150,255,200), 
		bg=Color3.fromRGB(5,5,5), 
		pn=Color3.fromRGB(15,15,15), 
		tx=Color3.new(1,1,1),
		-- 2. KATMAN GRADİENT
		bg1=Color3.fromRGB(0,0,0),       -- Siyah
		bg2=Color3.fromRGB(0,255,100),   -- Yeşil
		bg3=Color3.fromRGB(100,255,150)  -- Açık yeşil
	},
	Normal = {
		p=Color3.fromRGB(80,80,80), 
		s=Color3.fromRGB(120,120,120), 
		t=Color3.fromRGB(160,160,160), 
		bg=Color3.fromRGB(0,0,0), 
		pn=Color3.fromRGB(20,20,20), 
		tx=Color3.new(1,1,1),
		-- 2. KATMAN GRADİENT (FULL SİYAH)
		bg1=Color3.fromRGB(0,0,0),
		bg2=Color3.fromRGB(0,0,0),
		bg3=Color3.fromRGB(0,0,0)
	},
	Rainbow = {
		p=Color3.fromRGB(255,0,0), 
		s=Color3.fromRGB(0,255,0), 
		t=Color3.fromRGB(0,0,255), 
		bg=Color3.fromRGB(10,10,10), 
		pn=Color3.fromRGB(20,20,20), 
		tx=Color3.new(1,1,1),
		-- 2. KATMAN GRADİENT (RENGARENK)
		bg1=Color3.fromRGB(255,0,0),     -- Kırmızı
		bg2=Color3.fromRGB(0,255,0),     -- Yeşil
		bg3=Color3.fromRGB(0,0,255),     -- Mavi
		rainbow=true -- Özel flag
	}
}

local Lang = {
	TR = {scripts="📜 Scriptler", addScript="+ Yeni Script Ekle", player="🎮 Oyuncu", esp="👁️ ESP", settings="⚙️ Ayarlar", about="ℹ️ Hakkında", walkSpeed="🏃 Yürüme Hızı", jumpPower="⬆️ Zıplama Gücü", fov="👁️ Görüş Alanı", execute="▶ Çalıştır", delete="🗑 Sil", ready="Çalıştırmaya hazır", scriptName="Script İsmi:", scriptCode="Script Kodu:", addBtn="✓ Scripti Ekle", added="✓ Eklendi!", empty="⚠️ Boş bırakma!", save="💾 Kaydet", reset="🔄 Sıfırla", delAll="🗑️ Tümünü Sil", theme="🎨 Tema", language="🌐 Dil", playerESP="👁️ Oyuncu ESP", boxESP="📦 Kutu ESP", nameESP="👤 İsim ESP", healthESP="❤️ Can ESP", themeChanged="Tema değişti! GUI'yi kapat-aç.", langChanged="Dil değişti! GUI'yi kapat-aç."},
	EN = {scripts="📜 Scripts", addScript="+ Add Script", player="🎮 Player", esp="👁️ ESP", settings="⚙️ Settings", about="ℹ️ About", walkSpeed="🏃 Walk Speed", jumpPower="⬆️ Jump Power", fov="👁️ FOV", execute="▶ Execute", delete="🗑 Delete", ready="Ready", scriptName="Name:", scriptCode="Code:", addBtn="✓ Add", added="✓ Added!", empty="⚠️ Empty!", save="💾 Save", reset="🔄 Reset", delAll="🗑️ Delete All", theme="🎨 Theme", language="🌐 Language", playerESP="👁️ Player ESP", boxESP="📦 Box ESP", nameESP="👤 Name ESP", healthESP="❤️ Health ESP", themeChanged="Theme changed! Close and reopen GUI.", langChanged="Language changed! Close and reopen GUI."},
	DE = {scripts="📜 Skripte", addScript="+ Neu", player="🎮 Spieler", esp="👁️ ESP", settings="⚙️ Einstellungen", about="ℹ️ Über", walkSpeed="🏃 Speed", jumpPower="⬆️ Jump", fov="👁️ FOV", execute="▶ Start", delete="🗑 Löschen", ready="Bereit", scriptName="Name:", scriptCode="Code:", addBtn="✓ Add", added="✓ OK!", empty="⚠️ Leer!", save="💾 Speichern", reset="🔄 Zurück", delAll="🗑️ Löschen", theme="🎨 Thema", language="🌐 Sprache", playerESP="👁️ ESP", boxESP="📦 ESP", nameESP="👤 ESP", healthESP="❤️ ESP", themeChanged="Thema geändert! GUI schließen und öffnen.", langChanged="Sprache geändert! GUI schließen und öffnen."},
	AR = {scripts="📜 سكريبت", addScript="+ جديد", player="🎮 لاعب", esp="👁️ ESP", settings="⚙️ إعدادات", about="ℹ️ حول", walkSpeed="🏃 سرعة", jumpPower="⬆️ قفز", fov="👁️ رؤية", execute="▶ تنفيذ", delete="🗑 حذف", ready="جاهز", scriptName="اسم:", scriptCode="كود:", addBtn="✓ إضافة", added="✓ تم!", empty="⚠️ فارغ!", save="💾 حفظ", reset="🔄 إعادة", delAll="🗑️ حذف", theme="🎨 مظهر", language="🌐 لغة", playerESP="👁️ ESP", boxESP="📦 ESP", nameESP="👤 ESP", healthESP="❤️ ESP", themeChanged="تم تغيير المظهر! أغلق وافتح GUI.", langChanged="تم تغيير اللغة! أغلق وافتح GUI."},
	AZ = {scripts="📜 Skriptlər", addScript="+ Yeni", player="🎮 Oyunçu", esp="👁️ ESP", settings="⚙️ Parametrlər", about="ℹ️ Haqqında", walkSpeed="🏃 Sürət", jumpPower="⬆️ Tullanma", fov="👁️ Görüş", execute="▶ İcra", delete="🗑 Sil", ready="Hazır", scriptName="Ad:", scriptCode="Kod:", addBtn="✓ Əlavə", added="✓ OK!", empty="⚠️ Boş!", save="💾 Saxla", reset="🔄 Sıfırla", delAll="🗑️ Sil", theme="🎨 Tema", language="🌐 Dil", playerESP="👁️ ESP", boxESP="📦 ESP", nameESP="👤 ESP", healthESP="❤️ ESP", themeChanged="Tema dəyişdi! GUI-ni bağla-aç.", langChanged="Dil dəyişdi! GUI-ni bağla-aç."}
}

local th = Themes[Settings.Theme]
local lg = Lang[Settings.Language]
local function GT(k) return lg[k] or k end

local function SaveScriptData() writefile("76S.json", game:GetService("HttpService"):JSONEncode(SavedScripts)) end
local function LoadScriptData() if isfile("76S.json") then pcall(function() SavedScripts = game:GetService("HttpService"):JSONDecode(readfile("76S.json")) end) end end
local function SaveSettings() writefile("76Set.json", game:GetService("HttpService"):JSONEncode(Settings)) end
local function LoadSettings() if isfile("76Set.json") then pcall(function() Settings = game:GetService("HttpService"):JSONDecode(readfile("76Set.json")) th = Themes[Settings.Theme] lg = Lang[Settings.Language] end) end end

LoadScriptData()
LoadSettings()

local sg = Instance.new("ScreenGui")
sg.Name = "76Reborn"
sg.IgnoreGuiInset = true
pcall(function() sg.Parent = game:GetService("CoreGui") end)
if not sg.Parent then sg.Parent = lp.PlayerGui end

-- Loading Bar
local LB = Instance.new("Frame", sg)
LB.Size = UDim2.new(0, 130, 0, 4)
LB.Position = UDim2.new(0.5, -65, 0.5, -2)
LB.BackgroundColor3 = Color3.new(0, 0, 0)
LB.BackgroundTransparency = 0.5
LB.BorderSizePixel = 0
Instance.new("UICorner", LB).CornerRadius = UDim.new(1, 0)

local Bar = Instance.new("Frame", LB)
Bar.BackgroundColor3 = Color3.fromRGB(0, 113, 226)
Bar.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

local TitleLabel = Instance.new("TextLabel", sg)
TitleLabel.Size = UDim2.new(0, 500, 0, 100)
TitleLabel.Position = UDim2.new(0.5, -250, 0.5, -50)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(0, 113, 226)
TitleLabel.Text = "."
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 0

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 650, 0, 320)
Main.Position = UDim2.new(0.5, -325, 1.5, 0)
Main.BackgroundTransparency = 1
Main.Visible = false
Main.Active = true

-- ========== 2. KATMAN (ARKA PLAN GRADİENT) ==========
local BackgroundLayer = Instance.new("Frame", Main)
BackgroundLayer.Size = UDim2.new(1, 0, 1, 0)
BackgroundLayer.Position = UDim2.new(0, 0, 0, 0)
BackgroundLayer.BackgroundColor3 = Color3.new(1, 1, 1)
BackgroundLayer.ZIndex = 0 -- EN ARKADA
Instance.new("UICorner", BackgroundLayer).CornerRadius = UDim.new(0, 12)

local BackgroundGradient = Instance.new("UIGradient", BackgroundLayer)
local bgKeys = {
	ColorSequenceKeypoint.new(0, th.bg1),
	ColorSequenceKeypoint.new(0.5, th.bg2),
	ColorSequenceKeypoint.new(1, th.bg3)
}
BackgroundGradient.Color = ColorSequence.new(bgKeys)
BackgroundGradient.Rotation = 45

-- Drag
local isDragging = false
local dragOffset = Vector2.new(0, 0)
local startMainPos = UDim2.new()

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		dragOffset = input.Position
		startMainPos = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragOffset
		Main.Position = UDim2.new(startMainPos.X.Scale, startMainPos.X.Offset + delta.X, startMainPos.Y.Scale, startMainPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = false
	end
end)

-- Header (1. KATMAN - ZIndex yüksek)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = th.pn
Header.ZIndex = 1
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local HeaderGrad = Instance.new("UIGradient", Header)
local colorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(0.5, th.s),
	ColorSequenceKeypoint.new(1, th.t)
}
HeaderGrad.Color = ColorSequence.new(colorKeys)
local transKeys = {
	NumberSequenceKeypoint.new(0, 0.88),
	NumberSequenceKeypoint.new(1, 0.92)
}
HeaderGrad.Transparency = NumberSequence.new(transKeys)
HeaderGrad.Rotation = 135

local Logo = Instance.new("TextLabel", Header)
Logo.Size = UDim2.new(0, 38, 0, 38)
Logo.Position = UDim2.new(0, 8, 0, 6)
Logo.BackgroundColor3 = th.p
Logo.Text = "76"
Logo.TextColor3 = th.tx
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 17
Logo.ZIndex = 2
Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 8)

local LogoGrad = Instance.new("UIGradient", Logo)
local logoColorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(1, th.s)
}
LogoGrad.Color = ColorSequence.new(logoColorKeys)
LogoGrad.Rotation = 45

local HTitle = Instance.new("TextLabel", Header)
HTitle.Size = UDim2.new(0, 150, 0, 20)
HTitle.Position = UDim2.new(0, 53, 0, 8)
HTitle.BackgroundTransparency = 1
HTitle.Text = "76 Reborn"
HTitle.TextColor3 = th.tx
HTitle.Font = Enum.Font.GothamBold
HTitle.TextSize = 14
HTitle.TextXAlignment = Enum.TextXAlignment.Left
HTitle.ZIndex = 2

local HSub = Instance.new("TextLabel", Header)
HSub.Size = UDim2.new(0, 150, 0, 15)
HSub.Position = UDim2.new(0, 53, 0, 28)
HSub.BackgroundTransparency = 1
HSub.Text = "Premium Hub"
HSub.TextColor3 = th.s
HSub.Font = Enum.Font.Gotham
HSub.TextSize = 9
HSub.TextXAlignment = Enum.TextXAlignment.Left
HSub.ZIndex = 2

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -72, 0, 9)
MinBtn.BackgroundColor3 = th.pn
MinBtn.Text = "−"
MinBtn.TextColor3 = th.s
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.ZIndex = 2
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

local ClsBtn = Instance.new("TextButton", Header)
ClsBtn.Size = UDim2.new(0, 32, 0, 32)
ClsBtn.Position = UDim2.new(1, -34, 0, 9)
ClsBtn.BackgroundColor3 = th.pn
ClsBtn.Text = "×"
ClsBtn.TextColor3 = Color3.fromRGB(248, 113, 113)
ClsBtn.Font = Enum.Font.GothamBold
ClsBtn.TextSize = 22
ClsBtn.ZIndex = 2
Instance.new("UICorner", ClsBtn).CornerRadius = UDim.new(0, 7)

-- Mini Logo
local MiniLogo = Instance.new("TextButton", sg)
MiniLogo.Size = UDim2.new(0, 45, 0, 45)
MiniLogo.Position = UDim2.new(0, 12, 0, 60)
MiniLogo.BackgroundColor3 = th.p
MiniLogo.Text = "76"
MiniLogo.TextColor3 = th.tx
MiniLogo.Font = Enum.Font.GothamBold
MiniLogo.TextSize = 16
MiniLogo.Visible = false
MiniLogo.ZIndex = 100
MiniLogo.Active = true
MiniLogo.Draggable = true
Instance.new("UICorner", MiniLogo).CornerRadius = UDim.new(0, 10)

-- Mini Logo Gradient
local MiniLogoGrad = Instance.new("UIGradient", MiniLogo)
local miniColorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(1, th.s)
}
MiniLogoGrad.Color = ColorSequence.new(miniColorKeys)
MiniLogoGrad.Rotation = 45

-- Left Panel
local LeftPanel = Instance.new("Frame", Main)
LeftPanel.Size = UDim2.new(0, 200, 0, 260)
LeftPanel.Position = UDim2.new(0, 0, 0, 60)
LeftPanel.BackgroundColor3 = th.pn
LeftPanel.BackgroundTransparency = 0.1
LeftPanel.ZIndex = 1
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 12)

local LeftGrad = Instance.new("UIGradient", LeftPanel)
local leftColorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(0.5, th.s),
	ColorSequenceKeypoint.new(1, th.t)
}
LeftGrad.Color = ColorSequence.new(leftColorKeys)
local leftTransKeys = {
	NumberSequenceKeypoint.new(0, 0.88),
	NumberSequenceKeypoint.new(1, 0.92)
}
LeftGrad.Transparency = NumberSequence.new(leftTransKeys)
LeftGrad.Rotation = 135

local LeftScroll = Instance.new("ScrollingFrame", LeftPanel)
LeftScroll.Size = UDim2.new(1, -10, 1, -10)
LeftScroll.Position = UDim2.new(0, 5, 0, 5)
LeftScroll.BackgroundTransparency = 1
LeftScroll.BorderSizePixel = 0
LeftScroll.ScrollBarThickness = 4
LeftScroll.ScrollBarImageColor3 = th.p
LeftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
LeftScroll.ZIndex = 2

local LeftLayout = Instance.new("UIListLayout", LeftScroll)
LeftLayout.Padding = UDim.new(0, 6)
LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
LeftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	LeftScroll.CanvasSize = UDim2.new(0, 0, 0, LeftLayout.AbsoluteContentSize.Y + 10)
end)

-- Right Panel
local RightPanel = Instance.new("Frame", Main)
RightPanel.Size = UDim2.new(0, 440, 0, 260)
RightPanel.Position = UDim2.new(0, 210, 0, 60)
RightPanel.BackgroundColor3 = th.bg
RightPanel.ZIndex = 1
Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 12)

local RightGrad = Instance.new("UIGradient", RightPanel)
local rightColorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(0.5, th.s),
	ColorSequenceKeypoint.new(1, th.t)
}
RightGrad.Color = ColorSequence.new(rightColorKeys)
local rightTransKeys = {
	NumberSequenceKeypoint.new(0, 0.9),
	NumberSequenceKeypoint.new(1, 0.95)
}
RightGrad.Transparency = NumberSequence.new(rightTransKeys)
RightGrad.Rotation = 90

-- Pages
local Pages = {}
local function CreatePage(name)
	local Page = Instance.new("ScrollingFrame", RightPanel)
	Page.Size = UDim2.new(1, -16, 1, -16)
	Page.Position = UDim2.new(0, 8, 0, 8)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.ScrollBarThickness = 5
	Page.ScrollBarImageColor3 = th.p
	Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	Page.Visible = false
	Page.ZIndex = 2
	local PL = Instance.new("UIListLayout", Page)
	PL.Padding = UDim.new(0, 8)
	PL.SortOrder = Enum.SortOrder.LayoutOrder
	PL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Page.CanvasSize = UDim2.new(0, 0, 0, PL.AbsoluteContentSize.Y + 10)
	end)
	Pages[name] = Page
	return Page
end

local function ShowPage(name)
	for k, v in pairs(Pages) do
		v.Visible = (k == name)
	end
end

local ScriptsPage = CreatePage("Scripts")
local PlayerPage = CreatePage("Player")
local ESPPage = CreatePage("ESP")
local SettingsPage = CreatePage("Settings")
local AboutPage = CreatePage("About")

-- Menu Button
local function CreateMenuBtn(icon, text, pageName)
	local Btn = Instance.new("TextButton", LeftScroll)
	Btn.Size = UDim2.new(1, -6, 0, 38)
	Btn.BackgroundColor3 = th.pn
	Btn.BackgroundTransparency = 0.5
	Btn.Text = ""
	Btn.ZIndex = 3
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
	local Ic = Instance.new("TextLabel", Btn)
	Ic.Size = UDim2.new(0, 25, 0, 25)
	Ic.Position = UDim2.new(0, 8, 0.5, -12.5)
	Ic.BackgroundTransparency = 1
	Ic.Text = icon
	Ic.TextColor3 = th.p
	Ic.Font = Enum.Font.GothamBold
	Ic.TextSize = 14
	Ic.ZIndex = 4
	local Lb = Instance.new("TextLabel", Btn)
	Lb.Size = UDim2.new(1, -40, 1, 0)
	Lb.Position = UDim2.new(0, 35, 0, 0)
	Lb.BackgroundTransparency = 1
	Lb.Text = text
	Lb.TextColor3 = th.tx
	Lb.Font = Enum.Font.Gotham
	Lb.TextSize = 11
	Lb.TextXAlignment = Enum.TextXAlignment.Left
	Lb.ZIndex = 4
	Btn.MouseButton1Click:Connect(function()
		ShowPage(pageName)
	end)
end

-- Slider
local function CreateSlider(parent, text, min, max, default, callback)
	local C = Instance.new("Frame", parent)
	C.Size = UDim2.new(1, 0, 0, 60)
	C.BackgroundColor3 = th.pn
	C.BackgroundTransparency = 0.3
	C.ZIndex = 3
	Instance.new("UICorner", C).CornerRadius = UDim.new(0, 10)
	local Label = Instance.new("TextLabel", C)
	Label.Size = UDim2.new(1, -70, 0, 20)
	Label.Position = UDim2.new(0, 10, 0, 8)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = th.tx
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 11
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 4
	local ValLabel = Instance.new("TextLabel", C)
	ValLabel.Size = UDim2.new(0, 50, 0, 20)
	ValLabel.Position = UDim2.new(1, -60, 0, 8)
	ValLabel.BackgroundTransparency = 1
	ValLabel.Text = tostring(default)
	ValLabel.TextColor3 = th.p
	ValLabel.Font = Enum.Font.GothamBold
	ValLabel.TextSize = 11
	ValLabel.TextXAlignment = Enum.TextXAlignment.Right
	ValLabel.ZIndex = 4
	local Track = Instance.new("Frame", C)
	Track.Size = UDim2.new(1, -20, 0, 6)
	Track.Position = UDim2.new(0, 10, 0, 40)
	Track.BackgroundColor3 = th.bg
	Track.ZIndex = 4
	Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
	local Fill = Instance.new("Frame", Track)
	Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	Fill.BackgroundColor3 = th.p
	Fill.ZIndex = 5
	Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
	local pressing = false
	local function calc(pos)
		local rel = math.clamp((pos - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
		Fill.Size = UDim2.new(rel, 0, 1, 0)
		local val = math.floor(min + (max - min) * rel)
		ValLabel.Text = tostring(val)
		if callback then callback(val) end
	end
	Track.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			pressing = true
			calc(inp.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if pressing and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			calc(inp.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			pressing = false
		end
	end)
end

-- Toggle
local function CreateToggle(parent, text, default, callback)
	local C = Instance.new("Frame", parent)
	C.Size = UDim2.new(1, 0, 0, 45)
	C.BackgroundColor3 = th.pn
	C.BackgroundTransparency = 0.3
	C.ZIndex = 3
	Instance.new("UICorner", C).CornerRadius = UDim.new(0, 10)
	local Label = Instance.new("TextLabel", C)
	Label.Size = UDim2.new(1, -60, 1, 0)
	Label.Position = UDim2.new(0, 10, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.TextColor3 = th.tx
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 11
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.ZIndex = 4
	local Back = Instance.new("Frame", C)
	Back.Size = UDim2.new(0, 45, 0, 25)
	Back.Position = UDim2.new(1, -55, 0.5, -12.5)
	Back.BackgroundColor3 = default and Color3.fromRGB(34, 197, 94) or th.bg
	Back.ZIndex = 4
	Instance.new("UICorner", Back).CornerRadius = UDim.new(1, 0)
	local Knob = Instance.new("Frame", Back)
	Knob.Size = UDim2.new(0, 21, 0, 21)
	Knob.Position = default and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
	Knob.BackgroundColor3 = Color3.new(1, 1, 1)
	Knob.ZIndex = 5
	Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
	local state = default
	local Btn = Instance.new("TextButton", Back)
	Btn.Size = UDim2.new(1, 0, 1, 0)
	Btn.BackgroundTransparency = 1
	Btn.Text = ""
	Btn.ZIndex = 6
	Btn.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(Knob, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)}):Play()
		TweenService:Create(Back, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(34, 197, 94) or th.bg}):Play()
		if callback then callback(state) end
	end)
end

-- Button
local function CreateButton(parent, text, color, callback)
	local Btn = Instance.new("TextButton", parent)
	Btn.Size = UDim2.new(1, 0, 0, 40)
	Btn.BackgroundColor3 = color
	Btn.BackgroundTransparency = 0.2
	Btn.Text = text
	Btn.TextColor3 = th.tx
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 12
	Btn.ZIndex = 3
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
	Btn.MouseButton1Click:Connect(function() if callback then callback() end end)
end

-- Script Card (ZIndex ekleyelim)
local function CreateScriptCard(name, code)
	local Card = Instance.new("Frame", ScriptsPage)
	Card.Size = UDim2.new(1, 0, 0, 75)
	Card.BackgroundColor3 = th.pn
	Card.BackgroundTransparency = 0.3
	Card.ZIndex = 3
	Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
	local NameL = Instance.new("TextLabel", Card)
	NameL.Size = UDim2.new(1, -170, 0, 22)
	NameL.Position = UDim2.new(0, 10, 0, 8)
	NameL.BackgroundTransparency = 1
	NameL.Text = name
	NameL.TextColor3 = th.tx
	NameL.Font = Enum.Font.GothamBold
	NameL.TextSize = 12
	NameL.TextXAlignment = Enum.TextXAlignment.Left
	NameL.TextTruncate = Enum.TextTruncate.AtEnd
	NameL.ZIndex = 4
	local DescL = Instance.new("TextLabel", Card)
	DescL.Size = UDim2.new(1, -170, 0, 14)
	DescL.Position = UDim2.new(0, 10, 0, 32)
	DescL.BackgroundTransparency = 1
	DescL.Text = GT("ready")
	DescL.TextColor3 = th.s
	DescL.Font = Enum.Font.Gotham
	DescL.TextSize = 9
	DescL.TextXAlignment = Enum.TextXAlignment.Left
	DescL.ZIndex = 4
	local ExecBtn = Instance.new("TextButton", Card)
	ExecBtn.Size = UDim2.new(0, 75, 0, 28)
	ExecBtn.Position = UDim2.new(1, -82, 0, 8)
	ExecBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
	ExecBtn.Text = GT("execute")
	ExecBtn.TextColor3 = th.tx
	ExecBtn.Font = Enum.Font.GothamBold
	ExecBtn.TextSize = 10
	ExecBtn.ZIndex = 4
	Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 7)
	ExecBtn.MouseButton1Click:Connect(function()
		ExecBtn.Text = "✓"
		pcall(function() loadstring(code)() end)
		task.wait(0.8)
		ExecBtn.Text = GT("execute")
	end)
	local DelBtn = Instance.new("TextButton", Card)
	DelBtn.Size = UDim2.new(0, 75, 0, 28)
	DelBtn.Position = UDim2.new(1, -82, 0, 42)
	DelBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
	DelBtn.Text = GT("delete")
	DelBtn.TextColor3 = th.tx
	DelBtn.Font = Enum.Font.GothamBold
	DelBtn.TextSize = 10
	DelBtn.ZIndex = 4
	Instance.new("UICorner", DelBtn).CornerRadius = UDim.new(0, 7)
	DelBtn.MouseButton1Click:Connect(function()
		for i, s in ipairs(SavedScripts) do
			if s.name == name then table.remove(SavedScripts, i) SaveScriptData() break end
		end
		Card:Destroy()
	end)
end

-- Scripts Page Header
local SH = Instance.new("Frame", ScriptsPage)
SH.Size = UDim2.new(1, 0, 0, 45)
SH.BackgroundTransparency = 1
SH.ZIndex = 3
local AddBtn = Instance.new("TextButton", SH)
AddBtn.Size = UDim2.new(1, 0, 0, 32)
AddBtn.Position = UDim2.new(0, 0, 0, 8)
AddBtn.BackgroundColor3 = th.pn
AddBtn.Text = GT("addScript")
AddBtn.TextColor3 = th.tx
AddBtn.Font = Enum.Font.GothamBold
AddBtn.TextSize = 12
AddBtn.ZIndex = 4
Instance.new("UICorner", AddBtn).CornerRadius = UDim.new(0, 8)
local ABG = Instance.new("UIGradient", AddBtn)
local addBtnColorKeys = {
	ColorSequenceKeypoint.new(0, th.p),
	ColorSequenceKeypoint.new(1, th.s)
}
ABG.Color = ColorSequence.new(addBtnColorKeys)
ABG.Rotation = 45

-- Player Page
CreateSlider(PlayerPage, GT("walkSpeed"), 16, 200, Settings.WalkSpeed, function(v)
	Settings.WalkSpeed = v SaveSettings()
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = v end
end)
CreateSlider(PlayerPage, GT("jumpPower"), 50, 300, Settings.JumpPower, function(v)
	Settings.JumpPower = v SaveSettings()
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.JumpPower = v end
end)
CreateSlider(PlayerPage, GT("fov"), 70, 120, Settings.FOV, function(v)
	Settings.FOV = v SaveSettings()
	workspace.CurrentCamera.FieldOfView = v
end)

-- ESP Page
CreateToggle(ESPPage, GT("playerESP"), false, function(v) print("PlayerESP:", v) end)
CreateToggle(ESPPage, GT("boxESP"), false, function(v) print("BoxESP:", v) end)
CreateToggle(ESPPage, GT("nameESP"), false, function(v) print("NameESP:", v) end)
CreateToggle(ESPPage, GT("healthESP"), false, function(v) print("HealthESP:", v) end)

-- Settings Page
CreateButton(SettingsPage, GT("save"), Color3.fromRGB(34, 197, 94), function() SaveSettings() SaveScriptData() end)
CreateButton(SettingsPage, GT("reset"), Color3.fromRGB(251, 146, 60), function() Settings = {WalkSpeed=16, JumpPower=50, FOV=70, Theme="Sunset", Language="TR"} SaveSettings() end)
CreateButton(SettingsPage, GT("delAll"), Color3.fromRGB(239, 68, 68), function()
	SavedScripts = {} SaveScriptData()
	for _, c in ipairs(ScriptsPage:GetChildren()) do if c:IsA("Frame") and c ~= SH then c:Destroy() end end
end)

-- Tema Butonları (GENİŞLETİLMİŞ)
local ThemeLabel = Instance.new("TextLabel", SettingsPage)
ThemeLabel.Size = UDim2.new(1, 0, 0, 24)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Text = GT("theme")
ThemeLabel.TextColor3 = th.s
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.TextSize = 12
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.ZIndex = 3

local TF = Instance.new("Frame", SettingsPage)
TF.Size = UDim2.new(1, 0, 0, 90)
TF.BackgroundTransparency = 1
TF.ZIndex = 3
local TL = Instance.new("UIListLayout", TF)
TL.FillDirection = Enum.FillDirection.Horizontal
TL.Padding = UDim.new(0, 8)
TL.Wraps = true

local function MakeThemeBtn(themeName)
	local B = Instance.new("TextButton", TF)
	B.Size = UDim2.new(0, 95, 0, 40)
	B.BackgroundColor3 = Themes[themeName].p
	B.Text = themeName
	B.TextColor3 = Color3.new(1, 1, 1)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 11
	B.ZIndex = 4
	Instance.new("UICorner", B).CornerRadius = UDim.new(0, 10)
	B.MouseButton1Click:Connect(function()
		Settings.Theme = themeName
		SaveSettings()
		game.StarterGui:SetCore("SendNotification", {Title="76 Reborn", Text=GT("themeChanged"), Duration=4})
	end)
end
MakeThemeBtn("Sunset")
MakeThemeBtn("Techno")
MakeThemeBtn("Dark Neon")
MakeThemeBtn("Normal")
MakeThemeBtn("Rainbow")

-- Dil
local LangLabel = Instance.new("TextLabel", SettingsPage)
LangLabel.Size = UDim2.new(1, 0, 0, 24)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = GT("language")
LangLabel.TextColor3 = th.s
LangLabel.Font = Enum.Font.GothamBold
LangLabel.TextSize = 12
LangLabel.TextXAlignment = Enum.TextXAlignment.Left
LangLabel.ZIndex = 3

local LF = Instance.new("Frame", SettingsPage)
LF.Size = UDim2.new(1, 0, 0, 40)
LF.BackgroundTransparency = 1
LF.ZIndex = 3
local LL = Instance.new("UIListLayout", LF)
LL.FillDirection = Enum.FillDirection.Horizontal
LL.Padding = UDim.new(0, 6)

local function MakeLangBtn(code, label)
	local B = Instance.new("TextButton", LF)
	B.Size = UDim2.new(0, 58, 0, 40)
	B.BackgroundColor3 = th.pn
	B.Text = label
	B.TextColor3 = th.tx
	B.Font = Enum.Font.GothamBold
	B.TextSize = 11
	B.ZIndex = 4
	Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
	B.MouseButton1Click:Connect(function()
		Settings.Language = code
		SaveSettings()
		local newLang = Lang[code]
		game.StarterGui:SetCore("SendNotification", {Title="76 Reborn", Text=newLang.langChanged, Duration=4})
	end)
end
MakeLangBtn("TR", "🇹🇷 TR")
MakeLangBtn("EN", "🇬🇧 EN")
MakeLangBtn("DE", "🇩🇪 DE")
MakeLangBtn("AR", "🇸🇦 AR")
MakeLangBtn("AZ", "🇦🇿 AZ")

-- About
local AC = Instance.new("Frame", AboutPage)
AC.Size = UDim2.new(1, 0, 0, 220)
AC.BackgroundColor3 = th.pn
AC.BackgroundTransparency = 0.2
AC.ZIndex = 3
Instance.new("UICorner", AC).CornerRadius = UDim.new(0, 12)
local AL = Instance.new("TextLabel", AC)
AL.Size = UDim2.new(0, 80, 0, 80)
AL.Position = UDim2.new(0.5, -40, 0, 15)
AL.BackgroundColor3 = th.p
AL.Text = "76"
AL.TextColor3 = th.tx
AL.Font = Enum.Font.GothamBold
AL.TextSize = 36
AL.ZIndex = 4
Instance.new("UICorner", AL).CornerRadius = UDim.new(0, 15)
local AT = Instance.new("TextLabel", AC)
AT.Size = UDim2.new(1, -20, 0, 25)
AT.Position = UDim2.new(0, 10, 0, 105)
AT.BackgroundTransparency = 1
AT.Text = "76 Reborn GUI"
AT.TextColor3 = th.tx
AT.Font = Enum.Font.GothamBold
AT.TextSize = 18
AT.ZIndex = 4
local AV = Instance.new("TextLabel", AC)
AV.Size = UDim2.new(1, -20, 0, 18)
AV.Position = UDim2.new(0, 10, 0, 133)
AV.BackgroundTransparency = 1
AV.Text = "v2.0 Premium | Tema: " .. Settings.Theme .. " | Dil: " .. Settings.Language
AV.TextColor3 = th.s
AV.Font = Enum.Font.Gotham
AV.TextSize = 11
AV.ZIndex = 4

-- Add Script Menu
local ASMenu = Instance.new("Frame", sg)
ASMenu.Size = UDim2.new(0, 400, 0, 280)
ASMenu.Position = UDim2.new(0.5, -200, 0.5, -140)
ASMenu.BackgroundColor3 = th.bg
ASMenu.Visible = false
ASMenu.ZIndex = 200
Instance.new("UICorner", ASMenu).CornerRadius = UDim.new(0, 15)
local MT = Instance.new("TextLabel", ASMenu)
MT.Size = UDim2.new(1, -60, 0, 30)
MT.Position = UDim2.new(0, 15, 0, 12)
MT.BackgroundTransparency = 1
MT.Text = "✨ Yeni Script Ekle"
MT.TextColor3 = th.tx
MT.Font = Enum.Font.GothamBold
MT.TextSize = 16
MT.TextXAlignment = Enum.TextXAlignment.Left
MT.ZIndex = 201
local MC = Instance.new("TextButton", ASMenu)
MC.Size = UDim2.new(0, 30, 0, 30)
MC.Position = UDim2.new(1, -42, 0, 12)
MC.BackgroundColor3 = th.pn
MC.Text = "×"
MC.TextColor3 = Color3.fromRGB(248, 113, 113)
MC.Font = Enum.Font.GothamBold
MC.TextSize = 20
MC.ZIndex = 201
Instance.new("UICorner", MC).CornerRadius = UDim.new(0, 8)
local NL = Instance.new("TextLabel", ASMenu)
NL.Size = UDim2.new(1, -30, 0, 18)
NL.Position = UDim2.new(0, 15, 0, 52)
NL.BackgroundTransparency = 1
NL.Text = GT("scriptName")
NL.TextColor3 = th.s
NL.Font = Enum.Font.GothamBold
NL.TextSize = 11
NL.TextXAlignment = Enum.TextXAlignment.Left
NL.ZIndex = 201
local NB = Instance.new("TextBox", ASMenu)
NB.Size = UDim2.new(1, -30, 0, 35)
NB.Position = UDim2.new(0, 15, 0, 73)
NB.BackgroundColor3 = th.pn
NB.PlaceholderText = "Örn: Speed Hack"
NB.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
NB.Text = ""
NB.TextColor3 = th.tx
NB.Font = Enum.Font.Gotham
NB.TextSize = 12
NB.ClearTextOnFocus = false
NB.ZIndex = 201
Instance.new("UICorner", NB).CornerRadius = UDim.new(0, 8)
local CL = Instance.new("TextLabel", ASMenu)
CL.Size = UDim2.new(1, -30, 0, 18)
CL.Position = UDim2.new(0, 15, 0, 118)
CL.BackgroundTransparency = 1
CL.Text = GT("scriptCode")
CL.TextColor3 = th.s
CL.Font = Enum.Font.GothamBold
CL.TextSize = 11
CL.TextXAlignment = Enum.TextXAlignment.Left
CL.ZIndex = 201
local CB = Instance.new("TextBox", ASMenu)
CB.Size = UDim2.new(1, -30, 0, 80)
CB.Position = UDim2.new(0, 15, 0, 139)
CB.BackgroundColor3 = th.pn
CB.PlaceholderText = "Lua kod..."
CB.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
CB.Text = ""
CB.TextColor3 = th.tx
CB.Font = Enum.Font.Code
CB.TextSize = 11
CB.MultiLine = true
CB.TextWrapped = true
CB.TextXAlignment = Enum.TextXAlignment.Left
CB.TextYAlignment = Enum.TextYAlignment.Top
CB.ClearTextOnFocus = false
CB.ZIndex = 201
Instance.new("UICorner", CB).CornerRadius = UDim.new(0, 8)
local SSB = Instance.new("TextButton", ASMenu)
SSB.Size = UDim2.new(1, -30, 0, 38)
SSB.Position = UDim2.new(0, 15, 0, 230)
SSB.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
SSB.Text = GT("addBtn")
SSB.TextColor3 = th.tx
SSB.Font = Enum.Font.GothamBold
SSB.TextSize = 14
SSB.ZIndex = 201
Instance.new("UICorner", SSB).CornerRadius = UDim.new(0, 10)

-- Controls
MinBtn.MouseButton1Click:Connect(function()
	Main:TweenPosition(UDim2.new(0.5, -325, 1.5, 0), "In", "Quart", 0.5, true)
	task.wait(0.5)
	Main.Visible = false
	MiniLogo.Visible = true
end)

MiniLogo.MouseButton1Click:Connect(function()
	MiniLogo.Visible = false
	Main.Visible = true
	Main:TweenPosition(UDim2.new(0.5, -325, 0.5, -160), "Out", "Quart", 0.5, true)
end)

ClsBtn.MouseButton1Click:Connect(function()
	Main:TweenPosition(UDim2.new(0.5, -325, 1.5, 0), "In", "Quart", 0.6, true)
	task.wait(0.6)
	sg:Destroy()
end)

AddBtn.MouseButton1Click:Connect(function()
	ASMenu.Visible = true
	ASMenu.Size = UDim2.new(0, 0, 0, 0)
	ASMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
	TweenService:Create(ASMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 280), Position = UDim2.new(0.5, -200, 0.5, -140)}):Play()
end)

MC.MouseButton1Click:Connect(function()
	TweenService:Create(ASMenu, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	task.wait(0.2)
	ASMenu.Visible = false
	NB.Text = ""
	CB.Text = ""
end)

SSB.MouseButton1Click:Connect(function()
	if NB.Text ~= "" and CB.Text ~= "" then
		table.insert(SavedScripts, {name = NB.Text, code = CB.Text})
		SaveScriptData()
		CreateScriptCard(NB.Text, CB.Text)
		SSB.Text = GT("added")
		task.wait(0.5)
		SSB.Text = GT("addBtn")
		TweenService:Create(ASMenu, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
		task.wait(0.2)
		ASMenu.Visible = false
		NB.Text = ""
		CB.Text = ""
	else
		SSB.Text = GT("empty")
		task.wait(1)
		SSB.Text = GT("addBtn")
	end
end)

-- Gradient Animations
task.spawn(function()
	while sg.Parent do
		TweenService:Create(HeaderGrad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = HeaderGrad.Rotation + 360}):Play()
		TweenService:Create(LeftGrad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = LeftGrad.Rotation + 360}):Play()
		TweenService:Create(LogoGrad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = LogoGrad.Rotation + 360}):Play()
		TweenService:Create(RightGrad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = RightGrad.Rotation + 360}):Play()
		TweenService:Create(MiniLogoGrad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Rotation = MiniLogoGrad.Rotation + 360}):Play()
		-- 2. KATMAN GRADİENT ANİMASYONU
		TweenService:Create(BackgroundGradient, TweenInfo.new(8, Enum.EasingStyle.Linear), {Rotation = BackgroundGradient.Rotation + 360}):Play()
		
		-- RAİNBOW TEMA İÇİN RENK DEĞİŞİMİ
		if th.rainbow then
			task.wait(0.5)
			local rainbowKeys = {
				ColorSequenceKeypoint.new(0, Color3.fromHSV(tick() % 5 / 5, 1, 1)),
				ColorSequenceKeypoint.new(0.5, Color3.fromHSV((tick() + 1.67) % 5 / 5, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV((tick() + 3.33) % 5 / 5, 1, 1))
			}
			BackgroundGradient.Color = ColorSequence.new(rainbowKeys)
			LogoGrad.Color = ColorSequence.new(rainbowKeys)
			MiniLogoGrad.Color = ColorSequence.new(rainbowKeys)
		end
		
		task.wait(5)
	end
end)

-- LOADING + OPEN
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
	LB:Destroy()

	TweenService:Create(TitleLabel, TweenInfo.new(0.7, Enum.EasingStyle.Back), {TextSize = 60}):Play()
	task.wait(0.7)
	TitleLabel.Text = "76 Pre Gui Reborn"
	TweenService:Create(TitleLabel, TweenInfo.new(0.6), {TextSize = 42, TextColor3 = Color3.new(1, 1, 1)}):Play()
	task.wait(2)
	TweenService:Create(TitleLabel, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {TextSize = 0}):Play()
	task.wait(0.6)
	TitleLabel:Destroy()

	CreateMenuBtn("📜", GT("scripts"), "Scripts")
	CreateMenuBtn("🎮", GT("player"), "Player")
	CreateMenuBtn("👁️", GT("esp"), "ESP")
	CreateMenuBtn("⚙️", GT("settings"), "Settings")
	CreateMenuBtn("ℹ️", GT("about"), "About")

	if #SavedScripts == 0 then
		CreateScriptCard("WalkSpeed Boost", 'game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100')
		CreateScriptCard("Jump Power", 'game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150')
	else
		for _, s in ipairs(SavedScripts) do
			CreateScriptCard(s.name, s.code)
		end
	end

	ShowPage("Scripts")

	Main.Visible = true
	Main:TweenPosition(UDim2.new(0.5, -325, 0.5, -160), "Out", "Quart", 0.8, true)
end)

print("✨ 76 Reborn GUI - " .. Settings.Theme .. " | " .. Settings.Language)
