--// RNG Dropper Menu v2.1 - By: EnvyHeadMonbo
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local container = ReplicatedStorage:WaitForChild("rbxts_include")
	:WaitForChild("node_modules")
	:WaitForChild("@rbxts")
	:WaitForChild("remo")
	:WaitForChild("src")
	:WaitForChild("container")

local allDrops = {"Cobblestone","RedSand","Sand","RubyOre","LapisOre","EmeraldOre","Bedrock","Snow","HayBale","Leaf","GrassBlock","Cactus","OakLog","Mushroom","Hellstone"}
local selectedDrops = {}

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RNGDropperMenu"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 4
frame.Parent = screenGui
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0,10)

-- Rainbow border animation (fixed)
task.spawn(function()
	while frame.Parent do
		for hue = 0, 1, 0.002 do
			frame.BorderColor3 = Color3.fromHSV(hue,1,1)
			task.wait(0.01)
		end
	end
end)

-- Draggable
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
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
title.Parent = frame

-- Container for UI elements
local containerUI = Instance.new("Frame")
containerUI.Size = UDim2.new(1, -20, 1, -50)
containerUI.Position = UDim2.new(0,10,0,50)
containerUI.BackgroundTransparency = 1
containerUI.Parent = frame

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

-- Side panel
local sidePanel = Instance.new("Frame")
sidePanel.Size = UDim2.new(0,180,0,#allDrops*30+10)
sidePanel.Position = UDim2.new(1,5,0,50)
sidePanel.BackgroundColor3 = Color3.fromRGB(35,35,35)
sidePanel.Visible = false
sidePanel.Parent = frame
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

-- Drop amount input (blank text)
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

-- Diamonds input (blank text)
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
footer.Parent = frame

-- Toggle main UI visibility (RightShift)
local visible = true
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightShift then
		visible = not visible
		frame.Visible = visible
	end
end)
