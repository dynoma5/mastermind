class Computer

def initialize
	@secret_code = []
end

def make_secret_code
	for i in 1..4
		@secret_code.push(rand(6)+1)
	end
	return @secret_code
end	

end

class Player
attr_accessor :code

def initialize
	@code = []
end

def input_code(numbers)
	for i in 0..3
		@code.push(numbers[i].to_i)
	end
	return @code	
end

end

def compare_code(usercode, cpucode)
	result = []
	for i in 0..3
		if usercode[i] == cpucode[i]
			result.push("White")
		elsif cpucode.any?{|x| x == usercode[i]}
			result.push("Grey")
		else
			result.push("Black")
		end
	puts "#{usercode[i]} = #{result[i]}"	
	end
	return result
end
	
def start_game
cpu = Computer.new
user = Player.new
counter = 1
cpu_code = cpu.make_secret_code
puts "Let's play some Mastermind. The computer will randomly generate a 4 digit code \nusing 1-9. Try to guess the correct code within 12 turns.\nWhite means the number and position of number is correct.\n
Grey means the number is correct but not in its correct spot.\n
Black means the number is not anywhere in the code. 
 \n"
 puts "Type 'cpu' if you'd like the computer to guess your code. Otherwise just press enter."
 option = gets.chomp
 unless option == "cpu"
	while (counter <13) do
		puts "Type in your guess."
		input = gets.chomp
		user.code = []
		user_code = user.input_code(input)
		result = compare_code(user_code, cpu_code)
		if result.all?{|x| x == "White"}
			puts "Wow! You correctly guessed the code in #{counter} guesses!"
			break
		else
			counter = counter +1
		
		end
	end
	if counter == 13
	puts "You could not solve the code. Game Over."
	end
else
puts "Type in your secret code."
	input = gets.chomp
		user.code = []
		user_code = user.input_code(input)
		new_code = [0,0,0,0]
	while(counter <13) do
		result = compare_code(cpu_code, user_code)
		if result.all?{|x| x == "White"}
			puts "The computer guessed your code in #{counter} guesses!"
			break
		else
			for i in 0..3
				if result[i] == "White"
					new_code[i] = cpu_code[i]
					
				elsif result[i] == "Black" or result[i] == "Grey"
					cpu_code[i] = rand(6)+1
					
				end
			end
		counter = counter +1	
		end
		if counter == 13
			puts "Computer could not solve your code. You win!"
		end	
	end	
	
end
end
start_game
loop do
 puts "Would you like to play again?"
 response = gets.chomp
 if response == "yes"
	start_game
	else 
	break
end
end	




