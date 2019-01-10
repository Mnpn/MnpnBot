# This is the main file of MnpnBot, programmed in Ruby.
# Shout out to LEGOlord208#1033 and tbodt#7244 for helping me.

require 'discordrb'
require 'urban_dict'
require 'json'
require 'color'
require 'weather-api'
require 'wikipedia'

CLIENT_ID = 289471282720800768

token = File.read "token.txt"

# Configuration

$version = 'Release 2.4.0'
$codename = 'Delta'

$started = 0
$wikilimit = 750

prefixes = ["_"] # Allows multiple prefixes if needed. I want to change this to mentioning in the future.
# End of config.

# MnpnBot S-mode
if File.exists?("settings.json")
	settings = File.read "settings.json"
	$settings = JSON.parse settings
else
	$settings = {}
end

$settings.default = {}
# End

# Initialize the bot.
$bot = Discordrb::Commands::CommandBot.new token: token, client_id: CLIENT_ID, prefix: prefixes

# Require the other files.
require_relative 'conversation.rb'
require_relative 'commands.rb'
require_relative 'info.rb'
require_relative 'development.rb'

$bot.ready do
	$bot.stream($version, 'https://www.twitch.tv/mnpn04')
end

# When ready, set the time it started and print some basic info.
$bot.ready do
	$started = Time.now
	puts('Running on version ' + $version + ', Codename ' + $codename + '.')
end

$bot.command :reload do |event|
	if event.user.id != 172_030_506_970_382_337
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command. :no_entry:'
			embed.description = "You're not allowed to run this command.\nIf something is badly wrong; please contact Mnpn#5043."
			embed.color = 16_722_454 # red
		end
	else
		event.channel.send_embed do |embed|
			embed.title = 'Reload'
			embed.description = 'Reloading MnpnBot!'
			embed.add_field(name: 'Version and Codename', value: $version + ", '%s'" % $codename, inline: true)
			embed.color = 1_108_583 # green
		end
		# WrapperUtil is an external program developed by LEGOlord208#1033. It allows me to restart the bot using _reload. Read more at https://github.com/LEGOlord208/WrapperUtil/
		print 'wrapperutil{"Restart":true}'
		exit
	end
end

# Debug: A simple eval command. Quite useful, actually!
$bot.command([:debug, :d], min_args: 1) do |event, *args|
	if event.user.id == 172030506970382337 || event.user.id == 211422653246865408
		time = Time.new
		h = time.hour.to_s
		min = time.min.to_s
		s = time.sec.to_s
		yee = time.year
		m = time.month
		d = time.day
		nicelookingtime = "%s/%s/%s %s:%s:%s" % [yee, m, d, h, min, s]
		begin
			result = eval(args.join(" "))
			event.respond "```md
# %s: '%s' ```" % [nicelookingtime, result]
		rescue Exception => e
			event.respond "```md
> Error while executing: " + "#{e.backtrace.first}: #{e.message} (#{e.class})" + e.backtrace.drop(1).map{|s| "\t#{s}"}.join("\n") + "```"
			end
	else
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command. :no_entry:'
			embed.description = "You're not permitted to run this command."
			embed.color = 16_722_454 # red
		end
	end
end
# End of debug.

trap('INT') do
	exit
end

# Run the bot.
$bot.run
