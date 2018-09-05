#This file contains the quiz class. It is called once a user has logged in or registered. It begins by showing the menu of possible options a user can choose. They can attempt a quiz, view the leaderboard or exit. The class uses recursion, so it will keep repeating, until the user selects exit
#require io/console to make the 'any_key' function run
require 'io/console' 

class Quiz

    class << self 
            
        #Prints a menu of possible user selections. Depending on user input, they will be sent to the quiz or the leaderboard or they will exit. Through recursion, this menu will be called at the en of a method, so the app will not finish, until the user exits
        def menu 
            system("clear")
            puts "###################################".red
            puts "#         Hi #{@@name}             ".red
            puts "#  Welcome to TRIVIA NEWTON JOHN  #".red
            puts "#                                 #".red
            puts "#    Please select an option:     #".red
            puts "#    [1] Try a quiz               #".red
            puts "#    [2] View the Leaderboard     #".red
            puts "#    [3] Exit                     #".red
            puts "#                                 #".red
            puts "###################################".red
            user_decision = gets.chomp.downcase
            if user_decision == '1'
                quiz_function
            elsif user_decision == '2'
                display_leaderboard
            elsif user_decision == '3'
                exit
            else 
                puts "Check your input and try again"
                sleep(2)
                menu
            end
        end

        #FIXME: Eventually add a feature where they can choose between 5,10 and 20 questions. Then have a leaderboard to match each of those numbers
        #This function is the quiz. It begins by reading the capital cities from a json file. Then cycles through randomised values to ask the user for the capital cities of certain countries.
        def quiz_function
            read_data_from_file

            #establish an array to hold the randomised keys of our hash. The purpose of this, is to ensure that every key is unique, so the user is not being asked the same country repeatadly
            randomised_capitals = []
            n = 10
            @count = 0

            #time-loop to go through our hash n times. It generates a random integer between 0 and the length of the hash, and uses that integer to chose a country of that index. An array is used to store the value of the countries that have been randomly generated. This is to ensure there is no duplication. The length of unique is compared to the length of the array. If they are not equal, there is a duplicate. The last value is popped out, and a new country is put in. This is repeated until all are unique
            n.times do
                random_index_number = rand(@countries_capitals_as_hash.length-1)
                randomised_capitals << @countries_capitals_as_hash[random_index_number]["country"]
                unique_array = false
                while unique_array == false do
                    if randomised_capitals.uniq.length == randomised_capitals.length
                        unique_array = true
                    else
                        randomised_capitals.pop
                        random_index_number = rand(@countries_capitals_as_hash.length-1)
                        randomised_capitals << @countries_capitals_as_hash[rand(@countries_capitals_as_hash.length-1)]["country"]
                    end
                end

                #The user is asked for the capital of the randomised country, with their answer checked, and the appropriate message dispalyed. If they are correct, the count variable will increment by 1. The function then calls result, so that the user can save the result
                system("clear")
                matching_capital = @countries_capitals_as_hash[random_index_number]["city"]
                puts "##################################"
                puts "#                                 "
                puts "#  What is the Capital of "
                puts "#  #{randomised_capitals[-1]}? "
                puts "#"
                puts "##################################"
                puts ""
                answer = gets.chomp.capitalize
                if answer == matching_capital
                    @count += 1
                    puts "Correct!"
                    puts "Total correct answers: #{@count}"
                else
                    puts "Incorrect. Better luck next time!"
                    puts "The correct answer was #{matching_capital}"
                end
                puts ""
                any_key
            end
            result
            menu
        end

        #This grabs the JSON from 'condensed_capitals.JSON' and converts it to a hash. The hash is saved in a class-instance variable, so that it is accessible across the rest of this instance
        def read_data_from_file
            file = File.read("condensed_capitals.json")
            @countries_capitals_as_hash = JSON.parse(file)
        end

        #Display the user's name and results. Calls upon the function send_to_leaderboard and send_to_file to store the score
        def result
            system("clear")
            puts "##############################"
            puts "# Congratulations #{@@name}!  " 
            puts "#                            #"
            puts "# You got #{@count} answers correct! #"
            puts "#                            #"
            puts "#   Check the leaderboard    #"
            puts "#     to see if you made     #"
            puts "#        the top 10!         #"
            puts "#                            #"
            puts "##############################"
            any_key
            send_to_leaderboard
            send_to_file
        end

        #convert date, username and score, from a hash, to a json, then append to the leaderboard file. This will keep track of all scores attempted by all users
        def send_to_leaderboard
            @date = Time.now.strftime("%d/%m/%Y")
            @new_score = Hash.new
            @new_score["date"] = @date
            @new_score["username"] = @@username
            @new_score["score"] = @count
            File.open("userDetails/leaderboard.json", "a") do |f|
                f.puts JSON.generate(@new_score)
            end
        end

        #Send date, username and score to users own file. This will come in handy later, when a feature is implemented for users to check their own best scores
        def send_to_file
            File.open("userDetails/#{@@username}.json", "a") do |f|
                f.puts JSON.generate(user_score)
            end
        end

        #A basic display for the leaderboard. It sends users to the leaderboard_info function, where the data is filled. At the end of the function, the any_key function is called, so nothing will happen until the user touches a key, then the menu is called for recursion
        def display_leaderboard
            system("clear")
            puts "##############################"
            puts "#  L E A D E R B O A R D "
            puts "#-----------------------------"
            puts "#            |       |         "
            puts "#    DATE    | SCORE | USERNAME "
            puts "#------------|-------|----------"
            leaderboard_info
            puts "#                              "
            puts "##############################" 
            any_key
            menu
        end

        #The leaderboard file is read, and each line is added to our new empty array - user_hash. This hash is then sorted by 'score', reversed and sliced, so the top 10 scores will remain. The remaining array will be passed through a while loop, with each element of each line being printed. Its done this way, so that the leaderboard will never exceed 10. If there are less than 10, its set up in such a way that an error will not be thrown
        def leaderboard_info
            #ADD rspec test here, so if there is no file, it goes to rescue
            user_hash = []
            File.open("userDetails/leaderboard.json", 'r') do |f|
                f.each_line do |line|
                    user_hash.push(JSON.parse(line))
                end
            end
            sorted_user_hash = user_hash.sort_by { |k| k["score"]}
            top_ten_scores = sorted_user_hash.reverse!.slice(0,9)
            i = 0
            while i < top_ten_scores.length do
                puts "# #{sorted_user_hash[i]["date"]} |   #{sorted_user_hash[i]["score"]}   | #{sorted_user_hash[i]["username"]}  "
                i += 1
            end   
        end

        #Function where the user can press any key to continue
        def any_key
            puts ""
            puts "Press any key to continue.."
            STDIN.getch
        end

      

    end

    def initialize username, name
        @@username = username
        @@name = name
        Quiz.menu
    end


end

#NOTES!!!! 
#Have users individual high score stored in their file
#Regex to accept answers that have two words