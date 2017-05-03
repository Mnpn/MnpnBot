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

# I'm too lazy to $bother with anything really, here is the config. Heh.

$ver = 'Release 1.5'

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
	puts('Started, any errors? Version ' + $version)
	$bot.send_message(289_641_868_856_262_656, 'MnpnBot started without any major issues. You should check the console, anyways. Running on version ' + $version)
end

$bot.mention do |event|
	event.respond('( •_•)')
end

trap('INT') do
	exit
end

$bot.run
