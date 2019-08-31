# This is the main file of MnpnBot, programmed in Ruby.
# Shout out to jD91mZM2#1033 and tbodt#7244 for helping me.

require "discordrb"
require "urban_dict"
require "color"
require "open-uri"
require "wikipedia"

token = File.read "token.txt"

$version = "Release 2.5"
$codename = "Light"
$started = 0
$wikilimit = 750

$bot = Discordrb::Commands::CommandBot.new token: token, client_id: 289471282720800768, prefix: "_"

require_relative "commands.rb"
require_relative "info.rb"

$bot.ready do
	$started = Time.now
	puts "Running on version #{$version}, codename #{$codename}"
	$bot.stream($version, "https://www.twitch.tv/themnpn")
end

$bot.command :reload do |event|
	if event.user.id == 172030506970382337
		# WrapperUtil is an external program developed by jD91mZM2#1033. It allows me to restart the bot using _reload. Read more at https://github.com/LEGOlord208/WrapperUtil/
		print 'wrapperutil{"Restart":true}'
		exit
	end
end

$bot.command([:debug, :d], min_args: 1) do |event, *args|
	if event.user.id == 172030506970382337
		time = Time.new
		h = time.hour.to_s
		min = time.min.to_s
		s = time.sec.to_s
		nicelookingtime = "%s:%s:%s" % [h, min, s]
		begin
			result = eval(args.join(" "))
			event.respond "```md
# %s: %s ```" % [nicelookingtime, result]
		rescue Exception => e
			event.respond "```md
> #{e.backtrace.first}: #{e.message} (#{e.class})" + e.backtrace.drop(1).map{|s| "\t#{s}"}.join("\n") + "```"
			end
	end
end

trap('INT') do
	exit
end

$bot.run
