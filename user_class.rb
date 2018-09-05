require "json"


#Creating a user class. This will have varoius funcions in it, and will use recursion to go through all necessary functions. It can be called using 'login_screen' which will go through the functions and bring the user of the app to the class
class User
    attr_accessor :name, :username, :password, :high_score

    @users = []

    #All class functions. These are kept here to use their functions, without creating a new instance of the User class
    class << self
        
        #A function to store all instances of User
        def all
			@users
        end
        
        #A function to display the names of all registered users
        def display_all_names
            @users.each do |user|
                puts user.name
            end
        end

        #FIXME: Stylise screen if theres time
        def login_screen
            puts "Welcome to Trivia Newtown John"
            puts "Please select an option"
            puts "[1] New User"
            puts "[2] Returning User"
            puts "[3] Exit"
            user_decision = gets.chomp.downcase
            if user_decision == '1'
                discover_user_information
            elsif user_decision == '2'
                login
            else
                puts "See you next time!"
                exit
            end
        end

        #This gets user to enter in their first_name, username and password. The username is taken to the function 'username_exist?' to see if the name is unique, or if it has been used before. On the last line, it calls the 'User.new' to create a new instance of the class User
        def discover_user_information
            puts "What is your first name?"
            @name = gets.chomp.capitalize
            puts "Hi #{@name}. What would you like to select for your username?"
            @username = gets.chomp.downcase
            username_exist?
            puts "#{@username}, an excellent choice! "
            puts "#{@name}, the last thing we need from you is a password. Make sure its unique, but something you'll remember."
            @password = gets.chomp
            puts "Alrighty. Your account has been created, and you are ready to go!"
            user = User.new(@name, @username, @password)
        end

        #Runs a while loop to see if @username file exists. If it exists, its already been taken, and the user must select another...if it doesn't exist, it goes back to the 'discover_user_function'
        def username_exist?
            while File.exist?("userDetails/#{@username}.json") == true
                puts "Sorry #{@first_name}, the username '#{@username}' is taken. Please try another."
                @username = gets.chomp.downcase
            end
        end

        #A function for returning users. Asks the user for their username, which is checked to see if it exists. If it does exist, they can move on to entering their password. If it doesn't exist, the user has the option of typing 'exit' to leave the app, or re-entering their username. The function then calls on 'load_data' to get the user's password, so that their inputted password can be checked agaisnt actual password. If it all passes the test, it takes the user to the menu
        def login 
            puts "Please enter your unique username or 'exit' to leave the app"
            username = gets.chomp.downcase
            if File.exist?("userDetails/#{username}.json") == true
                puts "Success! Username #{username} exists!"
                @username = username
            elsif username == 'exit'
                exit
            else
                puts "Unfortunately that username does not exist."
                sleep(2)
                login
            end
            load_data
            puts "Welcome back #{@first_name}!"
            puts "Please enter your password."
            password_check = false
            while password_check == false
                password = gets.chomp
                if password == @password
                    puts "Great success! Password validated!"
                    sleep(2)
                    password_check = true
                else
                    puts "Unfortunately, the password didn't match the one on file. Please try again. "
                    sleep(2)
                end
            end
            Quiz.menu
        end

        #Creates an array to store user data from their '@username.json' file. This is used to get their value for @username, @first_name, @password and @high_score
        def load_data
            user_hash = []
            File.open("userDetails/#{@username}.json", 'r') do |f|
              f.each_line do |line|
                user_hash.push(JSON.parse(line))
              end
            end
            @first_name = user_hash[0]["first_name"]
            @username = user_hash[0]["username"]
            @password = user_hash[0]["password"]
            @high_score = user_hash[-1]["high_score"]
        end
    end

    #The initialize function that is only called if the user has been verified as a new user. It then sends the user to 'add_user_details_to_file'
    def initialize name, username, password
        @name = name
        @username = username
        @password = password
        @high_score = 0
        self.class.all << self
        add_user_details_to_file
        #name = Quiz.new
    end

    #This gets the user's details using the 'user_details' function and sends them to a file, saved with their unique username. After doing this, it points the user to the menu
    def add_user_details_to_file
        user_details
        File.open("userDetails/#{@username}.json", 'a') do |f|
            f.puts JSON.generate(@user_data)
        end
    end

    #Gathers user details as a hash to send to their unique file
    def user_details
        @user_data = Hash.new
        @user_data["username"] = @username
        @user_data["password"] = @password
        @user_data["first_name"] = @name
        @user_data["high_score"] = @high_score
    end
end