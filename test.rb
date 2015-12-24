#################
# Control Logic #
#################

@current_page_number = 0

def evaluate_user_input(str)
  exit if str == "exit"

  next_page_number = str.to_i
  @current_page_number = next_page_number
end

#####################
# Game Instructions #
#####################

pages = [
  {
    description: "You walk into GA on your first day of WDI 25. Celso is sitting at the Front Desk.",
    options: [
      {
        text: "Talk to Celso",
        page_number: 1
      },
      {
        text: "Go home",
        page_number: 3
      }
    ]
  },
  {
    description: "Hi, it must be your first day of class! You'll be meeting in classroom 8.",
    options: [
      {
        text: "Go to classroom 8",
        page_number: 2
      },
      {
        text: "Go home",
        page_number: 3
      }
    ]
  },
  {
    description: "Class is canceled!",
    options: [
      {
        text: "Go home",
        page_number: 3
      }
    ]
  }
]

#############
# Game Play #
#############

# Infinite Loop!
while true do

  current_page = pages[@current_page_number]
  puts current_page[:description]
  current_page[:options].each do |option|
    puts "#{option[:page_number]}) #{option[:text]}"
  end

  print "~> "
  user_input = gets.chomp
  if (user_input)
    evaluate_user_input(user_input)
  end

  puts "-------------"

end

puts "Goodbye!"