module DiscordBot
	class Commands
$bot.command(:annoy, min_args: 1, max_args: 1, usage: 'Annoy true/false') do |event, answ|
	if event.user.id != 172030506970382337
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not allowed to change this."
			embed.color = 16_722_454 # red
		end
	elsif answ == 'true'
		$annoy = true
		event.channel.send_embed do |embed|
			embed.title = 'MnpnBot Settings - Annoy'
			embed.description = 'I changed it.'
			embed.add_field(name: 'Annoy', value: $annoy, inline: true)
			embed.color = 1_108_583 # green
		end
	elsif answ == 'false'
		$annoy = false
		event.channel.send_embed do |embed|
			embed.title = 'MnpnBot Settings - Annoy'
			embed.description = 'I changed it.'
			embed.add_field(name: 'Annoy', value: $annoy, inline: true)
			embed.color = 1_108_583 # green
		end
	else
		event.channel.send_embed do |embed|
			embed.title = 'What the fuck?'
			embed.description = "What's your problem? It's either true or false you fucking moron."
			embed.add_field(name: 'Annoy', value: $annoy, inline: true)
			embed.color = 16_722_454 # green
		end
	end
end


mnpn2 = "smart"
mnpn = true
$bot.command(:smart) do |event|
if mnpn == true then
   event.respond "im smart maybe"
   event.respond "looking though the variable; mnpn is " + mnpn2
end
end


# HELP

$bot.command :help do |event|
	event << 'Version: ' + $version
	event.channel.send_embed do |embed|
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: 'http://i.imgur.com/VpeUzUB.png')
		# embed.title = 'Help'
		embed.description = 'Command Information'
		embed.add_field(name: 'General commands:', value: "_help: Shows you this help menu. Click the 'MnpnBot' Author title to get an invite link for your server!
_randomize: Usage: '_randomize 1 10'. Number randomizer.
_define: Usage: '_define kek'. Not specifying what to define will result in a random definition.
_invite: Shows an invite link for the bot.
_roman: Usage: '_roman 50'. Change numerals to romans.
_rate: Usage: '_rate the laptop'. Rate something.
_website: Links my website.")

		embed.add_field(name: 'Status commands:', value: "_ping: Pings the bot.
_uptime: Shows bot uptime.
_si: Shows server information.
_bi: Shows bot information.
_ui: Shows your information.
_psi: Personal Server Information [I]")

		embed.add_field(name: 'Entertaining commands:', value: 'Joke: Tells you a terrible joke.')

		# embed.footer = "Made by Mnpn#5043 in Ruby with major help from LEGOlord208#1033."
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Made by Mnpn#5043 in Ruby with major help from LEGOlord208#1033.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')

		embed.color = 1_108_583
	end

	# END OF HELP
end


i = 0
$bot.command(:type) do |event|
	while i < $typeloops
		event.channel.start_typing
		sleep(1)
		i += 1
	end
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
	diff = (now - timestamp) / 1_000_000
	event.channel.send_embed do |embed|
		embed.title = 'Ping result'
		embed.description = "I'm here. Pinged in #{diff} ms."
		embed.color = 1_108_583
	end
end

# Randomize
$bot.command(:randomize, min_args: 2, max_args: 2, usage: 'randomize <min> <max>') do |event, min, max|
	min_i = 0
	max_i = 0

	begin
		min_i = Integer(min)
		max_i = Integer(max)
	rescue ArgumentError
		event.channel.send_embed do |embed|
			embed.title = 'Randomize:'
			embed.description = "That's not numbers!"
		end
	end

	event.channel.send_embed do |embed|
		embed.title = 'Randomize:'
		embed.description = 'The result was %d.' % [rand(min_i..max_i)]
	end
end
# End of Randomize
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
# End of Jokes

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

$bot.command :invite do |event|
	event.channel.send_embed do |embed|
		embed.title = 'Invite link. Click the invite text above to open a web browser to authorize MnpnBot.'
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot Invite', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.color = 1_108_583
	end
end

$bot.server_create do |event|
	event.server.default_channel.send_embed do |embed|
		embed.title = 'MnpnBot'
		embed.description = "You have authorized **MnpnBot**. Hello World! To get started, say '_help'"
		embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'MnpnBot', url: 'https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=16384', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		embed.color = 1_108_583
	end
end


$bot.command(:define, min_args: 0, usage: 'define <word>') do |event, *args|
	begin
		event.channel.send_embed do |embed|
			defin = nil
			msg = args.join(' ')
			defin = if msg != ''
			   UrbanDict.define(msg)
					else
						UrbanDict.random
					end
			embed.title = 'Urban Dictionary'
			embed.description = 'Urban Dictionary; Define a word.'
			embed.add_field(name: "***#{defin['word']}***", value: "by #{defin['author']}", inline: true)
			embed.add_field(name: '**Definition**', value: (defin['definition']).to_s, inline: true)
			embed.add_field(name: '**Example**', value: (defin['example']).to_s, inline: true)
			embed.add_field(name: "#{defin['thumbs_up']} Likes | #{defin['thumbs_down']} Dislikes", value: 'Urban Dictionary', inline: true)
			embed.add_field(name: "***<#{defin['permalink']}>***", value: 'Direct link', inline: true)
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

$bot.command :reload do |event|
	if event.user.id != 172_030_506_970_382_337
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not allowed to run this command."
			embed.color = 16_722_454 # red
		end
	else
		event.channel.send_embed do |embed|
			embed.title = 'Reload'
			embed.description = 'Reloading MnpnBot!'
			embed.add_field(name: 'Version', value: version, inline: true)
			embed.add_field(name: 'Development mode', value: devmode, inline: true)
			embed.add_field(name: 'Debug mode', value: debug, inline: true)
			embed.color = 1_108_583 # green
		end
		# i should probably fix this
	end
end

$bot.command :mcstat do |event, *args|
	begin
		serv = JSON.parse(RestClient.get('https://mcapi.ca/query/' + args[0] + '/info'))
	rescue => e
		event << 'Something went wrong!'
		event << e
	end
	serv['status']
		event.channel.send_embed do |embed|
			embed.title = 'Minecraft Server Statistics'
			embed.description = 'Minecraft Statistics for %s: ' % args[0]
			embed.add_field(name: 'MOTD: ', value: serv['motd'], inline: true)
			embed.add_field(name: 'Version: ', value: serv['version'], inline: true)
			embed.add_field(name: 'Players: ', value: serv['online.to_i'] + '/' + serv['max.to_i'], inline: true)
			embed.add_field(name: 'Ping: ', value: $debug, inline: true)
			embed.color = 1_108_583 # green
		end
	#else
	#	event.channel.send_embed do |embed|
	#		embed.title = ':octagonal_sign:'
	#		embed.description = 'Invalid server.'
	#		embed.color = 16_722_454 # red
	#	end
	#end
end

$bot.command(:mcskin, min_args: 1, max_args: 1) do |event|
	_, *rating = event.message.content.split
	event.respond "Sure, here is the 3D version of the skin: #{rating.join(' ')}. https://visage.surgeplay.com/full/512/#{rating.join(' ')}.png"
end

$bot.command(:rate, min_args: 1, description: 'Rate things!', usage: 'rate <stuff>') do |event, *text|
	event.respond "I give #{text.join(' ')} a " + "#{rand(0.0..10.0).round(1)}/10.0!"
end

$bot.command(:website) do |event|
	event.channel.send_embed do |embed|
			embed.title = 'Website'
			embed.description = "So you're interested in a website?
All my bots are on my website:"
			embed.add_field(name: 'https://mnpn.me/', value: "Go there!", inline: true)
			embed.color = 1_108_583 # green
		end
end

end
end

$bot.command(:"8ball") do |event|
	arr = ["Yes.","No.","Possibly.","Indeed.","Not at all.","Never.","Sure!","Absolutely!","Absolutely not."]
	event.respond(arr.sample)
end

$bot.command(:seen, usage: "_seen <@user>", min_arguments: 1, max_arguments: 1) do |event, user|
x = user[2..-2].to_i
mess = event.user.message
puts(mess)
	if mess.any?{|a| a.id == x}
		pos=mess.find_index {|item| item.id == x}
		event << "On: #{mess[pos].time.asctime}"
		event << "They said: '#{mess[pos].mess}'"
	else
		event.respond "I haven't seen anything from that user yet."
end

$bot.command(:quote, usage: "_quote [message ID]", min_arguments: 1, max_arguments: 1) do |event, mid|
mess = event.user.message
puts(mess)
event.channel.send_embed do |embed|
		find = mess.find_index {|item| item.id}
		event << "On: #{mid.id.time.asctime}"
		event << "They said: '#{mess[pos].mess}'"
	else
		event.respond "Invalid message ID or unable to read message."
end