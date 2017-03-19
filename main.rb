#I never do comments, but when I do, they suck.
#This is the main file of MnpnBot, programmed in Ruby.
#Shout out to LEGOlord208#1033 for helping me.


# Error catching and logging functions
log_debug = true
log_errors = true

# Copy paste from stack overflow.
# http://stackoverflow.com/questions/9433924/how-can-i-copy-stdout-to-a-file-without-stopping-it-showing-onscreen-using-ruby
# too lazy.
class TeeIO < IO
	def initialize orig, file
		@orig = orig
		@file = file
	end

	def write string
		@file.write string
		@orig.write string
	end
end

if log_debug then
	tee = TeeIO.new $stdout, File.new('log.txt', 'w')
	$stdout = tee
end
if log_errors then
	tee = TeeIO.new $stderr, File.new('log.txt', 'w')
	$stderr = tee
end

# Done


::RBNACL_LIBSODIUM_GEM_LIB_PATH = "Assets/libsodium.dll"
require "discordrb"
require 'urban_dict'

#require_relative 'lottery.rb'

CLIENT_ID = 289471282720800768
token = "";
File.open("token.txt") do |f|
	f.each_line do |line|
		token += line.strip
	end
end

bot = Discordrb::Commands::CommandBot.new token: token, client_id: CLIENT_ID, prefix: '_'

#I'm too lazy to bother with anything really, here is the config. Heh.

ver = "Release 1.3"

limit = 15
devmode = false
debug = true
annoy = false
started = 0
typeloops = 20
#End of config.

if devmode == true then
	version = ver + " Dev"
	puts("Development Mode is Enabled.")
else
	version = ver
end

bot.ready do
begin
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
	rescue => e
	event.channel.send_embed do |embed|
		embed.title = "Error"
		embed.description = "An error occured, and Albin caused it.\n#{e}"
		end
		end
	end

bot.ready do
	started = Time.now
	puts("Started, any errors? Version " + version)
	bot.send_message(289641868856262656, "MnpnBot started without any major issues. You should check the console, anyways. Running on version " + version)
end

bot.command(:annoy, min_args: 1, max_args: 1, usage: "annoy true/false") do |event, answ|
    if event.user.id != 172030506970382337 then
        event.channel.send_embed do |embed|
            embed.title = ":no_entry:"
            embed.description = "You're not allowed to change this."
            embed.color = 16722454 #red
        end
    else if answ == "true" then
        annoy = true
        event.channel.send_embed do |embed|
            embed.title = "MnpnBot Settings - Annoy"
            embed.description = "I changed it."
            embed.add_field(name: "Annoy", value: annoy, inline: true)
            embed.color = 1108583 #green
        end
    else if answ == "false" then
        annoy = false
        event.channel.send_embed do |embed|
            embed.title = "MnpnBot Settings - Annoy"
            embed.description = "I changed it."
            embed.add_field(name: "Annoy", value: annoy, inline: true)
            embed.color = 1108583 #green
        end
    else
        event.channel.send_embed do |embed|
            embed.title = "What the fuck?"
            embed.description = "What's your problem? It's either true or false you fucking moron."
            embed.add_field(name: "Annoy", value: annoy, inline: true)
            embed.color = 16722454 #green
        end
    end
end
end
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

bot.message(start_with:"amirite") do |event|
    if !annoy
        next
    end
    event.respond ":regional_indicator_a::regional_indicator_m::regional_indicator_i::regional_indicator_r::regional_indicator_i::regional_indicator_t::regional_indicator_e:,    :regional_indicator_y::regional_indicator_e::regional_indicator_s:    :regional_indicator_u:    :regional_indicator_r:"
end
bot.message(contains: "why") do |event|
    if !annoy
        next
    end
    event.respond ":regional_indicator_b::regional_indicator_e::regional_indicator_c::regional_indicator_a::regional_indicator_u::regional_indicator_s::regional_indicator_e:    :regional_indicator_y::regional_indicator_o::regional_indicator_u:':regional_indicator_r::regional_indicator_e:    :regional_indicator_a::regional_indicator_n:    :regional_indicator_i::regional_indicator_d::regional_indicator_i::regional_indicator_o::regional_indicator_t:"
end

bot.message(with_text: /ikea.?/i) do |event|
	event.respond "IKEA was founded in 1943 in Älmtaryd, Sweden. The name comes from Ingvar Kamprad, Elmtaryd and Agunnaryd, the name of the founder and where he grew up."
end

#HELP

bot.command :help do |event|
	event << "Version: " + version
	event.channel.send_embed do |embed|
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: 'http://i.imgur.com/VpeUzUB.png')
		#embed.title = 'Help'
		embed.description = 'Command Information'
		embed.add_field(name: "General commands:", value: "_help: Shows you this help menu. Click the 'MnpnBot' Author title to get an invite link for your server!
_randomize: Usage: '_randomize 1 10'. Number randomizer.
_define: Usage: '_define kek'. Not specifying what to define will result in a random definition.
_invite: Shows an invite link for the bot.
_roman: Usage: '_roman 50'. Change numerals to romans.
_define: Usage: '_define kek'. Not specifying what to define will result in a random definition.
_rate: Usage: '_define the laptop'. Rate something.")

		embed.add_field(name: "Status commands:", value: "_ping: Pings the bot.
_uptime: Shows bot uptime.
_si: Shows server information.
_bi: Shows bot information.
_ui: Shows your information.")

		embed.add_field(name: "Entertaining commands:", value: "Joke: Tells you a terrible joke.")


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

i=0
bot.command(:type) do |event|
	while i < typeloops  do
		event.channel.start_typing()
		sleep(1)
		i +=1
	end
end

#Count

bot.command(:count, min_args: 1, max_args: 1, usage: "count [to]") do |event, to|
	i = 0
	begin
		i = Integer(to)
	rescue ArgumentError
		event.respond "Not a number!"
		next
	end
	if i > limit then
		event.respond "The limit is currently set at %d." % [limit]
		next
	end
	for j in 1..i do
		event << "Counting! Currently on %d." % [i+1]
	end
end
#Ping

bot.command :ping do |event|
	#event.respond "I'm here. Pinged in #{Time.now - event.timestamp} seconds."
	now = Time.now.nsec
	timestamp = event.timestamp.nsec
	diff = (now - timestamp) / 1000000
	event.channel.send_embed do |embed|
		embed.title = 'Ping result'
		embed.description = "I'm here. Pinged in #{diff} ms."
		embed.color = 1108583
		event << "If you recieved a negative number, it's a bug. The system thinks you sent the message before 'now'."
		event << "We're working on it. Run _ping again."
	end
end

#Randomize
bot.command(:randomize, min_args: 2, max_args: 2, usage: "randomize <min> <max>") do |event, min, max|
	min_i = 0
	max_i = 0

	begin
		min_i = Integer(min);
		max_i = Integer(max);
	rescue ArgumentError
		event.channel.send_embed do |embed|
			embed.title = "Randomize:"
			embed.description = "That's not numbers!"
		end
	end

	event.channel.send_embed do |embed|
		embed.title = 'Randomize:'
		embed.description = 'The result was %d.' % [rand(min_i..max_i)]
	end
end
#End of Randomize
#Jokes

bot.message(with_text: /joke.?/i) do |event|
	lines = Array.new

	File.open("jokes.txt", "r") do |f|
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

bot.command :uptime do |event|
	full_sec = Time.now - started
	sec = full_sec % 60;
	min = full_sec / 60;
	sec = sec.floor
	min = min.floor
	event.channel.send_embed do |embed|
		embed.title = 'Uptime:'
		embed.description = 'Bot uptime is %s:%s' % [min, sec]# + " minutes."
		if min < 5 then
			embed.color = 16773910 #yellow
			#16722454 red
		else
			embed.color = 1108583 #green
		end
		if min > 2880 then
			embed.color = 16722454 #red
			puts("Bot should restart!")
		end
	end
end

bot.command :invite do |event|
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

bot.command :si do |event|
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
	rescue
		event.channel.send_embed do |embed|
			embed.title = "Server Information"
			embed.description = "Advanced server information."
			embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")

			embed.add_field(name: "IDs:", value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
			embed.color = 1108583
			embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: "#{event.server.icon_url}")

			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{event.server.name}")
		end
	end
end

bot.command :bi do |event|
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
		embed.add_field(name: "Messages sent since last restart:", value: " #{msg}", inline: true)
		embed.color = 1108583
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot is hosted on a DigitalOcean Droplet in Amsterdam, Europe.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
	end
end


bot.command([:ui, :uinfo, :userinfo]) do |event|
playing = event.user.game
if playing == nil then
   playing = "None"
end
event.channel.send_embed do |embed|
  embed.title = "User Information"
	embed.description = "Name and Tag: #{event.user.name}##{event.user.discrim}"
	embed.add_field(name: "Status:", value: "#{event.user.status}")
	embed.add_field(name: "Currently Playing:", value: playing)
	embed.color = 1108583
	embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "MnpnBot %s." % [version], icon_url: 'http://i.imgur.com/VpeUzUB.png')
	end
end

bot.command(:define, min_args: 1, usage: "define <word>") do |event, *args|
	begin
		event.channel.send_embed do |embed|
			defin = nil
			msg = args.join(" ")
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

bot.command :psi do |event|
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

bot.command :mnpn do |event|
    if event.user.id != 172030506970382337 and event.user.id != 292020442422706177 then
        event.channel.send_embed do |embed|
            embed.title = ":no_entry:"
            embed.description = "You're not Mnpn or Xeon, kek."
            embed.color = 16722454 #red
        end
    else
        event.channel.send_embed do |embed|
            embed.title = "MnpnBot Settings"
            embed.description = "Here are the current settings."
            embed.add_field(name: "Development mode", value: devmode, inline: true)
            embed.add_field(name: "Count Limit", value: limit, inline: true)
            embed.add_field(name: "Version", value: version, inline: true)
            embed.add_field(name: "Debug mode", value: debug, inline: true)
            embed.add_field(name: "Annoy", value: annoy, inline: true)
            embed.color = 1108583 #green
        end
    end
end

bot.command(:roman, min_args: 1, max_args: 1, usage: "roman [num]") do |event, num|
	# Coded by LEGOlord208
	i = 0;
	begin
		i = Integer(num)
	rescue ArgumentError
		event.respond "That's not a number."
		next
	end

	if i > 10000 then
		event.respond "The value is too big."
		next
	end

	nums = {
		1 => "I",
		4 => "IV",
		5 => "V",
		9 => "IX",
		10 => "X",
		40 => "XL",
		50 => "L",
		90 => "XC",
		100 => "C",
		400 => "CD",
		500 => "D",
		900 => "CM",
		1000 => "M"
	}

	len = 1000
	out = ""

	while i > 0 do
		d = i;
		if len != 1 then
			d = (i / len).floor
			if d <= 0 then
				len /= 10
				next
			end

			d *= len
		end

		rest = 0;
		while !nums.key?(d) do
			d -= len
			rest += 1
		end

		found = nums[d]
		one = nums[len]

		out += found.to_s

		while rest > 0 do
			out += one
			rest -= 1
		end

		i = i % len;
		len /= 10;
	end

	event.channel.send_embed do |embed|
		embed.title = "Roman:"
		embed.description = "The converted number is " + out + "."
	end
end

bot.command :reload do |event|
	if event.user.id != 172030506970382337 then
		event.channel.send_embed do |embed|
			embed.title = ":no_entry:"
			embed.description = "You're not allowed to run this command."
			embed.color = 16722454 #red
		end
	else
		event.channel.send_embed do |embed|
			embed.title = "Reload"
			embed.description = "Reloading Mnpnbot!"
			embed.add_field(name: "Version", value: version, inline: true)
			embed.add_field(name: "Development mode", value: devmode, inline: true)
			embed.add_field(name: "Debug mode", value: debug, inline: true)
			embed.color = 1108583 #green
		end
		#REALLY GOOD RELOADING CODES GOES HERE M9
	end
end

bot.command :mcstat do |event, *args|
	begin
		serv = JSON.parse(RestClient.get("https://mcapi.ca/query/"+args[0]+"/info"))
	rescue => e
		event << ("Something went wrong!")
		event << e
	end
	if serv['status']
		event.channel.send_embed do |embed|
			embed.title = "Minecraft Server Statistics"
			embed.description = "Minecraft Statistics for %d." % args[0]
			embed.add_field(name: "MOTD:", value: serv['motd'], inline: true)
			embed.add_field(name: "Version:", value: serv['version'], inline: true)
			embed.add_field(name: "Players:", value: serv['players']['online']+"/"+serv['players']['max'], inline: true)
			embed.add_field(name: "Ping:", value: debug, inline: true)
			embed.color = 1108583 #green
		end
	else
				event.channel.send_embed do |embed|
			embed.title = ":octagonal_sign:"
			embed.description = "Invalid server."
			embed.color = 16722454 #red
		end
	end
end

isplaying = 0
bot.command(:devplay) do |event, songlink|
  if isplaying == 1
    event.message.delete
    event.channel.send_embed do |embed|
			embed.title = ":arrow_forward:"
			embed.description = "Already playing!"
			embed.color = 16722454 #red
		end
    break
  end
  channel = event.user.voice_channel
  unless channel.nil?
    voice_bot = bot.voice_connect(channel)
    system("youtube-dl --no-playlist --max-filesize 100m -o 'music/s.%(ext)s' -x --audio-format mp3 #{songlink}")
    event.channel.send_embed do |embed|
			embed.title = ":arrow_forward:"
			embed.description = "Alright, I'll play it!"
			embed.color = 1108583 #red
		end
    isplaying = 1
    voice_bot.play_file('./music/s.mp3')
    voice_bot.destroy
    isplaying = 0
    break
  end
    event.channel.send_embed do |embed|
			embed.title = ":grey_question:"
			embed.description = "You're not in a voice channel! It's not that hard."
			embed.color = 16722454 #red
		end
		    event.channel.send_embed do |embed|
			embed.title = ":grey_question:"
			embed.description = "Are you stupid? You can't stop something that's already stopped. (No song is playing)."
			embed.color = 16722454 #red
		end
	end

bot.command(:devstop) do |event|
  isplaying = 0
  event.voice.stop_playing
  bot.voices[event.server.id].destroy
  nil
end

bot.command(:mcskin, min_args: 1, max_args: 1) do |event|
  _, *rating = event.message.content.split
  event.respond "Sure, here is the 3D version of the skin: #{rating.join(' ')}. https://visage.surgeplay.com/full/512/#{rating.join(' ')}.png"
end

      bot.command(:rate, min_args: 1, description: 'Rate things!', usage: 'rate <stuff>') do |event, *text|
        event.respond "I give #{text.join(' ')} a "\
                      "#{rand(0.0..10.0).round(1)}/10.0!"
end


trap("INT") do
	exit
end

bot.run
