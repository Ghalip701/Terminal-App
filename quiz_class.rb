require_relative "user_class"
require 'io/console' 

class Quiz

    class << self 
            
        def menu
            system("clear")
            puts "Welcome to Trivia Newtown John"
            puts "Please select an option"
            puts "[1] Try a quiz"
            puts "[2] View the leaderboard"
            puts "[3] Exit"
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

        #Eventually add a feature where they can choose between 5,10 and 20 questions. Then have a leaderboard to match each of those numbers
        def quiz_function
            read_data_from_file

            #establish an array to hold the randomised keys of our hash. The purpose of this, is to ensure that every key is unique, so the user is not being asked the same country repeatadly
            randomised_capitals = []
            n = 5
            @count = 0

            #time-loop to go through our hash n times. It generates a random integer between 0 and the length of the hash, and uses that integer to chose a country. The user is asked for the capital of that country, with their answer checked, and the appropriate message dispalyed. An array is used to store the value of the countries that have been randomly generated. This is to ensure there is no duplication. The length of unique is compared to the length of the array. If they are not equal, there is a duplicate. The last value is popped out, and a new country is put in. This is repeated until all are unique
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
                matching_capital = @countries_capitals_as_hash[random_index_number]["city"]
                puts "What is the Capital of #{randomised_capitals[-1]}?"
                answer = gets.chomp.capitalize
                if answer == matching_capital
                    @count += 1
                    puts "Good Job!"
                    puts "Total correct answers: #{@count}"
                else
                    puts "Try again!"
                    puts "The correct answer was #{matching_capital}"
                end
                puts "#########################"
            end
            result
            menu
        end

        #This grabs the JSON from 'condensed_capitals.JSON' and converts it to a hash. The hash is saved in a class-instance variable, so that it is accessible across the rest of this instance
        def read_data_from_file
            file = File.read("condensed_capitals.json")
            @countries_capitals_as_hash = JSON.parse(file)
        end

        def result
            puts "Congratulations! You got #{@count} answers correct!"
            puts "Please confirm your username below to get added to the leaderboard: "
            username = false
            while username == false
                @confirm_username = gets.chomp.downcase
                if File.exist?("userDetails/#{@confirm_username}.json") == true
                    username = true
                else 
                    puts "Thats not the same username you logged in with. Please try again. "
                end
            end
            send_to_leaderboard
            send_to_file
        end

        def send_to_leaderboard
            #Send user data and score to leaderboard...and time in the future?
            new_score = Hash.new
            new_score["username"] = @confirm_username
            new_score["score"] = @count
            File.open("userDetails/leaderboard.json", "a") do |f|
                f.puts JSON.generate(new_score)
            end
        end

        def send_to_file
            #Send high score to users own file
            user_score = Hash.new
            user_score["high_score"] = @count
            File.open("userDetails/#{@confirm_username}.json", "a") do |f|
                f.puts JSON.generate(user_score)
            end
        end

        def display_leaderboard
            puts "##############################"
            puts "#  L E A D E R B O A R D "
            puts "#-----------------------------"
            puts "#         |                                   "
            puts "#  SCORE  | USERNAME          "
            puts "#         |                                   "
            leaderboard_info
            puts "#                                             "
            puts "##############################" 
            any_key
            menu
        end

        def leaderboard_info
            user_hash = []
            File.open("userDetails/leaderboard.json", 'r') do |f|
                f.each_line do |line|
                    user_hash.push(JSON.parse(line))
                    # puts "#     #{user_hash[-1]["score"]}   | #{user_hash[-1]["username"]}     "
                end
            end
            sorted_user_hash = user_hash.sort_by { |k| k["score"]}
            sorted_user_hash.reverse!
            i = 0
            while i < sorted_user_hash.length do
                puts "#     #{sorted_user_hash[i]["score"]}   | #{sorted_user_hash[i]["username"]}  "
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


end

#NOTES!!!!
#Have user enter username when they get their score 
#Have users individual high score stored in their file
#Regex to accept answers that have two words