require "json"
require_relative "user_class"
#This is the 'main' file that will run our application. It grabs the JSON from 'condensed_capitals.JSON' and converts it to a hash. The user is asked for how many questions they'd like to answer, which is used in the 'times-loop' to randomize our hash, and ask the user for the capital cities, of a random assortment of countries. These answers are checked, and a success or fail message follow

login_screen

file = File.read("condensed_capitals.json")
countries_capitals_as_hash = JSON.parse(file)

#establish an array to hold the randomised keys of our hash. The purpose of this, is to ensure that every key is unique, so the user is not being asked the same country repeatadly
randomised_capitals = []

#n will hold the value of the amount of questions the user wants to answer, which is then sent down to our 'times-loop'
#FIXME: In a later version, we could implement a maximum amount of questions, and to ensure they only enter a number
puts "How many questions do you want to answer?"
n = gets.chomp.to_i
    

#time-loop to go through our hash n times. It generates a random integer between 0 and the length of the hash, and uses that integer to chose a country. The user is asked for the capital of that country, with their answer checked, and the appropriate message dispalyed. An array is used to store the value of the countries that have been randomly generated. This is to ensure there is no duplication. The length of unique is compared to the length of the array. If they are not equal, there is a duplicate. The last value is popped out, and a new country is put in. This is repeated until all are unique
count = 0
n.times do
    random_index_number = rand(countries_capitals_as_hash.length-1)
    randomised_capitals << countries_capitals_as_hash[random_index_number]["country"]
    unique_array = false
    while unique_array == false do
        if randomised_capitals.uniq.length == randomised_capitals.length
            unique_array = true
        else
            randomised_capitals.pop
            random_index_number = rand(countries_capitals_as_hash.length-1)
            randomised_capitals << countries_capitals_as_hash[rand(countries_capitals_as_hash.length-1)]["country"]
        end
    end
    matching_capital = countries_capitals_as_hash[random_index_number]["city"]
    puts "What is the Capital of #{randomised_capitals[-1]}?"
    answer = gets.chomp.capitalize
    if answer == matching_capital
        count += 1
        puts "Good Job!"
        puts "Total correct answers: #{count}"
    else
        puts "Try again!"
        puts "The correct answer was #{matching_capital}"
    end
    puts "#########################"
end


#BETWEEN lines 34 and 29, see if you can come up with a method to count the user's score. Check out google for examples
#SET up a class for user, that will use recursion to get the user to login