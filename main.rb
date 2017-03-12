#I never do comments, but when I do, they suck.
#This is the main file of MnpnBot, programmed in Ruby.
#Shout out to LEGOlord208#1033 for helping me.

::RBNACL_LIBSODIUM_GEM_LIB_PATH = "C:/Users/mnpn0/Desktop/Programmering/Ruby/libsodium-win32/lib/libsodium.dll.a"
require "discordrb"
require 'urban_dict'

CLIENT_ID = 289471282720800768
token = "";
File.open("token.txt") do |f|
    f.each_line do |line|
        token += line;
    end
end

bot = Discordrb::Bot.new token: token, client_id: CLIENT_ID

#I'm too lazy to bother with anything really, here is the config. Heh.

ver = "R1.0.2"

limit = 15
devmode = true
started = 0
#End of config.

if devmode == true then
	version = ver + " Dev"
	puts("Development Mode is Enabled.")
else
version = ver
end

bot.ready do
loop do
	#bot.game = "Ruby"
	#sleep(15)
	#bot.game = version
	#sleep(15)
	#bot.game = "_help-ful!"
	#sleep(5)
	bot.stream(version, "https://www.twitch.tv/mnpn04")
	sleep(20)
	bot.stream("Ruby", "https://www.twitch.tv/mnpn04")
	sleep(5)
end
end

bot.ready do
	started = Time.now
    puts("Started, any errors? Version " + version)
	bot.send_message(289641868856262656, "MnpnBot started without any major issues. You should check the console, anyways. Running on version " + version)
end


bot.message(with_text: ":>") do |event|
    event.respond ":>"
end
bot.message(with_text: ":<") do |event|
    event.respond ":<"
end
bot.message(start_with: "9/11") do |event|
    event.respond "It's a tragedy."
end
bot.message(with_text: /kek.?/i) do |event|
    event.respond "iKek: Kek'd."
end
bot.message(with_text: /planes.?/i) do |event|
    event.respond "It's a tragedy."
end
bot.message(with_text: /cyka blyat.?/i) do |event|
    event.respond "Kurwa."
end
bot.message(with_text: /ikea.?/i) do |event|
    event.respond "IKEA was founded in 1943 in Älmtaryd, Sweden. The name comes from Ingvar Kamprad, Elmtaryd and Agunnaryd, the name of the founder and where he grew up."
end

										#HELP

bot.message(with_text: /_help.?/i) do |event|
	event << "Version: " + version
	event.channel.send_embed do |embed|
	embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: 'http://i.imgur.com/VpeUzUB.png')
	embed.title = 'Help'
	embed.description = 'Command Information'
	embed.add_field(name: "_help", value: "Shows you this help menu. Click the 'MnpnBot' Author title to get an invite link for your server!", inline: true)
	embed.add_field(name: "_randomize", value: "Usage: '_randomize 1 10'. Number randomizer.")
	embed.add_field(name: "Joke", value: "Tells you a terrible joke.")
	embed.add_field(name: "_ping", value: "Pings the bot.", inline: true)
	embed.add_field(name: "_invite", value: "Shows an invite link for the bot.", inline: true)
	embed.add_field(name: "_uptime", value: "Shows bot uptime.", inline: true)
	embed.add_field(name: "_si", value: "Shows server information.", inline: true)
	embed.add_field(name: "_bi", value: "Shows bot information.", inline: true)
	embed.add_field(name: "_define", value: "Usage: '_define kek'. Not specifying what to define will result in a random definition.", inline: true)

	embed.add_field(name: "Tea, Coffee and Java", value: "Shows Emojis.")
	embed.add_field(name: "Lenny", value: "( ͡° ͜ʖ ͡°)", inline: true	)

	#embed.footer = "Made by Mnpn#5043 in Ruby with major help from LEGOlord208#1033."
	embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Made by Mnpn#5043 in Ruby with major help from LEGOlord208#1033.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
	embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')
	
	embed.color = 1108583
end

										#END OF HELP

end
bot.message(start_with: "tea") do |event|
    event.respond ":tea:"
end

bot.message(start_with: "coffee") do |event|
    event.respond ":coffee:"
end
bot.message(start_with: "java") do |event|
    event.respond "( ͡° ͜ʖ ͡°) :coffee:"
end

bot.message(start_with: "furry") do |event|
    event.respond "The command exists, are you happy now?"
end

bot.message(with_text: /tanks.?/i) do |event|
    event.respond "*Are you talking about a war m9?*"
end

bot.message(with_text: /noot.?/i) do |event|
    event.respond "noot noot"
end

bot.message(with_text: /mimimask.?/i) do |event|
    event.respond "määä"
end

bot.message(with_text: /lenny.?/i) do |event|
    event << "( ͡° ͜ʖ ͡°)"
	event << "That's a quick lenny for you!"
end
bot.message(start_with: "boi") do |event|
    event << "( ͡° ͜ʖ ͡°)"
	event << "BOIII!"
end

										#Count

bot.message(start_with: "count ") do |event|
i_str = event.content[6..-1]
start = 0
i = 0
begin
    start = Integer(i_str)
rescue ArgumentError
    event.respond "Not a number!"
    next
end
if start > limit then
event.respond "The limit is currently set at %d." % [limit]
next
end
while start > i do
   event << "Counting! Currently on %d." % [i+1]
   i +=1
end
end
										#Ping

bot.message(with_text: /_ping.?/i) do |event|
	#event.respond "I'm here. Pinged in #{Time.now - event.timestamp} seconds."
	event.channel.send_embed do |embed|
	embed.title = 'Ping result'
	embed.description = "I'm here. Pinged in #{Time.now - event.timestamp} seconds."
	embed.color = 1108583
	end
end

										#Randomize

bot.message(start_with: "_randomize ") do |event|
msg = event.content[11..-1]
parts = msg.split " "
if parts.length != 2 then
	event.channel.send_embed do |embed|
  embed.title = 'Error'
  embed.description = "That's the wrong format. Noob."
	next
	end
	end
arr = Array.new
failed = false
parts.each do |num_str|
    num = 0
    begin
        num = Integer(num_str)
    rescue ArgumentError
		failed = true
        next
    end
    arr.push(num)
end
if failed then
    next
end
min = arr.min
max = arr.max
num = rand(max - (min - 1)) + min
	event.channel.send_embed do |embed|
  embed.title = 'Randomize:'
  embed.description = 'The result was %d.' % [num]
  end
end
										#End of Randomize
										#Jokes

bot.message(with_text: /joke.?/i) do |event|
lines = Array.new

File.open("C:/Users/mnpn0/Desktop/Programmering/Ruby/MnpnBot/jokes.txt", "r") do |f|
    f.each_line do |line|
        lines.push(line)
    end
end

joke = lines.sample
event.channel.send_embed do |embed|
  embed.title = "Here is a bad joke."
  embed.description = joke
    
    end
end
										#End of Jokes

bot.message(start_with: "_uptime") do |event|
uptime_sec = Time.now - started
uptime = Time.at(uptime_sec).strftime("%M:%S")
    event.channel.send_embed do |embed|
		embed.title = 'Uptime:'
		embed.description = 'Bot uptime is %s' % [uptime]# + " minutes."
	if uptime_sec < 5*60 then
		embed.color = 16773910 #yellow
		#16722454 red
	else
		embed.color = 1108583 #green
  end
	if uptime_sec > 120*60 then
		embed.color = 16722454 #red
		puts("Bot should restart!")
	end
  end
end

bot.message(start_with: "_invite") do |event|
    event.channel.send_embed do |embed|
  embed.title = 'Invite link. Click the invite text above to open a web browser to authorize MnpnBot.'
embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot Invite', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')
  embed.color = 1108583
  end
end

  bot.server_create do |event|
    event.server.default_channel.send_embed do |embed|
	embed.title = "MnpnBot"
	embed.description = "You have authorized **MnpnBot**. Hello World! To get started, say '_help'"
embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')
  embed.color = 1108583
  end
  end

bot.message(start_with: "_si") do |event|
begin
  if event.channel.private? then
  event.channel.send_embed do |embed|
  embed.title = ":no_entry:"
  embed.description = "This command cannot be used in a PM!"
  embed.color = 16722454
    end
  else
  event.channel.send_embed do |embed|
  embed.title = "Server Information"
  embed.description = "Advanced server information."
  embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")
	embed.add_field(name: "Icon:", value: "#{event.server.icon_url}", inline: true)
    embed.add_field(name: "IDs:", value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
	embed.color = 1108583
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: "#{event.server.icon_url}")

	embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{event.server.name}", icon_url: "#{event.server.icon_url}")
    end
	end
	rescue => e
	event.channel.send_embed do |embed|
  embed.title = "Missing Permission."
    embed.color = 16722454
  embed.description = "Not enough permission for that..? Or atleast that's what we think the error is. Check it out for yourself."
  event << "#{e}"
 end
end
end

bot.message(start_with: "_bi") do |event, *args|
    event.channel.send_embed do |embed|
  lsc = 0
  ls = bot.servers.values.each {|s| if s.large; lsc+=1; end }
  ss = bot.servers.count - lsc
  embed.title = "Bot Information"
  embed.description = "Advanced bot information."
  embed.add_field(name: "Currently active on", value: "**#{bot.servers.count}** servers.")
	embed.add_field(name: "#{lsc}", value: "Large servers", inline: true)
    embed.add_field(name: "#{ss}", value: "Small servers.", inline: true)
	embed.add_field(name: "#{bot.users.count}", value: "Unique users.", inline: true)
	embed.add_field(name: "Connected to", value: "#{bot.servers.count} servers.", inline: true)
	embed.color = 1108583
	embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot is hosted in Sweden, Europe.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
end
end

bot.message(start_with: "_define") do |event, *args|
begin
	event.channel.send_embed do |embed|
  defin = nil
  msg = event.content[7..-1]
  if msg != ''
  defin = UrbanDict.define(msg)
  else
  defin = UrbanDict.random
  end
  embed.title = "Urban Dictionary"
  embed.description = "Urban Dictionary; Define a word."
  embed.add_field(name: "***#{defin['word']}***", value: "by #{defin['author']}", inline: true)
  embed.add_field(name: "**Definition**", value: "#{defin['definition']}", inline: true)
  embed.add_field(name: "**Example**", value: "#{defin['example']}", inline: true)
  embed.add_field(name: "#{defin['thumbs_up']} Likes | #{defin['thumbs_down']} Dislikes", value: "Urban Dictionary", inline: true)
embed.add_field(name: "***<#{defin['permalink']}>***", value: "Direct link", inline: true)
embed.color = 4359924
end
rescue
event.channel.send_embed do |embed|
embed.title = "Urban Dictionary"
  embed.description = "That's not in the dictionary!"
  embed.color = 16722454 #red
  end
  end
end

bot.message(start_with: "_psi") do |event|
    if event.user.id != event.server.owner.id then
        event.channel.send_embed do |embed|
            embed.title = ":no_entry:"
            embed.description = "You're not the owner of this server."
            embed.color = 16722454 #red
        end
    else
        event << "It looks like you, <@%d" % event.server.owner.id + "> is the server owner. This feature is pretty stupid right now."
    end
end

bot.message(start_with: "_mnpn") do |event|
    if event.user.id != 172030506970382337 then
        event.channel.send_embed do |embed|
            embed.title = ":no_entry:"
            embed.description = "You're not Mnpn, kek."
            embed.color = 16722454 #red
        end
    else
	event.channel.send_embed do |embed|
            embed.title = "MnpnBot Settings"
            embed.description = "Here are the current settings."
			embed.add_field(name: "Development mode", value: devmode, inline: true)
			embed.add_field(name: "Count Limit", value: limit, inline: true)
			embed.add_field(name: "Version", value: version, inline: true)
            embed.color = 1108583 #green
end
    end
end

trap("INT") do
    exit
end

bot.run