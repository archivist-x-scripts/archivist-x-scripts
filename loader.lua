-- 🔥 ArchivistX_SWIFT with Volcanic UI Theme
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ArchivistX_LavaFusion"
gui.ResetOnSpawn = false

-- 🔲 Container with lava theme
local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 300, 0, 400)
container.Position = UDim2.new(0, 20, 0.5, -200)
container.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
container.BorderSizePixel = 0
container.Active = true
container.Draggable = true
container.ClipsDescendants = true

-- 💧 Dripping Lava Effect
local function createDrip()
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

task.spawn(function()
	while true do
		createDrip()
		wait(0.2)
	end
end)

-- 🔥 Ambient Lava Glow
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

-- 🔘 Title
local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Archivist X — SWIFT Loader"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.ZIndex = 5

-- 📜 Script Button Panel
local List = Instance.new("ScrollingFrame", container)
List.Size = UDim2.new(1, 0, 1, -30)
List.Position = UDim2.new(0, 0, 0, 30)
List.CanvasSize = UDim2.new(0, 0, 0, 0)
List.ScrollBarThickness = 6
List.BackgroundTransparency = 1
List.ZIndex = 5
-- 🔣 Hieroglyph display label
local glyphLabel = Instance.new("TextLabel", container)
glyphLabel.Size = UDim2.new(1, 0, 0, 40)
glyphLabel.Position = UDim2.new(0, 0, 0, -10)
glyphLabel.BackgroundTransparency = 1
glyphLabel.TextColor3 = Color3.fromRGB(255, 80, 10)
glyphLabel.Font = Enum.Font.Code
glyphLabel.TextSize = 28
glyphLabel.ZIndex = 10
glyphLabel.TextStrokeTransparency = 0.3
glyphLabel.TextStrokeColor3 = Color3.fromRGB(255, 30, 10)
glyphLabel.TextTransparency = 1
glyphLabel.Text = "𐌰𐌼𐌀_𐌶𐌴𐍂𐍉"

local Layout = Instance.new("UIListLayout", List)
Layout.Padding = UDim.new(0, 4)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

List.ChildAdded:Connect(function()
	task.wait()
	List.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- 📎 Script Button Generator
local function createScriptButton(name, scriptUrl, optionalParam)
	local button = Instance.new("TextButton", List)
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = UDim2.new(0, 5, 0, 0)
	button.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
	button.TextColor3 = Color3.new(1, 1, 1)
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

-- 🧨 Eruption Burst
local function eruption()
	local burst = Instance.new("Frame", container)
	burst.Size = UDim2.new(0, math.random(50, 120), 0, math.random(20, 60))
	burst.Position = UDim2.new(math.random(), 0, math.random(), 0)
	burst.AnchorPoint = Vector2.new(0.5, 0.5)
	burst.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
	burst.BorderSizePixel = 0
	burst.BackgroundTransparency = 0.2
	burst.Rotation = math.random(-15, 15)
	burst.ZIndex = 4
	TweenService:Create(burst, TweenInfo.new(0.5), {
		Size = burst.Size + UDim2.new(0, 40, 0, 20),
		BackgroundTransparency = 1
	}):Play()
	game.Debris:AddItem(burst, 0.6)
end

task.spawn(function()
	while true do
		wait(math.random(2, 5))
		eruption()
	end
end)
-- 🌀 Shake utility
local function shakeFrame(frame, duration, intensity)
	local originalPos = frame.Position
	local t = 0
	while t < duration do
		local offsetX = math.random(-intensity, intensity)
		local offsetY = math.random(-intensity, intensity)
		frame.Position = originalPos + UDim2.new(0, offsetX, 0, offsetY)
		task.wait(0.03)
		t = t + 0.03
	end
	frame.Position = originalPos
end

-- 🔁 Every 5 seconds, trigger flash + shake
task.spawn(function()
	while true do
		wait(5)

		local flashIn = TweenService:Create(glyphLabel, TweenInfo.new(0.25), {
			TextTransparency = 0
		})
		flashIn:Play()
		flashIn.Completed:Wait()

		task.spawn(function() shakeFrame(container, 0.4, 2) end)
		task.spawn(function() shakeFrame(glyphLabel, 0.4, 1) end)

		wait(0.4)
		local flashOut = TweenService:Create(glyphLabel, TweenInfo.new(0.25), {
			TextTransparency = 1
		})
		flashOut:Play()
	end
end)

-- ➕ Script Buttons
createScriptButton("Redhub", "https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau", _G.Settings or {})
createScriptButton("Hohohub", "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI")
createScriptButton("Zenith Hub", "https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader")

-- ⏬ Minimize Toggle
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
	if minimized then
		container:TweenSize(UDim2.new(0, 80, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
		haze.Visible = false
		List.Visible = false
		title.Visible = false
	else
		container:TweenSize(UDim2.new(0, 300, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
		wait(0.5)
		haze.Visible = true
		List.Visible = true
		title.Visible = true
	end
end)
