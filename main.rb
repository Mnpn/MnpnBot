# I never do comments, but when I do, they suck.
# This is the main file of MnpnBot, programmed in Ruby.
# Shout out to LEGOlord208#1033 and tbodt#7244 for helping me.

require 'discordrb'
require 'urban_dict'
require 'json'

CLIENT_ID = 289471282720800768

token = File.read "token.txt"

# MnpnBot S-mode

if File.exists?("settings.json")
	settings = File.read "settings.json"
	$settings = JSON.parse settings
else
	$settings = {}
end

$settings.default = {}

# End

# I'm too lazy to bother with anything really, here is the config. Heh.

$ver = 'Release 1.7.2'
$codename = 'Sea Salt'

$limit = 15
$devmode = false
$debug = false
$annoy = false
$started = 0
$typeloops = 20

prefix = "_"
# End of config.

$bot = Discordrb::Commands::CommandBot.new token: token, client_id: CLIENT_ID, prefix: prefix

require_relative 'conversation.rb'
require_relative 'commands.rb'
require_relative 'info.rb'

if $devmode == true
	require_relative 'development.rb'
	$version = $ver + ' Dev'
	puts 'Development Mode is Enabled.'
else
	$version = $ver
end

$bot.ready do
	#begin
		loop do
			$bot.stream($version, 'https://www.twitch.tv/mnpn04')
			sleep(20)
			$bot.stream('Ruby', 'https://www.twitch.tv/mnpn04')
			sleep(5)
		end
		#rescue => e
		#	event.channel.send_embed do |embed|
		#		embed.title = 'Error'
		#		embed.description = "An error occured, and Albin caused it.\n#{e}"
		#	end
	#end
end

$bot.ready do
	$started = Time.now
	puts('Running on version ' + $version + ', Codename ' + $codename + '.')
	#$bot.send_message(289_641_868_856_262_656, 'Started! Running on version ' + $version + ', Codename ' + $codename + '.')
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
			embed.add_field(name: 'Development mode', value: $devmode, inline: true)
			embed.add_field(name: 'Debug mode', value: $debug, inline: true)
			embed.color = 1_108_583 # green
		end
		print 'wrapperutil{"Restart":true}'
		exit
	end
end

shyrix = "edgelord" # Again, testing variable to mess around with.

$bot.command(:debug, min_args: 1) do |event, *args|
	if event.user.id == 172030506970382337 || event.user.id == 211422653246865408
		time = Time.new
		h = time.hour.to_s
		min = time.min.to_s
		yee = time.year
		m = time.month
		d = time.day
		nicelookingtime = "%s/%s/%s %s:%s" % [yee, m, d, h, min]
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

trap('INT') do
	exit
end

$bot.run
