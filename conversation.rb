module DiscordBot
	class Conversation

$bot.message(with_text: ':>') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond ':>'
end
$bot.message(with_text: ':<') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond ':<'
end
$bot.message(start_with: '9/11') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond "It's a tragedy."
end
$bot.message(with_text: /kek.?/i) do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond "iKek: Kek'd."
end
$bot.message(with_text: /planes.?/i) do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond "It's a tragedy."
end
$bot.message(with_text: /cyka blyat.?/i) do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond 'Kurwa.'
end

$bot.message(start_with: 'amirite') do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	next unless $annoy
	event.respond ':regional_indicator_a::regional_indicator_m::regional_indicator_i::regional_indicator_r::regional_indicator_i::regional_indicator_t::regional_indicator_e:,    :regional_indicator_y::regional_indicator_e::regional_indicator_s:    :regional_indicator_u:    :regional_indicator_r:'
end
$bot.message(contains: 'why') do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	next unless $annoy
	event.respond ":regional_indicator_b::regional_indicator_e::regional_indicator_c::regional_indicator_a::regional_indicator_u::regional_indicator_s::regional_indicator_e:    :regional_indicator_y::regional_indicator_o::regional_indicator_u:':regional_indicator_r::regional_indicator_e:    :regional_indicator_a::regional_indicator_n:    :regional_indicator_i::regional_indicator_d::regional_indicator_i::regional_indicator_o::regional_indicator_t:"
end

$bot.message(with_text: /ikea.?/i) do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond 'IKEA was founded in 1943 in Älmtaryd, Sweden. The name comes from Ingvar Kamprad, Elmtaryd and Agunnaryd, the name of the founder and where he grew up.'
end

$bot.message(start_with: 'tea') do |event|
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond ':tea:'
end

$bot.message(start_with: 'coffee') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond ':coffee:'
end
$bot.message(start_with: 'java') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond '( ͡° ͜ʖ ͡°) :coffee:'
end

$bot.message(start_with: 'furry') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond 'The command exists, are you happy now?'
end

$bot.message(with_text: /tanks.?/i) do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond '*Are you talking about a war m9?*'
end

$bot.message(with_text: /noot.?/i) do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond 'noot noot'
end

$bot.message(with_text: /mimimask.?/i) do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond 'määä'
end

$bot.message(contains: 'covfefe') do |event|
s_mode = $settings[event.server.id.to_s]["s_mode"]
	if $settings[event.server.id.to_s]["s_mode"]
        next
    end
	event.respond '@realDonaldTrump'
end

$bot.message(with_text: /lenny.?/i) do |event|
	event << '( ͡° ͜ʖ ͡°)'
	event << "That's a quick lenny for you!"
end
$bot.message(start_with: 'boi') do |event|
	event << '( ͡° ͜ʖ ͡°)'
	event << 'BOIII!'
end
end
end