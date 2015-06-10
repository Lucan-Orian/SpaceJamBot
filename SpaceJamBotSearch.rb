require 'rubygems'
require 'chatterbot/dsl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


consumer_key 'CONSUMER KEY HERE'
consumer_secret 'SECRET CONSUMER KEY HERE'

secret 'SECRET TOKEN HERE'
token 'TOKEN HERE'



SPACEJAM_TRIGGERS =["come on and slam","come on and slam and welcome to the jam","party people in the house lets go", "pass that thing and watch me flex","to the jam all in your face", "drop it rock it down the room", "just work that body work that body", "get wild and lose your mind", 
	"hey dj turn it up","cmon yall get on the floor","everybody get up its time to slam now", "welcome to the space jam", "wave your hands in the air if you feel fine", "cmon its time to get hype say whoop there it is",
	"cmon one time for all the ladies say whoop there it is", "cmon one time for the ladies say whoop there it is", "cmon and run baby run","yeah you want a hoop so shoot baby shoot", "slam bam thank you maam", "if you see me on the microphone", "cmon cmon and start the game", "we the team im the coach",
	 "just slide from left to right", "you see me drop the base", "jam on it lets have some fun", "you run the o and i run the d", "cmon everybody say nah nah nah nah nah", "check it out check it out yall ready for this", 
	 "nah yall aint ready yall ready for this", "cmon check it out yall ready to jam", "nah i dont think so yall ready to jam",
	"check it out check it out you ready for this", "nah you aint ready you ready for this", "cmon check it out you ready to jam", "nah i dont hink so you ready to jam",
	"nah you aint yall ready for this", "nah yall aint you ready for this", "hey you watchagonna do", "hey you what you gonna do", "hey you watcha gonna do", "hey dj", "new cd", "everybody get up", "every body get up"]

def coinflip
	return rand(0..1)
end

def log_id(id)
	id_log = File.open("log.txt", "w")
	id_log.puts id
	id_log.close
end

def comeonandslam(user_input)

	case user_input
	when "come on and slam"
		if coinflip == 0
			return "AND WELCOME TO THE JAM!"
		else
			return "IF YOU WANNA JAM!"
		end
	when "come on and slam and welcome to the jam"
		return "Come on and slam! IF YOU WANNA JAM!"
	when "hey you watchagonna do", "hey you what you gonna do", "hey you watcha gonna do"
		return "HEY YOU! WATCHAGONNA DO!"
	when "hey you"
		return "WATCHAGONNA DO"
	when "party people in the house lets go"
		return "It's your boy Jayski a'ight so!"
	when "pass that thing and watch me flex"
		return "Behind my back, you know what's next!"
	when "to the jam all in your face"
		return "Wassup! Just feel the bass!"
	when "drop it rock it down the room"
		return "Shake it, quake it, space Kaboom!"
	when "just work that body work that body"
		return "Make sure you don't hurt no body!"
	when "get wild and lose your mind"
		return "Take this thing into overtime!"
	when "hey dj turn it up"
		return "New CD goin' burn it up!"
	when "hey dj"
		return "Turn it up!"
	when "new cd"
		return "Goin' burn it up!"
	when "cmon yall get on the floor"
		return "So hey, let's go a'ight"
	when "everybody get up", "every body get up"
		return "It's time to slam now!"
	when "everybody get up its time to slam now"
		return "We got a real jam goin' down!"
	when "welcome to the space jam"
		return "Here's your chance, do the dance at the Space Jam! Alright!"
	when "heres your chance"
		return "Do the dance at the Space Jam! Alright!"
	when "wave your hands in the air if you feel fine"
		return "We're gonna take it into overtime!"
	when "cmon its time to get hype say whoop there it is"
	 	return "C'mon all the fellas say, \"Whoop, there it is\"!"
	 when "cmon one time for all the ladies say whoop there it is", "cmon one time for the ladies say whoop there it is"
	 	return "Now all the fellas, say \"Whoop, there it is\"!"
	 when "cmon and run baby run"
	 	return "C'mon, C'mon, do it, run baby run!"
	 when "yeah you want a hoop so shoot baby shoot"
	 	return "Yeah, it's time to hook, so shoot baby shoot!"
	 when "slam bam thank you maam"
		return "Get on the floor and jam!"
	when "if you see me on the microphone"
		return "Girl, you got me in a zone!"
	when "cmon cmon and start the game"
		return "Break it down, tell me your name!"
	when "we the team im the coach"
		return "Let's dance all night from coast to coast"
	when "just slide from left to right"
		return "Just slide, yourself enlight!"
	when "you see me drop the base"
		return "3-1-1 all in your face!"
	when "jam on it lets have some fun"
		return "Jam on it, one on one!"
	when "you run the o and i run the d"
		return "So c'mon baby just jam for me!"
	when "cmon everybody say nah nah nah nah nah"
		return "C'mon, C'mon let me hear you say, \"Hey ey ey O\"!"
	when "cmon cmon everybody say nah nah nah nah nah"
		return "Just take the time to say \"Hey ey ey O\"!"
	when "check it out check it out yall ready for this", "nah yall aint ready yall ready for this", "cmon check it out yall ready to jam", "nah i dont think so yall ready to jam",
		"check it out check it out you ready for this", "nah you aint ready you ready for this", "cmon check it out you ready to jam", "nah i dont hink so you ready to jam",
		"nah you aint yall ready for this", "nah yall aint you ready for this"
		return "You know it!"

	else
		return "nope"
	end
end

exclude "rt", "http://", "bot"




	id_log = File.open("log.txt", "r")
	highest_id = id_log.read.to_i
	id_log.close

loop do


	search(SPACEJAM_TRIGGERS, :result_type => "recent",:lang => "en", :since_id => highest_id) do |user_tweet|
		user_name = tweet_user(user_tweet)


		tweet_text = user_tweet.text.gsub(/[#\@]\w+\b/,'').gsub(/\W+$/,'').downcase.lstrip
		slam_text = tweet_text.gsub(/[^a-z0-9\s]/i, '')

		if user_tweet.id > highest_id
			log_id(user_tweet.id)
			highest_id = user_tweet.id
		end

		if user_name.include? "bot"
			next
			puts "skipped a bot!"
		end

		if slam_text == "hey you"
			reply "#{user_name} WATCHAGONNA DO", user_tweet
		elsif SPACEJAM_TRIGGERS.any? {|quote| slam_text.include? quote}
			lyric = comeonandslam(slam_text)
			if lyric == "nope"
				next
			else
				reply "#{user_name} #{lyric}", user_tweet

			end
		end

		puts tweet_text
	end

	replies do |user_tweet|

		user_name = tweet_user(user_tweet)

		tweet_text = user_tweet.text.gsub(/[#\@]\w+\b/,'').gsub(/\W+$/,'').downcase.lstrip
		slam_text = tweet_text.gsub(/[^a-z0-9\s]/i, '')

		if slam_text == "hey you"
			reply "#{user_name} WATCHAGONNA DO", user_tweet
		elsif SPACEJAM_TRIGGERS.any? {|quote| slam_text.include? quote}
			lyric = comeonandslam(slam_text)
			if lyric == "nope"
				puts lyric
				retweet user_tweet
				else
				reply "#{user_name} #{lyric}", user_tweet
			end
		end
	end #end replies

		update_config
		sleep 900
end
