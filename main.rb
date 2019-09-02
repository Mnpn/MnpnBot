require "discordrb"
require "urban_dict"
require "color"
require "open-uri"
require "wikipedia"

token = File.read "token.txt"
$version = "2.5.1"
$codename = "Light"
$started = 0
$wikilimit = 750

INVITE_URL = "https://discordapp.com/oauth2/authorize?client_id=289471282720800768&scope=bot&permissions=0"
ICON_URL = "http://i.imgur.com/VpeUzUB.png"

$bot = Discordrb::Commands::CommandBot.new token: token, client_id: 289471282720800768, prefix: "_"

require_relative "commands.rb"
require_relative "info.rb"

$bot.ready do
	$started = Time.now
	puts "Running version #{$version}, codename #{$codename}"
	$bot.stream("Release " + $version, "https://www.twitch.tv/themnpn")
end

$bot.command :reload do |event|
	if event.user.id == 172030506970382337
		# WrapperUtil is an external program developed by jD91mZM2#1033. It allows me to restart the bot.
		# Read more at https://github.com/jD91mZM2/WrapperUtil
		print 'wrapperutil{"Restart":true}'
		exit
	end
end

$bot.command([:debug, :d], min_args: 1) do |event, *args|
	if event.user.id == 172030506970382337
		time = Time.new
		nicelookingtime = "#{time.hour}:#{time.min}:#{time.sec}"
		begin
			result = eval(args.join(" "))
			event.respond "```md\n# %s: %s ```" % [nicelookingtime, result]
		rescue Exception => e
			event.respond "```md\n> #{e.backtrace.first}: #{e.message}```"
		end
	end
end

trap('INT') do
	exit
end

$bot.run
