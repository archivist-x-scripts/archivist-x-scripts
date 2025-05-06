-- Archivist X Lite Loader — v1.0
-- No animation. No bloat. Just buttons.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local req = (syn and syn.request) or http_request or request
local localPlayer = Players.LocalPlayer

-- Create UI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ArchivistX_Lite"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0, 20, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Archivist X — Loader"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local List = Instance.new("ScrollingFrame", Frame)
List.Size = UDim2.new(1, 0, 1, -30)
List.Position = UDim2.new(0, 0, 0, 30)
List.CanvasSize = UDim2.new(0, 0, 0, 0)
List.ScrollBarThickness = 6
List.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", List)
Layout.Padding = UDim.new(0, 4)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

List.ChildAdded:Connect(function()
	task.wait()
	List.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Load script buttons from remote JSON
local function loadScripts()
	local url = "https://raw.githubusercontent.com/archivist-x-scripts/archivist-x-scripts/main/scripts.json"
	local res = req({Url = url, Method = "GET"})

	if not res or res.StatusCode ~= 200 then
		warn("Failed to fetch scripts.json")
		return
	end

	local data = HttpService:JSONDecode(res.Body)
	for _, scriptEntry in ipairs(data) do
		local button = Instance.new("TextButton", List)
		button.Size = UDim2.new(1, -10, 0, 30)
		button.Position = UDim2.new(0, 5, 0, 0)
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Font = Enum.Font.Gotham
		button.TextSize = 14
		button.Text = scriptEntry.label or "Unnamed Script"

		button.MouseButton1Click:Connect(function()
			local scriptUrl = "https://raw.githubusercontent.com/" .. scriptEntry.repo .. "/main/" .. scriptEntry.file
			local fetch = req({Url = scriptUrl, Method = "GET"})
			if fetch and fetch.StatusCode == 200 then
				loadstring(fetch.Body)()
			else
				warn("Failed to load script: " .. scriptEntry.label)
			end
		end)
	end
end

loadScripts()
