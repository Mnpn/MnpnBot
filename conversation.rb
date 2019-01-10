# Everything in here is a part of the non-smode MnpnBot. All the auto-responses are located here. Remember! You can toggle them with _smode.

$bot.message(with_text: ':>') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond ':>'
end
$bot.message(with_text: ':<') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond ':<'
end
$bot.message(start_with: '9/11') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond "It's a tragedy."
end
$bot.message(with_text: /kek.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond "iKek: Kek'd."
end
$bot.message(with_text: /planes.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond "It's a tragedy."
end
$bot.message(with_text: /cyka blyat.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond 'Kurwa.'
end

$bot.message(with_text: /ikea.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond 'IKEA was founded in 1943 in Älmtaryd, Sweden. The name comes from Ingvar Kamprad, Elmtaryd and Agunnaryd, the name of the founder and where he grew up.'
end

$bot.message(start_with: 'tea') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond ':tea:'
end

$bot.message(start_with: 'coffee') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond ':coffee:'
end
$bot.message(start_with: 'java') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond '( ͡° ͜ʖ ͡°) :coffee:'
end

$bot.message(with_text: /tanks.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond '*Are you talking about a war m9?*'
end

$bot.message(with_text: /noot.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond 'noot noot'
end

$bot.message(with_text: /mimimask.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond 'määä'
end

$bot.message(contains: 'covfefe') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond '@realDonaldTrump'
end

$bot.mention do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event.respond('( •_•)')
end

$bot.message(with_text: /lenny.?/i) do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event << '( ͡° ͜ʖ ͡°)'
	event << "That's a quick lenny for you!"
end
$bot.message(start_with: 'boi') do |event|
	next if $settings[event.server.id.to_s]["s_mode"]
	event << '( ͡° ͜ʖ ͡°)'
	event << 'BOIII!'
end