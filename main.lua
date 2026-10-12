local R = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local W = R:CreateWindow({Name = "ណារ៉ា script - Steal 1B-1T", LoadingTitle = "Loading...", ConfigurationSaving = {Enabled = false}, KeySystem = false})
local T = W:CreateTab("Main", 4483362458)
local P, LP = game:GetService("Players"), game:GetService("Players").LocalPlayer
local en, rad, scf = false, 1000, nil

local function isValid(o, p)
   local pr = p.Parent
   local t = string.lower(o.Name .. " " .. p.Name .. " " .. (pr and pr.Name or ""))
   if pr then
      for _, d in ipairs(pr:GetDescendants()) do
         if d:IsA("TextLabel") or d:IsA("TextBox") then t = t .. " " .. string.lower(d.Text) end
      end
   end
   return string.find(t, "b") or string.find(t, "t") or string.find(t, "secret") or string.find(t, "godly") or string.find(t, "mythic")
end

game:GetService("RunService").RenderStepped:Connect(function()
   if not en then return end
   pcall(function()
      local rt = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
      if not rt then return end
      for _, o in ipairs(workspace:GetDescendants()) do
         if o:IsA("ProximityPrompt") and o.Parent and o.Parent:IsA("BasePart") then
            if (rt.Position - o.Parent.Position).Magnitude <= rad and isValid(o, o.Parent) then
               fireproximityprompt(o)
            end
         end
      end
   end)
end)

T:CreateToggle({Name = "Auto Steal (1B-1T)", CurrentValue = false, Callback = function(v) en = v end})
T:CreateSlider({Name = "Radius", Range = {50, 5000}, Increment = 50, CurrentValue = 1000, Callback = function(v) rad = v end})

local function tp()
   if not scf then return R:Notify({Title = "Error", Content = "Save Position មុន!", Duration = 2}) end
   local rt = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
   if rt then rt.CFrame = scf + Vector3.new(0, 3, 0) end
end

T:CreateButton({Name = "Save Position", Callback = function()
   local rt = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
   if rt then scf = rt.CFrame R:Notify({Title = "Saved!", Content = "បានរក្សាទុក!", Duration = 2}) end
end})

T:CreateButton({Name = "Teleport មកវិញ", Callback = tp})

local g = Instance.new("ScreenGui", game:CoreGui) g.ResetOnSpawn = false
local function mb(txt, pos, col, cb)
   local b = Instance.new("TextButton", g)
   b.Size = UDim2.new(0, 60, 0, 60) b.Position = pos b.BackgroundColor3 = col
   b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.TextScaled = true b.Draggable = true
   Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
   b.MouseButton1Click:Connect(cb)
end

mb("Save", UDim2.new(0.05, 0, 0.3, 0), Color3.fromRGB(0, 200, 100), function()
   local rt = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
   if rt then scf = rt.CFrame end
end)

mb("TP", UDim2.new(0.05, 0, 0.42, 0), Color3.fromRGB(255, 128, 0), tp)
