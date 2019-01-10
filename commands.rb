$bot.command(:annoy, min_args: 1, max_args: 1, usage: 'Annoy true/false') do |event, answ|
	if event.user.id != 172030506970382337
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not allowed to change this."
			embed.color = 16_722_454 # red
		end
		next
	end
	if answ == 'true'
		$annoy = true
	elsif answ == 'false'
		$annoy = false
	else
		event.channel.send_embed do |embed|
			embed.title = 'What the fuck?'
			embed.description = "What's your problem? It's either true or false you fucking moron."
			embed.add_field(name: 'Annoy', value: $annoy, inline: true)
			embed.color = 16_722_454 # green
		end
		next
	end
	event.channel.send_embed do |embed|
		embed.title = 'MnpnBot Settings - Annoy'
		embed.description = 'I changed it.'
		embed.add_field(name: 'Annoy', value: $annoy, inline: true)
		embed.color = 1_108_583 # green
	end
end

# The help command.
$bot.command :help do |event|
	begin
		event.message.delete
	rescue
	end
	event.user.pm.send_embed do |embed|
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: 'http://i.imgur.com/VpeUzUB.png')
		embed.description = 'Command Information'
		embed.add_field(name: 'General commands:', value: "_help: Shows you this help menu. Click the 'MnpnBot' Author title to get an invite link for your server!
_random: Usage: '_random 1 10'. Number randomiser.
_define: Usage: '_define kek'. Not specifying what to define will result in a random definition.
_invite: Shows an invite link for the bot.
_roman: Usage: '_roman 50'. Change numerals to romans.
_rate: Usage: '_rate the laptop'. Rate something.
_colour/_color: Generate a random colour and show the value in Hex, RGB and Decimal.
_lmgtfy: Generate a LMGTFY link.
_avatar: Shows a user's avatar.
_feedback: Send feedback on MnpnBot.
_weather: Usage: '_weather Hell'. Weather Forecast.")

		embed.add_field(name: 'Status commands:', value: "_ping: Pings the bot.
_uptime: Shows bot uptime.
_si: Shows server information.
_bi: Shows bot information.
_ui: Shows your information.")

		embed.add_field(name: 'Entertaining commands:', value: 'Joke: Tells you a terrible joke.
_meme: Sends a random meme.
_insult: Sends a random insult using jD91mZM2\'s Oh...Sir!-like insult program.')
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "MnpnBot #{$version}", icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0', icon_url: 'http://i.imgur.com/VpeUzUB.png')

		embed.color = 1_108_583
	end
	responses = ["I sent all of that in DMs!", "Check your DMs!", "Sent in DMs.", "I sent that in your private messages!", "Sent!", "Help sent in DMs!"]
	event.respond(responses.sample + " :mailbox_with_mail:")
end

# Count
$bot.command(:count, min_args: 1, max_args: 1, usage: '_count [to]') do |event, to|
	i = 0
	begin
		i = Integer(to)
	rescue ArgumentError
		event.respond 'Not a number!'
		next
	end
	if i > $limit
		event.respond 'The limit is currently set at %d.' % [$limit]
		next
	end
	for j in 1..i do
		event << 'Counting! Currently on %d.' % [i + 1]
	end
end

# Ping
$bot.command :ping do |event|
	# event.respond "I'm here. Pinged in #{Time.now - event.timestamp} seconds."
	now = Time.now.utc.nsec
	timestamp = event.timestamp.nsec
	diff = (now - timestamp) / 1000000
	event.channel.send_embed do |embed|
		embed.title = 'Ping result'
		embed.description = "I'm here. Pinged in #{diff} ms."
		embed.color = 1108583
	end
end

# Random
$bot.command(:random, min_args: 2, max_args: 2, usage: 'random <min> <max>') do |event, min, max|
	min_i = 0
	max_i = 0

	begin
		min_i = Integer(min)
		max_i = Integer(max)
	rescue ArgumentError
		event.channel.send_embed do |embed|
			embed.title = 'Random:'
			embed.description = "That's not numbers!"
		end
	end

	event.channel.send_embed do |embed|
		embed.title = 'Random:'
		embed.description = 'The result was %d.' % [rand(min_i..max_i)]
	end
end

# Jokes
$bot.message(with_text: /joke.?/i) do |event|
	lines = []

	File.open('jokes.txt', 'r') do |f|
		f.each_line do |line|
			lines.push(line)
		end
	end

	joke = lines.sample
	event.channel.send_embed do |embed|
		embed.title = 'Here is a bad joke.'
		embed.description = joke
	end
end

# Uptime
$bot.command :uptime do |event|
	full_sec = Time.now - $started
	sec = full_sec % 60
	min = full_sec / 60
	sec = sec.floor
	min = min.floor
	event.channel.send_embed do |embed|
		embed.title = 'Uptime:'
		embed.description = 'Bot uptime is %s:%s' % [min, sec] # + " minutes."
		embed.color = if min < 5
					16_773_910 # yellow
					# 16722454 red
					  else
						  1_108_583 # green
					  end
		if min > 2880
			embed.color = 16_722_454 # red
			puts('Bot should restart!')
		end
	end
end

# Invite
$bot.command :invite do |event|
	event.channel.send_embed do |embed|
		embed.title = 'Invite link. Click the invite text above to open a web browser to authorise MnpnBot.'
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot Invite', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.color = 1_108_583
	end
end

# When authorized, send message.
$bot.server_create do |event|
	event.server.default_channel.send_embed do |embed|
		embed.title = 'MnpnBot'
		embed.description = "You have authorised **MnpnBot**. Hello World! To get started, say '_help'"
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0s', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.color = 1_108_583
	end
end

# Define
$bot.command(:define, min_args: 0, usage: 'define <word>') do |event, *args|
	begin
		event.channel.send_embed do |embed|
			define = nil
			msg = args.join(' ')
			define = if msg != ''
			   UrbanDict.define(msg)
					else
						UrbanDict.random
					end
			embed.title = 'Urban Dictionary'
			embed.description = 'Urban Dictionary; Define a word.'
			embed.add_field(name: "***#{define['word']}***", value: "by #{define['author']}", inline: true)
			embed.add_field(name: '**Definition**', value: (define['definition']).to_s, inline: true)
			embed.add_field(name: '**Example**', value: (define['example']).to_s, inline: true)
			embed.add_field(name: "#{define['thumbs_up']} Likes | #{define['thumbs_down']} Dislikes", value: 'Urban Dictionary', inline: true)
			embed.add_field(name: "***<#{define['permalink']}>***", value: 'Direct link', inline: true)
			embed.color = 4_359_924
		end
	rescue
		event.channel.send_embed do |embed|
			embed.title = 'Urban Dictionary'
			embed.description = "That's not in the dictionary!"
			embed.color = 16_722_454 # red
		end
	end
end

# Roman
$bot.command(:roman, min_args: 1, max_args: 1, usage: 'roman [num]') do |event, num|
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

	event.channel.send_embed do |embed|
		embed.title = 'Roman:'
		embed.description = 'The converted number is ' + out + '.'
	end
end

$bot.command(:mcskin, min_args: 1, max_args: 1) do |event|
	_, *rating = event.message.content.split
	event.respond "Sure, here is the 3D version of the skin: #{rating.join(' ')}. https://visage.surgeplay.com/full/512/#{rating.join(' ')}.png"
end

$bot.command(:rate, min_args: 1, description: 'Rate things!', usage: 'rate <stuff>') do |event, *text|
	text = text.join(" ")
	if text == "Dusty" ||
			text == "Dusty01" ||
			text == "Dusty01_" ||
			text == "<@151392836292444160>" ||
			text == "<@!151392836292444160>"
		rating = -0.1
	elsif text == "tbodt" ||
			text == "tbuddy" ||
			text == "<@155417194530996225>" ||
			text == "<@!155417194530996225>"
		rating = Float::INFINITY
	elsif text == "ELChris414" ||
			text == "ELChris" ||
			text == "<@125228190825316352>" ||
			text == "<@!125228190825316352>"
		rating = rand(0.0..3.0).round(1)
	elsif text == "Shyrix" ||
			text == "Shy" ||
			text == "<@211422653246865408>" ||
			text == "<@!211422653246865408>"
		rating = "Edgy"
	elsif text == "Lionnco" ||
			text == "Lionn" ||
			text == "Mike" ||
			text == "<@297803183206563841>" ||
			text == "<@!297803183206563841>"
		rating = rand(0.0..2.5).round(1)
	else
		rating = rand(0.0..10.0).round(1)
	end
	event.respond "I give #{text} a #{rating}/10.0!"
end

$bot.command(:website) do |event|
	event.channel.send_embed do |embed|
		embed.title = 'Website'
		embed.description = "Here's my website:"
		embed.add_field(name: 'https://mnpn.hisses-at.me/', value: "I like the domain name.", inline: true)
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: $bot.profile.avatar_url)
		embed.color = 1_108_583 # green
	end
end

$bot.command(:"8ball") do |event|
	arr = ["Yes.","No.","Possibly.","Indeed.","Not at all.","Never.","Sure!","Absolutely!","Absolutely not."]
	event.respond(arr.sample)
end

$bot.command(:version) do |event|
	event.respond("%s, Codename '%s'." % [$version, $codename])
end

$bot.command(:play, min_args: 1) do |event, *args|
	if event.author.id == 172030506970382337
		$custom = true
		$bot.game = args.join(" ")
		next
	else
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command. :no_entry:'
			embed.description = "You're not permitted to run this command."
			embed.color = 16_722_454 # red
		end
	end
end

$bot.command(:rplay) do |event, *args|
	if event.author.id == 172030506970382337
		$custom = false
		event.respond "Done."
		next
	else
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command. :no_entry:'
			embed.description = "You're not permitted to run this command."
			embed.color = 16_722_454 # red
		end
	end
end

$bot.command(:smode) do |event|
if event.channel.private?
			event.channel.send_embed do |embed|
				embed.title = ':no_entry:'
				embed.description = 'This command cannot be used in a PM!'
				embed.color = 16_722_454
			end
		else
	if event.author.id != event.server.owner.id && event.author.id != 172030506970382337
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command :no_entry:'
			embed.description = "Only the server owner can toggle S-Mode."
			embed.color = 16_722_454 # red
		end
		next
	end
	$settings[event.server.id.to_s] = {} unless $settings.key?(event.server.id.to_s)
	$settings[event.server.id.to_s]["s_mode"] = !$settings[event.server.id.to_s]["s_mode"]
	begin
		File.write "settings.json", $settings.to_json
	rescue IOError => e
		puts "_smode failed to write to file."
		puts e
		event.respond "Failed to write to file."
		next # Skip sending a message that it toggled if it didn't.
	end
	event.channel.send_embed do |embed|
		embed.title = 'MnpnBot S'
		embed.description = "Toggled S-Mode!"
		embed.add_field(name: 'S-Mode', value: $settings[event.server.id.to_s]["s_mode"], inline: true)
		embed.color = 1_108_583 # green
	end
end
end

$bot.command(:ptr) do |event|
if event.channel.private?
			event.channel.send_embed do |embed|
				embed.title = ':no_entry:'
				embed.description = 'This command cannot be used in a PM!'
				embed.color = 16_722_454
			end
		else
	if event.author.id != event.server.owner.id && event.author.id != 172030506970382337
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command :no_entry:'
			embed.description = "Only the server owner can opt in and out of the PTR."
			embed.color = 16_722_454 # red
		end
		next
	end
	$settings[event.server.id.to_s] = {} unless $settings.key?(event.server.id.to_s)
	$settings[event.server.id.to_s]["ptr"] = !$settings[event.server.id.to_s]["ptr"]
	begin
		File.write "settings.json", $settings.to_json
	rescue IOError => e
		puts "PTR failed to write to file."
		puts e
		event.respond "Failed to write to file."
		next # Skip sending a message that it toggled if it didn't.
	end
	event.channel.send_embed do |embed|
		embed.title = 'MnpnBot Public Test Ring'
		embed.description = "Toggled PTR!"
		embed.add_field(name: 'PTR', value: $settings[event.server.id.to_s]["ptr"], inline: true)
		embed.color = 1_108_583 # green
	end
end
end

$bot.command(:sinfo) do |event|
	event.respond "MnpnBot's S-Mode is a version of MnpnBot that is more targeted to \"serious\" servers. Enabling S-Mode will remove auto-responses (e.g. kek, :>)."
end

$bot.command(:cookies) do |event|
	event.respond ":cookie:"
end

# Colour.
# Hiss! It's colour! I'm just adding _color for the miserable thots (americans*) out there. Shut up, it's colour.
$bot.command([:colour, :color], min_args: 0, max_args: 1, usage: "_colour [hex]", description: "Find a hex colour or get a random one.") do |event, *args|

colour = rand(1000000..19000000)

class String
	def convert_base(from, to)
		self.to_i(from).to_s(to)
	end
end

unless args.length == 0
# somone has put an argument
	event.respond "Sorry, I only do random colours so far."
else
	hexc = colour.to_s.convert_base(10, 16)
	c = Color::RGB.from_html(hexc)
		event.channel.send_embed do |embed|
			#embed.title = 'Hex Colour'
			embed.description = "Hex: ##{hexc} | RGB: #{c.red}, #{c.green}, #{c.blue} | Decimal: #{colour}"
			embed.color = colour
		end
	end
end

$bot.command(:lmgtfy) do |event, *args|
	event.respond "#{event.user.mention}, <http://lmgtfy.com/?q=%s>" % [args.join("+")]
end

RBLACKLIST = []

$bot.command(:feedback, min_args: 1) do |event, *args|
	if RBLACKLIST.include?(event.author.id)
		event.respond "You're temporarily blacklisted for sending trash."
		next
	end
	event.respond "Done! Check your DMs! :mailbox_with_mail: "
	event.user.pm "You've sent some feedback to Mnpn: `%s`." % args.join(" ")
	$bot.send_message(289_641_868_856_262_656, "%s has sent feedback regarding MnpnBot #{$version}: `%s`." % [(event.author.name + "#" + event.author.discrim), args.join(" ")])
end

MEME_BLACKLIST = [200223980483772416, # Nick (Demo_Nick)#5841
	]

REQUESTABLES = [172030506970382337]
	
$bot.command(:addmeme, min_args: 1, max_args: 1) do |event, args|
	if MEME_BLACKLIST.include?(event.author.id)
		event.respond "You're temporarily blacklisted for requesting trash."
		next
	end
		event.respond "Requested! It will be reviewed soon."
		REQUESTABLES.each do |item|
			$user = $bot.user(item);
			$user.pm("%s has requested a meme: %s" % [(event.author.name + "#" + event.author.discrim), args])
		end
	next
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

# Memes

MEME_LINKS = ["https://s-media-cache-ak0.pinimg.com/736x/4c/76/0f/4c760fba47623735a658e0b77d937062--happy-friday-the-th-horror-movies.jpg",
	"https://i.imgur.com/94Qd8i2.jpg",
	"https://i.imgur.com/LH0tziN.jpg",
	"https://i.imgur.com/qv30k9P.png",
	"https://i.imgur.com/P1FYuZX.jpg",
	"https://cdn.discordapp.com/attachments/331762274966437888/339740554273357824/oncewentoutsude.png",
	"https://i.imgur.com/xHK8BRY.jpg",
	"https://cdn.discordapp.com/attachments/228221346608316417/338253135795716097/image.jpg",
	"https://s-media-cache-ak0.pinimg.com/736x/13/e0/ce/13e0cef23c4323e8d32be0e6322be99a--funny-happy-birthday-meme-funny-happy-birthdays.jpg",
	"http://www.fullredneck.com/wp-content/uploads/2016/04/Funny-Russia-Meme-20.jpg",
	"https://i.imgur.com/4v86w8y.png"]

$bot.command(:meme) do |event|
memeages = ["ill meme u!","here's a meme","oh look, a meme!","I got u fam!","meme","this one is dank, i promise","https://niceme.me/","ur a meme","meeeeee.me","i think im out of ideas for this string here","k","kk","ok","mhm","sure"]
	event.channel.send_embed do |embed|
		embed.description = memeages.sample
		embed.color = rand(1000000..1900000)
		embed.image = Discordrb::Webhooks::EmbedImage.new(url: MEME_LINKS.sample)
	end
end

$bot.command(:support) do |event|
    event.channel.send_embed do |embed|
        embed.title = 'MnpnBot Support'
        embed.description = "If you have any issues, our staff team is ready to help you at **<https://discord.gg/Ww74Xjh>**!"
        embed.color = 1_151_202
    end
end

$bot.command(:weather, usage: "_weather <Zip/Name>", description: "Weather Forecast.", min_arguments: 1) do |event, *args|
if args[0] == nil
	event.channel.send_embed do |embed|
		embed.title = 'Weather'
		embed.description = "You need to provide an argument! Usage: _weather <Zip/Name>."
		embed.color = 16_722_454 # red
	end
	next
end
	begin
		zip = Integer(args[0])
		if zip < 1000 || zip > 99950
			event.respond "The Zip-code is invalid."
			next
		end
		$response = Weather.lookup(zip, Weather::Units::CELSIUS) # I'll be using Celsius for the time being because it's what I normally use.
	rescue
		begin
			$response = Weather.lookup_by_location(args.join(" "), Weather::Units::CELSIUS)
		rescue
			event.channel.send_embed do |embed|
				embed.title = 'Weather'
				embed.description = "Location not found!"
				embed.color = 16_722_454 # red
			end
			next
		end
	end
	condition = $response.condition.text
		event.channel.send_embed do |embed|
			embed.title = $response.title
				if $response.condition.text == "Sunny" || $response.condition.text == "Mostly Sunny"
					embed.color = 15924992 # Yellow
				elsif $response.condition.text == "Cloudy" || $response.condition.text == "Partly Cloudy" || $response.condition.text == "Mostly Cloudy"
					embed.color = 12040119 # Grey
				elsif $response.condition.text == "Rain"
					embed.color = 11865 # A nice dark blue.
					condition = "Raining" # Otherwise it will respond with "It's Rain"!
				elsif $response.condition.text == "Thunderstorms"
					embed.color = 11865 # A nice dark blue.
				else
					embed.color = 4359924 # Kinda light-blue
				end
			embed.description = "It's currently #{$response.condition.temp}°C outside.
It's #{condition}."
		end
end

$bot.command(:suggest, min_args: 1) do |event, *args|
	event.user.pm "You've sent a suggestion to Mnpn's Support server: `%s`." % args.join(" ")
	guild = $bot.server(337921262343159809)
	channel = $bot.channel(422296321257635841, guild.id)
	msg = channel.send_embed do |embed|
		embed.title = 'Suggestion'
		embed.description = "#{args.join(" ")}"
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Suggested by #{event.user.name}.", icon_url: guild.icon_url.to_s)
		embed.color = 10233776
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.user.avatar_url)
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name:("%s#%s" % [event.user.name, event.user.discrim]), icon_url: event.user.avatar_url)
	end
	msg.react("🔼")
	msg.react("🔽")
	event.respond "Suggested! People can now up- and down-vote it in <#422296321257635841>."
end

$bot.command(:insult) do |event|
	event.respond `insult`
end

$bot.command([:wikipedia, :wiki], min_args: 1, usage: 'wikipedia <search term>') do |event, *args|
	begin
		page = Wikipedia.find(args.join(" "))
		event.channel.send_embed do |embed|
			embed.title = "Wikipedia - #{page.title}"
			# Not using page.text. Way too spammy.
			embed.description = page.summary[0..$wikilimit].gsub(/\s\w+\s*$/,'...')
			embed.color = 16777215
			if page.main_image_url != nil
				embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: page.main_image_url)
			end
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "#{event.user.name}##{event.user.discrim} looked this up!", icon_url: "https://i.imgur.com/PiGLy6H.png")
			embed.add_field(name: "View the full article here:", value: "*<#{page.fullurl}>*")
			#embed.author = Discordrb::Webhooks::EmbedAuthor.new(name:("%s#%s looked this up!" % [event.user.name, event.user.discrim]), icon_url: event.user.avatar_url)
		end
	rescue => e
		event.channel.send_embed do |embed|
			embed.title = "Wikipedia"
			embed.description = "The page you were looking for was probably not found.\n#{e}"
			embed.color = 16722454 # red
		end
	end
end

