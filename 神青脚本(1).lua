local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "神青脚本", HidePremium = false, IntroText = "神青脚本"})

local Tab = Window:MakeTab({
	Name = "公告",
	Icon = "rbxassetid://928950173",
	PremiumOnly = false
})

Tab:AddParagraph("免费缝合脚本（群:985470501 快手:神青）")

Tab:AddParagraph("持续云更新，如果发现不可用脚本请向作者反馈，加群加速更新")

Tab:AddParagraph("更新时间:11月16日，更新内容：啥也没有")

local Tab =Window:MakeTab({

	Name = "快捷复制",

	Icon = "rbxassetid://928950173",

	PremiumOnly = false

})

Tab:AddButton({

	Name = "复制QQ群",

	Callback = function()

     setclipboard("985470501")

  	end

})

Tab:AddButton({

	Name = "复制师傅QQ",

	Callback = function()
     setclipboard("3769797457")

  	end

})

Tab:AddButton({

	Name = "复制快手",

	Callback = function()
     setclipboard("神青")

  	end

})

local Tab = Window:MakeTab({
	Name = "通用功能",
	Icon = "rbxassetid://10527577695",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "光影",
  Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/arzRCgwS"))()
  end
})

Tab:AddButton({
  Name = "光影2",
  Default = false,
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
  end
})

Tab:AddButton({
	Name = "建筑工具",
	Callback = function()
		Hammer = Instance.new("HopperBin")
		Hammer.Name = "锤子"
		Hammer.BinType = 4
		Hammer.Parent = game.Players.LocalPlayer.Backpack
		Clone = Instance.new("HopperBin")
		Clone.Name = "克隆"
		Clone.BinType = 3
		Clone.Parent = game.Players.LocalPlayer.Backpack
		Grab = Instance.new("HopperBin")
		Grab.Name = "抓取"
		Grab.BinType = 2
	end
})

Tab:AddButton({
	Name = "画质",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end
})    

Tab:AddButton({
  Name = "旋转",
  Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()
  end
})

Tab:AddToggle({
	Name = "夜视",
	Default = false,
	Callback = function(Value)
		if Value then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
		else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
		end
	end
})
 
Tab:AddButton({
	Name = "飞车",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()
	end
})

Tab:AddButton({
   Name = "工具挂",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
   end
})

Tab:AddButton({
	Name = "人物无敌",
	Callback = function()
     loadstring(game:HttpGet('https://pastebin.com/raw/H3RLCWWZ'))()
	end    
})

Tab:AddButton({
	Name = "飞行",
	Callback = function()
loadstring(game:HttpGet('https://pastebin.com/raw/U27yQRxS'))()
	end 
})

Tab:AddButton({
	Name = "速度更改",
	Callback = function()
     loadstring(game:HttpGet("https://pastebin.com/raw/Zuw5T7DP",true))()
	end    
})

Tab:AddButton({
	Name = "甩飞别人",
	Callback = function()
     loadstring(game:HttpGet("https://pastebin.com/raw/GnvPVBEi"))()
  	end    
})

Tab:AddButton({
	Name = "爬墙",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end
})

Tab:AddButton({
    Name = "动作",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Zj4NnKs6"))()
    end
})

Tab:AddButton({
	Name = "电脑键盘",
	Callback = function()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
  	end    
})

Tab:AddButton({
  Name = "铁拳",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
  end
})

Tab:AddButton({
  Name = "无敌",
  Callback = function()
  loadstring(game:HttpGet('https://pastebin.com/raw/H3RLCWWZ'))()
  end
})

Tab:AddButton({   
  Name = "飞车",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/G3GnBCyC", true))()
  end
})

Tab:AddButton({
   Name = "转圈",
   Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()
   end
})

Tab:AddButton({
   Name = "飞车2",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vb/main/%E9%A3%9E%E8%BD%A6.lua"))()
   end
})

Tab:AddButton({
	Name = "吸取全部玩家",
	Callback = function()
     loadstring(game:HttpGet('https://pastebin.com/raw/hQSBGsw2'))()
  	end    
})

Tab:AddButton({
  Name = "死亡笔记",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
  end
})

Tab:AddButton({
  Name = "甩人",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
  end  
})

Tab:AddButton({
  Name = "铁拳",
  Callback = function()  	
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
   end
})

Tab:AddButton({
	Name = "踏空",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
	end
})

local Tab = Window:MakeTab({
	Name = "其它脚本",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "鸭",
	Callback = function()
loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,81,89,49,113,112,99,115,106})end)())))()
    end
})

Tab:AddButton({
Name = "刺客",
	Callback = function()
CK_V2 = "作者_神罚"SheFa = "刺客群637340150"loadstring(game:HttpGet(('https://raw.githubusercontent.com/WDQi/SF/main/%E7%9C%8B%E4%BD%A0M.txt')))()
    end
})

Tab:AddButton({
  Name = "导管中心",
  Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\117\115\101\114\97\110\101\119\114\102\102\47\114\111\98\108\111\120\45\47\109\97\105\110\47\37\69\54\37\57\68\37\65\49\37\69\54\37\65\67\37\66\69\37\69\53\37\56\68\37\56\70\37\69\56\37\65\69\37\65\69\34\41\41\40\41\10")()
  end
})

Tab:AddButton({
    Name = "北约中心",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/USA868/114514-55-646-114514-88-61518-618-840-1018-634-10-4949-3457578401-615/main/Protected-36.lua"))()
    end
})

Tab:AddButton({
    Name = "脚本中心",
    Callback = function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\103\101\109\120\72\119\65\49"))()
    end
})

Tab:AddButton({
    Name = "XCS（卡密不知）",
    Callback = function()
    getgenv().XC="作者XC"loadstring(game:HttpGet("https://pastebin.com/raw/PAFzYx0F"))()
    end
})

Tab:AddButton({
	Name = "小魔",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaomoNB666/xiaomoNB666/main/666.txt"))()
  	end
})

Tab:AddButton({
	Name = "小星",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/XhQpcE5m"))()
  	end    
})

Tab:AddButton({
	Name = "皇",
	Callback = function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\80\100\84\55\99\65\82\84"))()
  	end    
})
                                           
Tab:AddButton({
	Name = "静新",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/jxdjbx/Ghfjfhfjejjfbdbdbefbbd/main/Xgvvdhnxcv%20vbbvbb%20mnknbHB"))()  
  	end    
})

Tab:AddButton({
	Name = "青",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/kkaaccnnbb/money/main/fix'))()
  	end    
})

Tab:AddButton({
    Name = "林",
    Callback = function()
lin = "作者林"lin ="林QQ群 747623342"loadstring(game:HttpGet("https://raw.githubusercontent.com/linnblin/lin/main/lin"))()
    end
})

Tab:AddButton({
Name = "落叶",
	Callback = function()
getgenv().LS="落叶中心" loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))()
    end
})

Tab:AddButton({
	Name = "陈(卡密不外传)",
	Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\81\120\68\68\57\83\112\87\34\41\41\40\41")()
  	end    
})

Tab:AddButton({
Name = "绿",
  Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Esw6YQKR"))()
   end
})

Tab:AddButton({
Name = "玖恶脚本",
	Callback = function()
loadstring(game:HttpGet('https://ayangwp.cn/api/v3/file/get/8508/%E7%8E%96%E6%81%B6%E4%B8%AD%E5%BF%83.lua?sign=wt54yWf_f0LDB3gXXyQu0SFQ0oUDUXZBOaWQShwCFGg%3D%3A0'))()
    end
})

Tab:AddButton({
Name = "秋脚本",
	Callback = function()
_G[".秋·自制脚本 遗存抢救"]="2024dncxddtsnchzxtb0112"loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,87,83,98,117,113,47,45,47,109,97,105,110,47,37,69,55,37,65,55,37,56,66,37,67,50,37,66,55,37,69,56,37,56,55,37,65,65,37,69,53,37,56,56,37,66,54,37,69,56,37,56,52,37,57,65,37,69,54,37,57,67,37,65,67})end)())))()
    end
})

Tab:AddButton({
Name = "乌云脚本",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/dT4ZGge8"))()
    end
})

Tab:AddButton({
Name = "老大脚本",
	Callback = function()
loadstring(game:HttpGet("https://ayangwp.cn/api/v3/file/get/8401/%E8%80%81%E5%A4%A7%E8%84%9A%E6%9C%AC1.0%E7%89%88.txt?sign=XHxQ1ja8djAnEjVEG-eEZFPeZKFHJ0FHeybHpSbtBW4%3D%3A0"))()
    end
})

Tab:AddButton({
	Name = "不公平中心(外国缝合)",
	Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua'),true))()	
      end
})

Tab:AddButton({
	Name = "白(付费)",
	Callback = function()
_G["白脚本作者修狗"]="xdjhadgdsrfcyefjhsadcctyseyr6432478rudghfvszhxcaheey"loadstring(game:HttpGet(('https://raw.githubusercontent.com/wev666666/baijiaobengV2.0beta/main/%E7%99%BD%E8%84%9A%E6%9C%ACbeta'),true))() 
  	end
})


Tab:AddButton({
  Name = "霖溺(付费)",
  Callback = function()
LINNI__Script = "作者LinNiQQ号1802952013" Roblox= "作者LinNiQ群932613422" loadstring(game:HttpGet(('https://shz.al/~LINNI_ROBLOX'),true))()
  end
})

local Tab = Window:MakeTab({
	Name = "监狱人生",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "脚本"
})

Tab:AddButton({
	Name = "1",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/De4aYHDY"))()
  	end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dalloc2/Roblox/main/TigerAdmin.lua"))()
  end
})

Tab:AddButton({
	Name = "手里剑秒杀",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/PSXhuge/1/114514/jian"))()
  	end
})

Tab:AddButton({
	Name = "变车模型",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
  	end
})

Tab:AddButton({
  Name = "变钢铁侠",
  Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
  end
})

Tab:AddButton({
  Name = "杀所有人(不可关)",
  Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
  end
})

Tab:AddButton({
	Name = "无敌模式",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
  	end
})

local Section = Tab:AddSection({
	Name = "传送"
})

Tab:AddButton({
	Name = "警卫室",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
  	end
})

Tab:AddButton({
	Name = "监狱室内",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
  	end
})

Tab:AddButton({
	Name = "罪犯复活点",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
  	end
})

Tab:AddButton({
	Name = "监狱室外",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
  	end
})

local Tab = Window:MakeTab({
	Name = "忍者传奇(内置)",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

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

Tab:AddToggle(
    {
        Name = "自动挥舞",
        Default = false,
        Callback = function(x)
            autoswing = x
            if autoswing then
                swinging()
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "自动售卖",
        Default = false,
        Callback = function(x)
            autosell = x
            if autosell then
                selling()
            end
        end
    }
)
    
Tab:AddToggle(
    {
        Name = "存满了自动售卖",
        Default = false,
        Callback = function(x)
            autosellmax = x
            if autosellmax then
                maxsell()
            end
        end
    }
)

local Section = Tab:AddSection({
	Name = "自动购买功能"
})

Tab:AddToggle(
    {
        Name = "自动购买剑",
        Default = false,
        Callback = function(x)
            autobuyswords = x
            if autobuyswords then
                buyswords()
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "自动购买腰带",
        Default = false,
        Callback = function(x)
            autobuybelts = x
            if autobuybelts then
                buybelts()
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "自动购买称号（等级）",
        Default = false,
        Callback = function(x)
            autobuyranks = x
            if autobuyranks then
                buyranks()
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "自动购买忍术",
        Default = false,
        Callback = function(x)
            autobuyskill = x
            if autobuyskill then
                buyskill()
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "自动购买（全部打开）",
        Default = false,
        Callback = function(x)
            autobuyshurikens = x
            if autobuyshurikens then
                buyshurikens()
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "解锁所有岛",
        Callback = function()
            for _, v in next, game.workspace.islandUnlockParts:GetChildren() do
                if v then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame
                    wait(.5)
                end
            end
        end
    }
)

local player = Window:MakeTab({
	Name = "忍者传奇",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "超强(使用教程可以看我b站[公告])",
	Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XRoLLu/Rolly_Hub/main/open-source-trash-loader.exe.yeah"))()
  	end
})

player:AddButton({
	Name = "2",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AliCode14/scripts/main/ScriptHub.lua"))()
  	end
})

local Tab = Window:MakeTab({
	Name = "doors",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "地吸制作",
	Callback = function()
pcall(function()gui_data=game:HttpGet("https://github.com/DocYogurt/script/raw/main/info.json",true)gui_data=game:GetService("HttpService"):JSONDecode(gui_data)end)version=gui_data.ver;loadstring(game:HttpGet("https://github.com/DocYogurt/F/raw/main/NB.lua"))()
end
})

Tab:AddButton({
	Name = "汉化",
	Callback = function()
--[[Doors Blackking And BobHub脚本汉化]]loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end
})

Tab:AddButton({
	Name = "穿墙",
	Callback = function()
loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()
end
})

Tab:AddButton({
	Name = "超级",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Doors"))()
end
}) 

Tab:AddButton({
	Name = "5",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/VaniaPerets/FolderGui-FolderHub/main/loader.lua", true))()
end
})

Tab:AddButton({
	Name = "MS",
	Callback = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/MSDOORS/main/MSHUB_Loader.lua"),true))()
end
})

Tab:AddButton({
    Name = "XD",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DXuwu/test-lol/main/YO.lua"))()
	
end
})

Tab:AddButton({
  Name = "无卡密陈",
  Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\89\83\108\111\110\47\82\65\87\45\46\46\97\45\115\99\114\105\112\116\47\109\97\105\110\47\37\69\57\37\57\57\37\56\56\68\79\79\82\83\50\46\48\77\79\79\78\37\69\54\37\66\55\37\66\55\37\69\54\37\66\55\37\56\54\34\41\41\40\41")()

  end
})

local Section = Tab:AddSection({
	Name = "功能"
})

Tab:AddButton({  
    Name = "十字架",
	Callback = function()
	_G.Uses = 99999999999
_G.Range = 999
_G.OnAnything = true
_G.Fail = false
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))() --no deivid-- --execute this instead--
     end
})

Tab:AddButton({
	Name = "紫色手电筒",
	Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Purple%20Flashlight%20Script.lua"))()
    end
})

Tab:AddButton({
      Name = "剪刀",
      Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/v2yEJYmu"))()
      end
      })  

Tab:AddButton({
      Name = "神圣炸弹",
      Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/u5B1UjGv"))()
      end
      })  

local Tab = Window:MakeTab({
	Name = "伐木",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "白",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/CloudX-ScriptsWane/ScriptsDache/main/%E4%BC%90%E6%9C%A8%E5%A4%A7%E4%BA%A822.lua", true))()
  end
})

Tab:AddButton({
	Name = "超强(使用教程可以看我b站[公告])",
	Callback = function()
	loadstring(game:HttpGet"https://raw.githubusercontent.com/darkxwin/darkxsourcethinkyoutousedarkx/main/darkx")()
  	end
})

local Section = Tab:AddSection({	Name = "传送地点"})                                      Tab:AddButton({Name = "火木",      Callback = function()              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1615.8934326171875, 622.9998779296875, 1086.1234130859375)               end                                    })                                                                              Tab:AddButton({                  Name = "画室",                 Callback = function()                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5241.55810546875, -166.00003051757812, 709.5656127929688)                end                                    })                                                                Tab:AddButton({                  Name = "幻影木",              Callback = function()             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-56.28166198730469, -213.13137817382812, -1357.8018798828125)              end                                   })                                                                Tab:AddButton({                 Name = "木材反斗城",            Callback = function()             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(252.31906127929688, 2.9999992847442627, 56.9854850769043)                  end                                   })                                                                               Tab:AddButton({                 Name = "冰木",                  Callback = function()              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1522.8817138671875, 412.3657531738281, 3277.71826171875)                     end                                    })                                                                Tab:AddButton({                  Name = "椰子木",                Callback = function()              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2615.709228515625, -5.899986743927002, -21.30138397216797)                  end                                     })                                               

local Tab = Window:MakeTab({
	Name = "力量传奇",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "范围增加",
  Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/KKY9EpZU"))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/noobhosting/noobscript/main/MuscleLegends.lua'))()
  end
})

Tab:AddButton({
	Name = "3",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/harisiskandar178/Roblox-Script/main/Muscle%20Legend"))()
    end
})

local Section = Tab:AddSection({
	Name = "传送"
})

Tab:AddButton({
	Name = "传送到出生点",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
  	end    
})
 
Tab:AddButton({
	Name = "传送到冰霜健身房",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
  	end    
})
 
Tab:AddButton({
	Name = "传送到神话健身房",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
  	end    
})

Tab:AddButton({
	Name = "传送到永恒健身房",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
  	end    
})

Tab:AddButton({
	Name = "传送到传说健身房",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
  	end    
})

Tab:AddButton({
	Name = "传送到肌肉之王健身房",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
  	end    
})

Tab:AddButton({
	Name = "传送到安全岛",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
  	end    
})

Tab:AddButton({
	Name = "传送到幸运抽奖区域",
	Callback = function()
      		      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
  	end    
})

local Tab = Window:MakeTab({
	Name = "极速传奇",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "脚本"
})

Tab:AddButton({
  Name = "超强(使用教程可以看我b站[公告])",
  Callback = function()
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ahmadsgamer2/Script--Game/main/Script%20Game"))()
  end
})

local Section = Tab:AddSection({
	Name = "功能"
})

Tab:AddButton({
	Name = "开启卡宠",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/uR6azdQQ"))()
	end
})

Tab:AddButton({
	Name = "自动重生和自动刷等级",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/T9wTL150"))()        
  	end    
})

local Section = Tab:AddSection({
	Name = "传送岛屿"
})

Tab:AddButton({
	Name = "返还出生岛",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9682.98828125, 58.87917709350586, 3099.033935546875)      
  	end    
})

Tab:AddButton({
	Name = "白雪城",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9676.138671875, 58.87917709350586, 3782.69384765625)   
  	end    
})

Tab:AddButton({
	Name = "熔岩城",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11054.96875, 216.83917236328125, 4898.62841796875)       
  	end    
})

Tab:AddButton({
	Name = "传奇公路",
	Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13098.87109375, 216.83917236328125, 5907.6279296875)    
  	end    
})

local Tab = Window:MakeTab({
	Name = "BF",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "青",
  Callback = function()
loadstring(game:HttpGet('https://rentry.co/ct293/raw'))()
  end
})

Tab:AddButton({
  Name = "2(hoho)",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
  end
})
    
    Tab:AddButton({
  Name = "3(强)",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/redz9999"))()
  end
})
    
    Tab:AddButton({
  Name = "4",
  Callback = function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Basicallyy/Basicallyy/main/MinGamingV4.lua")()
  end
})
    
    Tab:AddButton({
  Name = "5(强)",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Minhtriettt/Free-Script/main/MTriet-Hub.lua"))()
  end
})

Tab:AddButton({
  Name = "6(强)",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadsgamer2/Speed-Hub-X/main/SpeedHubX"))()
  end
})

Tab:AddButton({
	Name = "7",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/MaxFast"))()   
  	end    
})

    local Tab = Window:MakeTab({
	Name = "最强战场",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/REPoaFWC/raw",true))();
  end
})

Tab:AddButton({
  Name = "2(需卡密)",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nicuse/RobloxScripts/main/SaitamaBattlegrounds.lua"))()
  end
})
    
    Tab:AddButton({
  Name = "3",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sandwichk/RobloxScripts/main/Scripts/BadWare/Hub/Load.lua", true))()
  end
})

Tab:AddButton({
  Name = "↓有卡密↓",
  Callback = function ()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/Strongest/main/Battlegrounds77"))()
  end
})

Tab:AddButton({
	Name = "↑点击复制卡密↑",
	Callback = function()
     setclipboard("BestTheStrongest5412Roblox")
  end
})

    local Tab = Window:MakeTab({
	Name = "CW",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "无限体力",
  Callback = function()
loadstring(game:HttpGet("https://shz.al/~KSK"))()
  end
})

Tab:AddButton({
    Name = "锁头",
    Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/6RQGbFqD"))()
    end
})

Tab:AddButton({
  Name = "3",
  Callback = function()
loadstring(game:HttpGet("https://paste.gg/p/anonymous/697fc3cad5f743508318cb7399e89432/files/b5923e52edab4e5c91e46b74563d0ae8/raw"))()
  end
})

local Tab = Window:MakeTab({
	Name = "自然灾害",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "指令",
  Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
      end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/LoadstringUjHI6RQpz2o8", true))()
  end
})

Tab:AddButton({
  Name = "3",
  Callback = function()
loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/7c75386107937fa006304efd24543ad4/raw/8d759dfcd95d39949c692735cfdf62baec0bf835/cafwetweg", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "一路向西",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/Drifter0507/scripts/main/westbound"),true))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:GetObjects("rbxassetid://773377961010144323913")[1].Source)()
  end
})

local Tab = Window:MakeTab({
  Name = "造船寻宝",
  Icon = "rbxassetid://7733779610",
  PremiumOnly = false
  })
  
Tab:AddButton({
	Name = "1",
	Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/urmomjklol69/GoldFarmBabft/main/GoldFarm.lua'),true))()
    end
})

Tab:AddButton({
  Name = "复制别人的船",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/max2007killer/auto-build-not-limit/main/autobuild.txt"))()---https://discord.gg/HjNaYs6AnV discord
  end
})

local Tab = Window:MakeTab({
	Name = "蜂群",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "1",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Historia00012/HISTORIAHUB/main/BSS%20FREE"))()
  	end    
})

Tab:AddButton({
	Name = "2",
	Callback = function()
loadstring(game:GetObjects("rbxassetid://77337796104384103988")[0X1].Source)("Pepsi Swarm")
  	end    
})

Tab:AddButton({
	Name = "3",
	Callback = function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Bee-Swarm-Simulator-Cloud-hub-bss-script-source-5818"))()
  	end    
})

Tab:AddButton({
  Name = "4",
  Callback = function ()
loadstring(game:HttpGet("https://pastebin.com/raw/3A61hnGA", true))()
  end

})

local Tab = Window:MakeTab({
	Name = "战争大亨",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "1",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraIsMe/ToraIsMe/main/0wartycoon", true))()
    end
})

Tab:AddButton({
	Name = "2",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nivex123456/War-Tycoon/main/Script"))()
    end
})

local player = Window:MakeTab({
	Name = "刀刃球",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "1(需卡密)",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/3345-c-a-t-s-u-s/New-C4-Remote.lua/main/BetaTest/Bladeball15m.html'))()
  	end
})

player:AddButton({
	Name = "2(需卡密)",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/nqxlOfc/Loaders/main/Blade_Ball.lua'))()
  	end
})

player:AddButton({
    Name= "3",
    Callback=function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/-beta-/main/AutoParry.lua"))()
    end
})

player:AddButton({
  Name = "4",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HKLua/Balls/main/DawnLoader.lua"))()
  end
})

player:AddButton({
  Name = "5",
  Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Unknownscripts/main/slap-battles')))()
  end
})

local player = Window:MakeTab({
	Name = "超级大力士",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "1",
	Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ToraScript/Script/main/Strongman'))()
  	end
})

local player = Window:MakeTab({
	Name = "幸运方块",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "1",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/PlanetHubX/Lucky-Blocks/main/source", true))()
  	end
})

local player = Window:MakeTab({
	Name = "EVADE",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "1",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Evade"))()
  	end
})

local player = Window:MakeTab({
	Name = "Break in 2",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

player:AddButton({ 
	Name = "1",
	Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/Break/main/In"))()
  	end
})

local Tab = Window:MakeTab({
	Name = "兵工厂",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "1",
    Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()
    end
})

Tab:AddButton({
    Name = "2",
    Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init'), true))()
    end
})

local Tab = Window:MakeTab({
	Name = "索尔的RNG",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "1",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Looser3itx/Hmmmmmmmmmmmmmmmmmmmmmmmmmmmm/main/loader.lua"))()
  	end
})

Tab:AddButton({
	Name = "hoho(需卡密)",
	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
  	end
})

Tab:AddButton({
	Name = "3(需卡密)",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/upd/main/rng"))()
  	end
})

local Tab = Window:MakeTab({
	Name = "巴掌大战",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "1(推荐)",
	Callback = function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Slap-Battles-UI-v1-12403"))()  	
end
})

Tab:AddButton({
	Name = "2(需卡密)",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/haxhell/roblox-scripts/main/slap-battles.lua", true))()
  	end
})

Tab:AddButton({
  Name = "自动刷巴掌",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Farm'))()
  end
})

local Tab = Window:MakeTab({
	Name = "鲨口求生2",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddDropdown({
	Name = "免费船只",
	Default = "1",
	Options = {"DuckyBoatBeta", "DuckyBoat", "BlueCanopyMotorboat", "BlueWoodenMotorboat", "UnicornBoat", "Jetski", "RedMarlin", "Sloop", "TugBoat", "SmallDinghyMotorboat", "JetskiDonut", "Marlin", "TubeBoat", "FishingBoat", "VikingShip", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine",  "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"},
	Callback = function(Value)
local ohString1 = (Value)
game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(ohString1)
	end
})

Tab:AddButton({
	Name = "杀鲨鱼",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()
  	end
})

local Tab = Window:MakeTab({
	Name = "火箭发射",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false

})

Tab:AddButton({

  Name = "QB",

  Callback = function ()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xinhaoxian2/QB/main/QB%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84%E6%A8%A1%E6%8B%9F%E5%99%A8.lua"))()

  end

})

local Tab = Window:MakeTab({

	Name = "进击的僵尸",

	Icon = "rbxassetid://7733779610",

	PremiumOnly = false

})

Tab:AddButton({

  Name = "自瞄",

  Callback = function ()

loadstring(game:HttpGet("https://pastebin.com/raw/1Gp9c57U"))()

  end

})

Tab:AddButton({

  Name = "2",

  Callback = function ()

loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Zombie%20Attack", true))()

  end

})

local Tab = Window:MakeTab({

	Name = "动感星期五",

	Icon = "rbxassetid://7733779610",

	PremiumOnly = false

})

Tab:AddButton({

  Name = "1",

  Callback = function ()

loadstring(game:HttpGet('https://raw.githubusercontent.com/ShowerHead-FluxTeam/scripts/main/funky-friday-autoplay'))()

  end

})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/funky-friday-autoplay/main/main.lua",true))()

  end
})

local Tab = Window:MakeTab({

	Name = "模仿者",

	Icon = "rbxassetid://7733779610",

	PremiumOnly = false

})

Tab:AddButton({

  Name = "1",

  Callback = function ()

loadstring(game:HttpGet("https://raw.githubusercontent.com/ttjy9808/THEMIMICNEWMOBILEUINOTBETA/main/README.md"))()

  end

})

local Tab = Window:MakeTab({
	Name = "彩虹朋友",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function ()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()
  end
})

local Tab = Window:MakeTab({
	Name = "手臂摔跤模拟器",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({

  Name = "1",

  Callback = function ()

loadstring(game:HttpGet("https://raw.githubusercontent.com/KrzysztofHub/script/main/loader.lua"))()

  end

})

Tab:AddButton({

  Name = "2",

  Callback = function ()

loadstring(game:HttpGet("https://raw.githubusercontent.com/zicus-scripts/SkullHub/main/Loader.lua"))()

  end

})

local Tab = Window:MakeTab({
	Name = "越狱",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "自瞄",
  Callback = function ()
loadstring(game:HttpGet("https://pastebin.com/raw/1Gp9c57U"))()
  end

})

Tab:AddButton({

  Name = "青",
  Callback = function ()
loadstring(game:HttpGet('https://rentry.co/ct293/raw'))()
  end

})

Tab:AddButton({
  Name = "自动抢劫",
  Callback = function ()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pxsta72/ProjectAuto/main/free"))()
  end
})

local Tab = Window:MakeTab({
	Name = "背上只因剑",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({  
    Name = "1",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraIsMe/ToraIsMe/main/0SwordWarriors"))()
	end
})

local Tab = Window:MakeTab({
	Name = "俄亥俄州",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({  
    Name = "1",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/ohio/main/Roblox232"))()
	end
})

Tab:AddButton({  
    Name = "2",
	Callback = function()
	loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\115\99\114\105\112\116\115\46\118\105\115\117\114\117\115\46\100\101\118\47\111\104\105\111\47\115\111\117\114\99\101"))()
	end
})

Tab:AddButton({  
    Name = "3",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/1QCwNAXx"))()
	end
})

local Tab = Window:MakeTab({
	Name = "法宝模拟器",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/loader_1038"))()
    end
})

local Tab = Window:MakeTab({
	Name = "内脏与黑火药",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "茗月清风",
	Callback = function()
loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\115\120\99\115\114\49\49\52\53\49\52\47\115\120\99\115\114\49\49\52\53\49\52\49\47\109\97\105\110\47\115\120\99\115\114\49\51\52\56\52\56\52\56\56\46\108\117\97"),true))()
  	end
})

Tab:AddButton({
	Name = "2",
	Callback = function()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\34\104\116\116\112\115\58\47\47\102\114\101\101\110\111\116\101\46\98\105\122\47\114\97\119\47\109\117\122\110\104\101\114\104\114\117\34\41\44\116\114\117\101\41\41\40\41\10")()
  	end
})

local Tab = Window:MakeTab({
	Name = "河北唐县",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/s20nni0h/raw"))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Tang%20Country.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "死亡球",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LOLking123456/Ball1/main/Death"))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://github.com/Hosvile/InfiniX/releases/latest/download/main.lua",true))()
  end
})

local Tab = Window:MakeTab({
	Name = "杀手与警长",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/yadbPQUm",true))()
  end
})

local Tab = Window:MakeTab({
	Name = "51区",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Saktk-In-Area51/main/Area51", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "克隆大亨",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HELLLO1073/RobloxStuff/main/CT-Destroyer"))()
  end
})

local Tab = Window:MakeTab({
	Name = "破坏者谜团",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/Ethanoj1/EclipseMM2/master/Script"),true))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ihaveash0rtnamefordiscord/Releases/main/MurderMystery2HighlightESP"))(' Watermelon ?')
  end
})

local Tab = Window:MakeTab({
	Name = "nico下一个机器人",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/elonof/nicosbots-script/main/main.lua",true))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/fartbutt69/Nico-s-Nextbot-Killer/main/script.lua", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "小偷模拟器",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/adrician/Thief-Simulator---GUI/main/Thief%20sim.lua"),true))()
  end
})

local Tab = Window:MakeTab({
	Name = "怪兽宇宙",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/oRWEIEcJ/raw"))()
  end
})

local Tab = Window:MakeTab({
	Name = "汽车经销大亨",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/5o594Q0i/raw"))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/03sAlt/BlueLockSeason2/main/README.md"))()
  end
})

Tab:AddButton({
  Name = "3",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IExpIoit/Script/main/Car%20Dealership%20Tycoon.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "拳击模拟器",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/T4O1SA3q/raw"))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Solx69/Shit-Boy-Hub-Main/main/Master.lua'))()
  end
})

local Tab = Window:MakeTab({
	Name = "恐怖奶奶",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/o688Jvmn/raw"))()
  end
})

local Tab = Window:MakeTab({
	Name = "我的餐厅",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/5R1Ch6kk/raw"))()
  end
})

local Tab = Window:MakeTab({
	Name = "钓鱼模拟器",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/reddythedev/Reddy-Hub/main/_Loader'))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bebedi15/SRM-Scripts/main/Bebedi9960/SRMHub"))()
  end
})

local Tab = Window:MakeTab({
	Name = "旗帜战争",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Flag%20Wars.txt'))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://pastefy.app/otEg6PJV/raw"))()
  end
})

local Tab = Window:MakeTab({
	Name = "起床战争",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Alan0947383/Demonic-HUB-V2/main/S-C-R-I-P-T.lua",true))()
  end
})

Tab:AddButton({
  Name = "2",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "活过杀手",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Milan08Studio/ChairWare/main/main.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "基本都是混音FNF",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MariyaFurmanova/Library/main/BasicallyFNF", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "索纳里亚世界",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Mangnex/Creature-of-Sonaria-Mobile/main/Temporal.lua'))()
  end
})

local Tab = Window:MakeTab({
	Name = "健身联盟",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraScript/Script/main/GymLeague", true))()
  end
})

local Tab = Window:MakeTab({
	Name = "龙之冒险",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "1",
  Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Mangnex/Creature-of-Sonaria-Mobile/main/Temporal.lua'))()
  end
}）

local Tab = Window:MakeTab({
	Name = "俄亥俄州",
	Icon = "rbxassetid://7733779610",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "纳西妲",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/rbxluau/Roblox/main/ScriptHub.lua"))()
  end
}）

Tab:AddButton({
  Name = "fdf",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Night5449791/LUA-SCRIPT/main/Protected_3946246775852348.txt"))()
  end
}）