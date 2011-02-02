require "TenThousand.rb"

puts "LETS PLAY TEN THOUSAND"
puts "~~~~~~~~~~~~~~~~~~~~~~"


#set players, get rid of redundancy where poissible
number_humans = input_fixnum("How many Human Players?")

#initialize game variables
total_players = number_humans
players = []

number_humans.times do |i|
temp = Human_Player.new(i)
players << temp
end

number_AI = input_fixnum("How many AI Players?")
total_players +=number_AI

number_AI.times do |i|
temp = Ai_Player.new
players << temp
end



#start loop for game here
#while (true) ?, break if on computing score, score is greater than 10k 
#if human player, display roll ask what to keep, what to roll again?

while(true)
	
	players.each_index do |player_index| 	
		puts " It is " + players[player_index].name + "'s Turn"
		puts players[player_index].name + " currently has " + players[player_index].score.to_s + " points"
		if(players[player_index].turn >= 10000)
			puts  " Player " + players[player_index].name + " has won"
			return
		end
		puts players[player_index].name + " currently has " + players[player_index].score.to_s + "points"
	end
end



##

