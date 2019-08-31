$bot.command :si do |event|
	if event.channel.private?
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = 'This command cannot be used in a DM!'
			embed.color = 16722454
		end
	else
		event.channel.send_embed do |embed|
		verchann = event.server.verification_level
		if verchann == nil
			verchann = "None"
		end
		afkchann = event.server.afk_channel
		if afkchann == nil
			afkchann = "None"
		else
			afkchann = event.server.afk_channel.name
		end
		if event.server.large?
			size = "Large" else size = "Small"
		end
		if event.server.emoji? == true
			emoji = "Server has emoji." else emoji = "Server does not have any emoji."
		end
			embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: event.server.name, url: event.server.icon_url, icon_url: event.server.icon_url)
			embed.description = "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}
Server Settings: Verification level: \"#{verchann}\", AFK Channel and timeout: \"#{afkchann}, #{event.server.afk_timeout}\", Server size: #{size}. #{emoji}"
			embed.add_field(name: 'IDs:', value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
			embed.add_field(name: 'Creation time:', value: event.server.creation_time, inline: true)
			embed.color = 1108583
			embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url)
		end
	end
end

$bot.command :ui do |event|
	playing = event.user.game
	playing = 'Nothing' if playing.nil?
	event.channel.send_embed do |embed|
		embed.title = 'User Information'
		desc = "**Name#Discrim and ID:** #{event.user.name}##{event.user.discrim}, #{event.user.id}
**Status:** #{event.user.status}
**Currently playing:** #{playing}"
		if !event.channel.private?
			desc << "\n**Joined at:** #{event.user.joined_at}"
			nick = event.user.nick
			nick = 'None' if nick.nil?
			desc << "\n**Nickname:** #{nick}"
			roles = event.user.roles
			if !roles.empty?
				embed.add_field(name: 'Roles:', value: roles.map {|x| x.name}.join(", "))
			else
				embed.add_field(name: 'Roles:', value: "No assigned roles.")
			end
		end
		if event.user.status.to_s == "online"; embed.color = 1108583
		elsif event.user.status.to_s == "dnd"; embed.color = 16722454
		elsif event.user.status.to_s == "idle"; embed.color = 16761666
		end
		desc << "\n**Creation time:** #{event.user.creation_time}"
		embed.description = desc
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.user.avatar_url.to_s)
		if event.channel.private?
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Pro Tip! Run this command in a server!', icon_url: 'http://i.imgur.com/VpeUzUB.png')
			next
		end
	end
end

$bot.command :bi do |event|
	lsc = 0
	ls = $bot.servers.values.each { |s| lsc += 1 if s.large }
	ss = $bot.servers.count - lsc
	event.channel.send_embed do |embed|
		embed.title = "MnpnBot #{$version} (#{$codename}) Info"
		embed.description = "I'm in **#{$bot.servers.count}** servers (#{lsc} large, #{ss} small), totalling #{$bot.users.count} unique users."
		embed.add_field(name: "Wikipedia text limit", value: $wikilimit, inline: true)
		embed.color = 1108583 # green
	end
end