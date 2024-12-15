msg = Instance.new("Message")
		msg.Parent = game.Workspace
		msg.Text = "神青忍者传奇脚本启动中😡😡😡😡😡"
		wait(6)
		msg:remove()
		wait(3)

local library = loadstring(game:HttpGet("https://pastebin.com/raw/3vQbADjh", true))()
----------------------------------------------------------------------------------------------------------------------------------------
local window = library:new("神青忍者传奇")--V2.1.3
----------------------------------------------------------------------------------------------------------------------------------------

local creds = window:Tab("玩家",'7733993211')

local bin = creds:section("信息",true)

    bin:Label("你的用户名:"..game.Players.LocalPlayer.Character.Name)
    bin:Label("获取客户端ID:"..game:GetService("RbxAnalyticsService"):GetClientId())
    bin:Label("你的注入器:"..identifyexecutor())
    bin:Label("你的地图id:"..game.PlaceId)
    bin:Label("你现在的地图名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    
local creds = window:Tab("公告",'7733993211')

    local bin = creds:section("信息",true)
    bin:Label("大群:1003591865")
    bin:Label("作者:神青")
    bin:Label("师傅：叶")
    bin:Label("帮助者：鹤")
    bin:Label("缝合脚本")
    bin:Label("不能外传，不能诋毁")
    local creds = window:Tab("自动功能", "7733798747")
    local RZCQ = creds:section("功能", true)

autoswing = false
function swinging()
    spawn(
        function()
            while autoswing == true do
                task.wait()
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("swingKatana")
                if not autoswing then
                    break
                end
            end
        end
    )
end
autosell = false
function selling()
    spawn(
        function()
            while autosell == true do
                task.wait(.01)
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    game.workspace.sellAreaCircles["sellAreaCircle7"].circleInner.CFrame =
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                    wait(.1)
                    game.workspace.sellAreaCircles["sellAreaCircle7"].circleInner.CFrame =
                        game.Workspace.Part.CFrame
                    if not autosell then
                        break
                    end
                end
            end
        end
    )
end
autosellmax = false
function maxsell()
    spawn(
        function()
            while autosellmax == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    if game.Players.LocalPlayer.PlayerGui.gameGui.maxNinjitsuMenu.Visible == true then
                        game.workspace.sellAreaCircles["sellAreaCircle7"].circleInner.CFrame =
                            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
                        task.wait()
                        game.workspace.sellAreaCircles["sellAreaCircle7"].circleInner.CFrame =
                            game.Workspace.Part.CFrame
                    end
                end
                if not autosellmax then
                    break
                end
            end
        end
    )
end
autobuyswords = false
function buyswords()
    spawn(
        function()
            while autobuyswords == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    local oh1 = "buyAllSwords"
                    local oh2 = {
                        "Ground",
                        "Astral Island",
                        "Space Island",
                        "Tundra Island",
                        "Eternal Island",
                        "Sandstorm",
                        "Thunderstorm",
                        "Ancient Inferno Island",
                        "Midnight Shadow Island",
                        "Mythical Souls Island",
                        "Winter Wonder Island"
                    }
                    for i = 1, #oh2 do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                    end
                end
                if not autobuyswords then
                    break
                end
            end
        end
    )
end
autobuybelts = false
function buybelts()
    spawn(
        function()
            while autobuybelts == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    local oh1 = "buyAllBelts"
                    local oh2 = {
                        "Ground",
                        "Astral Island",
                        "Space Island",
                        "Tundra Island",
                        "Eternal Island",
                        "Sandstorm",
                        "Thunderstorm",
                        "Ancient Inferno Island",
                        "Midnight Shadow Island",
                        "Mythical Souls Island",
                        "Winter Wonder Island"
                    }
                    for i = 1, #oh2 do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                    end
                end
                if not autobuybelts then
                    break
                end
            end
        end
    )
end
autobuyranks = false
function buyranks()
    spawn(
        function()
            while autobuyranks == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    local oh1 = "buyRank"
                    local oh2 = game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()
                    for i = 1, #oh2 do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i].Name)
                    end
                end
                if not autobuyranks then
                    break
                end
            end
        end
    )
end
autobuyskill = false
function buyskill()
    spawn(
        function()
            while autobuyskill == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    local oh1 = "buyAllSkills"
                    local oh2 = {
                        "Ground",
                        "Astral Island",
                        "Space Island",
                        "Tundra Island",
                        "Eternal Island",
                        "Sandstorm",
                        "Thunderstorm",
                        "Ancient Inferno Island",
                        "Midnight Shadow Island",
                        "Mythical Souls Island",
                        "Winter Wonder Island"
                    }
                    for i = 1, #oh2 do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                    end
                end
                if not autobuyskill then
                    break
                end
            end
        end
    )
end
autobuyshurikens = false
function buyshurikens()
    spawn(
        function()
            while autobuyshurikens == true do
                task.wait()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
                    local oh1 = "buyAllShurikens"
                    local oh2 = {
                        "Ground",
                        "Astral Island",
                        "Space Island",
                        "Tundra Island",
                        "Eternal Island",
                        "Sandstorm",
                        "Thunderstorm",
                        "Ancient Inferno Island",
                        "Midnight Shadow Island",
                        "Mythical Souls Island",
                        "Winter Wonder Island"
                    }
                    for i = 1, #oh2 do
                        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                    end
                end
                if not autobuyshurikens then
                    break
                end
            end
        end
    )
end

RZCQ:Toggle("自动挥舞", "ATHW", false, function(ATHW)
    if v or not ATHW then getgenv().autoswing = ATHW while true do if not getgenv().autoswing then return end for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:FindFirstChild("ninjitsuGain") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(v) break end end local A_1 = "swingKatana" local Event = game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(A_1) wait() end end
end)
RZCQ:Toggle("自动售卖", "ATSELL", false, function(ATSELL)
    getgenv().autosell = ATSELL while true do if not getgenv().autosell then return end game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame wait(0.1) game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0) wait(0.1) end
end)
RZCQ:Toggle("购买排名", "ATBP", false, function(ATBP)
    getgenv().autobuyranks = ATBP while true do if not getgenv().autobuyranks then return end local deku1 = "buyRank" for i = 1, #ranks do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(deku1, ranks[i]) end wait(0.1) end
end)
RZCQ:Toggle("购买腰带", "ATBYD", false, function(ATBYD)
    getgenv().autobuybelts = ATBYD while true do if not getgenv().autobuybelts then return end local A_1 = "buyAllBelts" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
RZCQ:Toggle("购买技能", "ATB", false, function(ATB)
    getgenv().autobuyskills = ATB while true do if not getgenv().autobuyskills then return end local A_1 = "buyAllSkills" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
RZCQ:Toggle("自动购买剑", "ATBS", false, function(ATBS)
    getgenv().autobuy = ATBS while true do if not getgenv().autobuy then return end local A_1 = "buyAllSwords" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
RZCQ:Button("解锁所有岛", function()
  for _, v in next, game.workspace.islandUnlockParts:GetChildren() do if v then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame wait(.5) end end
end)

local creds = window:Tab("传送功能", "7733798747")
    local RZCQ = creds:section("功能", true)

RZCQ:Button("传送到出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)
RZCQ:Button("传送到附魔岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)
RZCQ:Button("传送到神秘岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
end)
RZCQ:Button("传送到太空岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
end)
RZCQ:Button("传送到冻土岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
end)
RZCQ:Button("传送到永恒岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
end)
RZCQ:Button("传送到沙暴岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
end)
RZCQ:Button("传送到雷暴岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)
RZCQ:Button("传送到远古炼狱岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
end)
RZCQ:Button("传送到午夜暗影岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
end)
RZCQ:Button("传送到神秘灵魂岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
end)
RZQC:Button("传送到冬季奇迹岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
end)
RZQC:Button("传送到黄金大师岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
end)
RZQC:Button("传送到龙传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
end)
RZQC:Button("传送到赛博传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
end)
RZQC:Button("传送到天岚超能岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
end)
RZQC:Button("传送到混沌传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)
RZQC:Button("传送到混沌传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)
RZQC:Button("传送到灵魂融合岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)
end)
RZQC:Button("传送到黑暗元素岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
end)
RZQC:Button("传送到内心和平岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
end)
RZQC:Button("传送到炽烈漩涡岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
end)
RZQC:Button("传送到35倍金币区域", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)
end)
RZQC:Button("传送到死亡宠物", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4593.21337890625, 130.87181091308594, 1430.2239990234375)
end)
