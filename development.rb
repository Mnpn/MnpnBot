# New commands I'm testing will appear here

MEME_LINKS = ["https://mnpn.me/images/triggered.png",
	"https://s-media-cache-ak0.pinimg.com/736x/4c/76/0f/4c760fba47623735a658e0b77d937062--happy-friday-the-th-horror-movies.jpg",
	"https://i.imgur.com/94Qd8i2.jpg",
	"https://i.imgur.com/LH0tziN.jpg",
	"https://i.imgur.com/qv30k9P.png",
	"https://i.imgur.com/P1FYuZX.jpg",
	"https://cdn.discordapp.com/attachments/331762274966437888/339740554273357824/oncewentoutsude.png",
	"https://i.imgur.com/xHK8BRY.jpg",
	"https://cdn.discordapp.com/attachments/228221346608316417/334426154784260096/S_T_O_P.png",
	"https://cdn.discordapp.com/attachments/228221346608316417/309355048494694410/unknown.png",
	"https://cdn.discordapp.com/attachments/228221346608316417/338054796399607809/THOTRIGGERED.png",
	"https://mnpn.me/images/EverydayWeDriftFurtherAwayFromSatansProtection.png",
	"https://mnpn.me/images/em.png",
	"https://cdn.discordapp.com/attachments/311566841728335882/341143275299930113/unknown.png",
	"https://cdn.discordapp.com/attachments/228221346608316417/338253135795716097/image.jpg",
	"https://s-media-cache-ak0.pinimg.com/736x/13/e0/ce/13e0cef23c4323e8d32be0e6322be99a--funny-happy-birthday-meme-funny-happy-birthdays.jpg",
	"http://www.fullredneck.com/wp-content/uploads/2016/04/Funny-Russia-Meme-20.jpg",
	"https://mnpn.me/images/kat_codes.png"]

$bot.command(:dank) do |event|
	if $settings[event.server.id.to_s]["ptr"]
		event << "You are dank! Thanks for participating in the PTR testing!"
		event << "You're a part of history! (Well, maybe not.)"
	end
end

$bot.command(:meme) do |event|
memeages = ["ill meme u!","here's a meme","oh look, a meme!","I gotcha fam!","meme","this one is dank, i promise","https://niceme.me/","ur a meme","meeeeee.me","i think im out of ideas for this string here","k","kk","ok","mhm","sure"]
	event.channel.send_embed do |embed|
		embed.description = memeages.sample
		embed.color = rand(1000000..1900000)
		embed.image = Discordrb::Webhooks::EmbedImage.new(url: MEME_LINKS.sample)
	end
end

$bot.command(:addmeme, min_args: 1, max_args: 1) do |event, link|
	if event.user.id != 172_030_506_970_382_337 || event.user.id != 211422653246865408
		event.respond "You're not allowed to add memes."
	else
		# todo: make it add memes
		event << "couldnt add meme"
	end
end

$bot.command(:avatar, min_args: 1, max_args: 1) do |event, user|
next unless $settings[event.server.id.to_s]["ptr"]
user = user[2..-1]
user = user.chomp('>')
	begin
		tagged_user = $bot.user(user);
		avatar = tagged_user.avatar_url
		avatar = tagged_user.avatar_url[0..-4]
		event.respond "#{tagged_user.mention}'s avatar URL is #{avatar}jpg?size=1024"	
	rescue
		# If the user has a nick the ID will be <@!id>, so this will remove that !, and fail if that also fails.
		begin
			user = user[1..-1]
			tagged_user = $bot.user(user);
			avatar = tagged_user.avatar_url[0..-4]
			event.respond "#{tagged_user.mention}'s avatar URL is #{avatar}jpg?size=1024"
		rescue
			event.respond "That's an invalid user."
		end
	end
end