local cloneref=cloneref or function(f)return f end
local requestfun = (syn and syn.request) or (fluxus and fluxus.request) or request or http_request
local clonefunction = clonefunction or function(f) return f end
local isfunctionhooked = isfunctionhooked and clonefunction(isfunctionhooked) or nil
local restorefunction = restorefunction or function(f) return f end
local newcclosure = newcclosure or function(f) return f end
env = _G or getenv
player = game:GetService("Players").LocalPlayer

function isvalidmetamethod(method)
  local valid = {"__namecall", "__index", "__newindex"}
  for _, m in next, valid do
    if m == method then
      return true
    end
  end
  return false
end

function getgamemt()
  local mt = getrawmetatable(game)
  setreadonly(mt, false)
  return mt
end

function hookmetamethod(method, func)
  print("HOOKING")
  assert(isvalidmetamethod(method), "Invalid metamethod!")
  local mt = getgamemt()
  if backup[method] == nil then 
    backup[method] = mt[method]
  end 
  if ishookset then
    restoremetamethod(method)
    mt = getgamemt()
  end
  local newfunc = func(mt[method])
  mt[method] = newfunc
  ishookset = true
  print("HOOKED")
end

function restoremetamethod(method)
  if backup[method] then
    local mt = getgamemt()
    mt[method] = backup[method]
  end
  ishookset = false
end

getgenv().hookmetamethod = hookmetamethod
getgenv().restoremetamethod = restoremetamethod

print("Module: MTHelper loaded")

hookfunction = function(original, hook)
    if type(original) ~= "function" then
        error("The first arg must be a function (original func).")
    end
    if type(hook) ~= "function" then
        error("The second arg must be a function (hook).")
    end
    local hooked = function(...)
        return hook(original, ...)
    end
    local info = debug.getinfo(original)
    if info and info.name then
        getgenv()[info.name] = hooked
    else
        error("Failed to get function name")
    end

    return hook
end

local oldsm = setmetatable
local savedmts = {}
setmetatable = function(taaable, metatable)
	local success, result = pcall(function() local result = oldsm(taaable, metatable) end)
	savedmts[taaable] = metatable
	if not success then error(result) end
	return taaable
end
getrawmetatable = function(taaable)
	return savedmts[taaable]
end
setrawmetatable = function(taaable, newmt)
	local currentmt = getrawmetatable(taaable)
	table.foreach(newmt, function(key, value)
		currentmt[key] = value
	end)
	return taaable
end
hookmetamethod = function(lr, method, newmethod) 
	local rawmetatable = getrawmetatable(lr) 
    local old = rawmetatable[method]
	rawmetatable[method] = newmethod
	setrawmetatable(lr, rawmetatable)
	return old
end 

replaceclosure = hookfunction

function kick(message)
player:Kick(message)
while true do end
end
local advance = {
    loadstring = loadstring,
    httpGet = game.HttpGet,
    httpPost = game.HttpPost,
    kick = player.Kick,
    lpname = player.Name,
    request = requestfun,
    print = print,
    error = error,
    warn = warn,
    pairs = pairs,
    ipairs = ipairs,
    next = next,
    pcall = pcall,
    xpcall = xpcall,
    spawn = spawn,
    clonefunction = clonefunction,
    newcclosure = newcclosure,
    rawset = rawset,
    rawget = rawget,
    rcon = {
        rconsoleerr = rconsoleerr,
        rconsolewarn = rconsolewarn,
        
        
    },
    debug = {
        getinfo = debug.getinfo,
        traceback = debug.traceback,
        info = debug.info
    },
    hook = {
        hookfunction = hookfunction,
        hookmetamethod = hookmetamethod,
        hookmethod = hookmethod
    },
    string = {
        format = string.format
    },
    getEnv = getenv,
    getScriptEnv = getsenv,
    getRegistry = getreg,
    getUpvalue = getupvalue,
    getGC = getgc,
    getConnections = getconnections,
    tostring = tostring,
    getmetatable = getmetatable,
    islclosure = islclosure,
    getfenv = getfenv,
    restorefunction = restorefunction
}

setmetatable(advance, {__index = _G})

for _, obj in pairs(getgc(true) or {}) do
    if typeof(obj) == "table" and not getmetatable(obj) then
        for k, v in pairs(obj) do
            local valid, result = pcall(function() 
                return isfunctionhooked(v)
            end)
            if valid and result then
                kick("请重新登录[Hook][1]")
            end
        end
    end
end

if typeof(getfenv) ~= "function" or isfunctionhooked(getfenv) then
    kick("[Hooker] getfenv")
    debug.info("[Hooker] getgenv")
elseif typeof(getgc) ~= "function" or isfunctionhooked(getgc) then
    kick("[Hooker] getgc")
    debug.info("[Hooker] getgc")
elseif typeof(debug.getinfo) ~= "function" or isfunctionhooked(debug.getinfo) then
    kick("[Hooker] debug.getinfo")
    debug.info("[Hooker] debug.getinfo")
end

if game:GetService("CoreGui"):FindFirstChild("ExperienceChat") then
    if game:GetService("CoreGui").ExperienceChat:FindFirstChild("BubbleChat_"..player.UserId) then
        kick("请重新尝试登录[2]")
    end
end

for _, obj in ipairs(game:GetDescendants()) do
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") or obj:IsA("Message") then
        local name = string.lower(tostring(obj.Name))
        local text = string.lower(tostring(obj.Text))
        
        if string.find(name, "spy") or string.find(text, "Spy") then
            obj:Destroy()
        end
    end
end

local ok, stack = pcall(debug.traceback)
if string.find(stack:lower(), "stack overflow") then
    kick("请重新登录[Hook][3]")
end

for _,v in ipairs(advance) do
    info = debug.getinfo(v, "S") or debug.getinfo(1, "S")
    if info.what ~= "C" then
        kick("请重新登录[Hook][4]")
    elseif info.source == "=[C]" or info.short_src == "[C]" then
        kick("请重新登录[Hook][5]")
    end
end

local Globals = {"_G", "getfenv", "setfenv", "getgenv"}
for _, global in ipairs(Globals) do
    if rawget(_G, global) ~= _G[global] then
        kick("请重新登录[Hook][6]")
    end
end

for i, v in ipairs(advance) do
    if type(env[v]) == "function" then
         player:Kick("请重新登录[Hook][7]")
    end
    if type(v) == "table" then
        for i, a in pairs(v) do
            if isfunctionhooked and isfunctionhooked(a) then
                restorefunction(a)
                kick("请重新登录[Hook][8]")
            end
        end
    else
        if isfunctionhooked and isfunctionhooked(v) then
            restorefunction(v)
            kick("请重新登录[Hook][8]")
        end
    end
end

if player.Name == "" or not player.Name then
    player:Kick("请重新登录[未检测到用户名]")
end

player.CharacterAdded:Connect(function(character)
    if player.Name ~= character.Name then
        kick("禁止修改用户名")
    end
end)

if game:GetService("RunService"):IsStudio() then
    kick("Do not run in Studio")
end

local response = requestfun({
    Url = "https://users.roblox.com/v1/users/"..player.UserId,
    Method = "GET"
})

if response.StatusCode == 404 or response.StatusCode ~= 200 then
    kick("http not found?")
end

if response.Success then
    local json = game:GetService("HttpService"):JSONDecode(response.Body)
else
    kick("请重新登录[未检测到url]")
end

if not player.DisplayName then
    kick("请重新登录[未检测到DisplayName]")
end

if json.name ~= player.Name and tostring(userData.id) ~= tostring(player.UserId) then
    kick("")
end