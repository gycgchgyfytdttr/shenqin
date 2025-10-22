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
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()

-- 颜色主题配置
local theme = {
    background = Color3.fromRGB(15, 15, 20),
    primary = Color3.fromRGB(25, 25, 35),
    secondary = Color3.fromRGB(40, 40, 50),
    accent = Color3.fromRGB(0, 150, 255),
    text = Color3.fromRGB(240, 240, 240),
    border = Color3.fromRGB(60, 60, 70)
}

function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
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
        Ripple.ImageColor3 = theme.accent
        Ripple.Position = UDim2.new(
            (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
            0,
            (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
            0
        )
        Tween(Ripple, {.3, "Linear", "InOut"}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
    if switchingTabs then
        return
    end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end

    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    library.currentTab = new

    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.1)
    switchingTabs = false
end

-- # Drag Function # --
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
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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

function library.new(library, name, customTheme)
    -- 应用自定义主题或使用默认主题
    if customTheme then
        for k, v in pairs(customTheme) do
            if theme[k] then
                theme[k] = v
            end
        end
    end

    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "DebrisOrbitUI" then
            v:Destroy()
        end
    end

    -- 创建主UI
    local DebrisOrbitUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    
    -- 启动动画UI
    local StartupUI = Instance.new("Frame")
    local StartupCorner = Instance.new("UICorner")
    local StartupStroke = Instance.new("UIStroke")
    local StartupTitle = Instance.new("TextLabel")
    local StartupSubtitle = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressBarCorner = Instance.new("UICorner")
    local ProgressFill = Instance.new("Frame")
    local ProgressFillCorner = Instance.new("UICorner")
    local ProgressStroke = Instance.new("UIStroke")

    if syn and syn.protect_gui then
        syn.protect_gui(DebrisOrbitUI)
    end

    DebrisOrbitUI.Name = "DebrisOrbitUI"
    DebrisOrbitUI.Parent = services.CoreGui
    DebrisOrbitUI.ResetOnSpawn = false
    DebrisOrbitUI.IgnoreGuiInset = true

    -- 启动动画UI设置
    StartupUI.Name = "StartupUI"
    StartupUI.Parent = DebrisOrbitUI
    StartupUI.AnchorPoint = Vector2.new(0.5, 0.5)
    StartupUI.BackgroundColor3 = theme.background
    StartupUI.BorderSizePixel = 0
    StartupUI.Position = UDim2.new(0.5, 0, 0.5, 0)
    StartupUI.Size = UDim2.new(0, 300, 0, 200)
    StartupUI.ZIndex = 10
    StartupUI.Visible = true

    StartupCorner.CornerRadius = UDim.new(0, 12)
    StartupCorner.Parent = StartupUI

    StartupStroke.Color = theme.accent
    StartupStroke.Thickness = 2
    StartupStroke.Parent = StartupUI

    StartupTitle.Name = "StartupTitle"
    StartupTitle.Parent = StartupUI
    StartupTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    StartupTitle.BackgroundTransparency = 1
    StartupTitle.Position = UDim2.new(0.5, 0, 0.4, 0)
    StartupTitle.Size = UDim2.new(0, 280, 0, 40)
    StartupTitle.Font = Enum.Font.GothamBold
    StartupTitle.Text = "DEBRIS ORBIT"
    StartupTitle.TextColor3 = theme.text
    StartupTitle.TextSize = 24
    StartupTitle.TextStrokeTransparency = 0.8

    StartupSubtitle.Name = "StartupSubtitle"
    StartupSubtitle.Parent = StartupUI
    StartupSubtitle.AnchorPoint = Vector2.new(0.5, 0.5)
    StartupSubtitle.BackgroundTransparency = 1
    StartupSubtitle.Position = UDim2.new(0.5, 0, 0.55, 0)
    StartupSubtitle.Size = UDim2.new(0, 280, 0, 20)
    StartupSubtitle.Font = Enum.Font.Gotham
    StartupSubtitle.Text = "Initializing..."
    StartupSubtitle.TextColor3 = theme.text
    StartupSubtitle.TextTransparency = 0.3
    StartupSubtitle.TextSize = 14

    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = StartupUI
    ProgressBar.AnchorPoint = Vector2.new(0.5, 0.5)
    ProgressBar.BackgroundColor3 = theme.secondary
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0.5, 0, 0.75, 0)
    ProgressBar.Size = UDim2.new(0, 260, 0, 8)

    ProgressBarCorner.CornerRadius = UDim.new(1, 0)
    ProgressBarCorner.Parent = ProgressBar

    ProgressFill.Name = "ProgressFill"
    ProgressFill.Parent = ProgressBar
    ProgressFill.BackgroundColor3 = theme.accent
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)

    ProgressFillCorner.CornerRadius = UDim.new(1, 0)
    ProgressFillCorner.Parent = ProgressFill

    ProgressStroke.Color = theme.border
    ProgressStroke.Thickness = 1
    ProgressStroke.Parent = ProgressBar

    -- 主UI设置
    Main.Name = "Main"
    Main.Parent = DebrisOrbitUI
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = theme.background
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    Main.Visible = false

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main

    MainStroke.Color = theme.border
    MainStroke.Thickness = 2
    MainStroke.Parent = Main

    -- 标题栏
    local TitleBar = Instance.new("Frame")
    local TitleBarCorner = Instance.new("UICorner")
    local TitleText = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local CloseButtonCorner = Instance.new("UICorner")

    TitleBar.Name = "TitleBar"
    TitleBar.Parent = Main
    TitleBar.BackgroundColor3 = theme.primary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 40)

    TitleBarCorner.CornerRadius = UDim.new(0, 12)
    TitleBarCorner.Parent = TitleBar

    TitleText.Name = "TitleText"
    TitleText.Parent = TitleBar
    TitleText.BackgroundTransparency = 1
    TitleText.Position = UDim2.new(0, 15, 0, 0)
    TitleText.Size = UDim2.new(0, 200, 1, 0)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Text = name or "DEBRIS ORBIT"
    TitleText.TextColor3 = theme.text
    TitleText.TextSize = 18
    TitleText.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -35, 0.5, -12)
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18

    CloseButtonCorner.CornerRadius = UDim.new(0, 6)
    CloseButtonCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(function()
        DebrisOrbitUI:Destroy()
    end)

    -- 标签容器
    local TabContainer = Instance.new("Frame")
    local TabContainerCorner = Instance.new("UICorner")
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = theme.primary
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.Size = UDim2.new(0, 150, 0, 340)

    TabContainerCorner.CornerRadius = UDim.new(0, 8)
    TabContainerCorner.Parent = TabContainer

    -- 内容容器
    local ContentContainer = Instance.new("Frame")
    local ContentContainerCorner = Instance.new("UICorner")
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundColor3 = theme.primary
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 170, 0, 50)
    ContentContainer.Size = UDim2.new(0, 420, 0, 340)

    ContentContainerCorner.CornerRadius = UDim.new(0, 8)
    ContentContainerCorner.Parent = ContentContainer

    -- 标签按钮容器
    local TabButtons = Instance.new("ScrollingFrame")
    local TabButtonsLayout = Instance.new("UIListLayout")
    
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabContainer
    TabButtons.Active = true
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 10, 0, 10)
    TabButtons.Size = UDim2.new(1, -20, 1, -20)
    TabButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabButtons.ScrollBarThickness = 4
    TabButtons.ScrollBarImageColor3 = theme.accent

    TabButtonsLayout.Name = "TabButtonsLayout"
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonsLayout.Padding = UDim.new(0, 8)

    -- 内容页面容器
    local TabPages = Instance.new("Frame")
    
    TabPages.Name = "TabPages"
    TabPages.Parent = ContentContainer
    TabPages.BackgroundTransparency = 1
    TabPages.BorderSizePixel = 0
    TabPages.Size = UDim2.new(1, 0, 1, 0)

    -- 开关按钮
    local ToggleButton = Instance.new("TextButton")
    local ToggleButtonCorner = Instance.new("UICorner")
    local ToggleButtonStroke = Instance.new("UIStroke")
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = DebrisOrbitUI
    ToggleButton.BackgroundColor3 = theme.primary
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 20, 0, 20)
    ToggleButton.Size = UDim2.new(0, 100, 0, 35)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "TOGGLE UI"
    ToggleButton.TextColor3 = theme.text
    ToggleButton.TextSize = 14

    ToggleButtonCorner.CornerRadius = UDim.new(0, 8)
    ToggleButtonCorner.Parent = ToggleButton

    ToggleButtonStroke.Color = theme.border
    ToggleButtonStroke.Thickness = 2
    ToggleButtonStroke.Parent = ToggleButton

    -- 启动动画函数
    local function playStartupAnimation()
        -- 初始缩放动画
        StartupUI.Size = UDim2.new(0, 0, 0, 0)
        Tween(StartupUI, {0.5, "Quad", "Out"}, {Size = UDim2.new(0, 300, 0, 200)})
        
        wait(0.5)
        
        -- 进度条动画
        local progress = 0
        local progressSteps = {"Loading modules...", "Initializing UI...", "Finalizing..."}
        
        for i, step in ipairs(progressSteps) do
            StartupSubtitle.Text = step
            Tween(ProgressFill, {0.8, "Quad", "Out"}, {Size = UDim2.new(i/3, 0, 1, 0)})
            wait(0.8)
        end
        
        wait(0.5)
        
        -- 淡出启动UI，淡入主UI
        Tween(StartupUI, {0.5, "Quad", "Out"}, {BackgroundTransparency = 1})
        Tween(StartupTitle, {0.5, "Quad", "Out"}, {TextTransparency = 1})
        Tween(StartupSubtitle, {0.5, "Quad", "Out"}, {TextTransparency = 1})
        Tween(ProgressBar, {0.5, "Quad", "Out"}, {BackgroundTransparency = 1})
        
        wait(0.5)
        
        StartupUI.Visible = false
        Main.Visible = true
        
        -- 主UI进入动画
        Main.Size = UDim2.new(0, 0, 0, 0)
        Tween(Main, {0.6, "Quad", "Out"}, {Size = UDim2.new(0, 600, 0, 400)})
    end

    -- UI切换功能
    local uiVisible = true
    
    function ToggleUIVisibility()
        uiVisible = not uiVisible
        if uiVisible then
            Main.Visible = true
            Tween(Main, {0.3, "Quad", "Out"}, {Size = UDim2.new(0, 600, 0, 400)})
        else
            Tween(Main, {0.3, "Quad", "Out"}, {Size = UDim2.new(0, 0, 0, 0)})
            wait(0.3)
            Main.Visible = false
        end
    end

    ToggleButton.MouseButton1Click:Connect(ToggleUIVisibility)
    drag(Main, TitleBar)

    -- 启动动画
    spawn(playStartupAnimation)

    -- 窗口功能
    local window = {}
    
    function window.Tab(window, name, icon)
        local TabButton = Instance.new("TextButton")
        local TabButtonCorner = Instance.new("UICorner")
        local TabButtonStroke = Instance.new("UIStroke")
        local TabIcon = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        
        local TabPage = Instance.new("ScrollingFrame")
        local TabPageLayout = Instance.new("UIListLayout")
        local TabPagePadding = Instance.new("UIPadding")
        
        -- 创建标签按钮
        TabButton.Name = "TabButton_" .. name
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = theme.secondary
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = ""
        TabButton.TextColor3 = theme.text
        TabButton.TextSize = 14

        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton

        TabButtonStroke.Color = theme.border
        TabButtonStroke.Thickness = 1
        TabButtonStroke.Parent = TabButton

        TabIcon.Name = "TabIcon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 10, 0.5, -10)
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Image = ("rbxassetid://%s"):format(icon or 4370341699)
        TabIcon.ImageColor3 = theme.text

        TabText.Name = "TabText"
        TabText.Parent = TabButton
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(0, 40, 0, 0)
        TabText.Size = UDim2.new(1, -40, 1, 0)
        TabText.Font = Enum.Font.Gotham
        TabText.Text = name
        TabText.TextColor3 = theme.text
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left

        -- 创建标签页面
        TabPage.Name = "TabPage_" .. name
        TabPage.Parent = TabPages
        TabPage.Active = true
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.ScrollBarThickness = 4
        TabPage.ScrollBarImageColor3 = theme.accent
        TabPage.Visible = false

        TabPageLayout.Name = "TabPageLayout"
        TabPageLayout.Parent = TabPage
        TabPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabPageLayout.Padding = UDim.new(0, 10)

        TabPagePadding.Name = "TabPagePadding"
        TabPagePadding.Parent = TabPage
        TabPagePadding.PaddingLeft = UDim.new(0, 10)
        TabPagePadding.PaddingTop = UDim.new(0, 10)

        TabPageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, TabPageLayout.AbsoluteContentSize.Y + 20)
        end)

        -- 标签切换功能
        TabButton.MouseButton1Click:Connect(function()
            Ripple(TabButton)
            
            -- 隐藏所有页面
            for _, page in ipairs(TabPages:GetChildren()) do
                if page:IsA("ScrollingFrame") then
                    page.Visible = false
                end
            end
            
            -- 重置所有按钮样式
            for _, button in ipairs(TabButtons:GetChildren()) do
                if button:IsA("TextButton") then
                    Tween(button, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.secondary})
                    Tween(button.TabButtonStroke, {0.2, "Quad", "Out"}, {Color = theme.border})
                end
            end
            
            -- 显示选中页面并高亮按钮
            TabPage.Visible = true
            Tween(TabButton, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.accent})
            Tween(TabButtonStroke, {0.2, "Quad", "Out"}, {Color = theme.text})
        end)

        -- 设置第一个标签为默认选中
        if #TabButtons:GetChildren() == 1 then
            wait(0.1)
            TabButton:SetAttribute("Default", true)
            TabButton.MouseButton1Click:Fire()
        end

        local tab = {}
        
        function tab.Section(tab, name)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionStroke = Instance.new("UIStroke")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContent = Instance.new("Frame")
            local SectionContentLayout = Instance.new("UIListLayout")
            
            Section.Name = "Section"
            Section.Parent = TabPage
            Section.BackgroundColor3 = theme.background
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, -20, 0, 0)

            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = Section

            SectionStroke.Color = theme.border
            SectionStroke.Thickness = 1
            SectionStroke.Parent = Section

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 10)
            SectionTitle.Size = UDim2.new(1, -30, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = theme.text
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 10, 0, 40)
            SectionContent.Size = UDim2.new(1, -20, 0, 0)

            SectionContentLayout.Name = "SectionContentLayout"
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 8)

            SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContent.Size = UDim2.new(1, -20, 0, SectionContentLayout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, -20, 0, SectionContentLayout.AbsoluteContentSize.Y + 50)
            end)

            local section = {}
            
            -- 按钮控件
            function section.Button(section, text, callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonStroke = Instance.new("UIStroke")
                
                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = theme.secondary
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Gotham
                Button.Text = text
                Button.TextColor3 = theme.text
                Button.TextSize = 14

                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = Button

                ButtonStroke.Color = theme.border
                ButtonStroke.Thickness = 1
                ButtonStroke.Parent = Button

                Button.MouseEnter:Connect(function()
                    Tween(Button, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.accent})
                end)

                Button.MouseLeave:Connect(function()
                    Tween(Button, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.secondary})
                end)

                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    if callback then
                        callback()
                    end
                end)

                return Button
            end

            -- 切换控件
            function section.Toggle(section, text, flag, default, callback)
                local Toggle = Instance.new("Frame")
                local ToggleButton = Instance.new("TextButton")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchCorner = Instance.new("UICorner")
                local ToggleKnob = Instance.new("Frame")
                local ToggleKnobCorner = Instance.new("UICorner")
                
                Toggle.Name = "Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundTransparency = 1
                Toggle.Size = UDim2.new(1, 0, 0, 30)

                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundTransparency = 1
                ToggleButton.Size = UDim2.new(1, 0, 1, 0)
                ToggleButton.Font = Enum.Font.SourceSans
                ToggleButton.Text = ""
                ToggleButton.TextColor3 = theme.text
                ToggleButton.TextSize = 14

                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = theme.text
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = Toggle
                ToggleSwitch.BackgroundColor3 = theme.secondary
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Position = UDim2.new(1, -40, 0.5, -10)
                ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)

                ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchCorner.Parent = ToggleSwitch

                ToggleKnob.Name = "ToggleKnob"
                ToggleKnob.Parent = ToggleSwitch
                ToggleKnob.BackgroundColor3 = theme.text
                ToggleKnob.BorderSizePixel = 0
                ToggleKnob.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleKnob.Size = UDim2.new(0, 16, 0, 16)

                ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
                ToggleKnobCorner.Parent = ToggleKnob

                local isToggled = default or false
                library.flags[flag] = isToggled

                local function updateToggle()
                    if isToggled then
                        Tween(ToggleSwitch, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.accent})
                        Tween(ToggleKnob, {0.2, "Quad", "Out"}, {Position = UDim2.new(0, 22, 0.5, -8)})
                    else
                        Tween(ToggleSwitch, {0.2, "Quad", "Out"}, {BackgroundColor3 = theme.secondary})
                        Tween(ToggleKnob, {0.2, "Quad", "Out"}, {Position = UDim2.new(0, 2, 0.5, -8)})
                    end
                end

                updateToggle()

                ToggleButton.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    library.flags[flag] = isToggled
                    updateToggle()
                    if callback then
                        callback(isToggled)
                    end
                end)

                local toggleFuncs = {}
                function toggleFuncs:SetValue(value)
                    isToggled = value
                    library.flags[flag] = isToggled
                    updateToggle()
                    if callback then
                        callback(isToggled)
                    end
                end

                return toggleFuncs
            end

            -- 滑块控件
            function section.Slider(section, text, flag, min, max, default, callback)
                local Slider = Instance.new("Frame")
                local SliderLabel = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderTrack = Instance.new("Frame")
                local SliderTrackCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderThumb = Instance.new("Frame")
                local SliderThumbCorner = Instance.new("UICorner")
                
                Slider.Name = "Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(1, 0, 0, 50)

                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = text
                SliderLabel.TextColor3 = theme.text
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -60, 0, 0)
                SliderValue.Size = UDim2.new(0, 60, 0, 20)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default or min)
                SliderValue.TextColor3 = theme.text
                SliderValue.TextSize = 14
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right

                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = theme.secondary
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 0, 0, 30)
                SliderTrack.Size = UDim2.new(1, 0, 0, 6)

                SliderTrackCorner.CornerRadius = UDim.new(1, 0)
                SliderTrackCorner.Parent = SliderTrack

                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = theme.accent
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(0, 0, 1, 0)

                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                SliderThumb.Name = "SliderThumb"
                SliderThumb.Parent = SliderTrack
                SliderThumb.BackgroundColor3 = theme.text
                SliderThumb.BorderSizePixel = 0
                SliderThumb.Position = UDim2.new(0, -8, 0.5, -8)
                SliderThumb.Size = UDim2.new(0, 16, 0, 16)

                SliderThumbCorner.CornerRadius = UDim.new(1, 0)
                SliderThumbCorner.Parent = SliderThumb

                min = min or 0
                max = max or 100
                default = default or min
                library.flags[flag] = default

                local function setValue(value)
                    value = math.clamp(value, min, max)
                    local percentage = (value - min) / (max - min)
                    
                    SliderValue.Text = tostring(value)
                    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    SliderThumb.Position = UDim2.new(percentage, -8, 0.5, -8)
                    
                    library.flags[flag] = value
                    if callback then
                        callback(value)
                    end
                end

                setValue(default)

                local dragging = false

                local function updateSliderFromMouse()
                    if not dragging then return end
                    
                    local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                    local trackAbsolutePos = SliderTrack.AbsolutePosition
                    local trackAbsoluteSize = SliderTrack.AbsoluteSize
                    
                    local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
                    relativeX = math.clamp(relativeX, 0, 1)
                    
                    local value = min + (max - min) * relativeX
                    if value % 1 == 0 then
                        value = math.floor(value)
                    else
                        value = tonumber(string.format("%.2f", value))
                    end
                    
                    setValue(value)
                end

                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateSliderFromMouse()
                    end
                end)

                SliderTrack.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSliderFromMouse()
                    end
                end)

                local sliderFuncs = {}
                function sliderFuncs:SetValue(value)
                    setValue(value)
                end

                return sliderFuncs
            end

            return section
        end

        return tab
    end

    return window
end

return library
