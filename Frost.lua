
game.TextChatService.ChatWindowConfiguration.Enabled = true
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/shenqin/refs/heads/main/77888.txt"))()

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end
    return result
end

local openButtonColor = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("#FF0000")),
    ColorSequenceKeypoint.new(0.2, Color3.fromHex("#FFA500")),
    ColorSequenceKeypoint.new(0.4, Color3.fromHex("#FFFF00")),
    ColorSequenceKeypoint.new(0.6, Color3.fromHex("#00FF00")),
    ColorSequenceKeypoint.new(0.65, Color3.fromHex("#00FFFF")),
    ColorSequenceKeypoint.new(0.8, Color3.fromHex("#0000FF")),
    ColorSequenceKeypoint.new(0.9, Color3.fromHex("#8A2BE2")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#FFFFFF"))
})

local Window = WindUI:CreateWindow({
    Title = "frost HUB V2",
    Icon = "rbxassetid://98541457845136",
    IconThemed = true,
    Author = "ohio",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(320, 270),
    Transparent = false,
    Theme = "Dark",
    User = { Enabled = true },
    SideBarWidth = 150,
    ScrollBarEnabled = true,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
})

Window:EditOpenButton({
    Title = "Frost HUB",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = openButtonColor,
    Draggable = true,
})
local Main = Window:Tab({Title = "战斗", Icon = "settings"})

local fistStyles = {
    { key = "meleepunch",    name = "普通拳击", dmg = 15 },
    { key = "meleemegapunch",name = "重拳",     dmg = 200 },
    { key = "meleekick",     name = "站立踢击", dmg = 20 },
    { key = "meleejumpKick", name = "宇将军飞踢", dmg = 20 },
}
local hitMOD = "meleemegapunch"

Main:Dropdown({
    Title  = "选择拳头方式",
    Values = { "普通拳击", "重拳", "站立踢击", "宇将军飞踢" },
    Value  = "重拳",
    Callback = function(val)
        for _, v in ipairs(fistStyles) do
            if v.name == val then 
                hitMOD = v.key 
                break 
            end
        end
    end
})

Main:Toggle({
    Title = "打击光环",
    Value = false,
    Callback = function(value)
        autoAttack = value
        if value then
            local RS = game:GetService("ReplicatedStorage")
            local Players = game:GetService("Players")
            local LP = Players.LocalPlayer
            local storage = RS:WaitForChild("devv"):WaitForChild("remoteStorage")
            local swing, hit
            
            local h
            h = hookmetamethod(game, "__namecall", function(s, ...)
                local m = getnamecallmethod()
                local a = {...}
                if m == "FireServer" and s.Parent == storage then
                    if type(a[1]) == "string" and a[1]:match("^melee") and #a == 1 then
                        swing = s
                    elseif a[1] == "player" and type(a[2]) == "table" then
                        hit = s
                    end
                end
                return h(s, ...)
            end)
            
            local function getNearestPlayer()
                local c = LP.Character
                if not c or not c.PrimaryPart then return end
                
                local nearestPlayer, minDistance = nil, math.huge
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LP and player.Character and player.Character.PrimaryPart then
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            local distance = (c.PrimaryPart.Position - player.Character.PrimaryPart.Position).Magnitude
                            if distance < minDistance and distance < 18 then
                                nearestPlayer, minDistance = player, distance
                            end
                        end
                    end
                end
                return nearestPlayer
            end
            
            spawn(function()
                while autoAttack do
                    pcall(function()
                        local target = getNearestPlayer()
                        if target and swing and hit then
                            swing:FireServer("meleepunch")
                            task.wait(0.01)
                            hit:FireServer("player", {
                                meleeType = hitMOD,
                                hitPlayerId = target.UserId
                            })
                        end
                    end)
                    task.wait(0.04)
                end
            end)
        end
    end
})

local bombardmentEnabled=false local bombardmentConnection local lastBombardmentTime=0 local lastAmmoPurchaseTime=0 local ammoPurchaseInterval=2 local ammoPurchaseAmount=2 local ignoreFriends=false local function getBombardmentInterval()return 0.05 end local function getAccuracyOffset()return Vector3.new(math.random(-0.3,0.3),math.random(-0.3,0.3),math.random(-0.3,0.3))end local function fixRemoteNames()local signalModule=require(game:GetService("ReplicatedStorage").devv.client.Helpers.remotes.Signal)for i,v in next,getupvalue(signalModule.LinkSignal,1)do v.Name=i v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)end for i,v in next,getupvalue(signalModule.InvokeServer,1)do v.Name=i v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)end for i,v in next,getupvalue(signalModule.FireServer,1)do v.Name=i v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)end end fixRemoteNames()local function hasShield(character)if not character then return false end local shield=character:FindFirstChild("Shield")or character:FindFirstChild("ForceField")return shield ~=nil end local function isFriend(player)if not ignoreFriends then return false end local localPlayer=game:GetService("Players").LocalPlayer return localPlayer:IsFriendsWith(player.UserId)end local function getDistanceFromPlayer(targetPosition)local localPlayer=game:GetService("Players").LocalPlayer local character=localPlayer.Character if not character then return math.huge end local humanoidRootPart=character:FindFirstChild("HumanoidRootPart")if not humanoidRootPart then return math.huge end return(humanoidRootPart.Position-targetPosition).Magnitude end local function purchaseAmmo()local weaponTypes={"AK-47","M4A1","M249","Minigun","Deagle","RPG","Raygun","M1911"}for _,weaponType in ipairs(weaponTypes)do require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchaseAmmo",weaponType)end end local function performBombardment()local ReplicatedStorage=game:GetService("ReplicatedStorage")local Players=game:GetService("Players")local localPlayer=Players.LocalPlayer local reload=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload),2)local t=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot),1)local reloadEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")local ammo=t.item.ammoManager local gunid=t.item.guid local firemode=t.item.firemode firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)reload()local targets={}for _,player in ipairs(Players:GetPlayers())do if player==localPlayer then continue end if isFriend(player)then continue end local character=player.Character if not character then continue end if hasShield(character)then continue end local humanoid=character:FindFirstChildOfClass("Humanoid")if not humanoid or humanoid.Health<=0 then continue end local hitbox=character:FindFirstChild("Hitbox")if not hitbox then continue end local headHitbox=hitbox:FindFirstChild("Head_Hitbox")if not headHitbox then continue end local targetRootPart=character:FindFirstChild("HumanoidRootPart")or humanoid.RootPart if not targetRootPart then continue end local distance=getDistanceFromPlayer(targetRootPart.Position)table.insert(targets,{player=player,character=character,headHitbox=headHitbox,rootPart=targetRootPart,distance=distance})end if #targets==0 then return end table.sort(targets,function(a,b)return a.distance<b.distance end)for _,targetData in ipairs(targets)do if hasShield(targetData.character)then continue end local targetHeadCFrame=targetData.headHitbox.CFrame local targetHeadSize=targetData.headHitbox.Size local targetHeadPosition=targetData.headHitbox.Position local targetPlayerId=targetData.player.UserId local shots=8 for i=1,math.min(ammo.ammo,shots)do local offset=getAccuracyOffset()local adjustedCFrame=targetHeadCFrame+offset local Event1=ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")if Event1 then Event1:FireServer(gunid,{{"EZohio123",adjustedCFrame}},firemode)end local Event2=ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")if Event2 then Event2:FireServer("EZohio123","player",{hitPart=targetData.headHitbox,hitPlayerId=targetPlayerId,hitSize=targetHeadSize,pos=targetHeadPosition+offset})end end end firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)reload()end
Main:Toggle({
    Title = "枪械杀戮光环",
    Default = false,
    Callback = function(Value)
bombardmentEnabled=Value if bombardmentConnection then bombardmentConnection:Disconnect()bombardmentConnection=nil end if Value then local RunService=game:GetService("RunService")local Players=game:GetService("Players")local localPlayer=Players.LocalPlayer local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)bombardmentConnection=RunService.Heartbeat:Connect(function()local currentTime=tick()local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()if ping>1850 then return end if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then for i=1,ammoPurchaseAmount do pcall(purchaseAmmo)end lastAmmoPurchaseTime=currentTime end if currentTime-lastBombardmentTime>=getBombardmentInterval()then pcall(performBombardment)lastBombardmentTime=currentTime end end)_G.Bombardment={connection=bombardmentConnection,originalGUID=originalGUID}else if _G.Bombardment then if _G.Bombardment.connection then _G.Bombardment.connection:Disconnect()end if _G.Bombardment.originalGUID then local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)hookfunction(guid,_G.Bombardment.originalGUID)end _G.Bombardment=nil end end
    end
})

Main:Toggle({
    Title = "忽略好友",
    Default = false,
    Callback = function(Value)
        ignoreFriends = Value
    end
})


local armorOptions = {"Light Vest", "Heavy Vest", "Military Vest", "EOD Vest"}
local selectedArmor = "Light Vest"
local AutoArmor = false

Main:Dropdown({
    Title = "选择甲类型",
    Values = {"轻甲", "重甲", "军用甲", "排爆甲"},
    Value = "轻甲",
    Callback = function(option)
        if option == "轻甲" then
            selectedArmor = "Light Vest"
        elseif option == "重甲" then
            selectedArmor = "Heavy Vest"
        elseif option == "军用甲" then
            selectedArmor = "Military Vest"
        elseif option == "排爆甲" then
            selectedArmor = "EOD Vest"
        end
    end
})

Main:Toggle({
    Title = "自动穿甲",
    Default = false,
    Callback = function(Value)
        AutoArmor = Value
        if Value then
            task.spawn(function()
                while AutoArmor do
                    pcall(function()
                        local player = game:GetService('Players').LocalPlayer
                        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health > 35 then
                            local inventory = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
                            local hasArmor = false
                            
                            for i, v in next, inventory do
                                if v.name == selectedArmor then
                                    hasArmor = true
                                    local armorGuid = v.guid
                                    local armor = player:GetAttribute('armor')
                                    if armor == nil or armor <= 0 then
                                        require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("equip", armorGuid)
                                        require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("useConsumable", armorGuid)
                                        require(game:GetService("ReplicatedStorage").devv).load("Signal").FireServer("removeItem", armorGuid)
                                    end
                                    break
                                end
                            end
                            
                            if not hasArmor then
                                require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", selectedArmor)
                            end
                        end
                    end)
                    wait(0)
                end
            end)
        end
    end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Signal = require(ReplicatedStorage.devv).load("Signal")
local item = require(ReplicatedStorage.devv).load("v3item")

local qtid
for i, v in next, item.inventory.items do
    if v.name == 'Fists' then
        qtid = v.guid
        break
    end
end

local autoEquipFists = false
local autoEquipConnection

Main:Toggle({
    Title = "自动装备拳头",
    Default = false,
    Callback = function(Value)
        autoEquipFists = Value
        if autoEquipConnection then
            autoEquipConnection:Disconnect()
            autoEquipConnection = nil
        end
        
        if Value then
            autoEquipConnection = RunService.Heartbeat:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        Signal.FireServer("equip", qtid)
                    end
                end)
            end)
        end
    end
})
local melee = require(game:GetService("ReplicatedStorage").devv).load("ClientReplicator")
local lp = game:GetService("Players").LocalPlayer
local AutoKnockReset = false
Main:Toggle({
    Title = "防倒地",
    Default = false,
    Callback = function(Value)
        AutoKnockReset = Value
        if Value then
            task.spawn(function()
                while AutoKnockReset do
                    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                        melee.Set(lp, "knocked", false)
                        melee.Replicate("knocked")
                    end
                    wait()
                end
            end)
        end
    end
})

local healOptions = {"Bandage", "Cookie"}
local selectedHealItem = "Bandage"
local healThread = nil

Main:Dropdown({
    Title = "选择回血物品",
    Values = {"绷带", "饼干"},
    Value = "绷带",
    Callback = function(option)
        if option == "绷带" then
            selectedHealItem = "Bandage"
        elseif option == "饼干" then
            selectedHealItem = "Cookie"
        end
    end
})

Main:Toggle({
    Title = "自动回血",
    Default = false,
    Callback = function(Value)
        if healThread then
            task.cancel(healThread)
            healThread = nil
        end

        if Value then
            healThread = task.spawn(function()
                while true do
                    task.wait()
                    Signal.InvokeServer("attemptPurchase", selectedHealItem)
                    for _, v in next, item.inventory.items do
                        if v.name == selectedHealItem then
                            local healItemGuid = v.guid
                            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                            local Humanoid = Character:WaitForChild('Humanoid')
                            if Humanoid.Health >= 38 and Humanoid.Health < Humanoid.MaxHealth then
                                Signal.FireServer("equip", healItemGuid)
                                Signal.FireServer("useConsumable", healItemGuid)
                                Signal.FireServer("removeItem", healItemGuid)
                            end
                            break
                        end
                    end
                end
            end)
        end
    end
})

local maskOptions = {"Surgeon Mask", "Hockey Mask", "Blue Bandana", "Black Bandana", "Red Bandana"}
local selectedMask = "Surgeon Mask"
local autoMaskEnabled = false

Main:Dropdown({
    Title = "选择口罩类型",
    Values = {"口罩", "小丑面具", "蓝色头巾", "黑色头巾", "红色头巾"},
    Value = "口罩",
    Callback = function(option)
        if option == "口罩" then
            selectedMask = "Surgeon Mask"
        elseif option == "小丑面具" then
            selectedMask = "Hockey Mask"
        elseif option == "蓝色头巾" then
            selectedMask = "Blue Bandana"
        elseif option == "黑色头巾" then
            selectedMask = "Black Bandana"
        elseif option == "红色头巾" then
            selectedMask = "Red Bandana"
        end
    end
})

Main:Toggle({
    Title = "自动口罩",
    Default = false,
    Callback = function(Value)
        autoMaskEnabled = Value
        
        if not Value then return end
        
        task.spawn(function()
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Signal = require(game:GetService("ReplicatedStorage").devv).load("Signal")
            local item = require(game:GetService("ReplicatedStorage").devv).load("v3item")

            local function purchaseAndEquipMask()
                if not autoMaskEnabled then return end
                
                local hasMask = false
                for _, v in pairs(item.inventory.items) do
                    if v.name == selectedMask then
                        hasMask = true
                        break
                    end
                end

                if not hasMask then
                    Signal.InvokeServer("attemptPurchase", selectedMask)
                    task.wait()
                end

                for _, v in pairs(item.inventory.items) do
                    if v.name == selectedMask then
                        Signal.FireServer("equip", v.guid)
                        Signal.FireServer("wearMask", v.guid)
                        break
                    end
                end
            end

            purchaseAndEquipMask()

            local conn
            conn = LocalPlayer.CharacterAdded:Connect(function(char)
                char:WaitForChild("HumanoidRootPart")
                task.wait()
                purchaseAndEquipMask()
            end)

            while autoMaskEnabled do
                task.wait()
            end

            if conn then conn:Disconnect() end
        end)
    end
})
Main:Button({
    Title = "变身警察",
    Callback = function()
        local function fastInteractProximityPrompt(proximityPrompt)
    if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
        return false
    end
    
  
    local originalRequiresLineOfSight = proximityPrompt.RequiresLineOfSight
    local originalHoldDuration = proximityPrompt.HoldDuration
    
    
    proximityPrompt.RequiresLineOfSight = false
    proximityPrompt.HoldDuration = 0
    
   
    for i = 1, 5 do
        fireproximityprompt(proximityPrompt)
        task.wait(0.01)
    end
    
   
    proximityPrompt.RequiresLineOfSight = originalRequiresLineOfSight
    proximityPrompt.HoldDuration = originalHoldDuration
    
    return true
end

local function interactAtPosition(position)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
   
    local originalPosition = rootPart.CFrame
    
    rootPart.CFrame = CFrame.new(position)
    task.wait(0.2) 
    
    local closestPrompt = nil
    local closestDistance = math.huge
    
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local promptParent = prompt.Parent
            if promptParent and (promptParent:IsA("MeshPart") or promptParent:IsA("Part")) then
                local distance = (rootPart.Position - promptParent.Position).Magnitude
                
                if distance < closestDistance then
                    closestDistance = distance
                    closestPrompt = prompt
                end
            end
        end
    end
    
    local interacted = false
    if closestPrompt then
        interacted = fastInteractProximityPrompt(closestPrompt)
    end
    rootPart.CFrame = originalPosition
    
    return interacted
end
interactAtPosition(Vector3.new(580.19, 26.67, -873.15))
interactAtPosition(Vector3.new(587.30, 26.66, -871.14))

    end
})

Main:Button({
    Title = "小丑头套",
    Callback = function()
        local function fastInteractProximityPrompt(proximityPrompt)
    if not proximityPrompt or not proximityPrompt:IsA("ProximityPrompt") then
        return false
    end
    
  
    local originalRequiresLineOfSight = proximityPrompt.RequiresLineOfSight
    local originalHoldDuration = proximityPrompt.HoldDuration
    
    
    proximityPrompt.RequiresLineOfSight = false
    proximityPrompt.HoldDuration = 0
    
   
    for i = 1, 5 do
        fireproximityprompt(proximityPrompt)
        task.wait(0.01)
    end
    
   
    proximityPrompt.RequiresLineOfSight = originalRequiresLineOfSight
    proximityPrompt.HoldDuration = originalHoldDuration
    
    return true
end

local function interactAtPosition(position)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
   
    local originalPosition = rootPart.CFrame
    
    rootPart.CFrame = CFrame.new(position)
    task.wait(0.2) 
    
    local closestPrompt = nil
    local closestDistance = math.huge
    
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local promptParent = prompt.Parent
            if promptParent and (promptParent:IsA("MeshPart") or promptParent:IsA("Part")) then
                local distance = (rootPart.Position - promptParent.Position).Magnitude
                
                if distance < closestDistance then
                    closestDistance = distance
                    closestPrompt = prompt
                end
            end
        end
    end
    
    local interacted = false
    if closestPrompt then
        interacted = fastInteractProximityPrompt(closestPrompt)
    end
    rootPart.CFrame = originalPosition
    
    return interacted
end
interactAtPosition(Vector3.new(1124.44, 16.84, 113.32))

    end
})

local Main = Window:Tab({Title = "枪锁人", Icon = "settings"})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer

local autoFireSettings = {
    targetPlayer = nil,
    isAutoFiring = false,
    ignoreShield = true,
    fireMode = "全部",
    bulletCount = {min = 1, max = 3},
    autoReload = false  -- 新增：自动换弹开关
}

local playerList = {"无"}
local selectedPlayer = "无"
local dropdownRef = nil

local function updatePlayerList()
    local currentPlayers = Players:GetPlayers()
    local newPlayerList = {"无"}
    for _, player in ipairs(currentPlayers) do
        if player ~= localPlayer then
            table.insert(newPlayerList, player.Name)
        end
    end
    playerList = newPlayerList
    if dropdownRef then
        dropdownRef:Refresh(playerList, true)
    end
end

local function getPlayerHealth(character)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health or 0
end

local function hasShield(character)
    if not character or not autoFireSettings.ignoreShield then return false end
    local shield = character:FindFirstChild("Shield") or character:FindFirstChild("ForceField")
    return shield ~= nil
end

local function autoFire()
    if not autoFireSettings.isAutoFiring then return end
    
    local reload = getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload), 2)
    local t = getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot), 1)
    local reloadEvent = ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")
    
    local ammo = t.item.ammoManager
    local gunid = t.item.guid
    local firemode = t.item.firemode
    
    -- 只有当自动换弹开启时才执行换弹逻辑
    if autoFireSettings.autoReload and ammo.ammo <= 0 then
        firesignal(reloadEvent.OnClientEvent, gunid, 0, ammo.ammoOut)
        reload()
        return
    end
    
    local targets = {}
    local localCharacter = localPlayer.Character
    local localRootPart = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    if autoFireSettings.fireMode == "单锁" and autoFireSettings.targetPlayer then
        local targetPlayer = autoFireSettings.targetPlayer
        if targetPlayer.Character and not hasShield(targetPlayer.Character) then
            local character = targetPlayer.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 and humanoidRootPart then
                table.insert(targets, {
                    player = targetPlayer,
                    character = character,
                    rootPart = humanoidRootPart,
                    health = humanoid.Health
                })
            end
        end
    else
        if localRootPart then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and not hasShield(player.Character) then
                    local character = player.Character
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid and humanoid.Health > 0 and humanoidRootPart then
                        local distance = (localRootPart.Position - humanoidRootPart.Position).Magnitude
                        table.insert(targets, {
                            player = player,
                            character = character,
                            distance = distance,
                            rootPart = humanoidRootPart,
                            health = humanoid.Health
                        })
                    end
                end
            end
            
            table.sort(targets, function(a, b)
                return a.distance < b.distance
            end)
            
            if #targets > 5 then
                targets = {table.unpack(targets, 1, 5)}
            end
        end
    end
    
    if #targets == 0 then return end
    
    local Event1 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")
    local Event2 = ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")
    
    if Event1 and Event2 then
        for _, targetData in ipairs(targets) do
            local bulletCount = autoFireSettings.bulletCount.min
            if targetData.health < 50 then
                bulletCount = math.min(autoFireSettings.bulletCount.max, 2)
            elseif targetData.health < 25 then
                bulletCount = autoFireSettings.bulletCount.min
            else
                bulletCount = autoFireSettings.bulletCount.max
            end
            
            for i = 1, bulletCount do
                -- 只有当自动换弹关闭且弹药为0时，停止射击
                if not autoFireSettings.autoReload and ammo.ammo <= 0 then 
                    break 
                end
                
                local targetCharacter = targetData.character
                local targetPart = targetCharacter:FindFirstChild("Head") or 
                                  targetCharacter:FindFirstChild("UpperTorso") or 
                                  targetCharacter:FindFirstChild("HumanoidRootPart")
                
                if targetPart then
                    local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        Event1:FireServer(gunid, {{"TrackingBullet", targetPart.CFrame}}, firemode)
                        Event2:FireServer("TrackingBullet", "player", {
                            hitPart = targetPart,
                            hitPlayerId = targetData.player.UserId,
                            hitSize = targetPart.Size,
                            pos = targetPart.Position
                        })
                        ammo.ammo = ammo.ammo - 1
                    end
                end
                if not autoFireSettings.autoReload and ammo.ammo <= 0 then 
                    break 
                end
            end
            if not autoFireSettings.autoReload and ammo.ammo <= 0 then 
                break 
            end
        end
    end
    
    -- 只有当自动换弹开启时才执行换弹
    if autoFireSettings.autoReload and ammo.ammo <= 0 then
        firesignal(reloadEvent.OnClientEvent, gunid, 0, ammo.ammoOut)
        reload()
    end
end

local autoFireConnection
local function toggleAutoFire(isEnabled)
    autoFireSettings.isAutoFiring = isEnabled
    if isEnabled then
        if autoFireConnection then
            autoFireConnection:Disconnect()
        end
        autoFireConnection = game:GetService("RunService").Heartbeat:Connect(autoFire)
    else
        if autoFireConnection then
            autoFireConnection:Disconnect()
            autoFireConnection = nil
        end
    end
end

updatePlayerList()

dropdownRef = Main:Dropdown({
    Title = "选择目标[单锁]",
    Values = playerList,
    Value = "无",
    Callback = function(option)
        selectedPlayer = option
        autoFireSettings.targetPlayer = option and option ~= "无" and Players:FindFirstChild(option) or nil
    end
})

Main:Dropdown({
    Title = "选择模式",
    Values = {"全部", "单锁"},
    Value = "全部",
    Callback = function(mode)
        autoFireSettings.fireMode = mode
    end
})

Main:Toggle({
    Title = "开始锁人",
    Value = false,  
    Callback = toggleAutoFire
})
Main:Toggle({
    Title = "自动开火换弹",
    Value = false,  
    Callback = function(isEnabled)
        autoFireSettings.autoReload = isEnabled
    end
})
Main:Toggle({
    Title = "忽略保护盾",
    Value = true,
    Callback = function(isEnabled)
        autoFireSettings.ignoreShield = isEnabled
    end
})


Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

local MainTab = Window:Tab({Title = "魔法", Icon = "settings"})
local bombardmentEnabled={RPG=false,Flamethrower=false,AcidGun=false}
local bombardmentConnections={}
local lastBombardmentTime=0 
local lastAmmoPurchaseTime=0 
local ammoPurchaseInterval=2 
local ammoPurchaseAmount=2 
local BOMBARDMENT_DURATION=3.2 

local function fixRemoteNames()
    local signalModule=require(game:GetService("ReplicatedStorage").devv.client.Helpers.remotes.Signal)
    for i,v in next,getupvalue(signalModule.LinkSignal,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
    for i,v in next,getupvalue(signalModule.InvokeServer,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
    for i,v in next,getupvalue(signalModule.FireServer,1)do 
        v.Name=i 
        v:GetPropertyChangedSignal("Name"):Connect(function()v.Name=i end)
    end 
end 
fixRemoteNames()

local function hasShield(player)
    local character=player.Character 
    if not character then return false end 
    local shieldPart=character:FindFirstChild("Shield")or character:FindFirstChild("ForceField")
    if shieldPart then return true end 
    for _,child in ipairs(character:GetDescendants())do 
        if child:IsA("ParticleEmitter")and child.Name:lower():find("shield")then 
            return true 
        end 
    end 
    return false 
end 

local function getAccuracyOffset()
    return Vector3.new(math.random(-0.2,0.2),math.random(-0.2,0.2),math.random(-0.2,0.2))
end 

local function purchaseAmmo(weaponType)
    local ammoType 
    if weaponType=="RPG" then 
        ammoType="RPG" 
    elseif weaponType=="Flamethrower" then 
        ammoType="Flamethrower" 
    elseif weaponType=="AcidGun" then 
        ammoType="Ace Gun" 
    end 
    require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchaseAmmo",ammoType)
end 

local function createVisualEffect(position)
    local explosion = Instance.new("Explosion")
    explosion.Position = position
    explosion.BlastPressure = 0
    explosion.BlastRadius = 10
    explosion.ExplosionType = Enum.ExplosionType.NoCraters
    explosion.DestroyJointRadiusPercent = 0
    explosion.Parent = workspace
    delay(1, function() explosion:Destroy() end)
end

local function performBombardment(weaponType)
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local Players=game:GetService("Players")
    local localPlayer=Players.LocalPlayer 
    local reload=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.reload),2)
    local t=getupvalue(require(game:GetService("ReplicatedStorage").devv.client.Objects.v3item.bin.Gun.modules.controller.modules.shoot),1)
    local reloadEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("reload")
    local ammo=t.item.ammoManager 
    local gunid=t.item.guid 
    local firemode=t.item.firemode 
    
    firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)
    reload()
    
    local targets={}
    for _,player in ipairs(Players:GetPlayers())do 
        if player==localPlayer then continue end 
        if hasShield(player)then continue end 
        local character=player.Character 
        if not character then continue end 
        local humanoid=character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health<=0 then continue end 
        
    
        if humanoid.Health <= 18 then continue end
        
        local hitbox=character:FindFirstChild("Hitbox")
        if not hitbox then continue end 
        local headHitbox=hitbox:FindFirstChild("Head_Hitbox")
        if not headHitbox then continue end 
        local targetRootPart=character:FindFirstChild("HumanoidRootPart")or humanoid.RootPart 
        if not targetRootPart then continue end 
        
        table.insert(targets,{player=player,character=character,headHitbox=headHitbox,rootPart=targetRootPart,humanoid=humanoid})
    end 
    
    if #targets==0 then return end 
    
    for _,targetData in ipairs(targets)do 
        local targetHeadCFrame=targetData.headHitbox.CFrame 
        local targetHeadPosition=targetData.headHitbox.Position 
        local targetPlayerId=targetData.player.UserId 
        targetHeadCFrame=CFrame.new(targetHeadPosition)
        
        if weaponType=="RPG" then 
            local shots=5 
            for i=1,math.min(ammo.ammo,shots)do 
                local offset=getAccuracyOffset()
                local adjustedCFrame=targetHeadCFrame+offset 
                local Event1=ReplicatedStorage.devv.remoteStorage:FindFirstChild("replicateProjectiles")
                if Event1 then 
                    Event1:FireServer(gunid,{{"EZohio123",adjustedCFrame}},firemode)
                end 
                local Event2=ReplicatedStorage.devv.remoteStorage:FindFirstChild("projectileHit")
                if Event2 then 
                    Event2:FireServer("EZohio123","player",{hitPart=targetData.headHitbox,hitPlayerId=targetPlayerId,hitSize=targetData.headHitbox.Size,pos=targetHeadPosition+offset})
                end 
                
             
                createVisualEffect(targetHeadPosition + offset)
            end 
            
            local rocketHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("rocketHit")
            if rocketHitEvent then 
                for i=1,5 do 
                    local offset=getAccuracyOffset()
                    rocketHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                 
                    createVisualEffect(targetHeadPosition + offset)
                end 
            end 
            
        elseif weaponType=="Flamethrower" then 
            local flameHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("flameHit")
            if flameHitEvent then 
                for i=1,50 do 
                    local offset=getAccuracyOffset()
                    flameHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                end 
            end 
            
        elseif weaponType=="AcidGun" then 
            local acidHitEvent=ReplicatedStorage.devv.remoteStorage:FindFirstChild("acidHit")
            if acidHitEvent then 
                for i=1,6 do 
                    local offset=getAccuracyOffset()
                    acidHitEvent:FireServer("EZohio123","EZohio123",targetHeadPosition+offset)
                end 
            end 
        end 
        
    
        if targetData.humanoid.Health > 18 then
          
            if weaponType == "RPG" then
                for i = 1, 2 do
                    local offset = getAccuracyOffset()
                    local rocketHitEvent = ReplicatedStorage.devv.remoteStorage:FindFirstChild("rocketHit")
                    if rocketHitEvent then
                        rocketHitEvent:FireServer("EZohio123", "EZohio123", targetHeadPosition + offset)
                        createVisualEffect(targetHeadPosition + offset)
                    end
                end
            end
        end
    end 
    
    firesignal(reloadEvent.OnClientEvent,gunid,0,ammo.ammoOut)
    reload()
end

MainTab:Toggle({
    Title="全图RPG",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.RPG=Value 
        if bombardmentConnections.RPG then 
            bombardmentConnections.RPG:Disconnect()
            bombardmentConnections.RPG=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.RPG=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>1850 then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"RPG")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("RPG")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.RPGBombardment={
                connection=bombardmentConnections.RPG,
                originalGUID=originalGUID
            }
        else 
            if _G.RPGBombardment then 
                if _G.RPGBombardment.connection then 
                    _G.RPGBombardment.connection:Disconnect()
                end 
                if _G.RPGBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.RPGBombardment.originalGUID)
                end 
                _G.RPGBombardment=nil 
            end 
        end 
    end
})

MainTab:Toggle({
    Title="全图火焰发射器",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.Flamethrower=Value 
        if bombardmentConnections.Flamethrower then 
            bombardmentConnections.Flamethrower:Disconnect()
            bombardmentConnections.Flamethrower=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.Flamethrower=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>1850 then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"Flamethrower")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("Flamethrower")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.FlamethrowerBombardment={
                connection=bombardmentConnections.Flamethrower,
                originalGUID=originalGUID
            }
        else 
            if _G.FlamethrowerBombardment then 
                if _G.FlamethrowerBombardment.connection then 
                    _G.FlamethrowerBombardment.connection:Disconnect()
                end 
                if _G.FlamethrowerBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.FlamethrowerBombardment.originalGUID)
                end 
                _G.FlamethrowerBombardment=nil 
            end 
        end 
    end
})

MainTab:Toggle({
    Title="全图硫酸枪",
    Default=false,
    Callback=function(Value)
        bombardmentEnabled.AcidGun=Value 
        if bombardmentConnections.AcidGun then 
            bombardmentConnections.AcidGun:Disconnect()
            bombardmentConnections.AcidGun=nil 
        end 
        if Value then 
            local RunService=game:GetService("RunService")
            local Players=game:GetService("Players")
            local localPlayer=Players.LocalPlayer 
            local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
            local originalGUID=hookfunction(guid,function(...)return "EZohio123" end)
            
            bombardmentConnections.AcidGun=RunService.Heartbeat:Connect(function()
                local currentTime=tick()
                local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                if ping>1850 then return end 
                
                if currentTime-lastAmmoPurchaseTime>=ammoPurchaseInterval then 
                    for i=1,ammoPurchaseAmount do 
                        pcall(purchaseAmmo,"AcidGun")
                    end 
                    lastAmmoPurchaseTime=currentTime 
                end 
                
                if currentTime-lastBombardmentTime>=0.15 then 
                    pcall(function()
                        performBombardment("AcidGun")
                    end)
                    lastBombardmentTime=currentTime 
                end 
            end)
            
            _G.AcidGunBombardment={
                connection=bombardmentConnections.AcidGun,
                originalGUID=originalGUID
            }
        else 
            if _G.AcidGunBombardment then 
                if _G.AcidGunBombardment.connection then 
                    _G.AcidGunBombardment.connection:Disconnect()
                end 
                if _G.AcidGunBombardment.originalGUID then 
                    local guid=require(game:GetService("ReplicatedStorage").devv.shared.Helpers.string.GUID)
                    hookfunction(guid,_G.AcidGunBombardment.originalGUID)
                end 
                _G.AcidGunBombardment=nil 
            end 
        end 
    end
})

local Main = Window:Tab({Title = "金钱", Icon = "user"})
local mode = "隐藏"
local targetPosition = CFrame.new(296.69, -127.59, -602.67)

Main:Dropdown({
    Title = "模式选择",
    Values = {"隐藏", "活跃"},
    Value = "隐藏",
    Callback = function(option)
        mode = option
    end
})

local atmThread
local halloweenThread
local kill77
local autoSellEnabled = false
local autoSellConnection = nil
local autoSellInterval = 0.001
local lastBombardmentTime = 0
local autoOpenLuckyBlocks = false
local luckyBlockThread = nil
local autoOpenMaterialBoxes = false
local materialBoxThread = nil
local autoOpenSafes = false
local autoOpenChests = false
local safeThread = nil
local chestThread = nil
local SmallSafe1 = false
local lock = false
local treasureSettings = {enabled = false}
local mngh = false
local setting = {autoMoney = false, minMoney = 250}

local function getRootPart()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart
    end
    return nil
end

local function teleportToPosition(position)
    local root = getRootPart()
    if root then
        root.CFrame = position
    end
end

local function teleportToHideSpot()
    if mode == "隐藏" then
        teleportToPosition(targetPosition)
    end
end

local function checkAnyTargetExists()
    if workspace:FindFirstChild("ATMs") then
        for _, obj in ipairs(workspace.ATMs:GetChildren()) do
            if obj:IsA("Model") and obj:GetAttribute("health") and obj:GetAttribute("health") > 0 then
                return true
            end
        end
    end
    
    if workspace:FindFirstChild("Halloween") then
        for _, obj in ipairs(workspace.Halloween:GetChildren()) do
            if obj:IsA("Model") and obj:GetAttribute("health") and obj:GetAttribute("health") > 0 then
                return true
            end
        end
    end
    
    if workspace:FindFirstChild("BankRobbery") and workspace.BankRobbery:FindFirstChild("BankCash") then
        return true
    end
    
    for _, obj in ipairs(workspace.Game.Entities:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and (obj.ActionText == "Crack Safe" or obj.ActionText == "Crack Chest") and obj.Enabled then
            return true
        end
    end
    
    if workspace.Game.Entities:FindFirstChild("SmallSafe") then
        for _, model in pairs(workspace.Game.Entities.SmallSafe:GetChildren()) do
            if model.ClassName == 'Model' then
                return true
            end
        end
    end
    
    if workspace.Game.Local.Debris:FindFirstChild('TreasureMarker') then
        return true
    end
    
    return false
end

local function pickupAll15m(centerPos)
    local root = getRootPart()
    if not root then return 0 end
    
    local itemPickups = workspace.Game.Entities.ItemPickup:GetChildren()
    local collectedCount = 0
    
    for _, l in ipairs(itemPickups) do
        for _, v in ipairs(l:GetChildren()) do
            if v:IsA("MeshPart") or v:IsA("Part") then
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")
                if prompt and prompt.Enabled then
                    local distance = (v.Position - centerPos).Magnitude
                    if distance <= 15 then
                        prompt.RequiresLineOfSight = false
                        prompt.HoldDuration = 0
                        
                        local itemCenter = v.Position
                        root.CFrame = CFrame.new(itemCenter)
                        
                        local t0 = tick()
                        while v and v.Parent and tick() - t0 < 3 do
                            root.CFrame = CFrame.new(itemCenter)
                            fireproximityprompt(prompt)
                            task.wait(0.05)
                        end
                        
                        collectedCount = collectedCount + 1
                    end
                end
            end
        end
    end
    
    return collectedCount
end

local function collectNearbyItems(radius)
    pcall(function()
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local character = localPlayer.Character
        if not character then return end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        local currentPosition = rootPart.Position
        local originalPosition = rootPart.CFrame
        local itemPickups = workspace.Game.Entities.ItemPickup:GetChildren()
        for _, folder in pairs(itemPickups) do
            local items = folder:GetChildren()
            for _, item in pairs(items) do
                if item:IsA("MeshPart") or item:IsA("Part") then
                    local prompt = item:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        local distance = (item.Position - currentPosition).Magnitude
                        if distance <= radius then
                            rootPart.CFrame = item.CFrame * CFrame.new(0, 2, 0)
                            prompt.RequiresLineOfSight = false
                            prompt.HoldDuration = 0
                            for _ = 1, 3 do
                                fireproximityprompt(prompt)
                                task.wait(0.05)
                            end
                            wait(0.1)
                        end
                    end
                end
            end
        end
        rootPart.CFrame = originalPosition
    end)
end

Main:Toggle({
    Title = "自动摧毁全部ATM",
    Default = false,
    Callback = function(Value)
        if atmThread then
            task.cancel(atmThread)
            atmThread = nil
        end

        if Value then
            atmThread = task.spawn(function()
                while true do
                    task.wait(0.01)
                    
                    if not checkAnyTargetExists() then
                        teleportToHideSpot()
                        task.wait(1)
                    else
                        pcall(function()
                            local plr = game:GetService("Players").LocalPlayer
                            local char = plr.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local atmFolder = workspace:FindFirstChild("ATMs")
                                if atmFolder then
                                    local targetATM = nil
                                    for _, obj in ipairs(atmFolder:GetChildren()) do
                                        if obj:IsA("Model") and obj:GetAttribute("health") and obj:GetAttribute("health") > 0 then
                                            targetATM = obj
                                            break
                                        end
                                    end
                                    
                                    if targetATM then
                                        targetATM:SetAttribute("health", 0)
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动摧毁全部万圣节物品",
    Default = false,
    Callback = function(Value)
        if halloweenThread then
            task.cancel(halloweenThread)
            halloweenThread = nil
        end

        if Value then
            halloweenThread = task.spawn(function()
                while true do
                    task.wait(0.1)
                    
                    if not checkAnyTargetExists() then
                        teleportToHideSpot()
                        task.wait(1)
                    else
                        pcall(function()
                            local plr = game:GetService("Players").LocalPlayer
                            local char = plr.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local halloweenFolder = workspace:FindFirstChild("Halloween")
                                if halloweenFolder then
                                    for _, obj in ipairs(halloweenFolder:GetChildren()) do
                                        if obj:IsA("Model") and obj:GetAttribute("health") and obj:GetAttribute("health") > 0 then
                                            local hrp = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                                            if hrp then
                                                obj:SetAttribute("health", 0)
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "全图糖果金钱光环",
    Default = false,
    Callback = function(Value)
        mngh = Value
        task.spawn(function()
            while mngh and task.wait() do
                if not checkAnyTargetExists() then
                    teleportToHideSpot()
                    task.wait(1)
                else
                    local Players = game:GetService("Players")
                    local localPlayer = Players.LocalPlayer
                    if localPlayer.Character then
                        local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local player = game:GetService("Players").LocalPlayer
                            local character = player.Character or player.CharacterAdded:Wait()
                            local rootPart = character:WaitForChild("HumanoidRootPart")
                            for _, v in pairs(workspace.Game.Entities.CashBundle:GetDescendants()) do
                                if v:IsA("ClickDetector") then
                                    local detectorPos = v.Parent:GetPivot().Position
                                    local distance = (rootPart.Position - detectorPos).Magnitude
                                    if distance <= 10000 then
                                        fireclickdetector(v)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ProximityPromptService = game:GetService("ProximityPromptService")
local player = Players.LocalPlayer
local originalPosition = nil
local isMonitoring = false
local monitorConnection = nil

local function monitorBankCash()
    if monitorConnection then
        monitorConnection:Disconnect()
        monitorConnection = nil
    end
    monitorConnection = Workspace.ChildRemoved:Connect(function(child)
        if child.Name == "BankRobbery" then
            if mode == "活跃" then
                teleportToHideSpot()
            end
        elseif child.Name == "BankCash" and child.Parent and child.Parent.Name == "BankRobbery" then
            if mode == "活跃" then
                teleportToHideSpot()
            end
        end
    end)
end

local function stopMonitoring()
    if monitorConnection then
        monitorConnection:Disconnect()
        monitorConnection = nil
    end
    isMonitoring = false
end

local function teleportToBankCash()
    if Workspace:FindFirstChild("BankRobbery") then
        local bankRobbery = Workspace.BankRobbery
        if bankRobbery:FindFirstChild("BankCash") then
            local bankCash = bankRobbery.BankCash
            local character = player.Character
            if not character then
                character = player.CharacterAdded:Wait()
            end
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            originalPosition = humanoidRootPart.Position
            monitorBankCash()
            isMonitoring = true
            if bankCash:IsA("BasePart") or bankCash:IsA("Model") then
                local targetPosition
                if bankCash:IsA("BasePart") then
                    targetPosition = bankCash.Position
                else
                    local primaryPart = bankCash.PrimaryPart or bankCash:FindFirstChildWhichIsA("BasePart")
                    if primaryPart then
                        targetPosition = primaryPart.Position
                    else
                        return false
                    end
                end
                humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

local function findTargetPrompt()
    if Workspace:FindFirstChild("BankRobbery") then
        local bankRobbery = Workspace.BankRobbery
        if bankRobbery:FindFirstChild("BankCash") then
            local bankCash = bankRobbery.BankCash
            if bankCash:FindFirstChild("Main") then
                local main = bankCash.Main
                if main:FindFirstChild("Attachment") then
                    local attachment = main.Attachment
                    if attachment:FindFirstChild("ProximityPrompt") then
                        return attachment.ProximityPrompt
                    end
                end
            end
        end
    end
    return nil
end

local function autoInteractPrompt()
    if not Workspace:FindFirstChild("BankRobbery") or not Workspace.BankRobbery:FindFirstChild("BankCash") then
        if mode == "活跃" then
            teleportToHideSpot()
        end
        return false
    end
    local targetPrompt = findTargetPrompt()
    if targetPrompt then
        local character = player.Character
        if not character then
            character = player.CharacterAdded:Wait()
        end
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local promptPosition
        if targetPrompt.Parent:IsA("BasePart") then
            promptPosition = targetPrompt.Parent.Position
        elseif targetPrompt.Parent:IsA("Attachment") then
            promptPosition = targetPrompt.Parent.WorldPosition
        else
            local model = targetPrompt.Parent
            while model and not model:IsA("Model") do
                model = model.Parent
            end
            if model and model.PrimaryPart then
                promptPosition = model.PrimaryPart.Position
            else
                return false
            end
        end
        humanoidRootPart.CFrame = CFrame.new(promptPosition + Vector3.new(0, 3, 0))
        wait()
        local promptClicked = false
        local connection
        connection = ProximityPromptService.PromptTriggered:Connect(function(prompt, otherPlayer)
            if prompt == targetPrompt and otherPlayer == player then
                promptClicked = true
                if connection then
                    connection:Disconnect()
                end
            end
        end)
        fireproximityprompt(targetPrompt)
        local startTime = tick()
        while not promptClicked and tick() - startTime < 1 do
            if not Workspace:FindFirstChild("BankRobbery") or not Workspace.BankRobbery:FindFirstChild("BankCash") then
                if connection then
                    connection:Disconnect()
                end
                if mode == "活跃" then
                    teleportToHideSpot()
                end
                return false
            end
            fireproximityprompt(targetPrompt)
            wait(0.1)
        end
        if connection then
            connection:Disconnect()
        end
        if promptClicked then
            return true
        else
            return false
        end
    else
        return false
    end
end

local function teleportBack()
    stopMonitoring()
    if originalPosition then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(originalPosition)
                return true
            end
        end
    else
        return false
    end
end

local function executeBankRobbery()
    while true do
        if not checkAnyTargetExists() then
            teleportToHideSpot()
            task.wait(5)
        else
            if teleportToBankCash() then
                wait()
                for i = 1, 520 do
                    if not Workspace:FindFirstChild("BankRobbery") or not Workspace.BankRobbery:FindFirstChild("BankCash") then
                        if mode == "活跃" then
                            teleportToHideSpot()
                        end
                        break
                    end
                    autoInteractPrompt()
                    wait()
                end
                if mode == "活跃" then
                    teleportToHideSpot()
                end
            else
                stopMonitoring()
            end
        end
        task.wait(1)
    end
end

Main:Toggle({
    Title = "自动抢银行",
    Default = false,
    Callback = function(Value)
        if Value then
            if not player.Character then
                player.CharacterAdded:Wait()
            end
            task.spawn(executeBankRobbery)
        else
            stopMonitoring()
        end
    end
})

Main:Toggle({
    Title = "万圣节农场",
    Default = false,
    Callback = function(Value)
        if halloweenThread then
            task.cancel(halloweenThread)
            halloweenThread = nil
        end

        if Value then
            halloweenThread = task.spawn(function()
                while true do
                    task.wait()
                    
                    if not checkAnyTargetExists() then
                        teleportToHideSpot()
                        task.wait(1)
                    else
                        pcall(function()
                            local plr = game:GetService("Players").LocalPlayer
                            local char = plr.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local halloweenFolder = workspace:FindFirstChild("Halloween")
                                
                                local rootPart = char:FindFirstChild("HumanoidRootPart")
                                if rootPart then
                                    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") then
                                        if workspace.Game.Entities:FindFirstChild("Candy") then
                                            for _, v in pairs(workspace.Game.Entities.Candy:GetDescendants()) do
                                                if v:IsA("ClickDetector") then
                                                    local detectorPos = v.Parent:GetPivot().Position
                                                    local distance = (rootPart.Position - detectorPos).Magnitude
                                                    if distance <= 20 then
                                                        fireclickdetector(v)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                if halloweenFolder then
                                    for _, obj in ipairs(halloweenFolder:GetChildren()) do
                                        if obj:IsA("Model") and obj:GetAttribute("health") and obj:GetAttribute("health") > 0 then
                                            local hrp = char:FindFirstChild("HumanoidRootPart")
                                            if hrp then
                                                hrp.CFrame = obj:GetPivot() * CFrame.new(0, 0, -2)
                                                task.wait(0.1)
                                                
                                                obj:SetAttribute("health", 0)
                                                
                                                task.wait(2)
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "ATM农场",
    Default = false,
    Callback = function(Value)
        if kill77 then
            task.cancel(kill77)
            kill77 = nil
        end

        if Value then
            kill77 = task.spawn(function()
                while true do
                    task.wait()
                    
                    if not checkAnyTargetExists() then
                        teleportToHideSpot()
                        task.wait(1)
                    else
                        pcall(function()
                            local plr = game:GetService("Players").LocalPlayer
                            local char = plr.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                local atmFolder = workspace:FindFirstChild("ATMs")
                                
                                local rootPart = char:FindFirstChild("HumanoidRootPart")
                                if rootPart then
                                    for _, v in pairs(workspace.Game.Entities.CashBundle:GetDescendants()) do
                                        if v:IsA("ClickDetector") then
                                            local detectorPos = v.Parent:GetPivot().Position
                                            local distance = (rootPart.Position - detectorPos).Magnitude
                                            if distance <= 20 then
                                                fireclickdetector(v)
                                            end
                                        end
                                    end
                                    
                                    if workspace.Game.Entities:FindFirstChild("Candy") then
                                        for _, v in pairs(workspace.Game.Entities.Candy:GetDescendants()) do
                                            if v:IsA("ClickDetector") then
                                                local detectorPos = v.Parent:GetPivot().Position
                                                local distance = (rootPart.Position - detectorPos).Magnitude
                                                if distance <= 20 then
                                                    fireclickdetector(v)
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                if atmFolder then
                                    for _, atm in ipairs(atmFolder:GetChildren()) do
                                        if atm:IsA("Model") and atm:GetAttribute("health") and atm:GetAttribute("health") > 0 then
                                            local hrp = char:FindFirstChild("HumanoidRootPart")
                                            if hrp then
                                                hrp.CFrame = atm:GetPivot() * CFrame.new(0, 0, -2)
                                                task.wait(0.1)
                                                
                                                atm:SetAttribute("health", 0)
                                                
                                                task.wait(3)
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end
})

local Signal = require(ReplicatedStorage.devv).load("Signal")
local item = require(ReplicatedStorage.devv).load("v3item")

local function autoSellItems()
    for i, v in next, item.inventory.items do
        local sellid = v.guid
        Signal.FireServer("equip", sellid)
        Signal.FireServer("sellItem", sellid)
    end
end

Main:Toggle({
    Title = "自动售卖物品",
    Default = false,
    Callback = function(Value)
        autoSellEnabled = Value
        
        if autoSellConnection then
            autoSellConnection:Disconnect()
            autoSellConnection = nil
        end
        
        if Value then
            local RunService = game:GetService("RunService")
            
            autoSellConnection = RunService.Heartbeat:Connect(function()
                local currentTime = tick()
                
                if currentTime - lastBombardmentTime >= autoSellInterval then
                    pcall(function()
                        autoSellItems()
                    end)
                    lastBombardmentTime = currentTime
                end
            end)
            
            _G.AutoSell = {
                connection = autoSellConnection
            }
            
            pcall(function()
                autoSellItems()
            end)
        else
            if _G.AutoSell then
                if _G.AutoSell.connection then
                    _G.AutoSell.connection:Disconnect()
                end
                _G.AutoSell = nil
            end
        end
    end
})

local luckyBlockItems = {
    "Green Lucky Block",
    "Orange Lucky Block", 
    "Purple Lucky Block"
}

local function openLuckyBlocks()
    for i, v in next, item.inventory.items do
        if table.find(luckyBlockItems, v.name) then
            local useid = v.guid
            pcall(function()
                Signal.FireServer("equip", useid)
                wait(0.1)
                Signal.FireServer("useConsumable", useid)
                wait(0.1)
                Signal.FireServer("removeItem", useid)
            end)
            break
        end
    end
end

Main:Toggle({
    Title = "自动开幸运方块",
    Default = false,
    Callback = function(Value)
        autoOpenLuckyBlocks = Value
        
        if luckyBlockThread then
            task.cancel(luckyBlockThread)
            luckyBlockThread = nil
        end
        
        if Value then
            luckyBlockThread = task.spawn(function()
                while autoOpenLuckyBlocks do
                    pcall(function()
                        openLuckyBlocks()
                    end)
                    task.wait(0.0001)
                end
            end)
        end
    end
})

local materialBoxItems = {
    "Electronics",
    "Weapon Parts"
}

local function openMaterialBoxes()
    for i, v in next, item.inventory.items do
        if table.find(materialBoxItems, v.name) then
            local useid = v.guid
            pcall(function()
                Signal.FireServer("equip", useid)
                wait(0.1)
                Signal.FireServer("useConsumable", useid)
                wait(0.1)
                Signal.FireServer("removeItem", useid)
            end)
            break
        end
    end
end

Main:Toggle({
    Title = "自动开材料盒",
    Default = false,
    Callback = function(Value)
        autoOpenMaterialBoxes = Value
        
        if materialBoxThread then
            task.cancel(materialBoxThread)
            materialBoxThread = nil
        end
        
        if Value then
            materialBoxThread = task.spawn(function()
                while autoOpenMaterialBoxes do
                    pcall(function()
                        openMaterialBoxes()
                    end)
                    task.wait()
                end
            end)
        end
    end
})
local function teleportToAirdrop()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    local originalPosition = rootPart.CFrame
    local foundAirdrop = false
    local airdrops = game:GetService('Workspace').Game.Airdrops:GetChildren()
    for _, airdrop in pairs(airdrops) do
        if airdrop:FindFirstChild('Airdrop') and airdrop.Airdrop:FindFirstChild('ProximityPrompt') then
            local prompt = airdrop.Airdrop.ProximityPrompt
            prompt.RequiresLineOfSight = false
            prompt.HoldDuration = 0
            rootPart.CFrame = airdrop.Airdrop.CFrame
            task.wait(0.1) 
            
      
            for i = 1, 15 do
                fireproximityprompt(prompt)
                task.wait(0.02) 
            end
            
            foundAirdrop = true
            break
        end
    end
    
 
    if not foundAirdrop then
        rootPart.CFrame = originalPosition
    else
       
        task.wait(0.3)
        rootPart.CFrame = originalPosition
    end
    
    return foundAirdrop
end
local airdropAutoEnabled = false
Main:Toggle({
    Title = "自动空投",
    Default = false,
    Callback = function(Value)
        airdropAutoEnabled = Value
        if Value then
            task.spawn(function()
                while airdropAutoEnabled do
                    local collected = teleportToAirdrop()
                    if not collected then
                  
                        for i = 1, 10 do
                            if not airdropAutoEnabled then break end
                            task.wait(0.1)
                        end
                    else
                     
                        for i = 1, 3 do
                            if not airdropAutoEnabled then break end
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end
})

local function fastCollectMoney()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    local originalPosition = humanoidRootPart.CFrame
    local foundMoney = false
    local moneyEntities = workspace.Game.Entities.CashBundle:GetChildren()
    for i = 1, #moneyEntities do
        local l = moneyEntities[i]
        local moneyValue = l:FindFirstChildWhichIsA("IntValue")
        if moneyValue and moneyValue.Value >= setting.minMoney then
            humanoidRootPart.CFrame = l:FindFirstChildWhichIsA("Part").CFrame
            task.wait(0.2)
            humanoidRootPart.CFrame = originalPosition
            foundMoney = true
            break
        end
    end
    return foundMoney
end

Main:Toggle({
    Title = "自动捡钱",
    Default = false,
    Callback = function(Value)
        setting.autoMoney = Value
        if Value then
            task.spawn(function()
                while setting.autoMoney and task.wait(0.1) do
                    fastCollectMoney()
                end
            end)
        end
    end
})

Main:Slider({
    Title = "最低钱数设置",
    Value = {
        Min = 250,
        Max = 1000,
        Default = 250,
    },
    Callback = function(Value)
        setting.minMoney = Value
    end
})

local function crackSafes()
    while autoOpenSafes do
        if not checkAnyTargetExists() then
            teleportToHideSpot()
            task.wait(1)
        else
            pcall(function()
                local rootPart = getRootPart()
                if not rootPart then return end

                for _, obj in ipairs(workspace.Game.Entities:GetDescendants()) do
                    if not autoOpenSafes then break end
                    if obj:IsA("ProximityPrompt") and obj.ActionText == "Crack Safe" and obj.Enabled then
                        obj.RequiresLineOfSight = false
                        obj.HoldDuration = 0

                        local target = obj.Parent and obj.Parent.Parent
                        if target and target:IsA("BasePart") then
                            rootPart.CFrame = CFrame.new(target.Position)
                            task.wait(1)
                            fireproximityprompt(obj)
                            task.wait(0.5)
                            task.wait(2)
                            pickupAll15m(target.Position)
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end
end

local function crackChests()
    while autoOpenChests do
        if not checkAnyTargetExists() then
            teleportToHideSpot()
            task.wait(1)
        else
            pcall(function()
                local rootPart = getRootPart()
                if not rootPart then return end

                for _, obj in ipairs(workspace.Game.Entities:GetDescendants()) do
                    if not autoOpenChests then break end
                    if obj:IsA("ProximityPrompt") and obj.ActionText == "Crack Chest" and obj.Enabled then
                        obj.RequiresLineOfSight = false
                        obj.HoldDuration = 0

                        local target = obj.Parent and obj.Parent.Parent
                        if target and target:IsA("BasePart") then
                            rootPart.CFrame = CFrame.new(target.Position)
                            task.wait(1)
                            fireproximityprompt(obj)
                            task.wait(0.5)
                            task.wait(2)
                            pickupAll15m(target.Position)
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end
end

local function updateThreads()
    if safeThread then
        task.cancel(safeThread)
        safeThread = nil
    end
    if autoOpenSafes then
        safeThread = task.spawn(crackSafes)
    end

    if chestThread then
        task.cancel(chestThread)
        chestThread = nil
    end
    if autoOpenChests then
        chestThread = task.spawn(crackChests)
    end
end

Main:Toggle({
    Title = "自动保险箱",
    Default = false,
    Callback = function(Value)
        autoOpenSafes = Value
        updateThreads()
    end
})

Main:Toggle({
    Title = "自动宝箱",
    Default = false,
    Callback = function(Value)
        autoOpenChests = Value
        updateThreads()
    end
})

Main:Toggle({
    Title = "自动购买撬锁",
    Default = false,
    Callback = function(Value)
        lock = Value
        task.spawn(function()
            while lock and task.wait() do
                pcall(function()
                    local Players = game:GetService("Players")
                    local localPlayer = Players.LocalPlayer
                    if localPlayer.Character then
                        local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            Signal.InvokeServer("attemptPurchase", "Lockpick")
                        end
                    end
                end)
            end
        end)
    end
})

Main:Toggle({
    Title = "自动藏宝图寻宝[弹bug正常]",
    Desc = "弹bug说明没有藏宝图",
    Default = false,
    Callback = function(Value)
        treasureSettings.enabled = Value
        if Value then
            task.spawn(function()
                while treasureSettings.enabled do
                    if not checkAnyTargetExists() then
                        teleportToHideSpot()
                        task.wait(1)
                    else
                        local Debri = game:GetService('Workspace').Game.Local.Debris
                        if Debri:FindFirstChild('TreasureMarker') then
                            local treasure = Debri.TreasureMarker
                            treasure.ProximityPrompt.HoldDuration = 0
                            treasure.ProximityPrompt.MaxActivationDistance = 40
                            local treasureCFrame = treasure.CFrame
                            local player = game:GetService('Players').LocalPlayer
                            local character = player.Character
                            if character and character:FindFirstChild('HumanoidRootPart') then
                                character.HumanoidRootPart.CFrame = treasureCFrame
                                fireproximityprompt(treasure.ProximityPrompt)
                            end
                            task.wait(0.5)
                        else
                            task.wait(2)
                        end
                    end
                end
            end)
        end
    end
})

local Main = Window:Tab({Title = "全自动类", Icon = "settings"})

Main:Button({
    Title = "全自动换服捡物品",
    Callback = function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local CONFIG_FILE = "auto_switch_config.json"
local defaultConfig = {
    enabled = true,
    switchInterval = 1, 
    minPlayers = 1,
    maxPlayers = 25,
    fallbackMinPlayers = 26, 
    fallbackMaxPlayers = 28
}
local function loadConfig()
    local success, config = pcall(function()
        if not isfile(CONFIG_FILE) then
            writefile(CONFIG_FILE, HttpService:JSONEncode(defaultConfig))
            return defaultConfig
        end
        
        local fileContent = readfile(CONFIG_FILE)
        return HttpService:JSONDecode(fileContent)
    end)
    
    return success and config or defaultConfig
end
local function saveConfig(config)
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode(config))
    end)
end
local autoPickupScript = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/715272.lua"))()
]]
local function saveAutoPickupScript()
    pcall(function()
        writefile("auto_pickup_script.lua", autoPickupScript)
    end)
end
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
local function getTargetServer(cursor)
    local url = _servers .. (cursor and "&cursor=" .. cursor or "")
    local success, raw = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        warn("获取服务器失败: " .. raw)
        return nil
    end
    
    local data = HttpService:JSONDecode(raw)
    local config = loadConfig()
    for _, server in ipairs(data.data) do
        if server.id ~= game.JobId and server.playing >= config.minPlayers and server.playing <= config.maxPlayers then
            return server
        end
    end
    
  
    for _, server in ipairs(data.data) do
        if server.id ~= game.JobId and server.playing >= config.fallbackMinPlayers and server.playing <= config.fallbackMaxPlayers then
            return server
        end
    end
    
    if data.nextPageCursor then
        return getTargetServer(data.nextPageCursor)
    end
    
    return nil
end

local function autoSwitchServer()
    local config = loadConfig()
    
    if not config.enabled then
        return
    end
    
    local targetServer = getTargetServer()
    
    if not targetServer then
        warn("未找到符合条件的服务器，1秒后重试...")
        task.wait(1)
        autoSwitchServer()
        return
    end
    
    print("找到目标服务器: " .. targetServer.id .. "，人数: " .. targetServer.playing)
    local nextScript = readfile("auto_pickup_script.lua")
    queue_on_teleport(nextScript)

    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
    end)
    
    if not success then
        warn("传送失败: " .. err .. "，1秒后重试...")
        task.wait(1)
        autoSwitchServer()
    end
end
saveConfig(defaultConfig)
saveAutoPickupScript()
while true do
    local config = loadConfig()
    if config.enabled then
        autoSwitchServer()
    end
    task.wait(config.switchInterval) 
end

    end
})


local qtl = Window:Tab({Title = "购买", Icon = "settings"})
local itemsOnSale = workspace:FindFirstChild("ItemsOnSale")
local itemNames = {}
local selectedItem = ""
if itemsOnSale then
    local seenNames = {}
    for _, item in ipairs(itemsOnSale:GetChildren()) do
        if not seenNames[item.Name] then
            table.insert(itemNames, item.Name)
            seenNames[item.Name] = true
        end
    end
end

local autoPurchaseSettings = {
    enabled = false,
    bulletEnabled = false,
    delay = 1
}

qtl:Dropdown({
    Title = "选择物品",
    Values = itemNames,
    Value = itemNames[1] or "",
    Callback = function(item)
        selectedItem = item 
    end
})

qtl:Toggle({
    Title = "自动购买选择物品",
    Default = false,
    Callback = function(Value)
        autoPurchaseSettings.enabled = Value
        if Value then
            task.spawn(function()
                while autoPurchaseSettings.enabled and task.wait(autoPurchaseSettings.delay) do
                    if selectedItem and selectedItem ~= "" then
                        require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", selectedItem)
                    end
                end
            end)
        end
    end
})

qtl:Toggle({
    Title = "自动购买子弹",
    Default = false,
    Callback = function(Value)
        autoPurchaseSettings.bulletEnabled = Value
        if Value then
            task.spawn(function()
                while autoPurchaseSettings.bulletEnabled and task.wait(autoPurchaseSettings.delay) do
                    require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", "子弹")
                end
            end)
        end
    end
})

qtl:Slider({
    Title = "购买延迟",
    Value = {
        Min = 0.1,
        Max = 5,
        Default = 1,
    },
    Callback = function(Value)
        autoPurchaseSettings.delay = Value
    end
})

qtl:Button({
    Title = "购买选择的物品",
    Callback = function()
        if selectedItem and selectedItem ~= "" then
            require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", selectedItem)
        else
            warn("请先选择一个物品")
        end
    end
})

qtl:Button({
    Title = "购买子弹",
    Callback = function()
        require(game:GetService("ReplicatedStorage").devv).load("Signal").InvokeServer("attemptPurchase", "子弹")
    end
})
local Main = Window:Tab({Title = "通行证", Icon = "settings"})
Main:Button({
    Title = "破解移动经销商",
    Callback = function()
        game:GetService("Players").LocalPlayer:SetAttribute("mobileDealer", true)
        
        local mobileDealerData = require(game:GetService("ReplicatedStorage").devv).load("mobileDealer")
        
       
        for category, items in pairs(mobileDealerData) do
            for _, item in ipairs(items) do
                item.stock = 999
            end
        end
        local dealerApp = require(game:GetService("ReplicatedStorage").devv).load("DealerApp")
        local originalUpdateFrame = dealerApp.updateFrame
        local originalGetItemStock = dealerApp.getItemStock
        local originalAttemptPurchase = dealerApp.attemptPurchase
        local originalAttemptPurchaseAmmo = dealerApp.attemptPurchaseAmmo
        
        dealerApp.updateFrame = function(itemName)
            local frame = dealerApp:GetScreenFrame().ItemContainer:FindFirstChild(itemName)
            if not frame then return end
            
            local itemData = dealerApp.getDealerData(itemName)
            if not itemData then return end
            frame.NameLabel.Text = itemName .. " (999)"
            frame.OutOfStock.Visible = false
            frame.Buy.TextLabel.Text = "BUY"
            frame.Buy.UIGradient.Enabled = true
            frame.Buy.BackgroundColor3 = Color3.fromRGB(209, 210, 212)
        end
        
        dealerApp.getItemStock = function(item)
            return 999
        end
        dealerApp.attemptPurchase = function(itemName)
            if originalAttemptPurchase then
                originalAttemptPurchase(itemName)
            else
                game:GetService("ReplicatedStorage").Signal:InvokeServer("attemptPurchase", itemName)
            end
        end
        dealerApp.attemptPurchaseAmmo = function(itemName)
            if originalAttemptPurchaseAmmo then
                originalAttemptPurchaseAmmo(itemName)
            else
                game:GetService("ReplicatedStorage").Signal:InvokeServer("attemptPurchaseAmmo", itemName)
            end
        end
        for _, frame in pairs(dealerApp:GetScreenFrame().ItemContainer:GetChildren()) do
            if frame:FindFirstChild("Buy") then
                frame.Buy.MouseButton1Click:Connect(function()
                    local itemName = string.gsub(frame.NameLabel.Text, " %(999%)", "")
                    if string.find(itemName, "Ammo") then
                        dealerApp.attemptPurchaseAmmo(itemName)
                    else
                        dealerApp.attemptPurchase(itemName)
                    end
                end)
            end
        end
        dealerApp:enable(dealerApp)
    end
})

Main:Button({
    Title = "破解所有物品格",
    Callback = function()
     
        game:GetService("Players").LocalPlayer:SetAttribute("lockerSlots", 999)
        
  
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local devv = require(ReplicatedStorage.devv)
        local lockerModule = devv.load("locker")
        local purchases = devv.load("purchases")
        local globals = devv.load("globals")
        
       
        local originalGetNextTier = lockerModule.getNextTier
        local originalGetRobuxPrice = lockerModule.getRobuxPrice
        
        lockerModule.getNextTier = function()
            return 5  
        end
        
        lockerModule.getRobuxPrice = function(slots)
            return 0 
        end
        
        
        local GUILoader = devv.load("GUILoader")
        local backpackUI = GUILoader.Get("Backpack")
        
        
        for _, slot in pairs(backpackUI.Holder.Locker.Frame:GetChildren()) do
            if slot:IsA("GuiObject") then
                slot.Locked.Visible = false
                slot.Unlocked.Visible = true
            end
        end
        
        backpackUI.Holder.Locker.Buttons.UnlockAll.Visible = false
        backpackUI.Holder.Locker.Buttons.PageSelector.Visible = false
        
      
        if lockerModule.PromptPurchase then
            local originalPromptPurchase = lockerModule.PromptPurchase
            lockerModule.PromptPurchase = function(itemId, infoType)
        
                game:GetService("ReplicatedStorage").Signal:InvokeServer("completePurchase", itemId, infoType)
            end
        end
        
        lockerModule.update()
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "破解成功",
            Text = "",
            Duration = 5
        })
    end
})
local tab = Window:Tab({Title = "封禁信息", Icon = "settings"})

local function fmt(ts)
    return os.date("%Y-%m-%d %H:%M:%S", ts)
end

local function updateBanInfo()
    local banReason = nil
    local banCount = nil
    local isBanned = false
    local banAt = nil
    local unbanAt = nil
    local remainingTime = nil
    
    for _, entry in ipairs(getgc(true)) do
        if type(entry) == "table" then
            local reason = rawget(entry, "shadowbanned")
            if reason then
                banReason = reason
                isBanned = true
            end
            
            local count = rawget(entry, "numshadowbans")
            if count then
                banCount = tostring(count)
                isBanned = true
            end
            
            local at = rawget(entry, "shadowbannedAt")
            if at then
                banAt = fmt(at)
            end
            
            local exes = rawget(entry, "shadowbannedExpires")
            if exes then
                unbanAt = fmt(exes)
                local now = os.time()
                local rem = exes - now
                if rem > 0 then
                    local d = math.floor(rem / 86400)
                    rem = rem % 86400
                    local h = math.floor(rem / 3600)
                    rem = rem % 3600
                    local m = math.floor(rem / 60)
                    rem = rem % 60
                    local s = rem
                    remainingTime = string.format("%d天 %d小时 %d分 %d秒", d, h, m, s)
                else
                    remainingTime = "已过期"
                end
            end
        end
    end
    tab:Paragraph({
        Title = "封禁原因：" .. (banReason or "无")
    })
    
    tab:Paragraph({
        Title = "封禁次数：" .. (banCount or "无")
    })
    
    tab:Paragraph({
        Title = "是否封禁：" .. (isBanned and "是" or "否")
    })
    
    tab:Paragraph({
        Title = "封禁时间：" .. (banAt or "无")
    })
    
    tab:Paragraph({
        Title = "解封时间：" .. (unbanAt or "无")
    })
    
    if remainingTime then
        tab:Paragraph({
            Title = "剩余时间：" .. remainingTime
        })
    end
    
    return isBanned, banReason, banCount, banAt, unbanAt, remainingTime
end

task.spawn(function()
    updateBanInfo()
end)
local MainTab = Window:Tab({Title = "传送", Icon = "settings"})

local teleportLocations = {
    ["银行里面"] = CFrame.new(1087.274658203125, 8.169801712036133, -343.4639587402344),
    ["银行外面"] = CFrame.new(1084.5325927734375, 6.2468485832214355, -425.96929931640625),
    ["珠宝店外面"] = CFrame.new(1546.2052001953125, 6.245292663574219, -684.1364135742188),
    ["珠宝店里面"] = CFrame.new(1718.9903564453125, 14.272229194641113, -725.5169067382812),
    ["警察局"] = CFrame.new(683.267578125, 6.245400428771973, -904.3998413085938),
    ["军事基地"] = CFrame.new(804.9326171875, 25.265623092651367, -1331.7320556640625),
    ["军事基旁武器店"] = CFrame.new(1119.950927734375, 25.343891143798828, -1308.7613525390625),
    ["警察局旁武器店"] = CFrame.new(670.1553344726562, 6.245391845703125, -658.22802734375),
    ["珠宝店旁武器店"] = CFrame.new(1547.314697265625, 6.24489164352417, -608.4329223632812),
    ["加油站"] = CFrame.new(1072.2225341796875, 6.045392990112305, -616.2798461914062),
    ["医院"] = CFrame.new(1073.444091796875, 6.0453948974609375, -968.4043579101562),
    ["买气球和摇摇乐"] = CFrame.new(834.3544921875, 6.245891094207764, -935.71044921875),
    ["电话店"] = CFrame.new(882.4231567382812, 6.246849060058594, -1023.138671875),
    ["家具店"] = CFrame.new(971.3882446289062, 6.2458648681640625, -783.7587890625),
    ["家具店2"] = CFrame.new(390.9602966308594, -6.0471086502075195, -384.566162109375),
    ["夜店"] = CFrame.new(1525.67529296875, 6.24489164352417, -785.3524780273438),
    ["消防站"] = CFrame.new(1572.544921875, 6.245391845703125, -514.4601440429688),
    ["咖啡馆"] = CFrame.new(1278.8885498046875, 6.245991230010986, -331.8045959472656),
    ["汉堡店"] = CFrame.new(1339.9090576171875, 6.044891357421875, -660.3264770507812),
    ["杂货店"] = CFrame.new(952.1937866210938, 6.245891094207764, -930.346435546875),
    ["剧院"] = CFrame.new(532.3129272460938, 6.045393466949463, -978.8245239257812),
    ["披萨店"] = CFrame.new(399.05078125, 6.2438507080078125, -878.3633422851562),
    ["摩天轮"] = CFrame.new(1152.4921875, 16.618755340576172, 16.511913299560547),
    ["教堂"] = CFrame.new(1456.5350341796875, 5.239261150360107, -35.529232025146484),
    ["滑板公园"] = CFrame.new(1552.9686279296875, 6.245391845703125, -218.27784729003906),
    ["健身房"] = CFrame.new(1559.5380859375, 6.246891021728516, -317.7867126464844)
}

local teleportSettings = {
    speed = 50,
    roundTripEnabled = false,
    smoothMoveEnabled = false
}

local selectedLocation = "银行里面"
local originalPosition = nil
local roundTripRunning = false
local smoothMoveRunning = false

MainTab:Dropdown({
    Title = "传送位置",
    Values = {"银行里面", "银行外面", "珠宝店外面", "珠宝店里面", "警察局", "军事基地", "军事基旁武器店", 
              "警察局旁武器店", "珠宝店旁武器店", "加油站", "医院", "买气球和摇摇乐", "电话店", "家具店", 
              "家具店2", "夜店", "消防站", "咖啡馆", "汉堡店", "杂货店", "剧院", "披萨店", "摩天轮", 
              "教堂", "滑板公园", "健身房"},
    Value = "银行里面",
    Callback = function(option)
        selectedLocation = option
    end
})

MainTab:Slider({
    Title = "传送速度",
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(Value)
        teleportSettings.speed = Value
    end
})

MainTab:Button({
    Title = "直接传送",
    Callback = function()
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = teleportLocations[selectedLocation]
        end
    end
})

MainTab:Button({
    Title = "穿墙传送",
    Callback = function()
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Flying)
            end
            character.HumanoidRootPart.CFrame = teleportLocations[selectedLocation]
            task.wait(0.1)
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
})

MainTab:Toggle({
    Title = "来回传送",
    Default = false,
    Callback = function(Value)
        teleportSettings.roundTripEnabled = Value
        if Value then
            roundTripRunning = true
            task.spawn(function()
                local character = game:GetService("Players").LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    originalPosition = character.HumanoidRootPart.CFrame
                end
                
                while teleportSettings.roundTripEnabled and roundTripRunning do
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = teleportLocations[selectedLocation]
                        task.wait()
                        if teleportSettings.roundTripEnabled and roundTripRunning then
                            character.HumanoidRootPart.CFrame = originalPosition
                            task.wait()
                        end
                    end
                    task.wait()
                end
            end)
        else
            roundTripRunning = false
        end
    end
})

MainTab:Button({
    Title = "保存当前位置",
    Callback = function()
        local character = game:GetService("Players").LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            originalPosition = character.HumanoidRootPart.CFrame
        end
    end
})

MainTab:Button({
    Title = "传送到保存位置",
    Callback = function()
        if originalPosition then
            local character = game:GetService("Players").LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = originalPosition
            end
        end
    end
})
local Main = Window:Tab({Title = "信息", Icon = "settings"})
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local stats = player:WaitForChild("stats")
local moneyValue = stats:WaitForChild("Money")

local playerList = {"无"}
local selectedPlayer = "无"
local dropdownRef = nil

local infoParagraphs = {
    playerName = nil,
    playerMoney = nil,
    playerEquipment = nil
}

local moneyConnections = {}
local equipmentConnections = {}

local function updatePlayerList()
    local currentPlayers = Players:GetPlayers()
    local newPlayerList = {"无"}
    for _, player in ipairs(currentPlayers) do
        if player ~= Players.LocalPlayer then
            table.insert(newPlayerList, player.Name)
        end
    end
    playerList = newPlayerList
    if dropdownRef then
        dropdownRef:Refresh(playerList, true)
    end
end

local function initializeInfoDisplay()
    if not infoParagraphs.playerName then
        infoParagraphs.playerName = Main:Paragraph({
            Title = "当前选择玩家: 无"
        })
    end
    if not infoParagraphs.playerMoney then
        infoParagraphs.playerMoney = Main:Paragraph({
            Title = "玩家金钱: 0"
        })
    end
    if not infoParagraphs.playerEquipment then
        infoParagraphs.playerEquipment = Main:Paragraph({
            Title = "玩家装备: 无"
        })
    end
end

local function updatePlayerInfo()
    if selectedPlayer and selectedPlayer ~= "无" then
        local targetPlayer = Players:FindFirstChild(selectedPlayer)
        if targetPlayer then
            if infoParagraphs.playerName then
                infoParagraphs.playerName:SetTitle("当前选择玩家: " .. selectedPlayer)
            end
            
            local moneyText = "无法获取"
            local targetStats = targetPlayer:FindFirstChild("stats")
            if targetStats then
                local targetMoney = targetStats:FindFirstChild("Money")
                if targetMoney then
                    moneyText = tostring(targetMoney.Value)
                end
            end
            
            if infoParagraphs.playerMoney then
                infoParagraphs.playerMoney:SetTitle("玩家金钱: " .. moneyText)
            end
            
            local equipmentText = "无装备"
            if targetPlayer.Character then
                local equippedItems = {}
                for _, tool in ipairs(targetPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        table.insert(equippedItems, tool.Name)
                    end
                end
                if #equippedItems > 0 then
                    equipmentText = table.concat(equippedItems, ", ")
                end
            end
            
            if infoParagraphs.playerEquipment then
                infoParagraphs.playerEquipment:SetTitle("玩家装备: " .. equipmentText)
            end
        end
    else
        if infoParagraphs.playerName then
            infoParagraphs.playerName:SetTitle("当前选择玩家: 无")
        end
        if infoParagraphs.playerMoney then
            infoParagraphs.playerMoney:SetTitle("玩家金钱: 0")
        end
        if infoParagraphs.playerEquipment then
            infoParagraphs.playerEquipment:SetTitle("玩家装备: 无")
        end
    end
end

local function setupMoneyMonitoring(targetPlayer)
    for _, connection in ipairs(moneyConnections) do
        connection:Disconnect()
    end
    moneyConnections = {}
    
    local targetStats = targetPlayer:FindFirstChild("stats")
    if targetStats then
        local targetMoney = targetStats:FindFirstChild("Money")
        if targetMoney then
            table.insert(moneyConnections, targetMoney.Changed:Connect(function()
                if selectedPlayer == targetPlayer.Name then
                    updatePlayerInfo()
                end
            end))
        end
    end
end

local function setupEquipmentMonitoring(targetPlayer)
    for _, connection in ipairs(equipmentConnections) do
        connection:Disconnect()
    end
    equipmentConnections = {}
    
    local function onCharacterAdded(character)
        local function onChildAdded(child)
            if child:IsA("Tool") then
                updatePlayerInfo()
            end
        end
        
        local function onChildRemoved(child)
            if child:IsA("Tool") then
                updatePlayerInfo()
            end
        end
        
        table.insert(equipmentConnections, character.ChildAdded:Connect(onChildAdded))
        table.insert(equipmentConnections, character.ChildRemoved:Connect(onChildRemoved))
        updatePlayerInfo()
    end
    
    table.insert(equipmentConnections, targetPlayer.CharacterAdded:Connect(onCharacterAdded))
    
    if targetPlayer.Character then
        onCharacterAdded(targetPlayer.Character)
    end
end

updatePlayerList()
initializeInfoDisplay()

dropdownRef = Main:Dropdown({
    Title = "选择玩家",
    Values = playerList,
    Value = "无",
    Callback = function(option)
        selectedPlayer = option
        if selectedPlayer and selectedPlayer ~= "无" then
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if targetPlayer then
                setupMoneyMonitoring(targetPlayer)
                setupEquipmentMonitoring(targetPlayer)
            end
        else
            for _, connection in ipairs(moneyConnections) do
                connection:Disconnect()
            end
            for _, connection in ipairs(equipmentConnections) do
                connection:Disconnect()
            end
            moneyConnections = {}
            equipmentConnections = {}
        end
        updatePlayerInfo()
    end
})

updatePlayerInfo()

moneyValue.Changed:Connect(function()
    if selectedPlayer == Players.LocalPlayer.Name then
        updatePlayerInfo()
    end
end)

Players.PlayerAdded:Connect(function()
    updatePlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    if selectedPlayer and selectedPlayer ~= "无" and player.Name == selectedPlayer then
        selectedPlayer = "无"
        if dropdownRef then
            dropdownRef:Set("无")
        end
        updatePlayerInfo()
    end
    updatePlayerList()
end)
local CollectTab = Window:Tab({Title = "拾取", Icon = "package"})

local setting = { 
    player = { list = {}, select = nil }, 
    rope = { autorope = false, autorandom = false },
    collect = {
        autospectral = false,
        autoskull = false,
        autocl = false,    
        autobs = false,    
        autohk = false, 
        automn = false,    
        autodj = false,    
        autojt = false,   
        autoqq = false,    
        autoblue = false,  
        autoluck = false,  
        autocc = false,  
        czycj = false,      
        autoprecious = false,  
        autobluekey = false,   
        autovehicle = false,  
        autoweapon = false   
    }
}

local itemCategories = {
    spectral = {"Spectral Scythe"},
    skull = {"Skull Balloon"},
    materials = {"Electronics", "Weapon Parts"},
    gems = {"Amethyst", "Sapphire", "Emerald", "Topaz", "Ruby", "Diamond Ring", "Rollie"},
    redcard = {"Military Armory Keycard"},
    printer = {"Money Printer"},
    nukes = {"Suitcase Nuke", "Nuke Launcher", "Easter Basket"},
    gold = {"Gold Bar"},
    balloons = {"Bunny Balloon", "Ghost Balloon", "Clover Balloon", "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon"},
    bluecandy = {"Blue Candy Cane"},
    candy = {"Candy Cane"},
    luckyblocks = {"Green Lucky Block", "Orange Lucky Block", "Purple Lucky Block"},
    precious = {"Dark Matter Gem", "Void Gem", "Diamond", "Diamond Ring", "Requirements"},
    bluecard = {"Blue Keycard"},
    vehicles = {"Car", "Helicopter"},
    weapons = {"RPG", "Scar L", "AS Val", "FN FAL", "P90", "Barrett M107", "AWP", "M249 SAW"}
}

local function fastCollectItems(itemNames)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
  
    local originalPosition = rootPart.CFrame
    local foundItem = false
    
    local itemPickups = workspace.Game.Entities.ItemPickup:GetChildren()
    for i = 1, #itemPickups do
        local l = itemPickups[i]
        local items = l:GetChildren()
        for j = 1, #items do
            local v = items[j]
            if v:IsA("MeshPart") or v:IsA("Part") then
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    for k = 1, #itemNames do
                        if prompt.ObjectText == itemNames[k] then
                       
                            rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                            
                            prompt.RequiresLineOfSight = false
                            prompt.HoldDuration = 0
                            
                         
                            for _ = 1, 10 do 
                                fireproximityprompt(prompt)
                                task.wait()  
                            end
                            
                         
                            rootPart.CFrame = originalPosition
                            return true
                        end
                    end
                end
            end
        end
    end
    
    return false
end

local function createCollectToggle(title, settingKey, itemType)
    CollectTab:Toggle({ 
        Title = title, 
        Default = false, 
        Callback = function(Value) 
            setting.collect[settingKey] = Value
            if Value then
                task.spawn(function()
                    local items = itemCategories[itemType]
                    while setting.collect[settingKey] and task.wait() do  -- 使用帧等待
                        fastCollectItems(items)
                    end
                end)
            end
        end 
    })
end
createCollectToggle("自动捡幽灵镰刀", "autospectral", "spectral")
createCollectToggle("自动捡骷髅气球", "autoskull", "skull")
createCollectToggle("自动捡材料", "autocl", "materials")
createCollectToggle("自动捡普通宝石", "autobs", "gems")
createCollectToggle("自动捡红卡", "autohk", "redcard")
createCollectToggle("自动捡钞票打印机", "automn", "printer")
createCollectToggle("自动捡核弹类物品", "autodj", "nukes")
createCollectToggle("自动捡金条", "autojt", "gold")
createCollectToggle("自动捡气球", "autoqq", "balloons")
createCollectToggle("自动捡蓝色糖果棒", "autoblue", "bluecandy")
createCollectToggle("自动捡红色糖果棒", "autocc", "candy")
createCollectToggle("自动捡幸运方块", "autoluck", "luckyblocks")
createCollectToggle("自动捡贵重宝石", "autoprecious", "precious")
createCollectToggle("自动捡蓝卡", "autobluekey", "bluecard")
createCollectToggle("自动捡载具", "autovehicle", "vehicles")
createCollectToggle("自动捡贵重枪支", "autowehicle", "weapons")
local Main = Window:Tab({Title = "跟踪", Icon = "settings"})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Signal = require(ReplicatedStorage.devv).load("Signal")

local teleportSettings = {
    targetPlayer = nil,
    position = "前面",
    distance = 3,
    isTeleporting = false,
    isCircling = false,
    circleSpeed = 1,
    circleRadius = 5,
    circleHeight = 0,
    circleAngle = 0,
    originalPosition = nil,
    originalCFrame = nil,
    hasNoclip = false,
    noclipConnection = nil,
    returnPosition = nil, 
    teleportCount = 0
}

local playerList = {"无"}
local selectedPlayer = "无"
local dropdownRef = nil 

local function enableNoclip(character)
    if not character then return end
    
    if teleportSettings.noclipConnection then
        teleportSettings.noclipConnection:Disconnect()
        teleportSettings.noclipConnection = nil
    end
    
    teleportSettings.hasNoclip = true
    
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    teleportSettings.noclipConnection = character.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false
        end
    end)
end

local function disableNoclip()
    teleportSettings.hasNoclip = false
    
    if teleportSettings.noclipConnection then
        teleportSettings.noclipConnection:Disconnect()
        teleportSettings.noclipConnection = nil
    end
    
    local localPlayer = Players.LocalPlayer
    if localPlayer and localPlayer.Character then
        for _, part in ipairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local function updatePlayerList()
    local currentPlayers = Players:GetPlayers()
    local newPlayerList = {"无"}
    
    for _, player in ipairs(currentPlayers) do
        if player ~= Players.LocalPlayer then
            table.insert(newPlayerList, player.Name)
        end
    end
    
    playerList = newPlayerList
    
    if dropdownRef then
        dropdownRef:Refresh(playerList, true)
    end
    
    if selectedPlayer and selectedPlayer ~= "无" and not table.find(playerList, selectedPlayer) then
        WindUI:Notify({
            Title = "传送提示",
            Content = "目标玩家："..selectedPlayer.." 已退出服务器",
            Duration = 5,
        })
        selectedPlayer = "无"
        teleportSettings.targetPlayer = nil
        if dropdownRef then
            dropdownRef:Set("无")
        end
    end
end

local function calculateTeleportPosition(targetChar, settings)
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then
        return nil, nil
    end
    
    local targetCF = targetChar.HumanoidRootPart.CFrame
    local offset = Vector3.new(0, 0, -settings.distance)
    
    if settings.position == "头顶" then
        offset = Vector3.new(0, settings.distance + 2, 0) 
    elseif settings.position == "背后" then
        offset = Vector3.new(0, 0, settings.distance)
    elseif settings.position == "下面" then
        offset = Vector3.new(0, -settings.distance - 2, 0)  
    end
    
    local position = targetCF * CFrame.new(offset)
    local lookAt = targetChar.HumanoidRootPart.Position
    
    return position, lookAt
end

local function calculateCirclePosition(targetChar, settings)
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then
        return nil, nil
    end
    
    settings.circleAngle = settings.circleAngle + settings.circleSpeed * 0.03
    
    local x = math.cos(settings.circleAngle) * settings.circleRadius
    local z = math.sin(settings.circleAngle) * settings.circleRadius
    local offset = Vector3.new(x, settings.circleHeight, z)
    
    local targetPos = targetChar.HumanoidRootPart.Position
    local position = CFrame.new(targetPos) * CFrame.new(offset)
    local lookAt = targetPos
    
    return position, lookAt
end

local function teleportToOriginalPosition()
    local localPlayer = Players.LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    enableNoclip(localPlayer.Character)
    
    teleportSettings.teleportCount = 0
    
    local function teleportLoop()
        if teleportSettings.teleportCount < 3 then
            teleportSettings.teleportCount = teleportSettings.teleportCount + 1
            if teleportSettings.originalCFrame then
                localPlayer.Character.HumanoidRootPart.CFrame = teleportSettings.originalCFrame
            end
            wait(0.2)
            teleportLoop()
        else
            wait(0.5)
            disableNoclip()
            teleportSettings.isTeleporting = false
            teleportSettings.isCircling = false
            teleportSettings.originalPosition = nil
            teleportSettings.originalCFrame = nil
            teleportSettings.teleportCount = 0
        end
    end
    
    teleportLoop()
end

local function continuousTeleport()
    local localPlayer = Players.LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    if teleportSettings.isTeleporting and teleportSettings.targetPlayer then
        local targetPlayer = teleportSettings.targetPlayer
        
        if not teleportSettings.originalPosition then
            teleportSettings.originalPosition = localPlayer.Character.HumanoidRootPart.Position
            teleportSettings.originalCFrame = localPlayer.Character.HumanoidRootPart.CFrame
        end
        
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local position, lookAt
            
            if teleportSettings.isCircling then
                position, lookAt = calculateCirclePosition(targetPlayer.Character, teleportSettings)
            else
                position, lookAt = calculateTeleportPosition(targetPlayer.Character, teleportSettings)
            end
            
            if position then
                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position.Position, lookAt)
            end
        end
    elseif teleportSettings.originalPosition then
        teleportToOriginalPosition()
    end
end

RunService.Heartbeat:Connect(continuousTeleport)

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(function(player)
    if selectedPlayer and selectedPlayer ~= "无" and player.Name == selectedPlayer then
        WindUI:Notify({
            Title = "传送提示",
            Content = "目标玩家："..selectedPlayer.." 已退出服务器",
            Duration = 5,
        })
    end
    updatePlayerList()
end)

updatePlayerList()
dropdownRef = Main:Dropdown({
    Title = "选择玩家",
    Values = playerList,
    Value = "无",
    Callback = function(option)
        selectedPlayer = option
        teleportSettings.targetPlayer = option and option ~= "无" and Players:FindFirstChild(option) or nil
    end
})

Main:Toggle({
    Title = "传送",
    Value = false,
    Callback = function(isEnabled)
        if isEnabled and (not teleportSettings.targetPlayer or selectedPlayer == "无") then
            WindUI:Notify({
                Title = "传送提示",
                Content = "请先选择要跟随的玩家",
                Duration = 3,
            })
            return false
        end
        
        teleportSettings.isTeleporting = isEnabled
        teleportSettings.isCircling = false
        
        if not isEnabled then
            teleportToOriginalPosition()
        end
    end
})

Main:Dropdown({
    Title = "传送位置",
    Values = {"前面", "头顶", "背后", "下面"},
    Value = "前面",
    Callback = function(position)
        teleportSettings.position = position
    end
})

Main:Toggle({
    Title = "环绕模式",
    Value = false,
    Callback = function(isEnabled)
        teleportSettings.isCircling = isEnabled
    end
})
Main:Slider({
    Title = "环绕半径",
    Desc = "设置环绕时的半径大小",
    Value = {
        Min = 1,
        Max = 20,
        Default = 5,
    },
    Callback = function(Value)
        teleportSettings.circleRadius = Value
    end
})

Main:Slider({
    Title = "环绕高度",
    Desc = "设置环绕时的高度",
    Value = {
        Min = -10,
        Max = 10,
        Default = 0,
    },
    Callback = function(Value)
        teleportSettings.circleHeight = Value
    end
})

Main:Slider({
    Title = "环绕速度",
    Desc = "设置环绕时的移动速度",
    Value = {
        Min = 0.1,
        Max = 5,
        Default = 1,
    },
    Callback = function(Value)
        teleportSettings.circleSpeed = Value
    end
})

Main:Slider({
    Title = "跟随距离",
    Desc = "设置跟随时的距离",
    Value = {
        Min = 1,
        Max = 20,
        Default = 3,
    },
    Callback = function(Value)
        teleportSettings.distance = Value
    end
})
    local MainTab = Window:Tab({Title = "背包", Icon = "settings"})
local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local devv               = require(ReplicatedStorage.devv)
local item               = devv.load("v3item")
local Signal             = devv.load("Signal")
local junkWeps  = {"Uzi","M1911","C4","Glock","Mossberg","Stagecouch","Python"}
local junkGems  = {"Amethyst","Sapphire","Emerald","Topaz","Ruby"}
local junkMisc  = {"Baseball Bat","Basketball","Bloxaide","Bloxy Cola","Cake","Stop Sign"}
local setting = { collect = {} }
local function rmList(list)
    for _, v in next, item.inventory.items do
        for _, name in ipairs(list) do
            if v.name == name then
                Signal.FireServer("removeItem", v.guid)
             
                break
            end
        end
    end
end
local running = {}         
local function loopClean(key, list)
    if running[key] then return end        
    running[key] = true
    task.spawn(function()
        while setting.collect[key] do
            rmList(list)
            task.wait(0.5)
        end
        running[key] = false
    end)
end
local function addToggle(title, key, list)
    MainTab:Toggle({
        Title   = title,
        Default = false,
        Callback = function(v)
            setting.collect[key] = v
            if v then loopClean(key, list) end
        end
    })
end

do
    local allJunk = {}
    for _, v in ipairs(junkWeps)  do table.insert(allJunk, v) end
    for _, v in ipairs(junkGems)  do table.insert(allJunk, v) end
    for _, v in ipairs(junkMisc)  do table.insert(allJunk, v) end
    rmList(allJunk)
end
addToggle("自动移除垃圾枪",   "autoremoveweps",  junkWeps)
addToggle("自动移除垃圾宝石", "autoremovegems",  junkGems)
addToggle("自动移除其它垃圾", "autoremovemisc",  junkMisc)
MainTab:Slider({
    Title = "物品栏数量",
    Desc = "调整背包物品栏的数量",
    Value = {
        Min = 1,
        Max = 12,
        Default = 6,
    },
    Callback = function(Value)
        local sum = require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory)
        sum.numSlots = Value
    end
})
local Magisk = Window:Tab({Title = "透视", Icon = "settings"})

Magisk:Toggle({
    Title = "显示名字血量",
    Value = false,
    Callback = function(enableESP)
        if enableESP then
            local function ApplyESP(v)
                if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                    v.Character.Humanoid.NameDisplayDistance = 9e9
                    v.Character.Humanoid.NameOcclusion = "NoOcclusion"
                    v.Character.Humanoid.HealthDisplayDistance = 9e9
                    v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
                    v.Character.Humanoid.Health = v.Character.Humanoid.Health 
                end
            end
            
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            
        
            for i, v in pairs(Players:GetPlayers()) do
                ApplyESP(v)
                v.CharacterAdded:Connect(function()
                    task.wait(0.33)
                    ApplyESP(v)
                end)
            end
            
          
            Players.PlayerAdded:Connect(function(v)
                ApplyESP(v)
                v.CharacterAdded:Connect(function()
                    task.wait(0.33)
                    ApplyESP(v)
                end)
            end)
            
          
            local espConnection = RunService.Heartbeat:Connect(function()
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                        v.Character.Humanoid.NameDisplayDistance = 9e9
                        v.Character.Humanoid.NameOcclusion = "NoOcclusion"
                        v.Character.Humanoid.HealthDisplayDistance = 9e9
                        v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
                    end
                end
            end)
            
        
            _G.ESPConnection = espConnection
        else
          
            if _G.ESPConnection then
                _G.ESPConnection:Disconnect()
                _G.ESPConnection = nil
            end
            
           
            local Players = game:GetService("Players")
            for i, v in pairs(Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
                    v.Character.Humanoid.NameDisplayDistance = 100
                    v.Character.Humanoid.NameOcclusion = "OccludeAll"
                    v.Character.Humanoid.HealthDisplayDistance = 100
                    v.Character.Humanoid.HealthDisplayType = "DisplayWhenDamaged"
                end
            end
        end
    end
})
local Magisk = Window:Tab({Title = "美化", Icon = "settings"})

Magisk:Dropdown({
    Title = "选择一个皮肤",
    Values = { 
        "烟火", "虚空", "纯金", "暗物质", "反物质", "神秘", "虚空神秘", "战术", "纯金战术", 
        "白未来", "黑未来", "圣诞未来", "礼物包装", "猩红", "收割者", "虚空收割者", "圣诞玩具",
        "荒地", "隐形", "像素", "钻石像素", "黄金零下", "绿水晶", "生物", "樱花", "精英", 
        "黑樱花", "彩虹激光", "蓝水晶", "紫水晶", "红水晶", "零下", "虚空射线", "冰冻钻石",
        "虚空梦魇", "金雪", "爱国者", "MM2", "声望", "酷化", "蒸汽", "海盗", "玫瑰", "黑玫瑰",
        "激光", "烟花", "诅咒背瓜", "大炮", "财富", "黄金大炮", "四叶草", "自由", "黑曜石", "赛博朋克"
    },
    Callback = function(Value) 
        if Value == "烟火" then
            skinsec = "Sparkler"
        elseif Value == "虚空" then
            skinsec = "Void"
        elseif Value == "纯金" then
            skinsec = "Solid Gold"
        elseif Value == "暗物质" then
            skinsec = "Dark Matter"
        elseif Value == "反物质" then
            skinsec = "Anti Matter"
        elseif Value == "神秘" then
            skinsec = "Hystic"
        elseif Value == "虚空神秘" then
            skinsec = "Void Mystic"
        elseif Value == "战术" then
            skinsec = "Tactical"
        elseif Value == "纯金战术" then
            skinsec = "Solid Gold Tactical"
        elseif Value == "白未来" then
            skinsec = "Future White"
        elseif Value == "黑未来" then
            skinsec = "Future Black"
        elseif Value == "圣诞未来" then
            skinsec = "Christmas Future"
        elseif Value == "礼物包装" then
            skinsec = "Gift Wrapped"
        elseif Value == "猩红" then
            skinsec = "Crimson Blood"
        elseif Value == "收割者" then
            skinsec = "Reaper"
        elseif Value == "虚空收割者" then
            skinsec = "Void Reaper"
        elseif Value == "圣诞玩具" then
            skinsec = "Christmas Toy"
        elseif Value == "荒地" then
            skinsec = "Wasteland"
        elseif Value == "隐形" then
            skinsec = "Invisible"
        elseif Value == "像素" then
            skinsec = "Pixel"
        elseif Value == "钻石像素" then
            skinsec = "Diamond Pixel"
        elseif Value == "黄金零下" then
            skinsec = "Frozen-Gold"
        elseif Value == "绿水晶" then
            skinsec = "Atomic Nature"
        elseif Value == "生物" then
            skinsec = "Biohazard"
        elseif Value == "樱花" then
            skinsec = "Sakura"
        elseif Value == "精英" then
            skinsec = "Elite"
        elseif Value == "黑樱花" then
            skinsec = "Death Blossom-Gold"
        elseif Value == "彩虹激光" then
            skinsec = "Rainbowlaser"
        elseif Value == "蓝水晶" then
            skinsec = "Atomic Water"
        elseif Value == "紫水晶" then
            skinsec = "Atomic Amethyst"
        elseif Value == "红水晶" then
            skinsec = "Atomic Flame"
        elseif Value == "零下" then
            skinsec = "Sub-Zero"
        elseif Value == "虚空射线" then
            skinsec = "Void-Ray"
        elseif Value == "冰冻钻石" then
            skinsec = "Frozen Diamond"
        elseif Value == "虚空梦魇" then
            skinsec = "Void Nightmare"
        elseif Value == "金雪" then
            skinsec = "Golden Snow"
        elseif Value == "爱国者" then
            skinsec = "Patriot"
        elseif Value == "MM2" then
            skinsec = "MM2 Barrett"
        elseif Value == "声望" then
            skinsec = "Prestige Barnett"
        elseif Value == "酷化" then
            skinsec = "Skin Walter"
        elseif Value == "蒸汽" then
            skinsec = "Steampunk"
        elseif Value == "海盗" then
            skinsec = "Pirate"
        elseif Value == "玫瑰" then
            skinsec = "Rose"
        elseif Value == "黑玫瑰" then
            skinsec = "Black Rose"
        elseif Value == "激光" then
            skinsec = "Hyperlaser"
        elseif Value == "烟花" then
            skinsec = "Firework"
        elseif Value == "诅咒背瓜" then
            skinsec = "Cursed Pumpkin"
        elseif Value == "大炮" then
            skinsec = "Cannon"
        elseif Value == "财富" then
            skinsec = "Firework"
        elseif Value == "黄金大炮" then
            skinsec = "Gold Cannon"
        elseif Value == "四叶草" then
            skinsec = "Lucky Clover"
        elseif Value == "自由" then
            skinsec = "Freedom"
        elseif Value == "黑曜石" then
            skinsec = "Obsidian"
        elseif Value == "赛博朋克" then
            skinsec = "Cyberpunk"
        end
    end
})
Magisk:Toggle({
    Title = "开启美化",
    --Image = "bird",
    Value = false,
    Callback = function(start) 
autoskin = start
if autoskin then
local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
for i, item in next, b1 do 
if item.type == "Gun" then
it.skinUpdate(item.name, skinsec)
end
end
end
end
})
local Main = Window:Tab({Title = "人物", Icon = "settings"})

Main:Toggle({
    Title = "走路/飞行速度 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})

Main:Slider({
    Title = "速度设置",
    Desc = "拉条",
    Value = {
        Min = 1,
        Max = 100,
        Default = 1,
    },
    Callback = function(Value)
        Speed = Value
    end
})

Main:Toggle({
    Title = "扩大视野 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            fovConnection = game:GetService("RunService").Heartbeat:Connect(function()
                workspace.CurrentCamera.FieldOfView = 120
            end)
        elseif not v and fovConnection then
            fovConnection:Disconnect()
            fovConnection = nil
        end
    end
})

Main:Slider({
    Title = "视野范围设置",
    Desc = "调整视野大小",
    Value = {
        Min = 70,
        Max = 120,
        Default = 120,
    },
    Callback = function(Value)
        if fovConnection then
            workspace.CurrentCamera.FieldOfView = Value
        end
    end
})


Main:Toggle({
    Title = "稳定飞行",
    Default = false,
    Callback = function(Value)
        FlyEnabled = Value
        if Value then
            for i, v in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                LocalPlayer.Character.Humanoid:SetStateEnabled(v, false)
            end
            LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            originalGravity = workspace.Gravity
            workspace.Gravity = 0
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.AutoRotate = false
            end
            task.spawn(function()
                while FlyEnabled do
                    pcall(function()
                        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
                        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
                        if LocalPlayer.Character then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                                LocalPlayer.Character.HumanoidRootPart.Position,
                                LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer:GetMouse().Hit.LookVector
                            )
                        end
                    end)
                    RunService.Heartbeat:Wait()
                end
            end)
        else
          
            for i, v in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                LocalPlayer.Character.Humanoid:SetStateEnabled(v, true)
            end
            
         
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.AutoRotate = true
            end
            
         
            workspace.Gravity = originalGravity or 196.2
            
            LocalPlayer.Character.Humanoid:ChangeState("Flying")
        end
    end
})

do local TouchFlingModule={}TouchFlingModule.Version="1.0" TouchFlingModule.LoadTime=tick()local flingEnabled=false local flingPower=10000 local flingThread=nil local flingMove=0.1 Main:Input({Title="碰飞距离",Desc="大小",Value=tostring(flingPower),Placeholder="输入",Color=Color3.fromRGB(0,170,255),Callback=function(Value)local power=tonumber(Value)if power then flingPower=power end end})Main:Toggle({Title="开启碰飞",Default=flingEnabled,Callback=function(State)flingEnabled=State if flingThread then task.cancel(flingThread)flingThread=nil end if flingEnabled then flingThread=task.spawn(function()local RunService=game:GetService("RunService")local Players=game:GetService("Players")local lp=Players.LocalPlayer while flingEnabled do RunService.Heartbeat:Wait()local c=lp.Character local hrp=c and c:FindFirstChild("HumanoidRootPart")if hrp then local vel=hrp.Velocity hrp.Velocity=vel*flingPower+Vector3.new(0,flingPower,0)RunService.RenderStepped:Wait()hrp.Velocity=vel RunService.Stepped:Wait()hrp.Velocity=vel+Vector3.new(0,flingMove,0)flingMove=-flingMove end end end)end end})TouchFlingModule.Cleanup=function()if flingThread then task.cancel(flingThread)flingThread=nil end flingEnabled=false end if _G.TouchFlingModule then _G.TouchFlingModule.Cleanup()end _G.TouchFlingModule=TouchFlingModule end


Main:Toggle({
    Title = "隐身",
    Default = false,
    Callback = function(Value)
        if invisThread then
            task.cancel(invisThread)
            invisThread = nil
        end

        if Value then
            invisThread = task.spawn(function()
                local Player = game:GetService("Players").LocalPlayer
                RealCharacter = Player.Character or Player.CharacterAdded:Wait()
                RealCharacter.Archivable = true
                FakeCharacter = RealCharacter:Clone()
                Part = Instance.new("Part")
                Part.Anchored = true
                Part.Size = Vector3.new(200, 1, 200)
                Part.CFrame = CFrame.new(0, -500, 0)
                Part.CanCollide = true
                Part.Parent = workspace
                FakeCharacter.Parent = workspace
                FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

                for _, v in pairs(RealCharacter:GetChildren()) do
                    if v:IsA("LocalScript") then
                        local clone = v:Clone()
                        clone.Disabled = true
                        clone.Parent = FakeCharacter
                    end
                end

                for _, v in pairs(FakeCharacter:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 0.7
                    end
                end

                local function EnableInvisibility()
                    StoredCF = RealCharacter.HumanoidRootPart.CFrame
                    RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
                    FakeCharacter.HumanoidRootPart.CFrame = StoredCF
                    RealCharacter.Humanoid:UnequipTools()
                    Player.Character = FakeCharacter
                    workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
                    RealCharacter.HumanoidRootPart.Anchored = true

                    for _, v in pairs(FakeCharacter:GetChildren()) do
                        if v:IsA("LocalScript") then
                            v.Disabled = false
                        end
                    end
                end

                RealCharacter.Humanoid.Died:Connect(function()
                    if Part then Part:Destroy() end
                    if FakeCharacter then FakeCharacter:Destroy() end
                    Player.Character = RealCharacter
                end)

                EnableInvisibility()

                game:GetService("RunService").RenderStepped:Connect(function()
                    if RealCharacter and RealCharacter:FindFirstChild("HumanoidRootPart") and Part then
                        RealCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
                    end
                end)
            end)
        else
            if Part then Part:Destroy() Part = nil end
            if FakeCharacter then FakeCharacter:Destroy() FakeCharacter = nil end
            if RealCharacter then
                RealCharacter.HumanoidRootPart.Anchored = false
                RealCharacter.HumanoidRootPart.CFrame = StoredCF
                game:GetService("Players").LocalPlayer.Character = RealCharacter
                workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
            end
        end
    end
})
local adminNames = {
    "LightKorzo",
    "Kehcdc1",
    "kumamlkan1",
    "Realsigmadeeepseek",
    "Ping4HelP",
    "RedRubyyy611",
    "Recall612",
    "Davydevv"
}
local adminCheckConn = nil
local function checkPlayers()
    local localPlayer = game:GetService("Players").LocalPlayer
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        for _, name in ipairs(adminNames) do
            if plr.Name == name then
                localPlayer:Kick("NE HUB 贵宾版本[防管理]\n检测到管理员: " .. name .. "\n已自动为你退出服务器")
                return
            end
        end
    end
end
Main:Toggle({
    Title   = "防管理员",
    Default = false,
    Callback = function(Value)
        if adminCheckConn then
            adminCheckConn:Disconnect()
            adminCheckConn = nil
        end
        if Value then
            adminCheckConn = game:GetService("RunService").Heartbeat:Connect(function()
                checkPlayers()
            end)
        end
    end
})
Main:Toggle({
    Title = "无限跳",
    Default = false,
    Callback = function(Value)
        local jumpConn
        if Value then
            jumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
                local humanoid = game:GetService("Players").LocalPlayer.Character and
                                 game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if jumpConn then
                jumpConn:Disconnect()
                jumpConn = nil
            end
        end
    end
})