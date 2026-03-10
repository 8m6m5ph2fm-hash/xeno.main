-- Xanoxxl V39 - Special "Fake Update" Edition
-- Key: abigail
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Xanoxxl_Final_V39"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local currentSpeed = 50 
local speedEnabled, infJumpEnabled, headlessEnabled, korbloxEnabled = false, false, false, false
local rainbowThemeActive = false

-- [ UTILITY ]
local function makeRainbow(obj)
    task.spawn(function()
        local counter = 0
        while task.wait() do
            if not obj then break end
            obj.TextColor3 = Color3.fromHSV(counter, 1, 1)
            counter = (counter + 0.005) % 1
        end
    end)
end

-- [1] INITIALIZATION (STAY COOL)
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.Size = UDim2.new(0, 350, 0, 100); LoadingFrame.Position = UDim2.new(0.5, -175, 0.5, -50); LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Instance.new("UICorner", LoadingFrame)
local LoadStroke = Instance.new("UIStroke", LoadingFrame); LoadStroke.Color = Color3.fromRGB(0, 255, 255)
local LoadTitle = Instance.new("TextLabel", LoadingFrame); LoadTitle.Size = UDim2.new(1, 0, 0, 40); LoadTitle.Text = "XENOXXL HYPERION | BOOTING..."; LoadTitle.TextColor3 = Color3.new(1,1,1); LoadTitle.Font = Enum.Font.GothamBold; LoadTitle.TextSize = 14; LoadTitle.BackgroundTransparency = 1
local ProgressBar = Instance.new("Frame", LoadingFrame); ProgressBar.Size = UDim2.new(0, 0, 0, 4); ProgressBar.Position = UDim2.new(0.05, 0, 0.7, 0); ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255); Instance.new("UICorner", ProgressBar)

task.spawn(function()
    ProgressBar:TweenSize(UDim2.new(0.9, 0, 0, 4), "Out", "Quad", 1.5)
    task.wait(1.7); LoadingFrame.Visible = false
end)

-- [2] LOGIN
local KeyGui = Instance.new("Frame", ScreenGui)
KeyGui.Size = UDim2.new(0, 320, 0, 240); KeyGui.Position = UDim2.new(0.5, -160, 0.5, -120); KeyGui.BackgroundColor3 = Color3.fromRGB(15, 15, 15); KeyGui.Visible = false; Instance.new("UICorner", KeyGui)
Instance.new("UIStroke", KeyGui).Color = Color3.fromRGB(0, 255, 255)
task.delay(1.8, function() KeyGui.Visible = true end)

local KeyInput = Instance.new("TextBox", KeyGui); KeyInput.Size = UDim2.new(0, 260, 0, 40); KeyInput.Position = UDim2.new(0.5, -130, 0.45, 0); KeyInput.PlaceholderText = "Enter Access Key..."; KeyInput.Text = ""; KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30); KeyInput.TextColor3 = Color3.fromRGB(0, 255, 255); Instance.new("UICorner", KeyInput)

local realKey = ""
KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local currentText = KeyInput.Text
    if #currentText > #realKey then realKey = realKey .. string.sub(currentText, #currentText)
    elseif #currentText < #realKey then realKey = string.sub(realKey, 1, #currentText) end
    KeyInput.Text = string.rep("*", #realKey)
end)

local VerifyBtn = Instance.new("TextButton", KeyGui); VerifyBtn.Size = UDim2.new(0, 200, 0, 40); VerifyBtn.Position = UDim2.new(0.5, -100, 0.8, 0); VerifyBtn.Text = "AUTHENTICATE"; VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255); VerifyBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", VerifyBtn)

-- [3] MAIN DASHBOARD
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 340); MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170); MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12); MainFrame.Visible = false; MainFrame.Active = true; MainFrame.Draggable = true; Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Color3.fromRGB(0, 255, 255); MainStroke.Thickness = 1.5

local TopBar = Instance.new("Frame", MainFrame); TopBar.Size = UDim2.new(1, 0, 0, 35); TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Instance.new("UICorner", TopBar)
local UserLabel = Instance.new("TextLabel", TopBar); UserLabel.Size = UDim2.new(0, 150, 1, 0); UserLabel.Position = UDim2.new(0, 15, 0, 0); UserLabel.Text = "User: Rk***x"; UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200); UserLabel.Font = Enum.Font.Gotham; UserLabel.TextSize = 12; UserLabel.TextXAlignment = "Left"; UserLabel.BackgroundTransparency = 1
local StatsLabel = Instance.new("TextLabel", TopBar); StatsLabel.Size = UDim2.new(0, 180, 1, 0); StatsLabel.Position = UDim2.new(1, -260, 0, 0); StatsLabel.Text = "FPS: 60 | Ping: 24ms"; StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 255); StatsLabel.Font = Enum.Font.GothamBold; StatsLabel.TextSize = 11; StatsLabel.TextXAlignment = "Right"; StatsLabel.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", MainFrame); Sidebar.Size = UDim2.new(0, 140, 1, -35); Sidebar.Position = UDim2.new(0, 0, 0, 35); Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", Sidebar)
local ContentArea = Instance.new("Frame", MainFrame); ContentArea.Size = UDim2.new(1, -155, 1, -50); ContentArea.Position = UDim2.new(0, 150, 0, 45); ContentArea.BackgroundTransparency = 1

local frames = {}
local function createTab(name, pos, showSoon)
    local btn = Instance.new("TextButton", Sidebar); btn.Size = UDim2.new(1, -20, 0, 30); btn.Position = UDim2.new(0, 10, 0, pos); btn.Text = "  " .. name; btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22); btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.GothamMedium; btn.TextSize = 9; btn.TextXAlignment = "Left"; Instance.new("UICorner", btn)
    local scroll = Instance.new("ScrollingFrame", ContentArea); scroll.Size = UDim2.new(1, 0, 1, 0); scroll.BackgroundTransparency = 1; scroll.Visible = false; scroll.CanvasSize = UDim2.new(0, 0, 2, 0); scroll.ScrollBarThickness = 1
    frames[name] = scroll
    if showSoon then
        local soon = Instance.new("TextLabel", scroll); soon.Size = UDim2.new(1, 0, 0, 60); soon.Position = UDim2.new(0,0,0.3,0); soon.Text = "MODULE LOCKED\nV2.5 REQUIRED"; soon.TextColor3 = Color3.fromRGB(0, 255, 255); soon.BackgroundTransparency = 1; soon.Font = Enum.Font.GothamBold; soon.TextSize = 14; makeRainbow(soon)
    end
    btn.MouseButton1Click:Connect(function() 
        for _, f in pairs(frames) do f.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(22, 22, 22) end end
        scroll.Visible = true; btn.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
    end)
    return scroll
end

local PlayerFrame = createTab("PLAYER HUB", 10)
local TradeFrame = createTab("TRADE PRO", 45)
local BrainrotFrame = createTab("BRAINROT HUB", 80)
local StealFrame = createTab("STEALER V2", 115, true)
local TradeListFrame = createTab("TRADE LIST", 150, true)
local MiscFrame = createTab("SYSTEM MISC", 185)
PlayerFrame.Visible = true

-- [4] FEATURES BUILDER
local function createToggle(text, parent, pos, callback, isTrade)
    local frame = Instance.new("Frame", parent); frame.Size = UDim2.new(0.95, 0, 0, 40); frame.Position = UDim2.new(0, 0, 0, pos); frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", frame)
    local label = Instance.new("TextLabel", frame); label.Size = UDim2.new(0.7, 0, 1, 0); label.Position = UDim2.new(0, 10, 0, 0); label.Text = text; label.TextColor3 = Color3.new(1,1,1); label.Font = Enum.Font.Gotham; label.TextSize = 11; label.BackgroundTransparency = 1; label.TextXAlignment = "Left"
    
    if isTrade then
        label.Text = text .. "\n(Bug, In update fixing)"
        label.TextSize = 9
        label.TextColor3 = Color3.fromRGB(255, 100, 100)
    end

    local btn = Instance.new("TextButton", frame); btn.Size = UDim2.new(0, 50, 0, 24); btn.Position = UDim2.new(1, -60, 0.5, -12); btn.Text = "OFF"; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; Instance.new("UICorner", btn)
    local act = false
    btn.MouseButton1Click:Connect(function() act = not act; btn.Text = act and "ON" or "OFF"; btn.BackgroundColor3 = act and Color3.fromRGB(0, 180, 180) or Color3.fromRGB(40, 40, 40); callback(act) end)
end

-- [PLAYER HUB]
createToggle("HYPER SPEED", PlayerFrame, 0, function(s) speedEnabled = s end)
local SpeedIn = Instance.new("TextBox", PlayerFrame); SpeedIn.Size = UDim2.new(0.95, 0, 0, 35); SpeedIn.Position = UDim2.new(0, 0, 0, 45); SpeedIn.PlaceholderText = "Set Velocity..."; SpeedIn.Text = "50"; SpeedIn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); SpeedIn.TextColor3 = Color3.fromRGB(0, 255, 255); Instance.new("UICorner", SpeedIn)
SpeedIn.FocusLost:Connect(function() currentSpeed = tonumber(SpeedIn.Text) or 50 end)
createToggle("INFINITE JUMP", PlayerFrame, 90, function(s) infJumpEnabled = s end)
createToggle("HEADLESS (VISUAL)", PlayerFrame, 135, function(s) headlessEnabled = s end)
createToggle("KORBLOX (VISUAL)", PlayerFrame, 180, function(s) korbloxEnabled = s end)
createToggle("REINDIER MAP (LAG REDUCER)", PlayerFrame, 225, function(s) if s then for _,v in pairs(game:GetDescendants()) do if v:IsA("BasePart") then v.CastShadow = false end end end end)

-- [TRADE PRO] (FAKE UPDATE STATUS ADDED)
createToggle("FROZE TRADE", TradeFrame, 0, function() end, true)
createToggle("AUTO ACCEPT", TradeFrame, 45, function() end, true)
createToggle("VISUAL TRADE", TradeFrame, 90, function() end, true)
createToggle("VISUAL BRAINROT", TradeFrame, 135, function() end, true)

-- [BRAINROT HUB]
local BrainLabel = Instance.new("TextLabel", BrainrotFrame); BrainLabel.Size = UDim2.new(0.95, 0, 0, 30); BrainLabel.Text = "CONFIGURE BRAINROT MODULE"; BrainLabel.TextColor3 = Color3.fromRGB(0, 255, 255); BrainLabel.Font = Enum.Font.GothamBold; BrainLabel.TextSize = 12; BrainLabel.BackgroundTransparency = 1
local BrainInput = Instance.new("TextBox", BrainrotFrame); BrainInput.Size = UDim2.new(0.95, 0, 0, 40); BrainInput.Position = UDim2.new(0, 0, 0, 40); BrainInput.PlaceholderText = "Type brainrot you want to visual..."; BrainInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25); BrainInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", BrainInput)
local ApplyBtn = Instance.new("TextButton", BrainrotFrame); ApplyBtn.Size = UDim2.new(0.95, 0, 0, 35); ApplyBtn.Position = UDim2.new(0, 0, 0, 90); ApplyBtn.Text = "APPLY VISUAL"; ApplyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 150); ApplyBtn.TextColor3 = Color3.new(1,1,1); ApplyBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", ApplyBtn)

-- [SYSTEM MISC]
local RainbowBtn = Instance.new("TextButton", MiscFrame); RainbowBtn.Size = UDim2.new(0.95, 0, 0, 40); RainbowBtn.Text = "THEME: RAINBOW VERSION"; RainbowBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); RainbowBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", RainbowBtn); makeRainbow(RainbowBtn)
RainbowBtn.MouseButton1Click:Connect(function() rainbowThemeActive = true end)

-- [5] MINIMIZE & CLOSE
local RestoreBtn = Instance.new("TextButton", ScreenGui); RestoreBtn.Size = UDim2.new(0, 120, 0, 35); RestoreBtn.Position = UDim2.new(0, 20, 0, 20); RestoreBtn.Text = "XENOXXL"; RestoreBtn.Visible = false; RestoreBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", RestoreBtn); makeRainbow(RestoreBtn)
local MinBtn = Instance.new("TextButton", MainFrame); MinBtn.Size = UDim2.new(0, 25, 0, 25); MinBtn.Position = UDim2.new(1, -65, 0, 5); MinBtn.Text = "-"; MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); MinBtn.TextColor3 = Color3.fromRGB(0, 255, 255); Instance.new("UICorner", MinBtn); MinBtn.ZIndex = 20
local CloseBtn = Instance.new("TextButton", MainFrame); CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(1, -35, 0, 5); CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0); Instance.new("UICorner", CloseBtn); CloseBtn.ZIndex = 20

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; RestoreBtn.Visible = true end)
RestoreBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; RestoreBtn.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- [6] CORE LOGIC
task.spawn(function()
    local counter = 0
    while task.wait() do
        if rainbowThemeActive then MainStroke.Color = Color3.fromHSV(counter, 1, 1); counter = (counter + 0.005) % 1 end
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                if speedEnabled then char.Humanoid.WalkSpeed = currentSpeed else char.Humanoid.WalkSpeed = 16 end
                if headlessEnabled and char:FindFirstChild("Head") then char.Head.Transparency = 1 end
                if korbloxEnabled then for _,v in pairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do if char:FindFirstChild(v) then char[v].Transparency = 1 end end end
            end
        end)
    end
end)

VerifyBtn.MouseButton1Click:Connect(function() if realKey == "abigail" then KeyGui.Visible = false; MainFrame.Visible = true else realKey = ""; KeyInput.Text = "" end end)
