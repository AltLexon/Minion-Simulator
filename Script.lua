local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local char = plr.Character
local hrp = char.HumanoidRootPart
local hum = char.Humanoid

local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/sol"))()

local Win = SolarisLib:New({
  Name = "Minion Simulator",
  FolderToSave = "Minion Simulator"
})

getgenv().AutoMine = false;
local WalkSpeed = 16
local JumpPower = 50
local main = Win:Tab("Main")
local mainS = main:Section("Main")
local player = Win:Tab("Player")
local playerS = player:Section("Player")
local Misc = Win:Tab("Misc")
local MiscS = Misc:Section("Misc")

playerS:Slider("WalkSpeed", 16, 300, 16, 1, "Slider", function(i)
  WalkSpeed = i
  hum.WalkSpeed = i
end)

hum.Changed:Connect(function(property)
  if property == "WalkSpeed" then
    hum[property] = WalkSpeed
  elseif property == "JumpPower" then
    hum[property] = JumpPower
  end
end)

playerS:Slider("JumpPower", 50, 300, 50, 1, "Slider", function(i)
  JumpPower = i
  hum.JumpPower = i
end)

local function BreakBlocks(ll)
  if getgenv().AutoMine == true then
    for i,v in next, game:GetService("Workspace").Loaded.Breakables:GetChildren() do
      local v1 = v:FindFirstChild("Circle")
      if v1 ~= nil then
          local v2 = v1:FindFirstChild("Decal")
          if v2 ~= nil then
              if v2.Transparency == 1 then
                  if (v1.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 150 then
                      game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2), {CFrame = v.Main.CFrame * CFrame.new(0,2,0)}):Play()
                      wait(2)
                      game:GetService("ReplicatedStorage").RemoteFunctions.PickaxeBreakableFunction:InvokeServer(v.Name)
                    break
                  end
              elseif v2.Transparency == 0.8 then
                    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(2), {CFrame = v.Main.CFrame * CFrame.new(0,2,0)}):Play()
                    wait(2)
                    game:GetService("ReplicatedStorage").RemoteFunctions.PickaxeBreakableFunction:InvokeServer(v.Name)
                    wait()
                  break
                end
              end
          end
      end
    end
    wait(1.5)
    if ll == "Auto" then
      BreakBlocks("Auto")
    end
end

mainS:Button("Mine", function()
  BreakBlocks()
end)

mainS:Toggle("Auto-Mine", false, "Toggle", function(v)
  getgenv().AutoMine = v
  BreakBlocks("Auto")
end)

mainS:Button("Free TP")
