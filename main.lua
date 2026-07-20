--[[
wiiremote
amazing software i guess lol????

notes:
* commented code is just deleted from the bot
* prefixes still hardcoded but i will change that soon
* this bot is wip and still has bugs, it is also very incomplete
* more stuff that i dont have in mind
* i forgot to tell that slash commands dont work anymore
--]]

local discordia = require("discordia")
local client = discordia.Client()
local botver = "3.0.0-alpha"
local embedcolor = 0x38e3fc
local server = {
	id = "1527755278010023996",
	bugreportchannel = "1527756530634723449",
	serverrequestchannel = "1528120109627867268",
}
local success = ":3"
local err = ":'C"
local prefix = "!"

discordia.extensions()

math.randomseed(os.time())

client:on("ready", function()
	print("Logged in as " .. client.user.name)
end)

client:on("messageCreate", function(message)
	if message.author.bot then
		return
	end
	if string.lower(message.content) == prefix.."cmd" then
		message:reply{
			content = "ja",
			embed = {
				title = "commands",
				description = "versione: "..botver.."\nprefisso: "..prefix.."\n\n"..prefix.."ver\n"..prefix.."serverinfo\n"..prefix.."channel <name>\n"..prefix.."8ball en/it <question>\n"..prefix.."invite\n"..prefix.."createinvite\n"..prefix.."color <color>\n"..prefix.."category <name>\n"..prefix.."setcategory\n"..prefix.."getchannelid\n"..prefix.."getserverid",
				--[[fields =  {
					--[[{
						name = "!avviso <avviso> **[DEPRECATO]**",
						value = "Manda un avviso nella bacheca (solo per amministratori)",
						inline = false,
					},
					{
						name = "!messaggio <messaggio> **[DEPRECATO]**",
						value = "Manda un messaggio ai moderatori/amministratori. Si prega di farlo solo se è urgente e anche di SEMPRE firmare il messaggio con il tuo username/handle di Discord così ti riconosciamo.",
						inline = false,
					},
					{
						name = "!richiesta <descrizione> **[DEPRECATO]**",
						value = "Manda una richiesta per una idea o per creare il tuo canale.",
						inline = false,
					},
					{
						name = prefix.."serverinfo",
						value = "prendi informazioni su questo server // get information about this server",
						inline = false,
					},
					{
						name = prefix.."ticket",
						value = "crea un ticket // create a ticket",
						inline = false,
					},
					{
						name = prefix.."8ball",
						value = "chiedi una domanda alla 8ball // ask the 8ball a question",
						inline = false,
					},
					{
						name = prefix.."invite",
						value = "prendi un link d'invito di carota // get a carota invite link",
						inline = false,
					},
					--[[{
						name = "!channel <name>",
						value = "crea un canale nella categoria \"Community\"",
						inline = false,
					},
					{
						name = prefix.."color <color>",
						value = "cambia il colore del nome // change name color",
						inline = false,
					},
					--[[{
						name = "!voto",
						value = "Crea un sondaggio.",
						inline = false,
					},
					{
						name = "!sondaggio",
						value = "Equivalente di !voto",
						inline = false,
					},
				},]]
				color = embedcolor,
			}
		}
	elseif string.lower(message.content) == prefix.."createinvite" then
		local invite = message.channel:createInvite()
		message:reply{
			embed = {
				title = "Invite",
				description = "ends in 24 hours!\nfinisce in 24 ore!\n\nhttps://discord.gg/"..invite.code,
				color = embedcolor,
			}
		}
	elseif string.lower(message.content) == prefix.."getchannelid" then
		message:reply(message.channel.id)
	elseif string.lower(message.content) == prefix.."getserverid" then
		message:reply(message.guild.id)
	elseif string.lower(message.content):startswith(prefix.."channel ") then
		local args = message.content:split(" ")
		table.remove(args, 1)

		local channelNameString = string.lower(table.concat(args, "-"))

		if message.member:hasPermission("manageChannels") then
			local channel = client:getGuild(server.id):createTextChannel(channelNameString)
			message:reply("<#"..channel.id..">")
		else
			message:reply(err)
		end
	elseif string.lower(message.content):startswith(prefix.."category") then
		local args = message.content:split(" ")
		table.remove(args, 1)
		local categoryNameString = string.lower(table.concat(args, " "))
		if message.member:hasPermission("manageChannels") then
			local category = client:getGuild(server.id):createCategory(categoryNameString)
			message:reply(success)
		else
			message:reply(err)
		end
	elseif string.lower(message.content):startswith(prefix.."setcategory") then
		local args = message.content:split(" ")
		if message.member:hasPermission("manageChannels") then
			message.channel:setCategory(args[2])
			message:reply(success)
		else
			message:reply(err)
		end
	elseif string.lower(message.content) == "!deletechannel" then
		if message.member:hasPermission("manageChannels") then
			message.channel:delete()
		else
			message:reply(err)
		end
	elseif string.lower(message.content):startswith(prefix.."8ball en ") then
		local rnd = math.random(1,6)
		local msg
		if rnd == 1 then
			message:reply("maybe")
		elseif rnd == 2 then
			message:reply("do some more thinking")
		elseif rnd == 3 then
			message:reply("yes")
		elseif rnd == 4 then
			message:reply("no")
		elseif rnd == 5 then
			message:reply("absolutely")
		elseif rnd == 6 then
			message:reply("absolutely not")
		end
	elseif string.lower(message.content):startswith(prefix.."8ball it ") then
		local rnd = math.random(1,6)
		local msg
		if rnd == 1 then
			message:reply("forse")
		elseif rnd == 2 then
			message:reply("pensaci un po'")
		elseif rnd == 3 then
			message:reply("si")
		elseif rnd == 4 then
			message:reply("no")
		elseif rnd == 5 then
			message:reply("assolutamente")
		elseif rnd == 6 then
			message:reply("assolutamente no")
		end
	elseif string.lower(message.content) == prefix.."invite" then
		message:reply{
			embed = {
				title = "Carota server invite link // Link invito del server di Carota",
				description = "ah ok\nhttps://discord.gg/t3tKaUWTBu",
				color = embedcolor,
			}
		}
	elseif string.lower(message.content):startswith(prefix.."bugreport") then
		local args = string.lower(message.content):split(" ")
		table.remove(args, 1)
		local finalreport = table.concat(args, " ")
		client:getGuild(server.id):getChannel(server.bugreportchannel):send{
			embed = {
				title = "bug report from "..message.author.tag,
				description = finalreport,
				color = embedcolor,
			}
		}
		message:reply(success)
	elseif string.lower(message.content) == prefix.."ver" then
		message:reply{embed={
			title = "WiiRemote",
			description = "version "..botver.."\nversione "..botver.."\n\nprogrammed by @pizzawizard32 in Lua and hosted by @tuxza! :D\nprogrammato da @pizzawizard32 con Lua e hostato da @tuxza! :D",
			color = embedcolor,
		}}
	elseif string.lower(message.content) == prefix.."serverinfo" then
		message:reply{embed={
			title = message.guild.name,
			description = "Server name: "..message.guild.name.."\nServer ID: "..message.guild.id.."\nOwner: <@"..message.guild.ownerId..">".."\nMembers: "..tostring(message.guild.totalMemberCount).."\nText channels: "..tostring(message.guild.textChannels:count()).."\nVoice channels: "..tostring(message.guild.voiceChannels:count()).."\nChannels (in total): "..tostring(message.guild.textChannels:count()+message.guild.voiceChannels:count()).."\nCategories: "..tostring(message.guild.categories:count()).."\nCurrent channel: <#"..tostring(message.channel.id).."> ("..message.channel.id..")".."\nRoles: "..tostring(message.guild.roles:count()).."\nVerification level: "..tostring(message.guild.verificationLevel).."\nEmojis: "..tostring(message.guild.emojis:count()).."\nServer boost level: "..tostring(message.guild.premiumTier).."\nServer boost count: "..tostring(message.guild.premiumSubscriptionCount),
			color = embedcolor,
		}}
	elseif string.lower(message.content):startswith(prefix.."color ") then
		local args = string.lower(message.content):split(" ")

		for i, role in pairs(message.guild.roles:toArray()) do
			if role.name == "red" then
				message.member:removeRole(role.id)
			end
			if role.name == "orange" then
				message.member:removeRole(role.id)
			end
			if role.name == "yellow" then
				message.member:removeRole(role.id)
			end
			if role.name == "green" then
				message.member:removeRole(role.id)
			end
			if role.name == "lightblue" then
				message.member:removeRole(role.id)
			end
			if role.name == "blue" then
				message.member:removeRole(role.id)
			end
			if role.name == "purple" then
				message.member:removeRole(role.id)
			end
			if role.name == "pink" then
				message.member:removeRole(role.id)
			end
		end

		if args[2] == "red" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "red" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "orange" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "orange" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "yellow" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "yellow" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "green" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "green" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "lightblue" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "lightblue" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "blue" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "blue" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "purple" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "purple" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "pink" then
			for i, role in pairs(message.guild.roles:toArray()) do
				if role.name == "pink" then
					message.member:addRole(role.id)
				end
			end
		elseif args[2] == "pneumonoultramicroscopicsilicovolcanoconiosis" then
			message:reply("What?")
		end
	elseif message.content == prefix.."createcolorroles" then
		if message.member:hasPermission("manageRoles") then
			client:getGuild(server.id):createRole("red"):setColor(0xff0000)
			client:getGuild(server.id):createRole("orange"):setColor(0xff8000)
			client:getGuild(server.id):createRole("yellow"):setColor(0xffd600)
			client:getGuild(server.id):createRole("green"):setColor(0x00ff00)
			client:getGuild(server.id):createRole("lightblue"):setColor(0x00deff)
			client:getGuild(server.id):createRole("blue"):setColor(0x0000ff)
			client:getGuild(server.id):createRole("purple"):setColor(0x9000ff)
			client:getGuild(server.id):createRole("pink"):setColor(0xff00ff)
			message:reply(success)
		end
	elseif message.content == prefix.."whatsapp" then
		message:reply{embed = {
			title = "gruppo whatsapp",
			description = "entra nel gruppo whatsapp di carota con questo link:\nhttps://chat.whatsapp.com/FXkhVgPr4fJBkqRhQ3ckbw",
			color = 0x00ff00,
		}}
	end
end)

client:run("Bot TOKEN")
