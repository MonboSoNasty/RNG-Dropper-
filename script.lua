--// RNG Dropper Full Script v3.0 - By: EnvyHeadMonbo
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Config
local correctKey = "MV1337" -- CHANGE THIS TO YOUR KEY
local keyLink = "https://discord.gg/8EwSkxPEJV" -- CHANGE THIS

local container = ReplicatedStorage:WaitForChild("rbxts_include")
	:WaitForChild("node_modules")
	:WaitForChild("@rbxts")
	:WaitForChild("remo")
	:WaitForChild("src")
	:WaitForChild("container")

local allDrops = {"Cobblestone","RedSand","Sand","RubyOre","LapisOre","EmeraldOre","Bedrock","Snow","HayBale","Leaf","GrassBlock","Cactus","OakLog","Mushroom","Hellstone"}
local selectedDrops = {}

-- =======================
-- KEY ACCESS UI
-- =======================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RNGDropperKeyUI"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 2
frame.Parent = screenGui
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,10)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Enter Access Key"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Key input box
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0,35)
keyBox.Position = UDim2.new(0.1,0,0,50)
keyBox.PlaceholderText = "Enter key..."
keyBox.ClearTextOnFocus = true
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 16
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.Parent = frame
local keyCorner = Instance.new("UICorner", keyBox)
keyCorner.CornerRadius = UDim.new(0,6)

-- Submit Button
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.5,0,0,35)
submitBtn.Position = UDim2.new(0.25,0,0,95)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 16
submitBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
submitBtn.Parent = frame
local submitCorner = Instance.new("UICorner", submitBtn)
submitCorner.CornerRadius = UDim.new(0,6)

-- Key Link Button
local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.25,0,0,35)
keyBtn.Position = UDim2.new(0.375,0,0,140)
keyBtn.BackgroundColor3 = Color3.fromRGB(72, 72, 255) -- Blue
keyBtn.Text = "Key Link"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.TextColor3 = Color3.fromRGB(255,255,255)
keyBtn.Parent = frame
local keyCornerBtn = Instance.new("UICorner", keyBtn)
keyCornerBtn.CornerRadius = UDim.new(0,6)

keyBtn.MouseButton1Click:Connect(function()
	setclipboard(keyLink)
	keyBtn.Text = "Copied!"
	task.delay(1.5, function()
		keyBtn.Text = "Key Link"
	end)
end)

-- Error Label
local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(1,0,0,20)
errorLabel.Position = UDim2.new(0,0,0.75,0)
errorLabel.BackgroundTransparency = 1
errorLabel.TextColor3 = Color3.fromRGB(255,50,50)
errorLabel.Font = Enum.Font.Gotham
errorLabel.TextSize = 14
errorLabel.Text = ""
errorLabel.TextScaled = false
errorLabel.Parent = frame

-- Function to open RNG Dropper UI
local function openRNGDropper()
	frame:Destroy() -- Remove key UI

	-- =======================
	-- RNG Dropper UI
	-- =======================

	local dropScreenGui = Instance.new("ScreenGui")
	dropScreenGui.Name = "RNGDropperMenu"
	dropScreenGui.Parent = game.CoreGui
	dropScreenGui.ResetOnSpawn = false

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 350, 0, 450)
	mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	mainFrame.BorderSizePixel = 4
	mainFrame.Parent = dropScreenGui
	local frameCorner = Instance.new("UICorner", mainFrame)
	frameCorner.CornerRadius = UDim.new(0,10)

	-- Rainbow border animation
	task.spawn(function()
		while mainFrame.Parent do
			for hue = 0,1,0.002 do
				mainFrame.BorderColor3 = Color3.fromHSV(hue,1,1)
				task.wait(0.01)
			end
		end
	end)

	-- Draggable
	local dragging, dragStart, startPos
	mainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- Title
	local title = Instance.new("TextLabel")
	title.Text = "RNG Dropper Menu"
	title.Size = UDim2.new(1,0,0,40)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 20
	title.Parent = mainFrame

	-- Container for UI elements
	local containerUI = Instance.new("Frame")
	containerUI.Size = UDim2.new(1, -20, 1, -50)
	containerUI.Position = UDim2.new(0,10,0,50)
	containerUI.BackgroundTransparency = 1
	containerUI.Parent = mainFrame

	local layout = Instance.new("UIListLayout", containerUI)
	layout.Padding = UDim.new(0,8)

	-- Select Drops Button
	local selectDropsBtn = Instance.new("TextButton")
	selectDropsBtn.Size = UDim2.new(1,0,0,35)
	selectDropsBtn.Text = "Select Drops"
	selectDropsBtn.Font = Enum.Font.GothamBold
	selectDropsBtn.TextSize = 16
	selectDropsBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	selectDropsBtn.TextColor3 = Color3.fromRGB(255,255,255)
	selectDropsBtn.Parent = containerUI
	local cornerBtn = Instance.new("UICorner", selectDropsBtn)
	cornerBtn.CornerRadius = UDim.new(0,6)

	-- Side panel for drops
	local sidePanel = Instance.new("Frame")
	sidePanel.Size = UDim2.new(0,180,0,#allDrops*30+10)
	sidePanel.Position = UDim2.new(1,5,0,50)
	sidePanel.BackgroundColor3 = Color3.fromRGB(35,35,35)
	sidePanel.Visible = false
	sidePanel.Parent = mainFrame
	local sideCorner = Instance.new("UICorner", sidePanel)
	sideCorner.CornerRadius = UDim.new(0,6)

	-- Drop checkboxes
	for i, dropName in ipairs(allDrops) do
		local dropFrame = Instance.new("Frame")
		dropFrame.Size = UDim2.new(1,-10,0,25)
		dropFrame.Position = UDim2.new(0,5,0,(i-1)*30+5)
		dropFrame.BackgroundTransparency = 1
		dropFrame.Parent = sidePanel

		local dropLabel = Instance.new("TextLabel")
		dropLabel.Text = dropName
		dropLabel.Size = UDim2.new(0.65,0,1,0)
		dropLabel.BackgroundTransparency = 1
		dropLabel.TextColor3 = Color3.fromRGB(255,255,255)
		dropLabel.Font = Enum.Font.Gotham
		dropLabel.TextSize = 14
		dropLabel.TextXAlignment = Enum.TextXAlignment.Left
		dropLabel.Parent = dropFrame

		local checkbox = Instance.new("TextButton")
		checkbox.Size = UDim2.new(0.3,0,0.8,0)
		checkbox.Position = UDim2.new(0.65,0,0.1,0)
		checkbox.BackgroundColor3 = Color3.fromRGB(120,0,0)
		checkbox.Text = "OFF"
		checkbox.TextColor3 = Color3.fromRGB(255,255,255)
		checkbox.Font = Enum.Font.GothamBold
		checkbox.TextSize = 12
		checkbox.Parent = dropFrame
		local boxCorner = Instance.new("UICorner", checkbox)
		boxCorner.CornerRadius = UDim.new(0,4)

		checkbox.MouseButton1Click:Connect(function()
			if selectedDrops[dropName] then
				selectedDrops[dropName] = nil
				checkbox.Text = "OFF"
				checkbox.BackgroundColor3 = Color3.fromRGB(120,0,0)
			else
				selectedDrops[dropName] = true
				checkbox.Text = "ON"
				checkbox.BackgroundColor3 = Color3.fromRGB(0,120,0)
			end
		end)
	end

	-- Toggle side panel
	selectDropsBtn.MouseButton1Click:Connect(function()
		sidePanel.Visible = not sidePanel.Visible
	end)

	-- Drop amount input
	local amountBox = Instance.new("TextBox")
	amountBox.Size = UDim2.new(1,0,0,30)
	amountBox.PlaceholderText = "Enter amount for selected drops"
	amountBox.Text = ""
	amountBox.Font = Enum.Font.Gotham
	amountBox.TextSize = 14
	amountBox.ClearTextOnFocus = false
	amountBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
	amountBox.TextColor3 = Color3.fromRGB(255,255,255)
	amountBox.Parent = containerUI
	local amountCorner = Instance.new("UICorner", amountBox)
	amountCorner.CornerRadius = UDim.new(0,6)

	-- Fire Selected Drops Button
	local fireBtn = Instance.new("TextButton")
	fireBtn.Size = UDim2.new(1,0,0,35)
	fireBtn.Text = "Fire Selected Drops"
	fireBtn.Font = Enum.Font.GothamBold
	fireBtn.TextSize = 16
	fireBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
	fireBtn.TextColor3 = Color3.fromRGB(255,255,255)
	fireBtn.Parent = containerUI
	local fireCorner = Instance.new("UICorner", fireBtn)
	fireCorner.CornerRadius = UDim.new(0,6)

	fireBtn.MouseButton1Click:Connect(function()
		local num = tonumber(amountBox.Text)
		if not num then return end
		local argsTable = {}
		for drop,_ in pairs(selectedDrops) do
			argsTable[drop] = num
		end
		if next(argsTable) then
			local args = {argsTable}
			container["collect.drops"]:FireServer(unpack(args))
		end
	end)

	-- Diamonds input
	local diamondsBox = Instance.new("TextBox")
	diamondsBox.Size = UDim2.new(1,0,0,30)
	diamondsBox.PlaceholderText = "Diamonds amount"
	diamondsBox.Text = ""
	diamondsBox.Font = Enum.Font.Gotham
	diamondsBox.TextSize = 14
	diamondsBox.ClearTextOnFocus = false
	diamondsBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
	diamondsBox.TextColor3 = Color3.fromRGB(255,255,255)
	diamondsBox.Parent = containerUI
	local diamondsCorner = Instance.new("UICorner", diamondsBox)
	diamondsCorner.CornerRadius = UDim.new(0,6)

	local diamondsFire = Instance.new("TextButton")
	diamondsFire.Size = UDim2.new(1,0,0,35)
	diamondsFire.Text = "Fire Diamonds"
	diamondsFire.Font = Enum.Font.GothamBold
	diamondsFire.TextSize = 16
	diamondsFire.BackgroundColor3 = Color3.fromRGB(255,165,0)
	diamondsFire.TextColor3 = Color3.fromRGB(255,255,255)
	diamondsFire.Parent = containerUI
	local diamondsCornerBtn = Instance.new("UICorner", diamondsFire)
	diamondsCornerBtn.CornerRadius = UDim.new(0,6)

	diamondsFire.MouseButton1Click:Connect(function()
		local num = tonumber(diamondsBox.Text)
		if num then
			container["collect.diamonds"]:FireServer(num)
		end
	end)

	-- Rebirth toggle
	local rebirthRunning = false
	local rebirthBtn = Instance.new("TextButton")
	rebirthBtn.Size = UDim2.new(1,0,0,35)
	rebirthBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
	rebirthBtn.Text = "Rebirth: OFF"
	rebirthBtn.TextColor3 = Color3.fromRGB(255,255,255)
	rebirthBtn.Font = Enum.Font.GothamBold
	rebirthBtn.TextSize = 16
	rebirthBtn.Parent = containerUI
	local rcorner = Instance.new("UICorner", rebirthBtn)
	rcorner.CornerRadius = UDim.new(0,6)

	rebirthBtn.MouseButton1Click:Connect(function()
		rebirthRunning = not rebirthRunning
		rebirthBtn.Text = "Rebirth: "..(rebirthRunning and "ON" or "OFF")
		rebirthBtn.BackgroundColor3 = rebirthRunning and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
		if rebirthRunning then
			task.spawn(function()
				while rebirthRunning do
					container["rebirth"]:InvokeServer()
					task.wait(1)
				end
			end)
		end
	end)

	-- Footer
	local footer = Instance.new("TextLabel")
	footer.Text = "By: EnvyHeadMonbo"
	footer.Size = UDim2.new(1,0,0,20)
	footer.Position = UDim2.new(0,0,1,-20)
	footer.BackgroundTransparency = 1
	footer.TextColor3 = Color3.fromRGB(200,200,200)
	footer.Font = Enum.Font.Gotham
	footer.TextSize = 12
	footer.Parent = mainFrame

	-- Toggle main UI visibility (RightShift)
	local visible = true
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.RightShift then
			visible = not visible
			mainFrame.Visible = visible
		end
	end)
end

-- Submit Key
submitBtn.MouseButton1Click:Connect(function()
	local enteredKey = keyBox.Text
	if enteredKey == correctKey then
		openRNGDropper()
	else
		errorLabel.Text = "Wrong key!"
	end
end)
