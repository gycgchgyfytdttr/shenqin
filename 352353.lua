repeat
	task.wait()
until game:IsLoaded()
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}
local services = setmetatable({}, {
	__index = function(t, k)
		return game.GetService(game, k)
	end,
})
local mouse = services.Players.LocalPlayer:GetMouse()

-- 配置存储
local uiConfig = {
    mainSize = UDim2.new(0, 520, 0, 340),
    backgroundColor = Color3.fromRGB(17, 17, 17),
    transparency = 0,
    borderColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 165, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(238, 130, 238)
    },
    openButtonColor = Color3.fromRGB(37, 254, 152)
}

function Tween(obj, t, data)
	services.TweenService
		:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
		:Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.Position = UDim2.new(
			(mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
			0,
			(mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
			0
		)
		Tween(
			Ripple,
			{ 0.3, "Linear", "InOut" },
			{ Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0) }
		)
		wait(0.15)
		Tween(Ripple, { 0.3, "Linear", "InOut" }, { ImageTransparency = 1 })
		wait(0.3)
		Ripple:Destroy()
	end)
end

local toggled = false
local switchingTabs = false

function switchTab(new)
	if switchingTabs then
		return
	end
	local old = library.currentTab
	if old == nil then
		new[2].Visible = true
		library.currentTab = new
		services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
		services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
		return
	end
	if old[1] == new[1] then
		return
	end
	switchingTabs = true
	library.currentTab = new
	services.TweenService:Create(old[1], TweenInfo.new(0.1), { ImageTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
	services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
	old[2].Visible = false
	new[2].Visible = true
	task.wait(0.1)
	switchingTabs = false
end

function drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library.new(library, name, theme)
	for _, v in next, services.CoreGui:GetChildren() do
		if v.Name == "AL V3 -- Make 123fa98" then
			v:Destroy()
		end
	end

	local config = {
		MainColor = Color3.fromRGB(16, 16, 16),
		TabColor = Color3.fromRGB(22, 22, 22),
		Bg_Color = uiConfig.backgroundColor,
		Zy_Color = Color3.fromRGB(17, 17, 17),

		Button_Color = Color3.fromRGB(22, 22, 22),
		Textbox_Color = Color3.fromRGB(22, 22, 22),
		Dropdown_Color = Color3.fromRGB(22, 22, 22),
		Keybind_Color = Color3.fromRGB(22, 22, 22),
		Label_Color = Color3.fromRGB(22, 22, 22),

		Slider_Color = Color3.fromRGB(22, 22, 22),
		SliderBar_Color = Color3.fromRGB(37, 254, 152),

		Toggle_Color = Color3.fromRGB(22, 22, 22),
		Toggle_Off = Color3.fromRGB(34, 34, 34),
		Toggle_On = Color3.fromRGB(37, 254, 152),
	}

	local dogent = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local TabMain = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local SB = Instance.new("Frame")
	local SBC = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local SideG = Instance.new("UIGradient")
	local TabBtns = Instance.new("ScrollingFrame")
	local TabBtnsL = Instance.new("UIListLayout")
	local ScriptTitle = Instance.new("TextLabel")
	local SBG = Instance.new("UIGradient")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local UICornerMain = Instance.new("UICorner")
	
	-- 彩虹边框
	local RainbowBorder = Instance.new("Frame")
	local RainbowCorner = Instance.new("UICorner")
	local RainbowGradient = Instance.new("UIGradient")
	
	-- 发光效果
	local GlowEffect = Instance.new("ImageLabel")
	
	-- 设置按钮
	local SettingsButton = Instance.new("ImageButton")
	local SettingsCorner = Instance.new("UICorner")

	if syn and syn.protect_gui then
		syn.protect_gui(dogent)
	end
	dogent.Name = "AL V3 -- Make 123fa98"
	dogent.Parent = services.CoreGui
	
	function UiDestroy()
		dogent:Destroy()
	end
	
	function ToggleUILib()
		if not ToggleUI then
			dogent.Enabled = false
			ToggleUI = true
		else
			ToggleUI = false
			dogent.Enabled = true
		end
	end

	-- 彩虹边框设置
	RainbowBorder.Name = "RainbowBorder"
	RainbowBorder.Parent = Main
	RainbowBorder.Size = UDim2.new(1, 8, 1, 8)
	RainbowBorder.Position = UDim2.new(0, -4, 0, -4)
	RainbowBorder.BackgroundTransparency = 0
	RainbowBorder.BorderSizePixel = 0
	RainbowBorder.ZIndex = 0
	
	RainbowCorner.CornerRadius = UDim.new(0, 14)
	RainbowCorner.Parent = RainbowBorder
	
	RainbowGradient.Rotation = 0
	RainbowGradient.Color = ColorSequence.new(uiConfig.borderColors)
	RainbowGradient.Parent = RainbowBorder

	-- 发光效果
	GlowEffect.Name = "GlowEffect"
	GlowEffect.Parent = RainbowBorder
	GlowEffect.BackgroundTransparency = 1
	GlowEffect.Size = UDim2.new(1, 0, 1, 0)
	GlowEffect.Image = "rbxassetid://8992230671"
	GlowEffect.ImageColor3 = Color3.fromRGB(37, 254, 152)
	GlowEffect.ImageTransparency = 0.8
	GlowEffect.ScaleType = Enum.ScaleType.Slice
	GlowEffect.SliceCenter = Rect.new(49, 49, 450, 450)

	Main.Name = "Main"
	Main.Parent = dogent
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = config.Bg_Color
	Main.BackgroundTransparency = uiConfig.transparency
	Main.BorderColor3 = config.MainColor
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 0, 0, 0) -- 初始大小为0
	Main.ZIndex = 1
	Main.Active = true
	Main.Draggable = true
	
	services.UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftControl then
			toggleui()
		end
	end)

	-- 设置按钮
	SettingsButton.Name = "SettingsButton"
	SettingsButton.Parent = Main
	SettingsButton.BackgroundColor3 = Color3.fromRGB(37, 254, 152)
	SettingsButton.Position = UDim2.new(1, -35, 0, 5)
	SettingsButton.Size = UDim2.new(0, 30, 0, 30)
	SettingsButton.Image = "http://www.roblox.com/asset/?id=6031280882"
	SettingsButton.AutoButtonColor = false
	
	SettingsCorner.CornerRadius = UDim.new(0, 6)
	SettingsCorner.Parent = SettingsButton

	local Open = Instance.new("ImageButton")
	local UICorner = Instance.new("UICorner")
	local OpenBorder = Instance.new("Frame")
	local OpenBorderCorner = Instance.new("UICorner")
	local OpenBorderGradient = Instance.new("UIGradient")

	-- 开启按钮的彩虹边框
	OpenBorder.Name = "OpenBorder"
	OpenBorder.Parent = Open
	OpenBorder.Size = UDim2.new(1, 8, 1, 8)
	OpenBorder.Position = UDim2.new(0, -4, 0, -4)
	OpenBorder.BackgroundTransparency = 0
	OpenBorder.BorderSizePixel = 0
	OpenBorder.ZIndex = -1
	
	OpenBorderCorner.CornerRadius = UDim.new(0, 12)
	OpenBorderCorner.Parent = OpenBorder
	
	OpenBorderGradient.Rotation = 0
	OpenBorderGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, uiConfig.openButtonColor),
		ColorSequenceKeypoint.new(1, uiConfig.openButtonColor)
	})
	OpenBorderGradient.Parent = OpenBorder

	Open.Name = "Open"
	Open.Parent = dogent
	Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Open.BackgroundTransparency = 1
	Open.Position = UDim2.new(0.00829315186, 0, 0.13107837, 0)
	Open.Size = UDim2.new(0, 66, 0, 66)
	Open.Active = true
	Open.Draggable = true
	Open.Image = "rbxassetid://93774288685915"
	
	Open.MouseButton1Click:Connect(function()
		toggleui()
	end)

	UICorner.Parent = Open

	drag(Main)
	
	UICornerMain.Parent = Main
	UICornerMain.CornerRadius = UDim.new(0, 12) -- 统一的圆角
	
	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
	DropShadowHolder.ZIndex = 0

	function toggleui()
		toggled = not toggled
		if toggled then
			-- 提前启动彩虹边框动画
			RainbowBorder.BackgroundTransparency = 0
			RainbowBorder.Size = UDim2.new(0, 8, 0, 8)
			
			-- 打开UI的动画 - 彩虹边框先展开
			Tween(RainbowBorder, { 0.2, "Quad", "Out" }, {
				Size = UDim2.new(1, 8, 1, 8)
			})
			
			-- 然后主UI展开
			wait(0.1)
			Main.Visible = true
			Tween(Main, { 0.3, "Elastic", "Out" }, { 
				Size = uiConfig.mainSize,
				BackgroundTransparency = uiConfig.transparency
			})
			
			-- 发光效果
			Tween(GlowEffect, { 0.5, "Sine", "InOut" }, {
				ImageTransparency = 0.6
			})
		else
			-- 关闭UI的动画 - 快速缩小
			Tween(Main, { 0.2, "Quad", "In" }, { 
				Size = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1
			})
			
			Tween(RainbowBorder, { 0.2, "Quad", "In" }, {
				Size = UDim2.new(0, 0, 0, 0)
			})
			
			Tween(GlowEffect, { 0.2, "Sine", "InOut" }, {
				ImageTransparency = 1
			})
			
			wait(0.25)
			Main.Visible = false
			RainbowBorder.BackgroundTransparency = 1
		end
	end
	
	-- 彩虹边框动画
	spawn(function()
		local rotationSpeed = 30
		while wait() do
			if RainbowBorder then
				RainbowGradient.Rotation = (RainbowGradient.Rotation + rotationSpeed * 0.1) % 360
				OpenBorderGradient.Rotation = (OpenBorderGradient.Rotation + rotationSpeed * 0.1) % 360
			end
		end
	end)

	TabMain.Name = "TabMain"
	TabMain.Parent = Main
	TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabMain.BackgroundTransparency = 1.000
	TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
	TabMain.Size = UDim2.new(0, 400, 0, 334) -- 调整尺寸
	
	MainC.CornerRadius = UDim.new(0, 8)
	MainC.Name = "MainC"
	MainC.Parent = Main
	
	SB.Name = "SB"
	SB.Parent = Main
	SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SB.BorderColor3 = config.MainColor
	SB.Size = UDim2.new(0, 8, 0, 340)
	
	SBC.CornerRadius = UDim.new(0, 8)
	SBC.Name = "SBC"
	SBC.Parent = SB
	
	Side.Name = "Side"
	Side.Parent = SB
	Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Side.BorderSizePixel = 0
	Side.ClipsDescendants = true
	Side.Position = UDim2.new(1, 0, 0, 0)
	Side.Size = UDim2.new(0, 100, 0, 340)
	
	SideG.Color =
		ColorSequence.new({ ColorSequenceKeypoint.new(0.00, config.Zy_Color), ColorSequenceKeypoint.new(1.00, config.Zy_Color) })
	SideG.Rotation = 90
	SideG.Name = "SideG"
	SideG.Parent = Side
	
	TabBtns.Name = "TabBtns"
	TabBtns.Parent = Side
	TabBtns.Active = true
	TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabBtns.BackgroundTransparency = 1.000
	TabBtns.BorderSizePixel = 0
	TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
	TabBtns.Size = UDim2.new(0, 100, 0, 305)
	TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
	TabBtns.ScrollBarThickness = 0
	
	TabBtnsL.Name = "TabBtnsL"
	TabBtnsL.Parent = TabBtns
	TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
	TabBtnsL.Padding = UDim.new(0, 10)
	
	ScriptTitle.Name = "ScriptTitle"
	ScriptTitle.Parent = Side
	ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScriptTitle.BackgroundTransparency = 1.000
	ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
	ScriptTitle.Size = UDim2.new(0, 92, 0, 20)
	ScriptTitle.Font = Enum.Font.GothamSemibold
	ScriptTitle.Text = name
	ScriptTitle.TextColor3 = Color3.fromRGB(37, 254, 152)
	ScriptTitle.TextSize = 14.000
	ScriptTitle.TextScaled = true
	ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

	SBG.Color =
		ColorSequence.new({ ColorSequenceKeypoint.new(0.00, config.Zy_Color), ColorSequenceKeypoint.new(1.00, config.Zy_Color) })
	SBG.Rotation = 90
	SBG.Name = "SBG"
	SBG.Parent = SB
	
	TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
	end)

	-- 设置菜单
	local SettingsMenu = Instance.new("Frame")
	local SettingsCorner = Instance.new("UICorner")
	local SettingsTitle = Instance.new("TextLabel")
	local CloseSettings = Instance.new("TextButton")
	local SettingsScroll = Instance.new("ScrollingFrame")
	local SettingsList = Instance.new("UIListLayout")
	
	SettingsMenu.Name = "SettingsMenu"
	SettingsMenu.Parent = Main
	SettingsMenu.BackgroundColor3 = config.TabColor
	SettingsMenu.BorderSizePixel = 0
	SettingsMenu.Position = UDim2.new(1, 10, 0, 0)
	SettingsMenu.Size = UDim2.new(0, 200, 0, 300)
	SettingsMenu.Visible = false
	SettingsMenu.ZIndex = 10
	
	SettingsCorner.CornerRadius = UDim.new(0, 8)
	SettingsCorner.Parent = SettingsMenu
	
	SettingsTitle.Name = "SettingsTitle"
	SettingsTitle.Parent = SettingsMenu
	SettingsTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsTitle.BackgroundTransparency = 1.000
	SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
	SettingsTitle.Font = Enum.Font.GothamSemibold
	SettingsTitle.Text = "设置"
	SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	SettingsTitle.TextSize = 16.000
	
	CloseSettings.Name = "CloseSettings"
	CloseSettings.Parent = SettingsMenu
	CloseSettings.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	CloseSettings.BorderSizePixel = 0
	CloseSettings.Position = UDim2.new(1, -25, 0, 5)
	CloseSettings.Size = UDim2.new(0, 20, 0, 20)
	CloseSettings.Font = Enum.Font.Gotham
	CloseSettings.Text = "X"
	CloseSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseSettings.TextSize = 14.000
	
	SettingsScroll.Name = "SettingsScroll"
	SettingsScroll.Parent = SettingsMenu
	SettingsScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsScroll.BackgroundTransparency = 1.000
	SettingsScroll.Position = UDim2.new(0, 5, 0, 35)
	SettingsScroll.Size = UDim2.new(1, -10, 1, -40)
	SettingsScroll.ScrollBarThickness = 3
	
	SettingsList.Name = "SettingsList"
	SettingsList.Parent = SettingsScroll
	SettingsList.SortOrder = Enum.SortOrder.LayoutOrder
	SettingsList.Padding = UDim.new(0, 5)
	
	-- 创建设置选项的函数
	local function createSetting(parent, text, settingType, values, callback)
		local SettingFrame = Instance.new("Frame")
		local SettingLabel = Instance.new("TextLabel")
		local SettingCorner = Instance.new("UICorner")
		
		SettingFrame.Name = "SettingFrame"
		SettingFrame.Parent = parent
		SettingFrame.BackgroundColor3 = config.Button_Color
		SettingFrame.Size = UDim2.new(1, 0, 0, 30)
		
		SettingCorner.CornerRadius = UDim.new(0, 6)
		SettingCorner.Parent = SettingFrame
		
		SettingLabel.Name = "SettingLabel"
		SettingLabel.Parent = SettingFrame
		SettingLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SettingLabel.BackgroundTransparency = 1.000
		SettingLabel.Size = UDim2.new(1, -10, 1, 0)
		SettingLabel.Position = UDim2.new(0, 5, 0, 0)
		SettingLabel.Font = Enum.Font.Gotham
		SettingLabel.Text = text
		SettingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		SettingLabel.TextSize = 12.000
		SettingLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		if settingType == "slider" then
			local Slider = Instance.new("Frame")
			local SliderBar = Instance.new("Frame")
			local SliderButton = Instance.new("TextButton")
			local SliderValue = Instance.new("TextLabel")
			
			Slider.Name = "Slider"
			Slider.Parent = SettingFrame
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BackgroundTransparency = 1.000
			Slider.Position = UDim2.new(0, 0, 1, -20)
			Slider.Size = UDim2.new(1, 0, 0, 15)
			
			SliderBar.Name = "SliderBar"
			SliderBar.Parent = Slider
			SliderBar.BackgroundColor3 = config.Bg_Color
			SliderBar.BorderSizePixel = 0
			SliderBar.Position = UDim2.new(0, 5, 0, 5)
			SliderBar.Size = UDim2.new(1, -10, 0, 5)
			
			SliderButton.Name = "SliderButton"
			SliderButton.Parent = SliderBar
			SliderButton.BackgroundColor3 = Color3.fromRGB(37, 254, 152)
			SliderButton.BorderSizePixel = 0
			SliderButton.Size = UDim2.new(0.5, 0, 1, 0)
			SliderButton.AutoButtonColor = false
			SliderButton.Font = Enum.Font.SourceSans
			SliderButton.Text = ""
			SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			SliderButton.TextSize = 14.000
			
			SliderValue.Name = "SliderValue"
			SliderValue.Parent = SettingFrame
			SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderValue.BackgroundTransparency = 1.000
			SliderValue.Position = UDim2.new(1, -40, 0, 0)
			SliderValue.Size = UDim2.new(0, 35, 1, 0)
			SliderValue.Font = Enum.Font.Gotham
			SliderValue.Text = "50"
			SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderValue.TextSize = 12.000
			
			SettingFrame.Size = UDim2.new(1, 0, 0, 50)
		elseif settingType == "color" then
			local ColorButton = Instance.new("TextButton")
			local ColorCorner = Instance.new("UICorner")
			
			ColorButton.Name = "ColorButton"
			ColorButton.Parent = SettingFrame
			ColorButton.BackgroundColor3 = values[1] or Color3.fromRGB(255, 0, 0)
			ColorButton.BorderSizePixel = 0
			ColorButton.Position = UDim2.new(1, -35, 0, 5)
			ColorButton.Size = UDim2.new(0, 30, 0, 20)
			ColorButton.AutoButtonColor = false
			ColorButton.Font = Enum.Font.SourceSans
			ColorButton.Text = ""
			ColorButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			ColorButton.TextSize = 14.000
			
			ColorCorner.CornerRadius = UDim.new(0, 4)
			ColorCorner.Parent = ColorButton
		end
		
		return SettingFrame
	end
	
	-- 添加设置选项
	-- UI大小设置
	local sizeSetting = createSetting(SettingsScroll, "UI大小", "slider", {min = 400, max = 600, default = 520})
	-- 透明度设置
	local transparencySetting = createSetting(SettingsScroll, "透明度", "slider", {min = 0, max = 100, default = 0})
	-- 边框颜色设置
	local borderColorSetting = createSetting(SettingsScroll, "边框颜色", "color", uiConfig.borderColors)
	-- 按钮颜色设置
	local buttonColorSetting = createSetting(SettingsScroll, "按钮颜色", "color", {uiConfig.openButtonColor})
	
	SettingsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, SettingsList.AbsoluteContentSize.Y + 10)
	end)
	
	-- 设置按钮点击事件
	SettingsButton.MouseButton1Click:Connect(function()
		SettingsMenu.Visible = not SettingsMenu.Visible
	end)
	
	CloseSettings.MouseButton1Click:Connect(function()
		SettingsMenu.Visible = false
	end)

	local window = {}
	function window.Tab(window, name, icon)
		local Tab = Instance.new("ScrollingFrame")
		local TabIco = Instance.new("ImageLabel")
		local TabText = Instance.new("TextLabel")
		local TabBtn = Instance.new("TextButton")
		local TabL = Instance.new("UIListLayout")
		
		Tab.Name = "Tab"
		Tab.Parent = TabMain
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.Size = UDim2.new(1, 0, 1, 0)
		Tab.ScrollBarThickness = 2
		Tab.Visible = false
		
		TabIco.Name = "TabIco"
		TabIco.Parent = TabBtns
		TabIco.BackgroundTransparency = 1.000
		TabIco.BorderSizePixel = 0
		TabIco.Size = UDim2.new(0, 22, 0, 22)
		TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
		TabIco.ImageTransparency = 0.2
		
		TabText.Name = "TabText"
		TabText.Parent = TabIco
		TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabText.BackgroundTransparency = 1.000
		TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
		TabText.Size = UDim2.new(0, 68, 0, 22)
		TabText.Font = Enum.Font.GothamSemibold
		TabText.Text = name
		TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabText.TextSize = 12.000
		TabText.TextXAlignment = Enum.TextXAlignment.Left
		TabText.TextTransparency = 0.2
		
		TabBtn.Name = "TabBtn"
		TabBtn.Parent = TabIco
		TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabBtn.BackgroundTransparency = 1.000
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(0, 100, 0, 22)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.SourceSans
		TabBtn.Text = ""
		TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabBtn.TextSize = 14.000
		
		TabL.Name = "TabL"
		TabL.Parent = Tab
		TabL.SortOrder = Enum.SortOrder.LayoutOrder
		TabL.Padding = UDim.new(0, 4)
		
		TabBtn.MouseButton1Click:Connect(function()
			spawn(function()
				Ripple(TabBtn)
			end)
			switchTab({ TabIco, Tab })
		end)
		
		if library.currentTab == nil then
			switchTab({ TabIco, Tab })
		end
		
		TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
		end)
		
		local tab = {}
		function tab.section(tab, name, TabVal)
			local Section = Instance.new("Frame")
			local SectionC = Instance.new("UICorner")
			local SectionText = Instance.new("TextLabel")
			local SectionOpen = Instance.new("ImageLabel")
			local SectionOpened = Instance.new("ImageLabel")
			local SectionToggle = Instance.new("ImageButton")
			local Objs = Instance.new("Frame")
			local ObjsL = Instance.new("UIListLayout")
			
			Section.Name = "Section"
			Section.Parent = Tab
			Section.BackgroundColor3 = config.TabColor
			Section.BackgroundTransparency = 1.000
			Section.BorderSizePixel = 0
			Section.ClipsDescendants = true
			Section.Size = UDim2.new(0.975000006, 0, 0, 32)
			
			SectionC.CornerRadius = UDim.new(0, 6)
			SectionC.Name = "SectionC"
			SectionC.Parent = Section
			
			SectionText.Name = "SectionText"
			SectionText.Parent = Section
			SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionText.BackgroundTransparency = 1.000
			SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
			SectionText.Size = UDim2.new(0, 350, 0, 32)
			SectionText.Font = Enum.Font.GothamSemibold
			SectionText.Text = name
			SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionText.TextSize = 14.000
			SectionText.TextXAlignment = Enum.TextXAlignment.Left
			
			SectionOpen.Name = "SectionOpen"
			SectionOpen.Parent = SectionText
			SectionOpen.BackgroundTransparency = 1
			SectionOpen.BorderSizePixel = 0
			SectionOpen.Position = UDim2.new(0, -30, 0, 3)
			SectionOpen.Size = UDim2.new(0, 24, 0, 24)
			SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
			
			SectionOpened.Name = "SectionOpened"
			SectionOpened.Parent = SectionOpen
			SectionOpened.BackgroundTransparency = 1.000
			SectionOpened.BorderSizePixel = 0
			SectionOpened.Size = UDim2.new(0, 24, 0, 24)
			SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
			SectionOpened.ImageTransparency = 1.000
			
			SectionToggle.Name = "SectionToggle"
			SectionToggle.Parent = SectionOpen
			SectionToggle.BackgroundTransparency = 1
			SectionToggle.BorderSizePixel = 0
			SectionToggle.Size = UDim2.new(0, 24, 0, 24)
			
			Objs.Name = "Objs"
			Objs.Parent = Section
			Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Objs.BackgroundTransparency = 1
			Objs.BorderSizePixel = 0
			Objs.Position = UDim2.new(0, 6, 0, 32)
			Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
			
			ObjsL.Name = "ObjsL"
			ObjsL.Parent = Objs
			ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
			ObjsL.Padding = UDim.new(0, 6)
			
			local open = TabVal
			if TabVal ~= false then
				Section.Size = UDim2.new(0.975000006, 0, 0, open and 32 + ObjsL.AbsoluteContentSize.Y + 6 or 32)
				SectionOpened.ImageTransparency = (open and 0 or 1)
				SectionOpen.ImageTransparency = (open and 1 or 0)
			end
			
			SectionToggle.MouseButton1Click:Connect(function()
				open = not open
				Section.Size = UDim2.new(0.975000006, 0, 0, open and 32 + ObjsL.AbsoluteContentSize.Y + 6 or 32)
				SectionOpened.ImageTransparency = (open and 0 or 1)
				SectionOpen.ImageTransparency = (open and 1 or 0)
			end)
			
			ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if not open then
					return
				end
				Section.Size = UDim2.new(0.975000006, 0, 0, 32 + ObjsL.AbsoluteContentSize.Y + 6)
			end)
			
			local section = {}
			function section.Button(section, text, callback)
				local callback = callback or function() end
				local BtnModule = Instance.new("Frame")
				local Btn = Instance.new("TextButton")
				local BtnC = Instance.new("UICorner")
				
				BtnModule.Name = "BtnModule"
				BtnModule.Parent = Objs
				BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BtnModule.BackgroundTransparency = 1.000
				BtnModule.BorderSizePixel = 0
				BtnModule.Position = UDim2.new(0, 0, 0, 0)
				BtnModule.Size = UDim2.new(0, 375, 0, 34)
				
				Btn.Name = "Btn"
				Btn.Parent = BtnModule
				Btn.BackgroundColor3 = config.Button_Color
				Btn.BorderSizePixel = 0
				Btn.Size = UDim2.new(0, 375, 0, 34)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.GothamSemibold
				Btn.Text = "   " .. text
				Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				Btn.TextSize = 14.000
				Btn.TextXAlignment = Enum.TextXAlignment.Left
				
				BtnC.CornerRadius = UDim.new(0, 6)
				BtnC.Name = "BtnC"
				BtnC.Parent = Btn
				
				Btn.MouseButton1Click:Connect(function()
					spawn(function()
						Ripple(Btn)
					end)
					spawn(callback)
				end)
			end
			
			function section:Label(text)
				local LabelModule = Instance.new("Frame")
				local TextLabel = Instance.new("TextLabel")
				local LabelC = Instance.new("UICorner")
				
				LabelModule.Name = "LabelModule"
				LabelModule.Parent = Objs
				LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelModule.BackgroundTransparency = 1.000
				LabelModule.BorderSizePixel = 0
				LabelModule.Position = UDim2.new(0, 0, 0, 0)
				LabelModule.Size = UDim2.new(0, 375, 0, 17)
				
				TextLabel.Parent = LabelModule
				TextLabel.BackgroundColor3 = config.Label_Color
				TextLabel.Size = UDim2.new(0, 375, 0, 20)
				TextLabel.Font = Enum.Font.GothamSemibold
				TextLabel.Text = text
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextSize = 12.000
				
				LabelC.CornerRadius = UDim.new(0, 6)
				LabelC.Name = "LabelC"
				LabelC.Parent = TextLabel
				return TextLabel
			end
			
			function section.Toggle(section, text, flag, enabled, callback)
				local callback = callback or function() end
				local enabled = enabled or false
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				library.flags[flag] = enabled
				
				local ToggleModule = Instance.new("Frame")
				local ToggleBtn = Instance.new("TextButton")
				local ToggleBtnC = Instance.new("UICorner")
				local ToggleDisable = Instance.new("Frame")
				local ToggleSwitch = Instance.new("Frame")
				local ToggleSwitchC = Instance.new("UICorner")
				local ToggleDisableC = Instance.new("UICorner")
				
				ToggleModule.Name = "ToggleModule"
				ToggleModule.Parent = Objs
				ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleModule.BackgroundTransparency = 1.000
				ToggleModule.BorderSizePixel = 0
				ToggleModule.Position = UDim2.new(0, 0, 0, 0)
				ToggleModule.Size = UDim2.new(0, 375, 0, 34)
				
				ToggleBtn.Name = "ToggleBtn"
				ToggleBtn.Parent = ToggleModule
				ToggleBtn.BackgroundColor3 = config.Toggle_Color
				ToggleBtn.BorderSizePixel = 0
				ToggleBtn.Size = UDim2.new(0, 375, 0, 34)
				ToggleBtn.AutoButtonColor = false
				ToggleBtn.Font = Enum.Font.GothamSemibold
				ToggleBtn.Text = "   " .. text
				ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleBtn.TextSize = 14.000
				ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
				
				ToggleBtnC.CornerRadius = UDim.new(0, 6)
				ToggleBtnC.Name = "ToggleBtnC"
				ToggleBtnC.Parent = ToggleBtn
				
				ToggleDisable.Name = "ToggleDisable"
				ToggleDisable.Parent = ToggleBtn
				ToggleDisable.BackgroundColor3 = config.Bg_Color
				ToggleDisable.BorderSizePixel = 0
				ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
				ToggleDisable.Size = UDim2.new(0, 32, 0, 20)
				
				ToggleSwitch.Name = "ToggleSwitch"
				ToggleSwitch.Parent = ToggleDisable
				ToggleSwitch.BackgroundColor3 = config.Toggle_Off
				ToggleSwitch.Size = UDim2.new(0, 20, 0, 20)
				ToggleSwitchC.CornerRadius = UDim.new(0, 6)
				ToggleSwitchC.Name = "ToggleSwitchC"
				ToggleSwitchC.Parent = ToggleSwitch
				
				ToggleDisableC.CornerRadius = UDim.new(0, 6)
				ToggleDisableC.Name = "ToggleDisableC"
				ToggleDisableC.Parent = ToggleDisable
				
				local funcs = {
					SetState = function(self, state)
						if state == nil then
							state = not library.flags[flag]
						end
						if library.flags[flag] == state then
							return
						end
						services.TweenService
							:Create(ToggleSwitch, TweenInfo.new(0.2), {
								Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
								BackgroundColor3 = (state and config.Toggle_On or config.Toggle_Off),
							})
							:Play()
						library.flags[flag] = state
						callback(state)
					end,
					Module = ToggleModule,
				}
				
				if enabled ~= false then
					funcs:SetState(flag, true)
				end
				
				ToggleBtn.MouseButton1Click:Connect(function()
					funcs:SetState()
				end)
				return funcs
			end
			
			function section.Keybind(section, text, default, callback)
				local callback = callback or function() end
				assert(text, "No text provided")
				assert(default, "No default key provided")
				local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
				local banned = {
					Return = true,
					Space = true,
					Tab = true,
					Backquote = true,
					CapsLock = true,
					Escape = true,
					Unknown = true,
				}
				local shortNames = {
					RightControl = "Right Ctrl",
					LeftControl = "Left Ctrl",
					LeftShift = "Left Shift",
					RightShift = "Right Shift",
					Semicolon = ";",
					Quote = '"',
					LeftBracket = "[",
					RightBracket = "]",
					Equals = "=",
					Minus = "-",
					RightAlt = "Right Alt",
					LeftAlt = "Left Alt",
				}
				local bindKey = default
				local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")
				
				local KeybindModule = Instance.new("Frame")
				local KeybindBtn = Instance.new("TextButton")
				local KeybindBtnC = Instance.new("UICorner")
				local KeybindValue = Instance.new("TextButton")
				local KeybindValueC = Instance.new("UICorner")
				local KeybindL = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")
				
				KeybindModule.Name = "KeybindModule"
				KeybindModule.Parent = Objs
				KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KeybindModule.BackgroundTransparency = 1.000
				KeybindModule.BorderSizePixel = 0
				KeybindModule.Position = UDim2.new(0, 0, 0, 0)
				KeybindModule.Size = UDim2.new(0, 375, 0, 34)
				
				KeybindBtn.Name = "KeybindBtn"
				KeybindBtn.Parent = KeybindModule
				KeybindBtn.BackgroundColor3 = config.Keybind_Color
				KeybindBtn.BorderSizePixel = 0
				KeybindBtn.Size = UDim2.new(0, 375, 0, 34)
				KeybindBtn.AutoButtonColor = false
				KeybindBtn.Font = Enum.Font.GothamSemibold
				KeybindBtn.Text = "   " .. text
				KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				KeybindBtn.TextSize = 14.000
				KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
				
				KeybindBtnC.CornerRadius = UDim.new(0, 6)
				KeybindBtnC.Name = "KeybindBtnC"
				KeybindBtnC.Parent = KeybindBtn
				
				KeybindValue.Name = "KeybindValue"
				KeybindValue.Parent = KeybindBtn
				KeybindValue.BackgroundColor3 = config.Bg_Color
				KeybindValue.BorderSizePixel = 0
				KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
				KeybindValue.Size = UDim2.new(0, 90, 0, 26)
				KeybindValue.AutoButtonColor = false
				KeybindValue.Font = Enum.Font.Gotham
				KeybindValue.Text = keyTxt
				KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				KeybindValue.TextSize = 12.000
				
				KeybindValueC.CornerRadius = UDim.new(0, 6)
				KeybindValueC.Name = "KeybindValueC"
				KeybindValueC.Parent = KeybindValue
				
				KeybindL.Name = "KeybindL"
				KeybindL.Parent = KeybindBtn
				KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
				KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
				KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
				
				UIPadding.Parent = KeybindBtn
				UIPadding.PaddingRight = UDim.new(0, 6)
				
				services.UserInputService.InputBegan:Connect(function(inp, gpe)
					if gpe then
						return
					end
					if inp.UserInputType ~= Enum.UserInputType.Keyboard then
						return
					end
					if inp.KeyCode ~= bindKey then
						return
					end
					callback(bindKey.Name)
				end)
				
				KeybindValue.MouseButton1Click:Connect(function()
					KeybindValue.Text = "..."
					wait()
					local key, uwu = services.UserInputService.InputEnded:Wait()
					local keyName = tostring(key.KeyCode.Name)
					if key.UserInputType ~= Enum.UserInputType.Keyboard then
						KeybindValue.Text = keyTxt
						return
					end
					if banned[keyName] then
						KeybindValue.Text = keyTxt
						return
					end
					wait()
					bindKey = Enum.KeyCode[keyName]
					KeybindValue.Text = shortNames[keyName] or keyName
				end)
				
				KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
					KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 25, 0, 26)
				end)
				KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 25, 0, 26)
			end
			
			function section.Textbox(section, text, flag, default, callback)
				local callback = callback or function() end
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				assert(default, "No default text provided")
				library.flags[flag] = default
				
				local TextboxModule = Instance.new("Frame")
				local TextboxBack = Instance.new("TextButton")
				local TextboxBackC = Instance.new("UICorner")
				local BoxBG = Instance.new("TextButton")
				local BoxBGC = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local TextboxBackL = Instance.new("UIListLayout")
				local TextboxBackP = Instance.new("UIPadding")
				
				TextboxModule.Name = "TextboxModule"
				TextboxModule.Parent = Objs
				TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextboxModule.BackgroundTransparency = 1.000
				TextboxModule.BorderSizePixel = 0
				TextboxModule.Position = UDim2.new(0, 0, 0, 0)
				TextboxModule.Size = UDim2.new(0, 375, 0, 34)
				
				TextboxBack.Name = "TextboxBack"
				TextboxBack.Parent = TextboxModule
				TextboxBack.BackgroundColor3 = config.Textbox_Color
				TextboxBack.BorderSizePixel = 0
				TextboxBack.Size = UDim2.new(0, 375, 0, 34)
				TextboxBack.AutoButtonColor = false
				TextboxBack.Font = Enum.Font.GothamSemibold
				TextboxBack.Text = "   " .. text
				TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextboxBack.TextSize = 14.000
				TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
				
				TextboxBackC.CornerRadius = UDim.new(0, 6)
				TextboxBackC.Name = "TextboxBackC"
				TextboxBackC.Parent = TextboxBack
				
				BoxBG.Name = "BoxBG"
				BoxBG.Parent = TextboxBack
				BoxBG.BackgroundColor3 = config.Bg_Color
				BoxBG.BorderSizePixel = 0
				BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
				BoxBG.Size = UDim2.new(0, 90, 0, 26)
				BoxBG.AutoButtonColor = false
				BoxBG.Font = Enum.Font.Gotham
				BoxBG.Text = ""
				BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
				BoxBG.TextSize = 14.000
				
				BoxBGC.CornerRadius = UDim.new(0, 6)
				BoxBGC.Name = "BoxBGC"
				BoxBGC.Parent = BoxBG
				
				TextBox.Parent = BoxBG
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1.000
				TextBox.BorderSizePixel = 0
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Font = Enum.Font.Gotham
				TextBox.Text = default
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 12.000
				
				TextboxBackL.Name = "TextboxBackL"
				TextboxBackL.Parent = TextboxBack
				TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
				TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
				TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
				
				TextboxBackP.Name = "TextboxBackP"
				TextboxBackP.Parent = TextboxBack
				TextboxBackP.PaddingRight = UDim.new(0, 6)
				
				TextBox.FocusLost:Connect(function()
					if TextBox.Text == "" then
						TextBox.Text = default
					end
					library.flags[flag] = TextBox.Text
					callback(TextBox.Text)
				end)
				
				TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
					BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 25, 0, 26)
				end)
				BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 25, 0, 26)
			end
			
			function section.Slider(section, text, flag, default, min, max, precise, callback)
				local callback = callback or function() end
				local min = min or 1
				local max = max or 10
				local default = default or min
				local precise = precise or false
				library.flags[flag] = default
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				assert(default, "No default value provided")
				
				local SliderModule = Instance.new("Frame")
				local SliderBack = Instance.new("TextButton")
				local SliderBackC = Instance.new("UICorner")
				local SliderBar = Instance.new("Frame")
				local SliderBarC = Instance.new("UICorner")
				local SliderPart = Instance.new("Frame")
				local SliderPartC = Instance.new("UICorner")
				local SliderValBG = Instance.new("TextButton")
				local SliderValBGC = Instance.new("UICorner")
				local SliderValue = Instance.new("TextBox")
				local MinSlider = Instance.new("TextButton")
				local AddSlider = Instance.new("TextButton")
				
				SliderModule.Name = "SliderModule"
				SliderModule.Parent = Objs
				SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderModule.BackgroundTransparency = 1.000
				SliderModule.BorderSizePixel = 0
				SliderModule.Position = UDim2.new(0, 0, 0, 0)
				SliderModule.Size = UDim2.new(0, 375, 0, 34)
				
				SliderBack.Name = "SliderBack"
				SliderBack.Parent = SliderModule
				SliderBack.BackgroundColor3 = config.Slider_Color
				SliderBack.BorderSizePixel = 0
				SliderBack.Size = UDim2.new(0, 375, 0, 34)
				SliderBack.AutoButtonColor = false
				SliderBack.Font = Enum.Font.GothamSemibold
				SliderBack.Text = "   " .. text
				SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderBack.TextSize = 14.000
				SliderBack.TextXAlignment = Enum.TextXAlignment.Left
				
				SliderBackC.CornerRadius = UDim.new(0, 6)
				SliderBackC.Name = "SliderBackC"
				SliderBackC.Parent = SliderBack
				
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderBack
				SliderBar.AnchorPoint = Vector2.new(0, 0.5)
				SliderBar.BackgroundColor3 = config.Bg_Color
				SliderBar.BorderSizePixel = 0
				SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
				SliderBar.Size = UDim2.new(0, 120, 0, 10)
				
				SliderBarC.CornerRadius = UDim.new(0, 4)
				SliderBarC.Name = "SliderBarC"
				SliderBarC.Parent = SliderBar
				
				SliderPart.Name = "SliderPart"
				SliderPart.Parent = SliderBar
				SliderPart.BackgroundColor3 = config.SliderBar_Color
				SliderPart.BorderSizePixel = 0
				SliderPart.Size = UDim2.new(0, 54, 0, 11)
				SliderPartC.CornerRadius = UDim.new(0, 4)
				SliderPartC.Name = "SliderPartC"
				SliderPartC.Parent = SliderPart
				
				SliderValBG.Name = "SliderValBG"
				SliderValBG.Parent = SliderBack
				SliderValBG.BackgroundColor3 = config.Bg_Color
				SliderValBG.BorderSizePixel = 0
				SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
				SliderValBG.Size = UDim2.new(0, 40, 0, 26)
				SliderValBG.AutoButtonColor = false
				SliderValBG.Font = Enum.Font.Gotham
				SliderValBG.Text = ""
				SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderValBG.TextSize = 14.000
				
				SliderValBGC.CornerRadius = UDim.new(0, 6)
				SliderValBGC.Name = "SliderValBGC"
				SliderValBGC.Parent = SliderValBG
				
				SliderValue.Name = "SliderValue"
				SliderValue.Parent = SliderValBG
				SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.BackgroundTransparency = 1.000
				SliderValue.BorderSizePixel = 0
				SliderValue.Size = UDim2.new(1, 0, 1, 0)
				SliderValue.Font = Enum.Font.Gotham
				SliderValue.Text = "1000"
				SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.TextSize = 12.000
				
				MinSlider.Name = "MinSlider"
				MinSlider.Parent = SliderModule
				MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MinSlider.BackgroundTransparency = 1.000
				MinSlider.BorderSizePixel = 0
				MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
				MinSlider.Size = UDim2.new(0, 18, 0, 18)
				MinSlider.Font = Enum.Font.Gotham
				MinSlider.Text = "-"
				MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
				MinSlider.TextSize = 20.000
				MinSlider.TextWrapped = true
				
				AddSlider.Name = "AddSlider"
				AddSlider.Parent = SliderModule
				AddSlider.AnchorPoint = Vector2.new(0, 0.5)
				AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				AddSlider.BackgroundTransparency = 1.000
				AddSlider.BorderSizePixel = 0
				AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
				AddSlider.Size = UDim2.new(0, 18, 0, 18)
				AddSlider.Font = Enum.Font.Gotham
				AddSlider.Text = "+"
				AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
				AddSlider.TextSize = 20.000
				AddSlider.TextWrapped = true
				
				local funcs = {
					SetValue = function(self, value)
						local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
						if value then
							percent = (value - min) / (max - min)
						end
						percent = math.clamp(percent, 0, 1)
						if precise then
							value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
						else
							value = value or math.floor(min + (max - min) * percent)
						end
						library.flags[flag] = tonumber(value)
						SliderValue.Text = tostring(value)
						SliderPart.Size = UDim2.new(percent, 0, 1, 0)
						callback(tonumber(value))
					end,
				}
				
				MinSlider.MouseButton1Click:Connect(function()
					local currentValue = library.flags[flag]
					currentValue = math.clamp(currentValue - 1, min, max)
					funcs:SetValue(currentValue)
				end)
				
				AddSlider.MouseButton1Click:Connect(function()
					local currentValue = library.flags[flag]
					currentValue = math.clamp(currentValue + 1, min, max)
					funcs:SetValue(currentValue)
				end)
				
				funcs:SetValue(default)
				
				local dragging, boxFocused, allowed = false, false, { [""] = true, ["-"] = true }
				SliderBar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						funcs:SetValue()
						dragging = true
					end
				end)
				
				services.UserInputService.InputEnded:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				
				services.UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						funcs:SetValue()
					end
				end)
				
				SliderBar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch then
						funcs:SetValue()
						dragging = true
					end
				end)
				
				services.UserInputService.InputEnded:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)
				
				services.UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.Touch then
						funcs:SetValue()
					end
				end)
				
				SliderValue.Focused:Connect(function()
					boxFocused = true
				end)
				
				SliderValue.FocusLost:Connect(function()
					boxFocused = false
					if SliderValue.Text == "" then
						funcs:SetValue(default)
					end
				end)
				
				SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
					if not boxFocused then
						return
					end
					SliderValue.Text = SliderValue.Text:gsub("%D+", "")
					local text = SliderValue.Text
					if not tonumber(text) then
						SliderValue.Text = SliderValue.Text:gsub("%D+", "")
					elseif not allowed[text] then
						if tonumber(text) > max then
							text = max
							SliderValue.Text = tostring(max)
						end
						funcs:SetValue(tonumber(text))
					end
				end)
				return funcs
			end
			
			function section.Dropdown(section, text, flag, options, callback)
				local callback = callback or function() end
				local options = options or {}
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				library.flags[flag] = nil
				
				local DropdownModule = Instance.new("Frame")
				local DropdownTop = Instance.new("TextButton")
				local DropdownTopC = Instance.new("UICorner")
				local DropdownOpen = Instance.new("TextButton")
				local DropdownText = Instance.new("TextBox")
				local DropdownModuleL = Instance.new("UIListLayout")
				local Option = Instance.new("TextButton")
				local OptionC = Instance.new("UICorner")
				
				DropdownModule.Name = "DropdownModule"
				DropdownModule.Parent = Objs
				DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownModule.BackgroundTransparency = 1.000
				DropdownModule.BorderSizePixel = 0
				DropdownModule.ClipsDescendants = true
				DropdownModule.Position = UDim2.new(0, 0, 0, 0)
				DropdownModule.Size = UDim2.new(0, 375, 0, 34)
				
				DropdownTop.Name = "DropdownTop"
				DropdownTop.Parent = DropdownModule
				DropdownTop.BackgroundColor3 = config.Dropdown_Color
				DropdownTop.BorderSizePixel = 0
				DropdownTop.Size = UDim2.new(0, 375, 0, 34)
				DropdownTop.AutoButtonColor = false
				DropdownTop.Font = Enum.Font.GothamSemibold
				DropdownTop.Text = ""
				DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownTop.TextSize = 14.000
				DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
				
				DropdownTopC.CornerRadius = UDim.new(0, 6)
				DropdownTopC.Name = "DropdownTopC"
				DropdownTopC.Parent = DropdownTop
				
				DropdownOpen.Name = "DropdownOpen"
				DropdownOpen.Parent = DropdownTop
				DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
				DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownOpen.BackgroundTransparency = 1.000
				DropdownOpen.BorderSizePixel = 0
				DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
				DropdownOpen.Size = UDim2.new(0, 18, 0, 18)
				DropdownOpen.Font = Enum.Font.Gotham
				DropdownOpen.Text = "+"
				DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownOpen.TextSize = 20.000
				DropdownOpen.TextWrapped = true
				
				DropdownText.Name = "DropdownText"
				DropdownText.Parent = DropdownTop
				DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownText.BackgroundTransparency = 1.000
				DropdownText.BorderSizePixel = 0
				DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
				DropdownText.Size = UDim2.new(0, 160, 0, 34)
				DropdownText.Font = Enum.Font.GothamSemibold
				DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				DropdownText.PlaceholderText = text
				DropdownText.Text = ""
				DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownText.TextSize = 14.000
				DropdownText.TextXAlignment = Enum.TextXAlignment.Left
				
				DropdownModuleL.Name = "DropdownModuleL"
				DropdownModuleL.Parent = DropdownModule
				DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
				DropdownModuleL.Padding = UDim.new(0, 4)
				
				local setAllVisible = function()
					local options = DropdownModule:GetChildren()
					for i = 1, #options do
						local option = options[i]
						if option:IsA("TextButton") and option.Name:match("Option_") then
							option.Visible = true
						end
					end
				end
				
				local searchDropdown = function(text)
					local options = DropdownModule:GetChildren()
					for i = 1, #options do
						local option = options[i]
						if text == "" then
							setAllVisible()
						else
							if option:IsA("TextButton") and option.Name:match("Option_") then
								if option.Text:lower():match(text:lower()) then
									option.Visible = true
								else
									option.Visible = false
								end
							end
						end
					end
				end
				
				local open = false
				local ToggleDropVis = function()
					open = not open
					if open then
						setAllVisible()
					end
					DropdownOpen.Text = (open and "-" or "+")
					DropdownModule.Size =
						UDim2.new(0, 375, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 34))
				end
				
				DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
				DropdownText.Focused:Connect(function()
					if open then
						return
					end
					ToggleDropVis()
				end)
				
				DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
					if not open then
						return
					end
					searchDropdown(DropdownText.Text)
				end)
				
				DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					if not open then
						return
					end
					DropdownModule.Size = UDim2.new(0, 375, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
				end)
				
				local funcs = {}
				funcs.AddOption = function(self, option)
					local Option = Instance.new("TextButton")
					local OptionC = Instance.new("UICorner")
					Option.Name = "Option_" .. option
					Option.Parent = DropdownModule
					Option.BackgroundColor3 = config.TabColor
					Option.BorderSizePixel = 0
					Option.Position = UDim2.new(0, 0, 0.328125, 0)
					Option.Size = UDim2.new(0, 375, 0, 24)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.Gotham
					Option.Text = option
					Option.TextColor3 = Color3.fromRGB(255, 255, 255)
					Option.TextSize = 12.000
					OptionC.CornerRadius = UDim.new(0, 6)
					OptionC.Name = "OptionC"
					OptionC.Parent = Option
					Option.MouseButton1Click:Connect(function()
						ToggleDropVis()
						callback(Option.Text)
						DropdownText.Text = Option.Text
						library.flags[flag] = Option.Text
					end)
				end
				
				funcs.RemoveOption = function(self, option)
					local option = DropdownModule:FindFirstChild("Option_" .. option)
					if option then
						option:Destroy()
					end
				end
				
				funcs.SetOptions = function(self, options)
					for _, v in next, DropdownModule:GetChildren() do
						if v.Name:match("Option_") then
							v:Destroy()
						end
					end
					for _, v in next, options do
						funcs:AddOption(v)
					end
				end
				
				funcs:SetOptions(options)
				return funcs
			end
			return section
		end
		return tab
	end
	return window
end

return library