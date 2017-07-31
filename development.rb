# New commands I'm testing will appear here

$bot.command(:dank) do |event|
	if $settings[event.server.id.to_s]["ptr"]
		event << "You are dank! Thanks for participating in the PTR testing!"
		event << "You're a part of history! (Well, maybe not.)"
	end
end