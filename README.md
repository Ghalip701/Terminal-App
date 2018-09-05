##### Link to github: https://github.com/Ghalip701/Terminal-App

# **Trivia Newton John**

## **By Hamish Lees and Ghalip Yakob** ##
   
## **INFORM. EDUCATE. ENTERTAIN**

#### Welcome screen from app:

![Image of Welcome Screen](https://github.com/Ghalip701/Terminal-App/blob/master/docs/Welcome%20Screen.png)

# **Purpose**
##### We developed this app to assist high school students in gaining more knowledge about the Capitals of  Countries through an interactive quiz.

# **Functions** 
##### Students will have the option to register if they are a new user, or enter their details if they are returning. Students will then be taken to the menu, which will give them the opportunity to complete a quiz and have their score saved, to check the leaderboard, or to exit. Being able to view scores will create an element of fun and competitiveness, ensuring our aims are met - INFORM. EDUCATE. ENTERTAIN. 

# **Files**

### 1. main.rb - the file to run the app

### 2. user_class.rb - a class that allows the user to register or login

### 2. quiz_class.rb - a class to run the quiz, using the user's information 

#### Menu:

![Image of Menu](https://github.com/Ghalip701/Terminal-App/blob/master/docs/menu.png)


# **Instructions for use**
### 1. Perform < git clone https://github.com/Ghalip701/Terminal-App > 
### 2. Run the 'main.rb' file from terminal using the command 'ruby main.rb'
### 3. Choose the option for new user and enter your details

#### Login Screen:

![Image of Login Screen](https://github.com/Ghalip701/Terminal-App/blob/master/docs/create_username.png)

### 4. Try a quiz, and save your score

#### Correct Answer:

![Image of Correct Answer](https://github.com/Ghalip701/Terminal-App/blob/master/docs/correct%20answer.png)

#### Incorrect Answer:

![Image of Incorrect Answer](https://github.com/Ghalip701/Terminal-App/blob/master/docs/incorrect%20answer.png)

### 5. Try beat your score next time!

#### Leaderboard:

![Image of Leaderboard](https://github.com/Ghalip701/Terminal-App/blob/master/docs/leaderboard.png)



# **App User Workflow**

####Trivia Newton John Workflow:

![Image of Workflow](https://github.com/Ghalip701/Terminal-App/blob/master/docs/trivia_newton_john_workflow.png)


# **Planning and Timeline**

###  Day one
##### Initially we has a brainstorming session about what type of App we would be creating. After assessing and discussing all these wonderful options, we landed on the idea of an Educationl Quiz App that we would target towards High school students. We then came up with the purpose and functions of the App: Inform, Educate, Entertain. Everything we added to this app, we wanted to make sure it met either or all of those criteria.
##### Next, we agreed on a MVP. For us, that was to be the following: A pool of 20 countries, with their respective capitals, that a user could access is a quiz format and receive accurate answers. 

### Day two 
##### We completed our MVP in the morning on day 2, after discovering it was much harder than anticipated. We decided to progress our App. This involved downloading a JSON file that had every country in the world, with their respective capitals, in JSON format. We were able to get these into our file in an array that we could randomise, so the user would be asked 10 random capital city questions.
##### With everything functioning, we worked on and implemented a register and login system. This was done by saving user data to a hash, converting that hash to JSON, and saving it in a file, named after the user. Our next step was to create a method to keep track of a user's score, and eventually compare those scores to other users. This proved a bit more difficult than first thought, but we managed to solve it. We saved the user's score, with their username and the time they achieved their score to a file called 'leaderboard.json'. We were than able to sort this file and print out the top 10 results. Later, we will look at implementing a system for users to display their own top 10 scores


# **Brainstorming**

##### The initial brainstorming took place with a bit of good old fashioned pen and paper:

![Image of Brainstorming](https://github.com/Ghalip701/Terminal-App/blob/master/docs/brainstorming.jpg)

##### Once we had selected a capital city trivia game, we created a file called 'ideas.txt', where we both began writing down various ideas for the app:

![Image of Ideas](https://github.com/Ghalip701/Terminal-App/blob/master/docs/ideas1.png)
![Image of Ideas](https://github.com/Ghalip701/Terminal-App/blob/master/docs/ideas.png)

# **Trello Boards**
##### Trello boards were used extensively during the planning process, as we used them to ensure we wouldn't get overwhelmed. When starting a new project, its important to have a visual representation of what needs to be done, for the project to work.

#### Trello board during:
![Image of Trello Board](https://github.com/Ghalip701/Terminal-App/blob/master/docs/Trello%20Board%20-%20during.png)

#### Trello board after:
![Image of Trello Board](https://github.com/Ghalip701/Terminal-App/blob/master/docs/Trello%20Board%20-%20at%20end.png)

# **Ethical Issues**
##### Whilst Trivia Newton John is a socially positive app, helping to educate and entertain it's young users, it still faces an ethical dilemma. The capitals of numerous countries were changed to thei English spelling, for ease-of-use of our initial Australian market. A capital like 'Asunci' or Paraguay has been changed to 'Asuncion'. We are aware that this may offend some, but was a tough business decision we had to make.


# **Scaling**
##### Facebook didn't finish their first release and say, 'We are content as a glorified blogging platform.' No. They went bigger and better. We are no different. Yes, we've created a trivia app to rival names like 'Trivial Pursuit', but, we have plans to go further.


### Categorising the quiz
##### Currently, when a user enters our app, they can receive a question about 'Zambia', followed by a question about 'Canada'. In future releases, we could alter this, so when a user enters the quiz menu, they have additional choices, including 'capitals by continent' and maybe even 'capitals by language'

### Adding More subjects.
##### With a flexible name like 'Trivia Newton John', we are not locked to the idea of only capital cities. We could add many more subjects from all aspects of life - e.g. maths, science, tv shows. This will give the app the depth it would require, to secure more users.

### Augmenting the target segment.
##### Whilst Trivia Newton John is directed toward High School Students, this could be broadened in the future. By saying that, I don't mean just target it to everyone. But we could definitiely target different aspects toward different groups. The educational ones could be more directed to High School Students, whilst the 'hobby' topics could be more directed towards adults, enjoying the quiz in their own leisure.

### Graphics (i.e. an interactive world map)
##### Trivia Newton John is a technically sound app. We know that. But to pull more people in, we would need to improve the user experience. There would be many ways to achieve this, but perhaps most notable would be an interactive map. If you could lay down a 2D map of the world, or region, as an interface, that highlighted which country was being asked, users would flood in.