local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "ArchivistX_LavaFusion"
screenGui.ResetOnSpawn = false

-- Main Frame (Container)
local container = Instance.new("Frame", screenGui)
container.Size = UDim2.new(0, 300, 0, 400)
container.Position = UDim2.new(0, 20, 0.5, -200)
container.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
container.BorderSizePixel = 0
container.Active = true
container.Draggable = true
container.ClipsDescendants = true

-- Effect: Haze
local haze = Instance.new("Frame", container)
haze.Size = UDim2.new(1, 0, 1, 0)
haze.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
haze.BackgroundTransparency = 0.9
haze.BorderSizePixel = 0
haze.ZIndex = 1

task.spawn(function()
	while true do
		TweenService:Create(haze, TweenInfo.new(2), {BackgroundTransparency = 0.95}):Play()
		wait(2)
		TweenService:Create(haze, TweenInfo.new(2), {BackgroundTransparency = 0.9}):Play()
		wait(2)
	end
end)

-- Label: AMA_ZERO
local amaLabel = Instance.new("TextLabel", container)
amaLabel.Size = UDim2.new(0, 200, 0, 50)
amaLabel.Position = UDim2.new(0.5, -100, 0, -5)
amaLabel.BackgroundTransparency = 1
amaLabel.Text = "AMA_ZERO"
amaLabel.TextScaled = true
amaLabel.Font = Enum.Font.GothamBold
amaLabel.TextColor3 = Color3.new(0, 0, 1)
amaLabel.TextStrokeTransparency = 0
amaLabel.TextTransparency = 1
amaLabel.ZIndex = 5

local gradient = Instance.new("UIGradient", amaLabel)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 80))
}

-- Effects Toggle State
local visualEffectsEnabled = true
local crackFolder = Instance.new("Folder", container)
crackFolder.Name = "CrackFolder"
local pulseCount = 0
local maxCracks = 10

-- Function: Create Dripping Lava
local function createDrip()
	if not visualEffectsEnabled then return end
	local drip = Instance.new("Frame", container)
	drip.Size = UDim2.new(0, math.random(3, 6), 0, math.random(10, 25))
	drip.Position = UDim2.new(math.random(), 0, 0, -10)
	drip.BackgroundColor3 = Color3.fromRGB(255, 60, 0)
	drip.BorderSizePixel = 0
	drip.ZIndex = 3

	local tween = TweenService:Create(drip, TweenInfo.new(1), {
		Position = UDim2.new(drip.Position.X.Scale, 0, 1, 10),
		BackgroundTransparency = 1
	})
	tween:Play()
	tween.Completed:Connect(function() drip:Destroy() end)
end

-- Drip Loop
task.spawn(function()
	while true do
		if visualEffectsEnabled then createDrip() end
		wait(0.2)
	end
end)

-- Eruption Function
local function eruption()
	if not visualEffectsEnabled then return end
	local burst = Instance.new("Frame", container)
	burst.Size = UDim2.new(0, math.random(50, 120), 0, math.random(20, 60))
	burst.Position = UDim2.new(math.random(), 0, math.random(), 0)
	burst.AnchorPoint = Vector2.new(0.5, 0.5)
	burst.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
	burst.BorderSizePixel = 0
	burst.BackgroundTransparency = 0.2
	burst.Rotation = math.random(-15, 15)
	burst.ZIndex = 3

	TweenService:Create(burst, TweenInfo.new(0.5), {
		Size = burst.Size + UDim2.new(0, 40, 0, 20),
		BackgroundTransparency = 1
	}):Play()
	game.Debris:AddItem(burst, 0.6)
end

task.spawn(function()
	while true do
		wait(math.random(2, 5))
		if visualEffectsEnabled then eruption() end
	end
end)

-- Heat Shimmer
local shimmerTextures = {
	"rbxassetid://5553946655", "rbxassetid://495054302", "rbxassetid://6880522830"
}
for i = 1, 3 do
	local shimmer = Instance.new("ImageLabel", container)
	shimmer.Image = shimmerTextures[math.random(1, #shimmerTextures)]
	shimmer.BackgroundTransparency = 1
	shimmer.Size = UDim2.new(1, 0, 0, 20)
	shimmer.Position = UDim2.new(0, 0, 1, -20)
	shimmer.ImageTransparency = 0.85
	shimmer.ZIndex = 2

	task.spawn(function()
		while true do
			if not visualEffectsEnabled then shimmer.Visible = false wait(1) continue end
			shimmer.Visible = true
			shimmer.Position = UDim2.new(0, 0, 1, -20)
			TweenService:Create(shimmer, TweenInfo.new(3), {
				Position = UDim2.new(0, 0, 0, -math.random(60, 120)),
				ImageTransparency = 1
			}):Play()
			wait(3)
			shimmer.ImageTransparency = 0.85
		end
	end)
end
local function createCrack()
	if not visualEffectsEnabled then return end
	local crack = Instance.new("Frame", crackFolder)
	crack.Size = UDim2.new(0, math.random(40, 80), 0, math.random(2, 4))
	crack.Position = UDim2.new(math.random(), -40, math.random(), 0)
	crack.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
	crack.BackgroundTransparency = 0.5
	crack.BorderSizePixel = 0
	crack.Rotation = math.random(-30, 30)
	crack.ZIndex = 2

	local glow = Instance.new("UIGradient", crack)
	glow.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 0))
	}
	glow.Rotation = math.random(0, 360)

	TweenService:Create(crack, TweenInfo.new(2), {
		BackgroundTransparency = 1
	}):Play()
	game.Debris:AddItem(crack, 2)
end

-- Crack loop
task.spawn(function()
	while true do
		wait(1)
		if visualEffectsEnabled then
			createCrack()
		end
	end
end)

-- Pulse & Sigils
local sigilAssets = {
	"rbxassetid://616832947", "rbxassetid://531768862", "rbxassetid://10780761641"
}
task.spawn(function()
	while true do
		wait(10)
		if not visualEffectsEnabled then continue end

		amaLabel.TextTransparency = 0
		amaLabel.Rotation = 0
		gradient.Rotation = 0

		local origSize = container.Size
		TweenService:Create(container, TweenInfo.new(0.2, Enum.EasingStyle.Elastic), {
			Size = origSize + UDim2.new(0, 20, 0, 20),
			Rotation = math.random(-10, 10)
		}):Play()

		wait(0.3)
		TweenService:Create(container, TweenInfo.new(0.2), {
			Size = origSize,
			Rotation = 0
		}):Play()

		for i = 1, 10 do
			amaLabel.Rotation = math.random(-5, 5)
			gradient.Rotation += math.random(-10, 10)
			wait(0.05)
		end

		for i = 1, 3 do
			local sigil = Instance.new("ImageLabel", container)
			sigil.Size = UDim2.new(0, 60, 0, 60)
			sigil.Position = UDim2.new(0.5, math.random(-80, 80), 0.5, math.random(-60, 60))
			sigil.AnchorPoint = Vector2.new(0.5, 0.5)
			sigil.Image = sigilAssets[math.random(1, #sigilAssets)]
			sigil.BackgroundTransparency = 1
			sigil.ImageTransparency = 0.6
			sigil.Rotation = math.random(0, 360)
			sigil.ZIndex = 4

			local sigilTween = TweenService:Create(sigil, TweenInfo.new(1), {
				Rotation = sigil.Rotation + math.random(-30, 30),
				ImageTransparency = 1
			})
			sigilTween:Play()
			sigilTween.Completed:Connect(function() sigil:Destroy() end)
		end

		amaLabel.TextTransparency = 1
	end
end)

-- Minimize Button
local minimized = false
local button = Instance.new("TextButton", container)
button.Size = UDim2.new(0, 40, 0, 20)
button.Position = UDim2.new(1, -45, 0, 5)
button.Text = "-"
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.BorderSizePixel = 0
button.ZIndex = 6

button.MouseButton1Click:Connect(function()
	minimized = not minimized
	visualEffectsEnabled = not minimized

	if minimized then
		container:TweenSize(UDim2.new(0, 80, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	else
		container:TweenSize(UDim2.new(0, 300, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	end
end)

-- Button Loader UI (ArchivistX_SWIFT)
local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 30)
title.Text = "Archivist X — SWIFT Loader"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.ZIndex = 5

local list = Instance.new("ScrollingFrame", container)
list.Size = UDim2.new(1, 0, 1, -60)
list.Position = UDim2.new(0, 0, 0, 60)
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarThickness = 6
list.BackgroundTransparency = 1
list.ZIndex = 5

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

list.ChildAdded:Connect(function()
	task.wait()
	list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- Utility: Create Script Button
local function createScriptButton(name, scriptUrl, optionalParam)
	local button = Instance.new("TextButton", list)
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = UDim2.new(0, 5, 0, 0)
button.BackgroundTransparency = 1
local bg = Instance.new("Frame", button)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundTransparency = 0
bg.BorderSizePixel = 0
bg.ZIndex = button.ZIndex - 1

local grad = Instance.new("UIGradient", bg)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 60, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 140, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 60, 0))
}
grad.Rotation = math.random(0, 360)

-- Animate gradient rotation
task.spawn(function()
	while true do
		grad.Rotation = (grad.Rotation + 1) % 360
		wait(0.05)
	end
end)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.Text = name
	button.ZIndex = 5

	button.MouseButton1Click:Connect(function()
		local success, result = pcall(function()
			return game:HttpGet(scriptUrl, true)
		end)
		if success then
			local exec, err = pcall(function()
				if optionalParam then
					loadstring(result)(optionalParam)
				else
					loadstring(result)()
				end
			end)
			if not exec then
				warn("Execution failed for: " .. name .. " — " .. tostring(err))
			end
		else
			warn("Failed to fetch: " .. name)
		end
	end)
end

-- Define Script Buttons
createScriptButton("Redhub", "https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau", _G.Settings or {})
createScriptButton("Hohohub", "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI")
createScriptButton("Zenith Hub", "https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader")

