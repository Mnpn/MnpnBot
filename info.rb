$bot.command :si do |event|
	begin
		if event.channel.private?
			event.channel.send_embed do |embed|
				embed.title = ':no_entry:'
				embed.description = 'This command cannot be used in a PM!'
				embed.color = 16_722_454
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
			if $settings[event.server.id.to_s]["ptr"] == nil
				$settings[event.server.id.to_s]["ptr"] = false
			end
			if $settings[event.server.id.to_s]["s_mode"] == nil
				$settings[event.server.id.to_s]["s_mode"] = false
			end
			if event.server.large? == true
				size = "Large"
			else
				size = "Small"
			end
				embed.title = 'Server Information'
				embed.description = 'Advanced server information.'
				embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")
				embed.add_field(name: 'Server Settings:', value: "Verification level: \"#{verchann}\", AFK Channel and timeout: \"#{afkchann}, #{event.server.afk_timeout}\", Server size: #{size}.")
				embed.add_field(name: 'Icon:', value: event.server.icon_url.to_s, inline: true)
				embed.add_field(name: 'IDs:', value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
				embed.add_field(name: 'S-Mode, PTR:', value: "#{$settings[event.server.id.to_s]["s_mode"]}, #{$settings[event.server.id.to_s]["ptr"]}", inline: true)
				embed.add_field(name: 'Creation time:', value: event.server.creation_time, inline: true)
				embed.add_field(name: 'Has Emoji?', value: event.server.emoji?, inline: true)
				embed.color = 1_108_583
				embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url.to_s)

				embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: event.server.name.to_s, icon_url: event.server.icon_url.to_s)
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.title = 'Server Information'
			embed.description = 'Advanced server information.'
			embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")

			embed.add_field(name: 'IDs:', value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
			embed.color = 1_108_583
			embed.add_field(name: 'Creation time:', value: event.server.creation_time, inline: true)
			embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url.to_s)

			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: event.server.name.to_s)
		end
	end
end

$bot.command :bi do |event|
lsc = 0
ls = $bot.servers.values.each { |s| lsc += 1 if s.large }
ss = $bot.servers.count - lsc
	begin
		event.channel.send_embed do |embed|
			embed.title = 'Bot Information'
			embed.description = 'Advanced bot information.'
			embed.add_field(name: 'Currently active on', value: "**#{$bot.servers.count}** servers.")
			embed.add_field(name: lsc.to_s, value: 'Large servers', inline: true)
			embed.add_field(name: ss.to_s, value: 'Small servers.', inline: true)
			embed.add_field(name: $bot.users.count.to_s, value: 'Unique users.', inline: true)
			embed.add_field(name: 'Connected to', value: "#{$bot.servers.count} servers.", inline: true)
			embed.add_field(name: 'Version and Codename', value: "#{$version}, Codename '#{$codename}'.", inline: true)
			embed.add_field(name: 'S-Mode', value: $settings[event.server.id.to_s]["s_mode"], inline: false)
			embed.add_field(name: 'PTR', value: $settings[event.server.id.to_s]["ptr"], inline: false)
			embed.color = 1_108_583
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot is hosted on a DigitalOcean Droplet in Amsterdam, Europe.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		end
	rescue
		event.channel.send_embed do |embed|
			embed.title = 'Bot Information'
			embed.description = 'Advanced bot information.'
			embed.add_field(name: 'Currently active on', value: "**#{$bot.servers.count}** servers.")
			embed.add_field(name: lsc.to_s, value: 'Large servers', inline: true)
			embed.add_field(name: ss.to_s, value: 'Small servers.', inline: true)
			embed.add_field(name: $bot.users.count.to_s, value: 'Unique users.', inline: true)
			embed.add_field(name: 'Connected to', value: "#{$bot.servers.count} servers.", inline: true)
			embed.add_field(name: 'Version and Codename', value: "#{$version}, Codename '#{$codename}'.", inline: true)
			embed.color = 1_108_583
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot is hosted on a DigitalOcean Droplet in Amsterdam, Europe.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
		end
	end
end

$bot.command([:ui, :uinfo, :userinfo], min_args: 1, max_args: 1, usage: "_ui <@user>") do |event, user|
	user = user[2..-2]
	begin
		tagged_user = $bot.user(user)
		do_stuff(event, tagged_user)
	rescue
		# If the user has a nick the ID will be <@!id>, so this will remove that !, and fail if that also fails.
		begin
			user = user[1..-1]
			tagged_user = $bot.user(user)
			do_stuff(event, tagged_user)
		rescue => e
			event << "That's an invalid user."
			event << e
		end
	end
end

def do_stuff(event, tagged_user)
	playing = tagged_user.game
	playing = 'Nothing' if playing.nil?
	event.channel.send_embed do |embed|
		embed.title = 'User Information'
		embed.description = "Name, Discrim and ID: #{tagged_user.name}##{tagged_user.discrim}, #{tagged_user.id}"
		embed.add_field(name: 'Status:', value: tagged_user.status.to_s)
		embed.add_field(name: 'Currently Playing:', value: playing)
		if !event.channel.private?
			#joined = tagged_user.joined_at
			#embed.add_field(name: 'Joined at:', value: joined)
		end
		if !event.channel.private?
			#nick = tagged_user.nick
			#nick = 'None' if nick.nil?
			#embed.add_field(name: 'Nickname:', value: nick)
		end
		if !event.channel.private?
			roles = tagged_user.roles
			if !roles.empty?
				embed.add_field(name: 'Roles:', value: roles.map {|x| x.name}.join(", "))
			else
				embed.add_field(name: 'Roles:', value: "No assigned roles.")
			end
		end
		if tagged_user.status.to_s == "online"
			embed.color = 1_108_583
		elsif tagged_user.status.to_s == "dnd"
			embed.color = 16_722_454
		elsif tagged_user.status.to_s == "idle"
			embed.color = 16761666
		elsif tagged_user.status.to_s == "streaming"
			embed.color = 11141306
		end
		embed.add_field(name: 'Creation time:', value: "#{tagged_user.creation_time}")
		embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: tagged_user.avatar_url.to_s)
		if event.channel.private?
			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Pro Tip! Run this command in a server!', icon_url: 'http://i.imgur.com/VpeUzUB.png')
			next
		else
			owner = tagged_user.owner?
			if owner == false
				embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot %s.' % [$version], icon_url: 'http://i.imgur.com/VpeUzUB.png')
			else
				embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Server Owner", icon_url: 'http://i.imgur.com/VpeUzUB.png')
			end
		end
	end
end

$bot.command :psi do |event|
	if event.user.id != event.server.owner.id
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not the owner of this server."
			embed.color = 16_722_454 # red
		end
	else
		event << 'It looks like you, <@%d' % event.server.owner.id + '> is the server owner. This feature is pretty stupid right now.'
	end
end

$bot.command :mnpn do |event|
	if event.user.id != 172030506970382337 && event.user.id != 292020442422706177
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not Mnpn, kek."
			embed.color = 16_722_454 # red
		end
		next
	end
	event.channel.send_embed do |embed|
		embed.title = 'MnpnBot Settings'
		embed.description = 'Here are the current settings.'
		embed.add_field(name: 'Count limit', value: $limit, inline: true)
		embed.add_field(name: 'Version', value: $version, inline: true)
		embed.add_field(name: 'Annoy', value: $annoy, inline: true)
		embed.add_field(name: 'S-Mode', value: $settings[event.server.id.to_s]["s_mode"], inline: true)
		embed.color = 1_108_583 # green
	end
end
