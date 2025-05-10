--[[
    NyaCAST UI Library
    Created by NYA
    Version: 1.0.0
]]

local ver = "1.0.0"
local changelog = game:HttpGet("https://raw.githubusercontent.com/lolow2e/NyaCast-UI/main/Changelog.txt") or "UNABLE TO GET CHANGELOG"

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Utility Functions
local function GetXY(GuiObject)
    local X, Y = mouse.X - GuiObject.AbsolutePosition.X, mouse.Y - GuiObject.AbsolutePosition.Y
    local MaxX, MaxY = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
    X, Y = math.clamp(X, 0, MaxX), math.clamp(Y, 0, MaxY)
    return X, Y, X/MaxX, Y/MaxY
end

local function Tween(GuiObject, Dictionary, duration)
    duration = duration or 0.3
    local TweenBase = TweenService:Create(GuiObject, TweenInfo.new(duration, Enum.EasingStyle.Quint), Dictionary)
    TweenBase:Play()
    return TweenBase
end

-- Colors
local colors = {
    main = Color3.fromRGB(35, 35, 50),
    secondary = Color3.fromRGB(45, 45, 65),
    accent = Color3.fromRGB(190, 135, 255),
    text = Color3.fromRGB(240, 240, 245),
    subtext = Color3.fromRGB(180, 180, 190),
    positive = Color3.fromRGB(130, 220, 120),
    negative = Color3.fromRGB(250, 90, 90),
    neutral = Color3.fromRGB(100, 180, 250)
}

-- Main Window Creation
lib.createWindow = function(name, title, config)
    config = config or {}
    local draggable = config.draggable ~= nil and config.draggable or true
    local theme = config.theme or "default"
    
    if theme == "dark" then
        colors.main = Color3.fromRGB(25, 25, 35)
        colors.secondary = Color3.fromRGB(35, 35, 45)
    elseif theme == "light" then
        colors.main = Color3.fromRGB(240, 240, 245)
        colors.secondary = Color3.fromRGB(220, 220, 230)
        colors.text = Color3.fromRGB(50, 50, 60)
        colors.subtext = Color3.fromRGB(80, 80, 90)
    elseif theme == "purple" then
        colors.main = Color3.fromRGB(40, 30, 60)
        colors.secondary = Color3.fromRGB(50, 40, 75)
        colors.accent = Color3.fromRGB(210, 130, 240)
    elseif theme == "blue" then
        colors.main = Color3.fromRGB(30, 40, 60)
        colors.secondary = Color3.fromRGB(40, 50, 75)
        colors.accent = Color3.fromRGB(120, 170, 255)
    end

    -- Create UI
    local MainGui = Instance.new("ScreenGui")
    local ContainerFrame = Instance.new("Frame")
    local MainFrame = Instance.new("Frame")
    local SideBar = Instance.new("Frame")
    local SideBarUICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Seperator = Instance.new("Frame")
    local TabList = Instance.new("ScrollingFrame")
    local TabListLayout = Instance.new("UIListLayout")
    local TabListPadding = Instance.new("UIPadding")
    local Main = Instance.new("Frame")
    local MainUICorner = Instance.new("UICorner")
    local TabHolder = Instance.new("Frame")

    -- Initialize window data
    local tabs = {}
    local defualt_tab = false
    local WindowLib = {}

    -- Setup UI
    MainGui.Name = name or "NyaCAST"
    MainGui.Parent = game.CoreGui
    MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    MainGui.ResetOnSpawn = false

    ContainerFrame.Name = "ContainerFrame"
    ContainerFrame.Parent = MainGui
    ContainerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContainerFrame.BackgroundTransparency = 1.000
    ContainerFrame.BorderSizePixel = 0
    ContainerFrame.Size = UDim2.new(1, 0, 1, 0)

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ContainerFrame
    MainFrame.BackgroundTransparency = 1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.353, 0, 0.349, 0)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.ClipsDescendants = true

    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = colors.main
    SideBar.BorderSizePixel = 0
    SideBar.Position = UDim2.new(0, 0, 0, 0)
    SideBar.Size = UDim2.new(0, 160, 1, 0)

    SideBarUICorner.CornerRadius = UDim.new(0, 8)
    SideBarUICorner.Parent = SideBar

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 0, 0, 15)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title or "NyaCAST UI"
    Title.TextColor3 = colors.accent
    Title.TextSize = 18.000

    Seperator.Name = "Seperator"
    Seperator.Parent = SideBar
    Seperator.BackgroundColor3 = colors.accent
    Seperator.BorderSizePixel = 0
    Seperator.Position = UDim2.new(0.1, 0, 0, 50)
    Seperator.Size = UDim2.new(0.8, 0, 0, 2)
    Seperator.BackgroundTransparency = 0.5

    TabList.Name = "TabList"
    TabList.Parent = SideBar
    TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabList.BackgroundTransparency = 1.000
    TabList.BorderSizePixel = 0
    TabList.Position = UDim2.new(0, 0, 0, 60)
    TabList.Size = UDim2.new(1, 0, 0.9, -60)
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.ScrollBarThickness = 2
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.ScrollBarImageColor3 = colors.accent
    TabList.ScrollingDirection = Enum.ScrollingDirection.Y

    TabListLayout.Parent = TabList
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    TabListPadding.Parent = TabList
    TabListPadding.PaddingLeft = UDim.new(0, 10)
    TabListPadding.PaddingRight = UDim.new(0, 10)
    TabListPadding.PaddingTop = UDim.new(0, 5)

    Main.Name = "Main"
    Main.Parent = MainFrame
    Main.BackgroundColor3 = colors.secondary
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0, 170, 0, 0)
    Main.Size = UDim2.new(1, -170, 1, 0)

    MainUICorner.CornerRadius = UDim.new(0, 8)
    MainUICorner.Parent = Main

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = colors.secondary
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0, 170, 0, 0)
    TabHolder.Size = UDim2.new(1, -170, 1, 0)
    TabHolder.ClipsDescendants = true

    -- Animation utilities
    WindowLib.HighlightText = function(v)
        local info = TweenInfo.new(.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        local unselected = {
            TextColor3 = colors.text
        }
        local hover = {
            TextColor3 = colors.accent
        }
        v.MouseEnter:Connect(function()
            TweenService:Create(v, info, hover):Play()
        end)
        v.MouseLeave:Connect(function()
            TweenService:Create(v, info, unselected):Play()
        end)    
    end

    WindowLib.ImageFadeOut = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {ImageTransparency = 1}):Play()
    end
    
    WindowLib.ImageFadeIn = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {ImageTransparency = 0}):Play()
    end
    
    WindowLib.BackgroundFadeOut = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {BackgroundTransparency = 1}):Play()
    end
    
    WindowLib.BackgroundFadeIn = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {BackgroundTransparency = 0}):Play()
    end
    
    WindowLib.TextFadeOut = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {TextTransparency = 1}):Play()
    end
    
    WindowLib.TextFadeIn = function(v, duration)
        if not duration then duration = .3 end
        local info = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        TweenService:Create(v, info, {TextTransparency = 0}):Play()
    end

    -- Notification System
    WindowLib.notification = function(title, text, duration)
        duration = duration or 5
        
        local Popup = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local Main_2 = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local Title_2 = Instance.new("TextLabel")
        local Seperator_2 = Instance.new("Frame")
        local Message = Instance.new("TextLabel")
        local Close = Instance.new("TextButton")
        local UICorner_3 = Instance.new("UICorner")

        Popup.Name = "Notification"
        Popup.Parent = MainFrame
        Popup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Popup.BackgroundTransparency = 1
        Popup.BorderSizePixel = 0
        Popup.Size = UDim2.new(1, 0, 1, 0)
        Popup.Visible = true
        Popup.ZIndex = 10

        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Popup

        Main_2.Name = "Main"
        Main_2.Parent = Popup
        Main_2.BackgroundTransparency = 1
        Main_2.BackgroundColor3 = colors.main
        Main_2.BorderSizePixel = 0
        Main_2.Position = UDim2.new(0.5, -165, 0.5, -100)
        Main_2.Size = UDim2.new(0, 330, 0, 200)
        Main_2.ZIndex = 10

        UICorner_2.CornerRadius = UDim.new(0, 8)
        UICorner_2.Parent = Main_2

        Title_2.Name = "Title"
        Title_2.Parent = Main_2
        Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title_2.BackgroundTransparency = 1.000
        Title_2.BorderSizePixel = 0
        Title_2.Position = UDim2.new(0, 0, 0, 10)
        Title_2.Size = UDim2.new(1, 0, 0, 30)
        Title_2.Font = Enum.Font.GothamBold
        Title_2.Text = title
        Title_2.TextColor3 = colors.accent
        Title_2.TextSize = 16.000
        Title_2.TextTransparency = 1
        Title_2.ZIndex = 11

        Seperator_2.Name = "Seperator"
        Seperator_2.Parent = Main_2
        Seperator_2.BackgroundColor3 = colors.accent
        Seperator_2.BorderSizePixel = 0
        Seperator_2.Position = UDim2.new(0.15, 0, 0, 45)
        Seperator_2.Size = UDim2.new(0.7, 0, 0, 2)
        Seperator_2.BackgroundTransparency = 1
        Seperator_2.ZIndex = 11

        Message.Name = "Message"
        Message.Parent = Main_2
        Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Message.BackgroundTransparency = 1.000
        Message.BorderSizePixel = 0
        Message.Position = UDim2.new(0.05, 0, 0, 55)
        Message.Size = UDim2.new(0.9, 0, 0, 95)
        Message.Font = Enum.Font.Gotham
        Message.Text = text
        Message.TextColor3 = colors.text
        Message.TextSize = 14.000
        Message.TextWrapped = true
        Message.TextXAlignment = Enum.TextXAlignment.Left
        Message.TextYAlignment = Enum.TextYAlignment.Top
        Message.TextTransparency = 1
        Message.ZIndex = 11

        Close.Name = "Close"
        Close.Parent = Main_2
        Close.BackgroundColor3 = colors.accent
        Close.BorderSizePixel = 0
        Close.TextTransparency = 1
        Close.BackgroundTransparency = 1
        Close.Position = UDim2.new(0.1, 0, 0, 160)
        Close.Size = UDim2.new(0.8, 0, 0, 30)
        Close.Font = Enum.Font.GothamSemibold
        Close.Text = "Close"
        Close.TextColor3 = Color3.fromRGB(255, 255, 255)
        Close.TextSize = 14.000
        Close.ZIndex = 11
        
        Close.MouseButton1Down:Connect(function()
            Tween(Popup, {BackgroundTransparency = 1})
            for i,v in pairs(Popup:GetDescendants()) do
                if v:IsA("Frame") then
                    Tween(v, {BackgroundTransparency = 1})
                elseif v:IsA("TextLabel") or v:IsA("TextButton") then
                    Tween(v, {BackgroundTransparency = 1, TextTransparency = 1})
                end
            end
            task.wait(0.5)
            Popup:Destroy()
        end)

        UICorner_3.CornerRadius = UDim.new(0, 6)
        UICorner_3.Parent = Close

        -- Animation
        Tween(Popup, {BackgroundTransparency = 0.5})
        for i,v in pairs(Popup:GetDescendants()) do
            if v:IsA("Frame") then
                Tween(v, {BackgroundTransparency = 0})
            elseif v:IsA("TextLabel") then
                Tween(v, {BackgroundTransparency = 1, TextTransparency = 0})
            elseif v:IsA("TextButton") then
                Tween(v, {BackgroundTransparency = 0, TextTransparency = 0})
            end
        end
        
        -- Auto close after duration
        task.spawn(function()
            task.wait(duration)
            if Popup and Popup.Parent then
                Tween(Popup, {BackgroundTransparency = 1})
                for i,v in pairs(Popup:GetDescendants()) do
                    if v:IsA("Frame") then
                        Tween(v, {BackgroundTransparency = 1})
                    elseif v:IsA("TextLabel") or v:IsA("TextButton") then
                        Tween(v, {BackgroundTransparency = 1, TextTransparency = 1})
                    end
                end
                task.wait(0.5)
                if Popup and Popup.Parent then
                    Popup:Destroy()
                end
            end
        end)
    end

    -- Setup draggable functionality if enabled
    if draggable then
        local dragging = false
        local dragInput, mousePos, framePos
        
        MainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                mousePos = input.Position
                framePos = MainFrame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        MainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    local delta = input.Position - mousePos
                    MainFrame.Position = UDim2.new(
                        framePos.X.Scale, 
                        framePos.X.Offset + delta.X,
                        framePos.Y.Scale, 
                        framePos.Y.Offset + delta.Y
                    )
                end
            end
        end)
    end

    -- Welcome notification on first use
    if not isfile('NyaCAST_Ver.txt') then
        writefile('NyaCAST_Ver.txt', ver)
        WindowLib.notification("NyaCAST | Welcome", "Welcome to NyaCAST UI Library! Created by NYA. This is your first time using this UI library. Enjoy!")
    elseif readfile('NyaCAST_Ver.txt') ~= ver then
        writefile('NyaCAST_Ver.txt', ver)
        WindowLib.notification("NyaCAST | Update", changelog)
    end

    -- Create Tab function
    WindowLib.createTab = function(name, icon)
        local TabLib = {}
        table.insert(tabs, name)
        
        -- Create tab button
        local TabButton = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabIndicator = Instance.new("Frame")
        local TabUICorner = Instance.new("UICorner")
        
        TabButton.Name = name
        TabButton.Parent = TabList
        TabButton.BackgroundColor3 = colors.main
        TabButton.BackgroundTransparency = 1
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -20, 0, 36)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = ""
        TabButton.TextColor3 = colors.text
        TabButton.TextSize = 14.000
        TabButton.AutoButtonColor = false
        
        TabUICorner.CornerRadius = UDim.new(0, 6)
        TabUICorner.Parent = TabButton
        
        if icon then
            TabIcon.Name = "Icon"
            TabIcon.Parent = TabButton
            TabIcon.BackgroundTransparency = 1
            TabIcon.Position = UDim2.new(0, 8, 0, 8)
            TabIcon.Size = UDim2.new(0, 20, 0, 20)
            TabIcon.Image = icon
            TabIcon.ImageColor3 = colors.text
            
            TabText.Name = "Text"
            TabText.Parent = TabButton
            TabText.BackgroundTransparency = 1
            TabText.Position = UDim2.new(0, 36, 0, 0)
            TabText.Size = UDim2.new(1, -44, 1, 0)
            TabText.Font = Enum.Font.GothamSemibold
            TabText.Text = name
            TabText.TextColor3 = colors.text
            TabText.TextSize = 14
            TabText.TextXAlignment = Enum.TextXAlignment.Left
        else
            TabText.Name = "Text"
            TabText.Parent = TabButton
            TabText.BackgroundTransparency = 1
            TabText.Position = UDim2.new(0, 10, 0, 0)
            TabText.Size = UDim2.new(1, -20, 1, 0)
            TabText.Font = Enum.Font.GothamSemibold
            TabText.Text = name
            TabText.TextColor3 = colors.text
            TabText.TextSize = 14
            TabText.TextXAlignment = Enum.TextXAlignment.Left
        end
        
        TabIndicator.Name = "Indicator"
        TabIndicator.Parent = TabButton
        TabIndicator.BackgroundColor3 = colors.accent
        TabIndicator.Position = UDim2.new(0, 0, 0, 0)
        TabIndicator.Size = UDim2.new(0, 3, 1, 0)
        TabIndicator.Visible = false
        
        -- Create tab content
        local TabMain = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        
        TabMain.Name = name
        TabMain.Parent = TabHolder
        TabMain.Active = true
        TabMain.BackgroundColor3 = colors.secondary
        TabMain.BackgroundTransparency = 1
        TabMain.BorderSizePixel = 0
        TabMain.Position = UDim2.new(0, 0, 0, 0)
        TabMain.Size = UDim2.new(1, 0, 1, 0)
        TabMain.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabMain.ScrollBarThickness = 3
        TabMain.ScrollBarImageColor3 = colors.accent
        TabMain.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        TabLayout.Parent = TabMain
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)
        
        TabPadding.Parent = TabMain
        TabPadding.PaddingLeft = UDim.new(0, 15)
        TabPadding.PaddingRight = UDim.new(0, 15)
        TabPadding.PaddingTop = UDim.new(0, 15)
        TabPadding.PaddingBottom = UDim.new(0, 15)
        
        if not defualt_tab then
            defualt_tab = TabButton.Name
            TabIndicator.Visible = true
            TabButton.BackgroundTransparency = 0.8
            if TabIcon then
                TabIcon.ImageColor3 = colors.accent
            end
            TabText.TextColor3 = colors.accent
        else
            TabMain.Visible = false
        end
        
        -- Tab button effects
        TabButton.MouseEnter:Connect(function()
            if TabButton.Name ~= defualt_tab then
                Tween(TabButton, {BackgroundTransparency = 0.9})
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if TabButton.Name ~= defualt_tab then
                Tween(TabButton, {BackgroundTransparency = 1})
            end
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            if TabButton.Name ~= defualt_tab then
                -- Deselect current tab
                local currentTab = TabList:FindFirstChild(defualt_tab)
                Tween(currentTab, {BackgroundTransparency = 1})
                currentTab.Indicator.Visible = false
                
                if currentTab:FindFirstChild("Icon") then
                    Tween(currentTab.Icon, {ImageColor3 = colors.text})
                end
                Tween(currentTab.Text, {TextColor3 = colors.text})
                
                -- Hide current tab content
                TabHolder[defualt_tab]:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quint", 0.3, false)
                task.wait(0.3)
                TabHolder[defualt_tab].Visible = false
                
                -- Select new tab
                defualt_tab = TabButton.Name
                Tween(TabButton, {BackgroundTransparency = 0.8})
                TabIndicator.Visible = true
                
                if TabIcon then
                    Tween(TabIcon, {ImageColor3 = colors.accent})
                end
                Tween(TabText, {TextColor3 = colors.accent})
                
                -- Show new tab content
                TabHolder[defualt_tab].Visible = true
                TabHolder[defualt_tab]:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.3, false)
            end
        end)
        
        -- Button creation
        TabLib.createButton = function(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonUICorner = Instance.new("UICorner")
            local ButtonIcon = Instance.new("ImageLabel")
            
            Button.Name = text
            Button.Parent = TabMain
            Button.BackgroundColor3 = colors.main
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, 0, 0, 36)
            Button.Font = Enum.Font.GothamSemibold
            Button.TextColor3 = colors.text
            Button.TextSize = 14.000
            Button.Text = text
            Button.ClipsDescendants = true
            
            Button.MouseButton1Click:Connect(function()
                -- Ripple effect
                local Circle = Instance.new("Frame")
                Circle.Name = "Circle"
                Circle.Parent = Button
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 0.7
                Circle.ZIndex = 10
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = Circle
                
                local MousePos = game.Players.LocalPlayer:GetMouse()
                local Size = Button.AbsoluteSize.X
                
                Circle.Position = UDim2.new(0, MousePos.X - Button.AbsolutePosition.X, 0, MousePos.Y - Button.AbsolutePosition.Y)
                Circle.Size = UDim2.new(0, 0, 0, 0)
                
                Circle:TweenSize(UDim2.new(0, Size * 2, 0, Size * 2), "Out", "Quart", 0.5, false)
                Tween(Circle, {BackgroundTransparency = 1}, 0.5)
                
                task.spawn(function()
                    task.wait(0.5)
                    Circle:Destroy()
                end)
                
                if callback then
                    callback()
                end
            end)
            
            ButtonUICorner.CornerRadius = UDim.new(0, 6)
            ButtonUICorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                Tween(Button, {BackgroundColor3 = colors.secondary})
            end)
            
            Button.MouseLeave:Connect(function()
                Tween(Button, {BackgroundColor3 = colors.main})
            end)
            
            -- Optional icon handling
            if typeof(text) == "table" and text.icon then
                ButtonIcon.Name = "ButtonIcon"
                ButtonIcon.Parent = Button
                ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonIcon.BackgroundTransparency = 1.000
                ButtonIcon.BorderSizePixel = 0
                ButtonIcon.Position = UDim2.new(0.95, 0, 0.5, -10)
                ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                ButtonIcon.Image = text.icon
                Button.Text = text.text
            end
            
            return Button
        end
        
        -- Text label creation
        TabLib.createText = function(text, config)
            config = config or {}
            
            local Text = Instance.new("TextLabel")
            local TextUICorner = Instance.new("UICorner")
            
            Text.Name = "Text"
            Text.Parent = TabMain
            Text.BackgroundColor3 = colors.main
            Text.BorderSizePixel = 0
            Text.Size = UDim2.new(1, 0, 0, 36)
            Text.Font = Enum.Font.GothamSemibold
            Text.Text = text
            Text.TextColor3 = config.color or colors.text
            Text.TextSize = config.size or 14.000
            Text.TextXAlignment = config.align or Enum.TextXAlignment.Center
            
            if config.background == false then
                Text.BackgroundTransparency = 1
            end
            
            TextUICorner.CornerRadius = UDim.new(0, 6)
            TextUICorner.Parent = Text
            
            return Text
        end
        
        -- Toggle creation
        TabLib.createToggle = function(text, default, callback)
            local value = default or false
            
            local Toggle = Instance.new("Frame")
            local ToggleUICorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleButtonUICorner = Instance.new("UICorner")
            local ToggleIndicator = Instance.new("Frame")
            local ToggleIndicatorUICorner = Instance.new("UICorner")
            
            Toggle.Name = text
            Toggle.Parent = TabMain
            Toggle.BackgroundColor3 = colors.main
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, 0, 0, 36)
            
            ToggleUICorner.CornerRadius = UDim.new(0, 6)
            ToggleUICorner.Parent = Toggle
            
            ToggleTitle.Name = "Title"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.Position = UDim2.new(0.02, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.75, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.GothamSemibold
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = colors.text
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(0.9, -40, 0.5, -10)
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            ToggleButton.TextSize = 14.000
            ToggleButton.AutoButtonColor = false
            
            ToggleButtonUICorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonUICorner.Parent = ToggleButton
            
            ToggleIndicator.Name = "Indicator"
            ToggleIndicator.Parent = ToggleButton
            ToggleIndicator.BackgroundColor3 = value and colors.positive or Color3.fromRGB(100, 100, 100)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Position = UDim2.new(value and 0.5 or 0, 0, 0, 0)
            ToggleIndicator.Size = UDim2.new(0.5, 0, 1, 0)
            
            ToggleIndicatorUICorner.CornerRadius = UDim.new(1, 0)
            ToggleIndicatorUICorner.Parent = ToggleIndicator
            
            local function updateToggle()
                if value then
                    Tween(ToggleIndicator, {Position = UDim2.new(0.5, 0, 0, 0), BackgroundColor3 = colors.positive})
                else
                    Tween(ToggleIndicator, {Position = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(100, 100, 100)})
                end
                if callback then
                    callback(value)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                value = not value
                updateToggle()
            end)
            
            Toggle.MouseEnter:Connect(function()
                Tween(Toggle, {BackgroundColor3 = colors.secondary})
            end)
            
            Toggle.MouseLeave:Connect(function()
                Tween(Toggle, {BackgroundColor3 = colors.main})
            end)
            
            -- Call callback with initial value
            if callback and value then
                callback(value)
            end
            
            -- Toggle API
            local ToggleAPI = {}
            
            function ToggleAPI:SetValue(newValue)
                if typeof(newValue) == "boolean" and newValue ~= value then
                    value = newValue
                    updateToggle()
                end
            end
            
            function ToggleAPI:GetValue()
                return value
            end
            
            return ToggleAPI
        end
        
        -- Slider creation
        TabLib.createSlider = function(text, config, callback)
            local Configuration = config or {}
            local Minimum = Configuration.min or 0
            local Maximum = Configuration.max or 100
            local Default = Configuration.default or Minimum
            
            -- Ensure proper values
            if Minimum > Maximum then
                local temp = Minimum
                Minimum = Maximum
                Maximum = temp
            end
            
            Default = math.clamp(Default, Minimum, Maximum)
            local CurrentValue = Default
            local DefaultScale = (Default - Minimum) / (Maximum - Minimum)
            
            local Slider = Instance.new("Frame")
            local SliderUICorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SliderBG = Instance.new("Frame")
            local SliderBGUICorner = Instance.new("UICorner")
            local SliderFill = Instance.new("Frame")
            local SliderFillUICorner = Instance.new("UICorner")
            local SliderButton = Instance.new("TextButton")
            
            Slider.Name = text
            Slider.Parent = TabMain
            Slider.BackgroundColor3 = colors.main
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(1, 0, 0, 50)
            
            SliderUICorner.CornerRadius = UDim.new(0, 6)
            SliderUICorner.Parent = Slider
            
            SliderTitle.Name = "Title"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.BorderSizePixel = 0
            SliderTitle.Position = UDim2.new(0.02, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0.7, 0, 0, 25)
            SliderTitle.Font = Enum.Font.GothamSemibold
            SliderTitle.Text = text
            SliderTitle.TextColor3 = colors.text
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderValue.Name = "Value"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Position = UDim2.new(0.85, 0, 0, 0)
            SliderValue.Size = UDim2.new(0.15, -10, 0, 25)
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(Default)
            SliderValue.TextColor3 = colors.accent
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            
            SliderBG.Name = "SliderBG"
            SliderBG.Parent = Slider
            SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderBG.BorderSizePixel = 0
            SliderBG.Position = UDim2.new(0.02, 0, 0, 30)
            SliderBG.Size = UDim2.new(0.96, 0, 0, 10)
            
            SliderBGUICorner.CornerRadius = UDim.new(1, 0)
            SliderBGUICorner.Parent = SliderBG
            
            SliderFill.Name = "SliderFill"
            SliderFill.Parent = SliderBG
            SliderFill.BackgroundColor3 = colors.accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new(DefaultScale, 0, 1, 0)
            
            SliderFillUICorner.CornerRadius = UDim.new(1, 0)
            SliderFillUICorner.Parent = SliderFill
            
            SliderButton.Name = "SliderButton"
            SliderButton.Parent = Slider
            SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderButton.BackgroundTransparency = 1.000
            SliderButton.BorderSizePixel = 0
            SliderButton.Position = UDim2.new(0.02, 0, 0, 25)
            SliderButton.Size = UDim2.new(0.96, 0, 0, 20)
            SliderButton.Font = Enum.Font.SourceSans
            SliderButton.Text = ""
            SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            SliderButton.TextSize = 14.000
            
            local function updateSlider(scale)
                scale = math.clamp(scale, 0, 1)
                CurrentValue = math.floor(Minimum + ((Maximum - Minimum) * scale))
                SliderValue.Text = tostring(CurrentValue)
                Tween(SliderFill, {Size = UDim2.new(scale, 0, 1, 0)}, 0.1)
                
                if callback then
                    callback(CurrentValue)
                end
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                local dragging = true
                
                -- Initial update
                local scale = (game.Players.LocalPlayer:GetMouse().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
                updateSlider(scale)
                
                -- Mouse move connection
                local moveConnection = game.Players.LocalPlayer:GetMouse().Move:Connect(function()
                    if dragging then
                        local scale = (game.Players.LocalPlayer:GetMouse().X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
                        updateSlider(scale)
                    end
                end)
                
                -- Mouse up connection
                local releaseConnection = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        moveConnection:Disconnect()
                        releaseConnection:Disconnect()
                    end
                end)
            end)
            
            Slider.MouseEnter:Connect(function()
                Tween(Slider, {BackgroundColor3 = colors.secondary})
            end)
            
            Slider.MouseLeave:Connect(function()
                Tween(Slider, {BackgroundColor3 = colors.main})
            end)
            
            -- Initialize with default
            if callback then
                callback(Default)
            end
            
            -- Slider API
            local SliderAPI = {}
            
            function SliderAPI:SetValue(newValue)
                newValue = math.clamp(newValue, Minimum, Maximum)
                if newValue ~= CurrentValue then
                    CurrentValue = newValue
                    local scale = (CurrentValue - Minimum) / (Maximum - Minimum)
                    SliderValue.Text = tostring(CurrentValue)
                    Tween(SliderFill, {Size = UDim2.new(scale, 0, 1, 0)}, 0.1)
                    
                    if callback then
                        callback(CurrentValue)
                    end
                end
            end
            
            function SliderAPI:GetValue()
                return CurrentValue
            end
            
            return SliderAPI
        end
        
        -- Dropdown creation
        TabLib.createDropdown = function(text, options, default, callback)
            local options = options or {}
            local selected = default or options[1] or ""
            
            local Dropdown = Instance.new("Frame")
            local DropdownUICorner = Instance.new("UICorner")
            local DropdownTitle = Instance.new("TextLabel")
            local DropdownButton = Instance.new("TextButton")
            local DropdownButtonUICorner = Instance.new("UICorner")
            local DropdownIcon = Instance.new("ImageLabel")
            local DropdownText = Instance.new("TextLabel")
            local DropdownMenu = Instance.new("Frame")
            local DropdownMenuUICorner = Instance.new("UICorner")
            local DropdownScroll = Instance.new("ScrollingFrame")
            local DropdownScrollUIList = Instance.new("UIListLayout")
            
            Dropdown.Name = text
            Dropdown.Parent = TabMain
            Dropdown.BackgroundColor3 = colors.main
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(1, 0, 0, 36)
            Dropdown.ClipsDescendants = true
            
            DropdownUICorner.CornerRadius = UDim.new(0, 6)
            DropdownUICorner.Parent = Dropdown
            
            DropdownTitle.Name = "Title"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.BorderSizePixel = 0
            DropdownTitle.Position = UDim2.new(0.02, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0.4, 0, 0, 36)
            DropdownTitle.Font = Enum.Font.GothamSemibold
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = colors.text
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Parent = Dropdown
            DropdownButton.BackgroundColor3 = colors.secondary
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Position = UDim2.new(0.45, 0, 0.5, -15)
            DropdownButton.Size = UDim2.new(0.53, 0, 0, 30)
            DropdownButton.Font = Enum.Font.SourceSans
            DropdownButton.Text = ""
            DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownButton.TextSize = 14.000
            DropdownButton.AutoButtonColor = false
            
            DropdownButtonUICorner.CornerRadius = UDim.new(0, 6)
            DropdownButtonUICorner.Parent = DropdownButton
            
            DropdownIcon.Name = "Icon"
            DropdownIcon.Parent = DropdownButton
            DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownIcon.BackgroundTransparency = 1.000
            DropdownIcon.BorderSizePixel = 0
            DropdownIcon.Position = UDim2.new(0.9, -15, 0.5, -7)
            DropdownIcon.Size = UDim2.new(0, 14, 0, 14)
            DropdownIcon.Image = "rbxassetid://3926305904"
            DropdownIcon.ImageRectOffset = Vector2.new(564, 284)
            DropdownIcon.ImageRectSize = Vector2.new(36, 36)
            
            DropdownText.Name = "Selected"
            DropdownText.Parent = DropdownButton
            DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
            DropdownText.Size = UDim2.new(0.85, -20, 1, 0)
            DropdownText.Font = Enum.Font.Gotham
            DropdownText.Text = selected
            DropdownText.TextColor3 = colors.text
            DropdownText.TextSize = 14.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownMenu.Name = "Menu"
            DropdownMenu.Parent = Dropdown
            DropdownMenu.BackgroundColor3 = colors.secondary
            DropdownMenu.BorderSizePixel = 0
            DropdownMenu.Position = UDim2.new(0.45, 0, 0, 40)
            DropdownMenu.Size = UDim2.new(0.53, 0, 0, 0) -- Start closed
            DropdownMenu.ClipsDescendants = true
            DropdownMenu.Visible = false
            
            DropdownMenuUICorner.CornerRadius = UDim.new(0, 6)
            DropdownMenuUICorner.Parent = DropdownMenu
            
            DropdownScroll.Name = "Scroll"
            DropdownScroll.Parent = DropdownMenu
            DropdownScroll.Active = true
            DropdownScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownScroll.BackgroundTransparency = 1.000
            DropdownScroll.BorderSizePixel = 0
            DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
            DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropdownScroll.ScrollBarThickness = 2
            DropdownScroll.ScrollBarImageColor3 = colors.accent
            DropdownScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
            
            DropdownScrollUIList.Parent = DropdownScroll
            DropdownScrollUIList.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownScrollUIList.Padding = UDim.new(0, 5)
            
            -- Initial setup of options
            local function setup()
                DropdownScroll:ClearAllChildren()
                DropdownScrollUIList.Parent = DropdownScroll
                
                for i, option in ipairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    local OptionButtonUICorner = Instance.new("UICorner")
                    
                    OptionButton.Name = option
                    OptionButton.Parent = DropdownScroll
                    OptionButton.BackgroundColor3 = option == selected and colors.accent or colors.main
                    OptionButton.BackgroundTransparency = option == selected and 0.7 or 0.5
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, -10, 0, 30)
                    OptionButton.Position = UDim2.new(0, 5, 0, 0)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = option
                    OptionButton.TextColor3 = option == selected and colors.accent or colors.text
                    OptionButton.TextSize = 14.000
                    OptionButton.AutoButtonColor = false
                    
                    OptionButtonUICorner.CornerRadius = UDim.new(0, 6)
                    OptionButtonUICorner.Parent = OptionButton
                    
                    OptionButton.MouseEnter:Connect(function()
                        if option ~= selected then
                            Tween(OptionButton, {BackgroundTransparency = 0.3})
                        end
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        if option ~= selected then
                            Tween(OptionButton, {BackgroundTransparency = 0.5})
                        end
                    end)
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        selected = option
                        DropdownText.Text = selected
                        
                        -- Close dropdown
                        Tween(DropdownMenu, {Size = UDim2.new(0.53, 0, 0, 0)}, 0.3)
                        task.wait(0.3)
                        DropdownMenu.Visible = false
                        
                        -- Update options highlight
                        for _, child in ipairs(DropdownScroll:GetChildren()) do
                            if child:IsA("TextButton") then
                                Tween(child, {
                                    BackgroundColor3 = child.Name == selected and colors.accent or colors.main,
                                    BackgroundTransparency = child.Name == selected and 0.7 or 0.5,
                                    TextColor3 = child.Name == selected and colors.accent or colors.text
                                })
                            end
                        end
                        
                        if callback then
                            callback(selected)
                        end
                    end)
                end
            end
            
            setup()
            
            -- Toggle dropdown
            local dropdownOpen = false
            
            DropdownButton.MouseButton1Click:Connect(function()
                dropdownOpen = not dropdownOpen
                
                if dropdownOpen then
                    DropdownMenu.Visible = true
                    Tween(DropdownMenu, {Size = UDim2.new(0.53, 0, 0, math.min(#options * 35, 150))}, 0.3)
                    Tween(DropdownIcon, {Rotation = 180}, 0.3)
                else
                    Tween(DropdownMenu, {Size = UDim2.new(0.53, 0, 0, 0)}, 0.3)
                    Tween(DropdownIcon, {Rotation = 0}, 0.3)
                    task.wait(0.3)
                    DropdownMenu.Visible = false
                end
            end)
            
            Dropdown.MouseEnter:Connect(function()
                Tween(Dropdown, {BackgroundColor3 = colors.secondary})
            end)
            
            Dropdown.MouseLeave:Connect(function()
                Tween(Dropdown, {BackgroundColor3 = colors.main})
            end)
            
            -- Dropdown API
            local DropdownAPI = {}
            
            function DropdownAPI:SetValue(newValue)
                if table.find(options, newValue) and newValue ~= selected then
                    selected = newValue
                    DropdownText.Text = selected
                    
                    -- Update options highlight
                    for _, child in ipairs(DropdownScroll:GetChildren()) do
                        if child:IsA("TextButton") then
                            Tween(child, {
                                BackgroundColor3 = child.Name == selected and colors.accent or colors.main,
                                BackgroundTransparency = child.Name == selected and 0.7 or 0.5,
                                TextColor3 = child.Name == selected and colors.accent or colors.text
                            })
                        end
                    end
                    
                    if callback then
                        callback(selected)
                    end
                end
            end
            
            function DropdownAPI:GetValue()
                return selected
            end
            
            function DropdownAPI:UpdateOptions(newOptions, keepSelection)
                options = newOptions
                
                if not keepSelection or not table.find(options, selected) then
                    selected = options[1] or ""
                    DropdownText.Text = selected
                end
                
                setup()
                
                if callback then
                    callback(selected)
                end
            end
            
            return DropdownAPI
        end
        
        -- Section creation for grouping elements
        TabLib.createSection = function(text, isopen)
            local SectionLib = {}
            local isdown = isopen ~= false
            
            local Section = Instance.new("Frame")
            local SectionText = Instance.new("TextLabel")
            local SectionUICorner = Instance.new("UICorner")
            local OpenCloseIcon = Instance.new("ImageButton")
            local SectionListLayout = Instance.new("UIListLayout")
            local SectionPadding = Instance.new("UIPadding")
            
            Section.Name = text
            Section.Parent = TabMain
            Section.BackgroundColor3 = colors.main
            Section.BackgroundTransparency = 0.7
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 36)
            Section.AutomaticSize = Enum.AutomaticSize.Y
            Section.ClipsDescendants = false
            
            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = colors.main
            SectionText.BorderSizePixel = 0
            SectionText.Size = UDim2.new(1, 0, 0, 36)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = text
            SectionText.TextColor3 = colors.accent
            SectionText.TextSize = 14.000
            
            SectionUICorner.CornerRadius = UDim.new(0, 6)
            SectionUICorner.Parent = SectionText
            
            OpenCloseIcon.Name = "OpenCloseIcon"
            OpenCloseIcon.Parent = SectionText
            OpenCloseIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OpenCloseIcon.BackgroundTransparency = 1.000
            OpenCloseIcon.Position = UDim2.new(0.95, -18, 0.5, -8)
            OpenCloseIcon.Size = UDim2.new(0, 16, 0, 16)
            OpenCloseIcon.Image = "rbxassetid://3926305904"
            OpenCloseIcon.ImageRectOffset = Vector2.new(44, 404)
            OpenCloseIcon.ImageRectSize = Vector2.new(36, 36)
            OpenCloseIcon.Rotation = isdown and 0 or 180
            
            SectionListLayout.Parent = Section
            SectionListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionListLayout.Padding = UDim.new(0, 8)
            
            SectionPadding.Parent = Section
            SectionPadding.PaddingLeft = UDim.new(0, 5)
            SectionPadding.PaddingRight = UDim.new(0, 5)
            SectionPadding.PaddingTop = UDim.new(0, 36) -- Make room for header
            SectionPadding.PaddingBottom = UDim.new(0, 8)
            
            -- Toggle section functionality
            local function updateSection()
                for _, child in pairs(Section:GetChildren()) do
                    if child.Name ~= "SectionText" and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
                        child.Visible = isdown
                    end
                end
                
                if isdown then
                    Section.ClipsDescendants = false
                    Section.AutomaticSize = Enum.AutomaticSize.Y
                else
                    Section.ClipsDescendants = true
                    Section.Size = UDim2.new(1, 0, 0, 36)
                    Section.AutomaticSize = Enum.AutomaticSize.None
                end
            end
            
            updateSection()
            
            OpenCloseIcon.MouseButton1Click:Connect(function()
                isdown = not isdown
                Tween(OpenCloseIcon, {Rotation = isdown and 0 or 180})
                updateSection()
            end)
            
            Section.ChildAdded:Connect(function(child)
                if child.Name ~= "SectionText" and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
                    child.Visible = isdown
                end
            end)
            
            -- Element creation within section
            SectionLib.createButton = function(text, callback)
                local Button = Instance.new("TextButton")
                local ButtonUICorner = Instance.new("UICorner")
                
                Button.Name = text
                Button.Parent = Section
                Button.BackgroundColor3 = colors.secondary
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(0.95, 0, 0, 32)
                Button.Font = Enum.Font.GothamSemibold
                Button.TextColor3 = colors.text
                Button.TextSize = 14.000
                Button.Text = text
                Button.ClipsDescendants = true
                Button.Visible = isdown
                
                Button.MouseButton1Click:Connect(function()
                    -- Ripple effect
                    local Circle = Instance.new("Frame")
                    Circle.Name = "Circle"
                    Circle.Parent = Button
                    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Circle.BackgroundTransparency = 0.7
                    Circle.ZIndex = 10
                    
                    local CircleCorner = Instance.new("UICorner")
                    CircleCorner.CornerRadius = UDim.new(1, 0)
                    CircleCorner.Parent = Circle
                    
                    local MousePos = game.Players.LocalPlayer:GetMouse()
                    local Size = Button.AbsoluteSize.X
                    
                    Circle.Position = UDim2.new(0, MousePos.X - Button.AbsolutePosition.X, 0, MousePos.Y - Button.AbsolutePosition.Y)
                    Circle.Size = UDim2.new(0, 0, 0, 0)
                    
                    Circle:TweenSize(UDim2.new(0, Size * 2, 0, Size * 2), "Out", "Quart", 0.5, false)
                    Tween(Circle, {BackgroundTransparency = 1}, 0.5)
                    
                    task.spawn(function()
                        task.wait(0.5)
                        Circle:Destroy()
                    end)
                    
                    if callback then
                        callback()
                    end
                end)
                
                ButtonUICorner.CornerRadius = UDim.new(0, 6)
                ButtonUICorner.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = colors.main})
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = colors.secondary})
                end)
                
                return Button
            end
            
            SectionLib.createText = function(text, config)
                config = config or {}
                
                local Text = Instance.new("TextLabel")
                local TextUICorner = Instance.new("UICorner")
                
                Text.Name = "Text"
                Text.Parent = Section
                Text.BackgroundColor3 = colors.secondary
                Text.BorderSizePixel = 0
                Text.Size = UDim2.new(0.95, 0, 0, 32)
                Text.Font = Enum.Font.GothamSemibold
                Text.Text = text
                Text.TextColor3 = config.color or colors.text
                Text.TextSize = config.size or 14.000
                Text.TextXAlignment = config.align or Enum.TextXAlignment.Center
                Text.Visible = isdown
                
                if config.background == false then
                    Text.BackgroundTransparency = 1
                end
                
                TextUICorner.CornerRadius = UDim.new(0, 6)
                TextUICorner.Parent = Text
                
                return Text
            end
            
            -- Create textbox in section
            SectionLib.createTextBox = function(text, placeholder, callback)
                local TextBox = Instance.new("Frame")
                local TextBoxUICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Input = Instance.new("TextBox")
                local InputUICorner = Instance.new("UICorner")
                
                TextBox.Name = text
                TextBox.Parent = Section
                TextBox.BackgroundColor3 = colors.secondary
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(0.95, 0, 0, 60)
                TextBox.Visible = isdown
                
                TextBoxUICorner.CornerRadius = UDim.new(0, 6)
                TextBoxUICorner.Parent = TextBox
                
                Title.Name = "Title"
                Title.Parent = TextBox
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.03, 0, 0, 6)
                Title.Size = UDim2.new(0.97, 0, 0, 18)
                Title.Font = Enum.Font.GothamSemibold
                Title.Text = text
                Title.TextColor3 = colors.text
                Title.TextSize = 14.000
                Title.TextXAlignment = Enum.TextXAlignment.Left
                
                Input.Name = "Input"
                Input.Parent = TextBox
                Input.BackgroundColor3 = colors.main
                Input.BorderSizePixel = 0
                Input.Position = UDim2.new(0.03, 0, 0, 30)
                Input.Size = UDim2.new(0.94, 0, 0, 24)
                Input.Font = Enum.Font.Gotham
                Input.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
                Input.PlaceholderText = placeholder or "Введите текст..."
                Input.Text = ""
                Input.TextColor3 = colors.text
                Input.TextSize = 14.000
                Input.ClearTextOnFocus = false
                
                InputUICorner.CornerRadius = UDim.new(0, 6)
                InputUICorner.Parent = Input
                
                TextBox.MouseEnter:Connect(function()
                    Tween(TextBox, {BackgroundColor3 = colors.main})
                end)
                
                TextBox.MouseLeave:Connect(function()
                    Tween(TextBox, {BackgroundColor3 = colors.secondary})
                end)
                
                if callback then
                    Input.FocusLost:Connect(function(enterPressed)
                        callback(Input.Text, enterPressed)
                    end)
                end
                
                -- TextBox API
                local TextBoxAPI = {}
                
                function TextBoxAPI:GetText()
                    return Input.Text
                end
                
                function TextBoxAPI:SetText(newText)
                    Input.Text = newText or ""
                    if callback then
                        callback(Input.Text, false)
                    end
                end
                
                function TextBoxAPI:ClearText()
                    Input.Text = ""
                    if callback then
                        callback("", false)
                    end
                end
                
                return TextBoxAPI
            end
            
            return SectionLib
        end
        
        -- Create textbox in tab
        TabLib.createTextBox = function(text, placeholder, callback)
            local TextBox = Instance.new("Frame")
            local TextBoxUICorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local Input = Instance.new("TextBox")
            local InputUICorner = Instance.new("UICorner")
            
            TextBox.Name = text
            TextBox.Parent = TabMain
            TextBox.BackgroundColor3 = colors.main
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 0, 60)
            
            TextBoxUICorner.CornerRadius = UDim.new(0, 6)
            TextBoxUICorner.Parent = TextBox
            
            Title.Name = "Title"
            Title.Parent = TextBox
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.02, 0, 0, 6)
            Title.Size = UDim2.new(0.98, 0, 0, 18)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = text
            Title.TextColor3 = colors.text
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            Input.Name = "Input"
            Input.Parent = TextBox
            Input.BackgroundColor3 = colors.secondary
            Input.BorderSizePixel = 0
            Input.Position = UDim2.new(0.02, 0, 0, 30)
            Input.Size = UDim2.new(0.96, 0, 0, 24)
            Input.Font = Enum.Font.Gotham
            Input.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
            Input.PlaceholderText = placeholder or "Введите текст..."
            Input.Text = ""
            Input.TextColor3 = colors.text
            Input.TextSize = 14.000
            Input.ClearTextOnFocus = false
            
            InputUICorner.CornerRadius = UDim.new(0, 6)
            InputUICorner.Parent = Input
            
            TextBox.MouseEnter:Connect(function()
                Tween(TextBox, {BackgroundColor3 = colors.secondary})
            end)
            
            TextBox.MouseLeave:Connect(function()
                Tween(TextBox, {BackgroundColor3 = colors.main})
            end)
            
            if callback then
                Input.FocusLost:Connect(function(enterPressed)
                    callback(Input.Text, enterPressed)
                end)
            end
            
            -- TextBox API
            local TextBoxAPI = {}
            
            function TextBoxAPI:GetText()
                return Input.Text
            end
            
            function TextBoxAPI:SetText(newText)
                Input.Text = newText or ""
                if callback then
                    callback(Input.Text, false)
                end
            end
            
            function TextBoxAPI:ClearText()
                Input.Text = ""
                if callback then
                    callback("", false)
                end
            end
            
            return TextBoxAPI
        end
        
        return TabLib
    end
    
    -- Delete tab function
    WindowLib.deleteTab = function(name)
        if table.find(tabs, name) then
            table.remove(tabs, table.find(tabs, name))
            
            if defualt_tab == name then
                if #tabs > 0 then
                    -- Select the first available tab
                    local nextTab = tabs[1]
                    local nextTabButton = TabList:FindFirstChild(nextTab)
                    
                    if nextTabButton then
                        nextTabButton.BackgroundTransparency = 0.8
                        nextTabButton.Indicator.Visible = true
                        
                        if nextTabButton:FindFirstChild("Icon") then
                            nextTabButton.Icon.ImageColor3 = colors.accent
                        end
                        nextTabButton.Text.TextColor3 = colors.accent
                        
                        TabHolder[nextTab].Visible = true
                        defualt_tab = nextTab
                    end
                else
                    defualt_tab = false
                end
            end
            
            -- Remove tab elements
            local tab = TabHolder:FindFirstChild(name)
            local tabButton = TabList:FindFirstChild(name)
            
            if tab then tab:Destroy() end
            if tabButton then tabButton:Destroy() end
        end
    end
    
    -- Delete window function
    WindowLib.deleteWindow = function()
        MainGui:Destroy()
    end
    
    return WindowLib
end

return lib
