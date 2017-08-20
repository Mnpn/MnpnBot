# New commands I'm testing will appear here

$bot.command(:dank) do |event|
	if $settings[event.server.id.to_s]["ptr"]
		event << "You are dank! Thanks for participating in the PTR testing!"
		event << "You're a part of history! (Well, maybe not.)"
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
		embed.add_field(name: 'Players: ', value: "#{serv['online.to_i']}/#{serv['max.to_i']}", inline: true)
		embed.add_field(name: 'Ping: ', value: "", inline: true)
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

	$bot.command(:quote, usage: "_quote [message ID]", min_arguments: 1, max_arguments: 1) do |event, mid|
		begin
			id = Integer(mid)
			if id < 0
				event.respond "You know you won't crash me by doing that.."
				return
			end
		rescue ArgumentError
			event.respond "That's not a message ID."
			next
		end
		mess = event.user.message
		puts(mess)
		begin
			event.channel.send_embed do |embed|
				find = mess.find_index {|item| item.id}
				event << "On: #{mid.id.time.asctime}"
				event << "They said: '#{mess[pos].mess}'"
			end
		rescue
			event.respond "Invalid message ID or unable to read message."
		end
	end
	
$bot.command(:brick, usage: "_brick", description: "Play the Brick song.", min_arguments: 0, max_arguments: 0) do |event|
	$voice_bot = $bot.voice_connect(event.user.voice_channel)
	$voice_bot.play_file('./music/s.mp3');
	$bot.voices[event.server.id].destroy
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
		$response = Weather.lookup(zip, Weather::Units::CELSIUS)
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
