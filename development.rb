# New commands I'm testing will appear here
$bot.command(:encode, min_args: 2, usage: "_encode b64/bin/hex <text>") do |event|
args = event.message.to_s[8..-1]
	begin
		if args.start_with? "bin"
			event.respond(args[4..-1].unpack("B*")[0].gsub(/(.{8})/, '\1 '))
			next
		elsif args.start_with? "b64"
			event.respond([args[4..-1]].pack("m*").chomp)
			next
		elsif args.start_with? "hex"
			event.respond(args[4..-1].each_byte.map { |b| b.to_s(16) }.join)
			next
		else
			event.channel.send_embed do |embed|
				embed.description = "You need to select Base64 (b64), Binary (bin) or Hexadecimal (hex)! (Example: _encode bin I like bananas)"
				embed.color = 16722454 # red
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.description = "Error! Message too long or you need to select what to encode to! (Example: _encode b64 I like bananas)"
			embed.color = 16722454 # red
		end
	end
end

$bot.command(:decode, min_args: 1, usage: "_decode b64/bin/hex <text>") do |event|
args = event.message.to_s[8..-1]
	begin
		if args.start_with? "bin"
			args = args[4..-1].gsub(/\s+/, "")
			event.respond([args].pack("B*"))
			next
		elsif args.start_with? "b64"
			event.respond(args[4..-1].unpack('m*')[0])
			next
		elsif args.start_with? "hex"
			event.respond([args[4..-1]].pack('H*'))
			next
		else
			event.channel.send_embed do |embed|
				embed.description = "You need to select Base64 (b64), Binary (bin) or Hexadecimal (hex)! (Example: _encode bin I like bananas)"
				embed.color = 16722454 # red
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.description = "That message is too long to send, or I cannot decode that."
			embed.color = 16722454 # red
		end
	end
end
