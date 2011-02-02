def scoreDice(dice)
score =0 
#handle 1
#written as dice number - index difference
if(dice[1-1]<3)
	score+= 100*dice[0]
else
	score+= 1000*(2**(dice[0]-3))
end
dice.delete_at(0)
#handle singular 5's
if(dice[5-2]<3)
	score += 50*dice[5-2]
	dice[5-2] =0
end
#handle everything else
dice.each_index do |i|
if(dice[i]>2)
	score+= (2+i)*100*(2**(dice[i]-3))
	dice[i] =0
end
end
dice.each do |i|
if(i>0)
	puts "had non scoring dice"
	return -1
end
end
return score
end
def input_fixnum(message)
	while(true)
		puts message
		data = gets.chomp!
		data = data.to_i

		if(data.class != 6.class)
			puts "invalid entry"
		else
			return data
		end
	end
end

def roll_dice(num = 5)
	dice = Array.new(num)
	dice.map! {|i| i=rand(6)+1}
	return dice
end

class Human_Player 
	def initialize(player_number)
	@player_number = player_number+1
	puts "enter player number " +@player_number.to_s + "'s name: "
	@name = gets.chomp!
	@score =0
	end
	
	def turn
		#intialize values for the turn
		bank = 0
		rolls_left=1
		num_dice = 5
	
		#begin the turn
		while(rolls_left>-1)
			"Rolling Dice!!"	
			rolledQ = [0,0,0,0,0,0]
			dice = roll_dice(num_dice)
			puts "the dice are currently: " + dice.inspect
			
			dice.map {|i| rolledQ[i-1]+=1}

#which dice to save
			cheat=true
			while(cheat)
				puts "which dice would you like to save? "
				saved = gets.chomp!
				saved.gsub!(/[^\d]/,"")
				savedQ = [0,0,0,0,0,0]
				dice_banked = saved.size
				while(saved.size > 0 )
					num = saved.slice!(0,1).to_i					
					num -=1
					savedQ[num] += 1
				end
				cheat=false
				savedQ.each_index do |i|
					if(savedQ[i]>rolledQ[i])
						cheat=true
						break
					end	
				end
				
				tempNum = scoreDice(savedQ)
				if(tempNum <0)
					cheat = true
				end

			end
			
			num_dice -=dice_banked
			if(num_dice ==0)
				num_dice=5
			end
		
			bank+=tempNum
			if(tempNum > 0)
				rolls_left = 2
			end
		 # save dice, remove from pool, get ready to call
			
			if(rolls_left==2)	
				puts "want to roll again?(y/n)"
				confirm = gets.chomp!
	
				if(confirm == 'y')
					rolls_left-=1
				else
					break
				end
			else
				rolls_left-=1
			end

		end
		if(rolls_left > -1)
		@score += bank
		else
			puts "Bust!"
		end
		return @score	
	end
	def score
		@score
	end
	def name
		@name
	end
end

class Ai_Player 
@@Names = ["Ellen","Sophie","Samuel","Valentine", "Alfred", "Sampson", "Lucky","Cuddles", "Eddy 'Two-Hands'","Shifty Joe", "Dust Bin"]

def self.names
 return @@Names[rand(@@Names.size)]
end
def initialize
#5,4,3,2,1
@noScoreProb = [0.00617,0.03737,0.16667,0.44444,0.66667]
@score = 0
end

def turn

		#intialize values for the turn
		bank = 0
		rolls_left=1
		num_dice = 5
		dice_banked = 0
	
		#begin the turn
		while(rolls_left>-1)
			"Rolling Dice!!"	
			rolledQ = [0,0,0,0,0,0]
			savedQ = [0,0,0,0,0,0]
			dice = roll_dice(num_dice)
			puts "the dice are currently: " + dice.inspect
			
			dice.map {|i| rolledQ[i-1]+=1}

#which dice to save
			savedQ[0] = rolledQ[0]

			dice_banked = rolledQ[0]
			rolledQ.each_index do |number|
			if(rolledQ[number]>=3 && number!=0)
				savedQ[number] = rolledQ[number]
				dice_banked += rolledQ[number]
			end
			end


#logic for 5			
			if( rolledQ[4]<3 && (rolls_left == 0 || num_dice-rolledQ[4]<=0))
				savedQ[4] = rolledQ[4]
				dice_banked += rolledQ[4]
			end

			tempNum = scoreDice(savedQ)


			num_dice -=dice_banked
			if(num_dice ==0)
				num_dice=5
			end
		
			bank+=tempNum
			if(tempNum > 0)
				rolls_left = 2
			end
		 # save dice, remove from pool, get ready to call
		#conservative
			if(rolls_left==2)	
				if((bank + 70*num_dice)*(1-(@noScoreProb[5-num_dice]**2)) > bank)
					rolls_left-=1
				else
					break
				end
			else
				rolls_left-=1
			end

		end
		if(rolls_left > -1)
		@score += bank
		else
			puts "Bust!"
		end
		return @score	

end
def score
	@score
end

def name
	@name||=Ai_Player.names + "<AI>"
end

end

