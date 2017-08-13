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