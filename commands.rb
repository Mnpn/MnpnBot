$bot.command :help do |event|
	begin
		event.message.delete
	rescue
	end
	event.user.pm.send_embed do |embed|
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: "http://i.imgur.com/VpeUzUB.png")
		embed.description = "Command list"
		embed.add_field(name: "General commands:", value: "_help: Shows you this help menu. Click the 'MnpnBot' author title to get an invite link for your server!
_random: Usage: '_random 1 10'.
_define: Usage: '_define kek'. Not specifying what to define will result in a random definition.
_invite: Shows an invite link for the bot.
_roman: Usage: '_roman 50'. Change numerals to romans.
_rate: Usage: '_rate the laptop'.
_colour/_color: Generate a random colour and show the value in Hex, RGB and Decimal.
_lmgtfy: Generate a LMGTFY link.
_avatar: Shows a user's avatar.
_weather: Usage: '_weather Hell'.
_wikipedia/_wiki: Usage: '_wiki Ruby'.")

		embed.add_field(name: "Status commands:", value: "_ping: Pings the bot.
_uptime: Shows bot uptime.
_si: Shows server information.
_bi: Shows bot settings & information.
_ui: Shows details about you.")

		embed.add_field(name: "Entertaining commands:", value: "_insult: Sends a random insult using jD91mZM2's Oh...Sir!-like insult program.")
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "MnpnBot #{$version}", icon_url: "http://i.imgur.com/VpeUzUB.png")
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "MnpnBot", url: "https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0", icon_url: "http://i.imgur.com/VpeUzUB.png")

		embed.color = 1108583
	end
	unless event.channel.private?
		responses = ["Check your DMs!", "I sent that to you!", "Help sent in DMs!", "See if you got my message!"]
		event.respond(responses.sample + " :mailbox_with_mail:")
	end
end

$bot.command :ping do |event|
	# event.respond "I'm here. Pinged in #{Time.now - event.timestamp} seconds."
	now = Time.now.utc.nsec
	timestamp = event.timestamp.nsec
	diff = (now - timestamp) / 1000000
	event.channel.send_embed do |embed|
		embed.title = "Ping result"
		embed.description = "I'm here. Pinged in #{diff} ms."
		embed.color = 1108583
	end
end

$bot.command(:random, min_args: 2, max_args: 2, usage: "random <min> <max>") do |event, min, max|
	min_i = 0
	max_i = 0
	begin
		min_i = Integer(min)
		max_i = Integer(max)
	rescue ArgumentError
		embed.respond = "That's not numbers!"
	end
	event.respond "The result was %d." % [rand(min_i..max_i)]
end

$bot.command :uptime do |event|
	full_sec = Time.now - $started
	sec = full_sec % 60
	min = full_sec / 60
	sec = sec.floor
	min = min.floor
	event.channel.send_embed do |embed|
		embed.title = "Uptime:"
		embed.description = "Bot uptime is %s:%s" % [min, sec] # + " minutes."
		embed.color = 1108583 # green
	end
end

$bot.command :invite do |event|
	event.channel.send_embed do |embed|
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "MnpnBot Invite", url: "https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0", icon_url: "http://i.imgur.com/VpeUzUB.png")
		embed.color = 1108583
	end
end

# When authorised, send message.
$bot.server_create do |event|
	event.server.default_channel.send_embed do |embed|
		embed.title = "MnpnBot"
		embed.description = "You have authorised **MnpnBot**. Hello World! To get started, say '_help'"
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "MnpnBot", url: "https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0s", icon_url: "http://i.imgur.com/VpeUzUB.png")
		embed.color = 1108583
	end
end

$bot.command(:define, min_args: 0, usage: "define [word]") do |event, *args|
	begin
		event.channel.send_embed do |embed|
			define = nil
			msg = args.join(" ")
			define = if msg != ""
			   UrbanDict.define(msg)
					else
						UrbanDict.random
					end
			embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: define["word"], url: define["permalink"])
			embed.add_field(name: "**Definition**", value: (define["definition"]).to_s, inline: true)
			embed.add_field(name: "**Example**", value: (define["example"]).to_s, inline: true)
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{define["thumbs_up"]} likes/#{define["thumbs_down"]} dislikes", icon_url: "")
			embed.color = 4359924
		end
	rescue
		event.channel.send_embed do |embed|
			embed.title = "Urban Dictionary"
			embed.description = "That's not in the dictionary!"
			embed.color = 16722454 # red
		end
	end
end

$bot.command(:roman, min_args: 1, max_args: 1, usage: "roman <num>") do |event, num|
	# Coded by LEGOlord208
	i = 0
	begin
		i = Integer(num)
		if i < 0
			event.respond "You know you won't crash me by doing that.."
			return
		end
		if i == 0
			event.respond "I can't do that!"
			return
		end
	rescue ArgumentError
		event.respond "That's not a number."
		next
	end

	if i > 10_000
		event.respond 'The value is too big.'
		next
	end

	nums = {
		1 => 'I',
		4 => 'IV',
		5 => 'V',
		9 => 'IX',
		10 => 'X',
		40 => 'XL',
		50 => 'L',
		90 => 'XC',
		100 => 'C',
		400 => 'CD',
		500 => 'D',
		900 => 'CM',
		1000 => 'M'
	}

	len = 1000
	out = ''

	while i > 0
		d = i
		if len != 1
			d = (i / len).floor
			if d <= 0
				len /= 10
				next
			end

			d *= len
		end

		rest = 0
		until nums.key?(d)
			d -= len
			rest += 1
		end

		found = nums[d]
		one = nums[len]

		out += found.to_s

		while rest > 0
			out += one
			rest -= 1
		end

		i = i % len
		len /= 10
	end
	event.respond "Result: #{out}"
end

$bot.command(:rate, min_args: 1, description: "Rate things!", usage: "rate <stuff>") do |event, *text|
	text = text.join(" ")
	if text.downcase == "tbodt" ||
			text.downcase == "tdodl" ||
			text == "<@155417194530996225>" ||
			text == "<@!155417194530996225>"
		rating = Float::INFINITY
	elsif text.downcase == "elchris414" ||
			text.downcase == "elchris" ||
			text.downcase == "chris"
			text == "<@125228190825316352>" ||
			text == "<@!125228190825316352>"
		rating = rand(0.0..2.6).round(1)
	else
		rating = rand(0.0..10.0).round(1)
	end
	event.respond "I give #{text} a #{rating}/10.0!"
end

$bot.command(:"8ball") do |event|
	arr = ["Yes.", "No.", "Possibly.", "Probably.", "Indeed.", "Not at all.", "Never.", "Sure!", "Absolutely!", "Absolutely not."]
	event.respond(arr.sample)
end

$bot.command(:version) do |event|
	event.respond("%s, Codename '%s'." % [$version, $codename])
end

$bot.command([:colour, :color], min_args: 0, max_args: 1, usage: "_colour [hex]", description: "Find a hex colour or get a random one.") do |event, *args|
	if args.length != 0
		colour = args[0].tr('#', '').tr('0x', '') # remove hashtags and 0x from colours
		begin
			c = Color::RGB.by_hex(colour)
		rescue => e
			event.respond e
			return
		end
		dec = colour.to_i(16)
		event.channel.send_embed do |embed|
			embed.description = "Hex: ##{colour} | RGB: #{c.red}, #{c.green}, #{c.blue} | Decimal: #{dec}"
			embed.color = dec
		end
	else
		colour = rand(1000000..19000000)
		hexc = colour.to_s.to_i(10).to_s(16)
		c = Color::RGB.from_html(hexc)
		event.channel.send_embed do |embed|
			embed.description = "Hex: ##{hexc} | RGB: #{c.red}, #{c.green}, #{c.blue} | Decimal: #{colour}"
			embed.color = colour
		end
	end
end

$bot.command(:lmgtfy) do |event, *args|
	event.respond "#{event.user.mention}, <http://lmgtfy.com/?q=%s>" % [args.join("+")]
end

$bot.command(:avatar, min_args: 1, max_args: 1) do |event, user|
# Might want to look into webp and size
user = user[2..-2]
	begin
		tagged_user = $bot.user(user);
		event.respond "#{tagged_user.mention}'s avatar URL is #{tagged_user.avatar_url}"
	rescue
		# If the user has a nick the ID will be <@!id>, so this will remove that !, and fail if that also fails.
		begin
			user = user[1..-1]
			tagged_user = $bot.user(user);
			event.respond "#{tagged_user.mention}'s avatar URL is #{tagged_user.avatar_url}"
		rescue
			event.respond "That's an invalid user."
		end
	end
end

$lastweatherrun = Time.now.to_i
$bot.command(:weather, usage: "_weather <name>", min_args: 1) do |event, *args|
if (Time.now.to_i - $lastweatherrun) < 2
	event.respond "This command is being run too often! Please wait a few seconds, and try again."
	return
end
	$lastweatherrun = Time.now.to_i
	begin
		json = open("http://api.openweathermap.org/data/2.5/weather?q=#{args.join(" ")}&APPID=#{(File.read "weather.txt").delete!("\n")}").read
		$response = JSON.parse(json)
	rescue => e
		event.channel.send_embed do |embed|
			embed.title = "Weather"
			if e.message == "404 Not Found"
				embed.description = "Location not found."
			else
				embed.description = "JSON error: " + e.message
			end
			embed.color = 16722454 # red
		end
		next
	end
	event.channel.send_embed do |embed|
		embed.title = "Weather in #{$response["name"]}"
		embed.color = 11865 # A nice dark blue.
		# Oh also turn the K into C
		t = "It's currently #{($response["main"]["temp"]-273.15).round(1)}°C in #{$response["name"]}, #{$response["sys"]["country"]}."
		embed.description = t + "\nThe condition is \"#{$response["weather"][0]["description"]}\"."
	end
end

$bot.command(:insult) do |event|
	event.respond `insult`
end

$bot.command([:wikipedia, :wiki], min_args: 1, usage: "wikipedia <search term>") do |event, *args|
	begin
		event.message.delete
	rescue
	end
	begin
		page = Wikipedia.find(args.join(" "))
		event.channel.send_embed do |embed|
			embed.title = "Wikipedia - #{page.title}"
			# Not using page.text. Way too spammy.
			embed.description = page.summary[0..$wikilimit].gsub(/\s\w+\s*$/,"...")
			embed.color = 16777215
			if page.main_image_url != nil
				embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: page.main_image_url)
			end
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{event.user.name}##{event.user.discrim} looked this up!", icon_url: "https://i.imgur.com/PiGLy6H.png")
			embed.add_field(name: "View the full article here:", value: "*<#{page.fullurl}>*")
			#embed.author = Discordrb::Webhooks::EmbedAuthor.new(name:("%s#%s looked this up!" % [event.user.name, event.user.discrim]), icon_url: event.user.avatar_url)
		end
	rescue => e
		msg = event.channel.send_embed do |embed|
			embed.title = "Wikipedia"
			embed.description = "The page you were looking for was probably not found.\n#{e}"
			embed.color = 16722454 # red
		end
		sleep 5
		msg.delete
	end
end

$bot.command(:encode, min_args: 2, usage: "_encode b64/bin/hex <text>") do |event|
args = event.message.to_s[8..-1]
	begin
		if args.start_with? "bin"
			event.respond(args[4..-1].unpack("B*")[0].gsub(/(.{8})/, '\1 '))
			next
		elsif args.start_with? "b64"
			event.respond([args[4..-1]].pack("m*").chomp)
			next
		elsif args.start_with? "hex"
			event.respond(args[4..-1].each_byte.map { |b| b.to_s(16) }.join)
			next
		else
			event.channel.send_embed do |embed|
				embed.description = "You need to select Base64 (b64), Binary (bin) or Hexadecimal (hex)! (Example: _encode bin I like bananas)"
				embed.color = 16722454 # red
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.description = "Error! Message too long or you need to select what to encode to! (Example: _encode b64 I like bananas)"
			embed.color = 16722454 # red
		end
	end
end

$bot.command(:decode, min_args: 1, usage: "_decode b64/bin/hex <text>") do |event|
args = event.message.to_s[8..-1]
	begin
		if args.start_with? "bin"
			args = args[4..-1].gsub(/\s+/, "")
			event.respond([args].pack("B*"))
			next
		elsif args.start_with? "b64"
			event.respond(args[4..-1].unpack('m*')[0])
			next
		elsif args.start_with? "hex"
			event.respond([args[4..-1]].pack('H*'))
			next
		else
			event.channel.send_embed do |embed|
				embed.description = "You need to select Base64 (b64), Binary (bin) or Hexadecimal (hex)! (Example: _encode bin I like bananas)"
				embed.color = 16722454 # red
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.description = "That message is too long to send, or I cannot decode that."
			embed.color = 16722454 # red
		end
	end
end