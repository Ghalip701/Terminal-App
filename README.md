# Terminal-App MVP

Our MVP has changed as we made our way through the creation of the app. Initially, we had planned a pool of 20 questions, which would be randomized and used to ask users various questions on the capital cities of the data set. 

{INSERT SCREENSHOT}

This was our initial code. Which would have been 20X as long, had we used our whole data set on it. So we progressed onto a dictionary, but had troubles randomising it. Here is our hash. We managed to randomise it using "original_hash.to_a.sample(n).to_h". This worked fine randomising the keys, but made it impossible to reference their value

{INSERT SCREENSHOT}

So we searched the web for some ruby gold, and came across a file with every country in the world, and their respective capital cities, represented as JSON in a file. We were able to read the file, and turn the JSON into a HASH, which we were then able to randomise, and ask the user for their answer, while still being able to compare it to the respective capital

{INSERT SCREENSHOT OF APP IN ACTION}