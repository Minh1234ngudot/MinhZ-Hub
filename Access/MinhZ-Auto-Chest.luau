--[[
            ╔══════════════════════════════════════════════════════════════╗
            ║                                                              ║
            ║           ███╗   ███╗██╗███╗   ██╗██╗  ██╗███████╗           ║
            ║           ████╗ ████║██║████╗  ██║██║  ██║╚══███╔╝           ║
            ║           ██╔████╔██║██║██╔██╗ ██║███████║  ███╔╝            ║
            ║           ██║╚██╔╝██║██║██║╚██╗██║██╔══██║ ███╔╝             ║
            ║           ██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗           ║
            ║           ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝           ║
            ║   MinhZ Hub - Auto Chest | Made By MinhZ And Gravity Hub     ║
            ║                                                              ║
            ╚══════════════════════════════════════════════════════════════╝

                   Original Version: https://pastefy.app/iiFOhcot/raw
                           Note: This Is A Remake Version
]]--


local cfg = getgenv().MinhZHub or {}
local CFG = {
	Team = cfg["Team"] or "Marines",
	["Farm Chest"] = (cfg["Farm Chest"] == nil) and true or cfg["Farm Chest"],
	["Stop Item"] = (cfg["Stop Item"] == nil) and true or cfg["Stop Item"],
	["Hopping Server"] = (cfg["Hopping Server"] == nil) and true or cfg["Hopping Server"],
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

if CoreGui:FindFirstChild("Status_UI") then
	CoreGui.Status_UI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "Status_UI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 70)
frame.Position = UDim2.new(0.5, 0, 0.07, 0)
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.25
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 220, 70)
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 6)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 230, 120)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local statusText = Instance.new("TextLabel", frame)
statusText.Size = UDim2.new(1, -10, 0.5, 0)
statusText.Position = UDim2.new(0.5, 0, 0, 5)
statusText.AnchorPoint = Vector2.new(0.5, 0)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 18
statusText.TextColor3 = Color3.fromRGB(255,230,120)
statusText.Text = "MinhZ Hub - Auto Chest"

local itemText = Instance.new("TextLabel", frame)
itemText.Size = UDim2.new(1, -10, 0.5, 0)
itemText.Position = UDim2.new(0.5, 0, 0.5, 0)
itemText.AnchorPoint = Vector2.new(0.5, 0)
itemText.BackgroundTransparency = 1
itemText.Font = Enum.Font.Gotham
itemText.TextSize = 16
itemText.TextColor3 = Color3.fromRGB(255,230,120)
itemText.Text = "Status : Chest Bypass"

local function setItemText(newText)
	pcall(function()
		local out = TweenService:Create(itemText, TweenInfo.new(0.18), {TextTransparency = 1})
		local inn = TweenService:Create(itemText, TweenInfo.new(0.18), {TextTransparency = 0})
		out:Play(); out.Completed:Wait()
		itemText.Text = newText
		inn:Play()
	end)
end

task.spawn(function()
	while true do
		local a = TweenService:Create(stroke, TweenInfo.new(1.2), {Color = Color3.fromRGB(255,255,180)})
		local b = TweenService:Create(stroke, TweenInfo.new(1.2), {Color = Color3.fromRGB(255,200,60)})
		a:Play(); a.Completed:Wait()
		b:Play(); b.Completed:Wait()
	end
end)

local function collectChestParts()
	local list = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name:lower():match("chest") then
			table.insert(list, obj)
		end
	end
	return list
end

local function hasRareItem()
	local bp = LocalPlayer:FindFirstChild("Backpack")
	local char = LocalPlayer.Character
	local function check(container)
		if not container then return false end
		for _, c in pairs(container:GetChildren()) do
			local n = c.Name
			if n == "God's Chalice" or n == "Sweet Chalice" or n == "Fist of Darkness" then
				return true
			end
		end
		return false
	end
	return check(bp) or check(char)
end

local Farming = false

local function simulateHop()
	setItemText("Status : Hopping Server")
	task.wait(2)
end

local function startSimulatedFarm()
	if not CFG["Farm Chest"] then
		setItemText("Status : Chest Bypass")
		return
	end
	if Farming then return end
	Farming = true

	task.spawn(function()
		while Farming do
			if CFG["Stop Item"] and hasRareItem() then
				setItemText("Status : Stop Item")
				Farming = false
				break
			end

			local chests = collectChestParts()
			if #chests > 0 then
				setItemText("Status : Chest Bypass")
				task.wait(0.25)
			else
				if CFG["Hopping Server"] then
					setItemText("Status : Hopping Server")
					simulateHop()
					task.wait(0.5)
				else
					setItemText("Status : Chest Bypass")
					task.wait(1)
				end
			end
			task.wait(0.1)
		end
	end)
end

local function stopSimulatedFarm()
	Farming = false
end

if CFG["Farm Chest"] then
	setItemText("Status : Chest Bypass")
	startSimulatedFarm()
else
	setItemText("Status : Chest Bypass")
end

getgenv().MinhZHubControls = {
	Start = startSimulatedFarm,
	Stop = stopSimulatedFarm,
	SetConfig = function(newCfg)
		if type(newCfg) ~= "table" then return end
		for k,v in pairs(newCfg) do
			if CFG[k] ~= nil then CFG[k] = v end
		end
	end,
	GetConfig = function() return CFG end,
}
