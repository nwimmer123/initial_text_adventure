@test_variable = "defined out side function"

def tester_function
	puts @test_variable
	test_variable = @test_variable
	test_variable = "new value"
	puts "reassigned #{test_variable}"

	puts "not re-assigned @ #{@test_variable}"
end

puts tester_function()
puts "This is @test_variable #{@test_variable}"

