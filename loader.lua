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
local maxCracks = 5
local pulseCracks = {}
-- === GLOWING CRACK BUILDUP SYSTEM ===
local function spawnPersistentCrack()
	if pulseCount >= maxCracks or not visualEffectsEnabled then return end

	local crack = Instance.new("Frame", crackFolder)
	crack.Size = UDim2.new(0, math.random(40, 80), 0, math.random(2, 4))
	crack.Position = UDim2.new(math.random(), -40, math.random(), 0)
	crack.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	crack.BackgroundTransparency = 0.2
	crack.BorderSizePixel = 0
	crack.Rotation = math.random(-25, 25)
	crack.ZIndex = 2

	table.insert(pulseCracks, crack)
	pulseCount += 1
end

-- Crack buildup loop (One-time setup, then infinite shimmer)
task.spawn(function()
	while pulseCount < maxCracks do
		wait(1.5)
		if visualEffectsEnabled then spawnPersistentCrack() end
	end

	-- Begin glowing effect once 5 cracks are present
	for _, crack in ipairs(pulseCracks) do
		task.spawn(function()
			while true do
				if not visualEffectsEnabled then crack.Visible = false wait(1) continue end
				crack.Visible = true
				local flicker = Color3.fromRGB(255, math.random(40, 80), 0)
				TweenService:Create(crack, TweenInfo.new(0.4), {
					BackgroundColor3 = flicker,
					BackgroundTransparency = 0.1 + math.random() * 0.3
				}):Play()
				wait(0.6)
			end
		end)
	end
end)


-- Function: Create Dripping Lava
local function createDrip()
@@ -285,96 +326,130 @@

	if minimized then
		container:TweenSize(UDim2.new(0, 80, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

		-- Fade & destroy existing cracks
		for _, crack in ipairs(pulseCracks) do
			if crack and crack:IsA("Frame") then
				TweenService:Create(crack, TweenInfo.new(0.5), {
					BackgroundTransparency = 1
				}):Play()
				game.Debris:AddItem(crack, 0.6)
			end
		end
		table.clear(pulseCracks)
		pulseCount = 0
	else
		container:TweenSize(UDim2.new(0, 300, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

		-- Restart crack buildup loop
		task.spawn(function()
			while pulseCount < maxCracks do
				wait(1.5)
				if visualEffectsEnabled then spawnPersistentCrack() end
			end

			-- Glow again
			for _, crack in ipairs(pulseCracks) do
				task.spawn(function()
					while visualEffectsEnabled do
						local flicker = Color3.fromRGB(255, math.random(40, 80), 0)
						TweenService:Create(crack, TweenInfo.new(0.4), {
							BackgroundColor3 = flicker,
							BackgroundTransparency = 0.1 + math.random() * 0.3
						}):Play()
						wait(0.6)
					end
				end)
			end
		end)
	end
end)

-- Button Loader UI (ArchivistX_SWIFT)
local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 30)
title.Text = "Ama_Zero's — SWIFT Loader"
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

