# I never do comments, but when I do, they suck.
# This is the main file of MnpnBot, programmed in Ruby.
# Shout out to LEGOlord208#1033 and tbodt#7244 for helping me.

# Error catching and logging functions
log_debug = true
log_errors = true

# Copy paste from stack overflow.
# http://stackoverflow.com/questions/9433924/how-can-i-copy-stdout-to-a-file-without-stopping-it-showing-onscreen-using-ruby
# too lazy.
class TeeIO < IO
	def initialize(orig, file)
		@orig = orig
		@file = file
	end

	def write(string)
		@file.write string
		@orig.write string
	end
end

if log_debug
	tee = TeeIO.new $stdout, File.new('log.txt', 'w')
	$stdout = tee

	tee = TeeIO.new $stderr, File.new('log.txt', 'w')
	$stderr = tee
end

# Done
# No longer using Windows for hosting; Libsodium like this is useless!

require 'discordrb'
require 'urban_dict'

CLIENT_ID = 289_471_282_720_800_768
token = ''
File.open('token.txt') do |f|
	f.each_line do |line|
		token += line.strip
	end
end

# I'm too lazy to bother with anything really, here is the config. Heh.

$ver = 'Release 1.6'
$codename = "Salt"

$limit = 15
$devmode = false
$debug = true
$annoy = false
$started = 0
$typeloops = 20
# End of config.

$bot = Discordrb::Commands::CommandBot.new token: token, client_id: CLIENT_ID, prefix: '_'

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
	begin
	#I disabled the loop because it thows error when the internet is bad.
		#loop do
			# $bot.game = "Ruby"
			# sleep(15)
			# $bot.game = version
			# sleep(15)
			# $bot.game = "_help-ful!"
			# sleep(5)
			$bot.stream($version, 'https://www.twitch.tv/mnpn04')
			#sleep(20)
			#$bot.stream('Ruby', 'https://www.twitch.tv/mnpn04')
			#sleep(5)
		#end
	#rescue => e
	#	event.channel.send_embed do |embed|
	#		embed.title = 'Error'
	#		embed.description = "An error occured, and Albin caused it.\n#{e}"
	#	end
	end
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

$bot.command(:debug, min_args: 1) do |event, *args|
if event.user.id == 172030506970382337
		event.channel.send_embed do |embed|
			embed.title = 'Restricted command. :no_entry:'
			embed.description = "You're not permitted to run this command."
			embed.color = 16_722_454 # red
		end
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
rescue
	event.respond "```md
> Exception: #<NameError: undefined local variable or method '" + args.join(" ") + "' for main:Object>```
It's not a variable or a method."
end
else
	event.respond "Sorry, you're not permitted to use this command."
end
end

$bot.mention do |event|
	event.respond('( •_•)')
end

trap('INT') do
	exit
end

$bot.run
