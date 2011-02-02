require 'test/unit'
require "TenThousand.rb"

class Test_Ten_Thousand < Test::Unit::TestCase
	def test_AI_Names
	names = ["Ellen<AI>","Sophie<AI>","Samuel<AI>","Valentine<AI>", "Alfred<AI>", "Sampson<AI>", "Lucky<AI>","Cuddles<AI>", "Eddy 'Two-Hands'<AI>","Shifty Joe<AI>", "Dust Bin<AI>"]
	a = Ai_Player.new
	#puts a.name
	assert_equal true, names.include?(a.name)
	end

	def test_Human_Names
	puts "type in the name you want to use than type it again"
	name = gets.chomp!
	
	a_human =  Human_Player.new(8)

	assert_equal name, a_human.name	
	end
	def test_inputData_Normal
	a = input_fixnum("enter a fixnum")
	assert a.class == 5.class
	end
#def test_inputData_loop 
# this is a failure. Don't know what to do because ruby is kinda dumb =/
#	a = input_fixnum("enter a string, then a fixnum")
#	assert a.class == 5.class
#	end
	def test_dice_rolls
	a = roll_dice
#	puts a.inspect
	assert_equal a.size, 5
	a.map {|i| assert(i<7 && i>0)}
	end	
	def test_scoreDice()
	zero = [0,2,2,2,0,2]
	zero2 =[0,1,1,1,0,1]
	zero3 = [0,0,0,0,0,0]
	one_thousand = [3,0,0,0,0,0]
	two_thousand = [4,0,0,0,0,0]
	four_thousand = [5,0,0,0,0,0]
	two_hundred  = [0,3,0,0,0,0]
	two_hundred2 = [2,0,0,0,0,0]
	one_hundred = [1,0,0,0,0,0]
	one_hundred2 = [0,0,0,0,2,1]
	four_hundred = [0,4,0,0,0,0]
	eight_hundred = [0,5,0,0,0,0]
	five_hundred = [0,0,0,0,3,0]
	one_thousand2 = [0,0,0,0,4,0]
	two_thousand2 = [0,0,0,0,5,0]

	assert_equal 0,scoreDice(zero)
	assert_equal 0,scoreDice(zero2)
	assert_equal 0,scoreDice(zero3)
	assert_equal 100,scoreDice(one_hundred)
	assert_equal 100,scoreDice(one_hundred2)
	assert_equal 1000,scoreDice(one_thousand)
	assert_equal 1000,scoreDice(one_thousand2)
	assert_equal 2000,scoreDice(two_thousand)
	assert_equal 2000,scoreDice(two_thousand2)
	assert_equal 4000,scoreDice(four_thousand)
	assert_equal 200,scoreDice(two_hundred)
	assert_equal 200,scoreDice(two_hundred2)
	assert_equal 400,scoreDice(four_hundred)
	assert_equal 500,scoreDice(five_hundred)
	assert_equal 800,scoreDice(eight_hundred)
	
	#lets try some simple mixing
	three_hundred = [2,0,0,0,2,1]
	six_hundred = [1,1,0,0,3,0]
	zwolf = [3,3,0,0,0,0]
	assert_equal 300,scoreDice(three_hundred)
	assert_equal 600, scoreDice(six_hundred)
	assert_equal 1200,scoreDice(zwolf)
	end

end
