isplaying = 0
$bot.command(:devplay) do |event, songlink|
	if isplaying == 1
		event.message.delete
		event.channel.send_embed do |embed|
			embed.title = ':arrow_forward:'
			embed.description = 'Already playing!'
			embed.color = 16_722_454 # red
		end
		break
	end
	channel = event.user.voice_channel
	unless channel.nil?
		voice_$bot = $bot.voice_connect(channel)
		system("youtube-dl --no-playlist --max-filesize 100m -o 'music/s.%(ext)s' -x --audio-format mp3 #{songlink}")
		event.channel.send_embed do |embed|
			embed.title = ':arrow_forward:'
			embed.description = "Alright, I'll play it!"
			embed.color = 1_108_583 # red
		end
		isplaying = 1
		voice_$bot.play_file('./music/s.mp3')
		voice_$bot.destroy
		isplaying = 0
		break
	end
	event.channel.send_embed do |embed|
		embed.title = ':grey_question:'
		embed.description = "You're not in a voice channel! It's not that hard."
		embed.color = 16_722_454 # red
	end
	event.channel.send_embed do |embed|
		embed.title = ':grey_question:'
		embed.description = "Are you stupid? You can't stop something that's already stopped. (No song is playing)."
		embed.color = 16_722_454 # red
	end
end

$bot.command(:devstop) do |event|
	isplaying = 0
	event.voice.stop_playing
	$bot.voices[event.server.id].destroy
	nil
end



$bot.command(:icanhasadmin?, min_args: 0, max_args: 0) do |event|
	event.respond "i see u did a command there kek"
	if event.user.permission?(8, event.user.id)
		event.respond "I HAS PERMS"
		event.channel.send_embed do |embed|
			embed.title = ':thinking:'
			embed.description = "Yes, you are indeed in a role that has the Administrator permission."
			embed.color = 1_108_583 # green
		end
	else
		event.channel.send_embed do |embed|
			event.respond "YES BOI!"
			embed.title = ':thinking:'
			embed.description = "No! You are not in a role with Administrative priviledges. :("
			embed.color = 16_722_454 # green
		end
	end
	event.respond "im done with my crap for this command"
end
