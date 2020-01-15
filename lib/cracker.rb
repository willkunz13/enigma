require_relative 'decoder.rb'

class Cracker < Decoder

	attr_reader :input, :date, :last_four, :whitelist, :key

	def initialize(input, date)
		file = File.open("./file/white_list.txt")
                @whitelist = file.read.chomp.split(//)
                file.close	
		@input = input
		@date = date
		@last_four = input[-4,4]
		@key = "error: not yet calculated"
	end

	def starting_shift
		ending = " end"
		constant_shift = []
		constant_shift << whitelist.index(ending[0])
		constant_shift << whitelist.index(ending[1])
		constant_shift << whitelist.index(ending[2])
		constant_shift << whitelist.index(ending[3])
		constant_shift
	end

	def subtract_date_shift
		date_sq = date.to_i** 2
		shifts = []
		shifts << make_shifts_negative[0] -= date_sq.to_s[-4].to_i
		shifts << make_shifts_negative[1] -= date_sq.to_s[-3].to_i
		shifts << make_shifts_negative[2] -= date_sq.to_s[-2].to_i
		shifts << make_shifts_negative[3] -= date_sq.to_s[-1].to_i
		shifts
	end

	def calculate_shifters
		shifters = []
		starting_shift.each_with_index do |shift, index|
			shifters << shift - whitelist.index(last_four[index])
		end
		shifters
	end

	def decrypt_message
		decrypt_iteration(calc_shifters).flatten.join
	end

	def possible_key_to_s(shifts)
		shifts.map do |shift|
			if shift.to_s.size == 1
				"0" + shift.to_s
			else
				shift.to_s
			end
		end
	end

	def calculate_key
		@key = calculate_key_shifts[0][0] + calculate_key_shifts[0][0] + calculate_key_shifts[1][1] + \
calculate_key_shifts[2][1] + calculate_key_shifts[3][1]
		end
			
	def calculate_key_shifts
		all_possible_shifts.each do |shifts|
			correct_shifts = possible_key_to_s(shifts)
			if correct_shifts[0][1] == correct_shifts[1][0] && correct_shifts[1][1] == correct_shifts[2][0] \
&& correct_shifts[2][1] == correct_shifts[3][0]
				return correct_shifts
			end
		end
	end

	def make_shifts_negative
		calculate_shifters.map {|shift| -(shift)}
	end

	def make_shifts_positive
		subtract_date_shift.map do |shift|
			if shift < 0
				shift += 27
			else
				shift
			end
		end
	end

	def all_possible_shifts
		potential_key_combinations = []
		possible_first_shifts.each do |first|
			possible_second_shifts.each do |second|
				possible_third_shifts.each do |third|
					possible_fourth_shifts.each do |fourth|
						potential_key_combination = []
						potential_key_combination << first
						potential_key_combination << second
						potential_key_combination << third
						potential_key_combination << fourth
						potential_key_combinations << potential_key_combination
					end
				end
			end
		end
		potential_key_combinations
	end

	def possible_second_shifts
		potential_shifts = []
		starter = make_shifts_positive[1]
		while starter < 100
			potential_shifts << starter
			starter += 27	
		end
		potential_shifts
	end
			
	def possible_third_shifts
		potential_shifts = []
		starter = make_shifts_positive[2]
		while starter < 100
			potential_shifts << starter
			starter += 27	
		end
		potential_shifts
	end

	def possible_fourth_shifts
		potential_shifts = []
		starter = make_shifts_positive[3]
		while starter < 100
			potential_shifts << starter
			starter += 27	
		end
		potential_shifts
	end		

	def possible_first_shifts
		potential_shifts = []
		starter = make_shifts_positive[0]
		while starter < 100
			potential_shifts << starter
			starter += 27	
		end
		potential_shifts
	end
end

	
