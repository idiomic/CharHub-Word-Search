# CharHub-Word-Search
This is a custom made word searching algorithm. I was on the Roblox forums one day helping people when someone mentioned how hard it would be to create a phrase search on roblox. I took up the challenge and created this in a few hours without researching the topic. I did not create this with any previous knowledge of character searching algorithms. It linked lists out of the characters in words and puts the links into a corrisponding character array. When a word is searched, it iterates through each letter and gets every wording containing each letter from the character arrays. Next, it runs along the word checking how many consecutive characters match. Finally it adds the word the its score to a results array. The word may match more letters and the score will be updated. The higher the score, the better. It returns a table of results each with the key, score, and the value assigned. It can handle duplicate words. Here is example output. Note that all the words had a test value of 1.

Words: "Testi1ng", "Tesng", "Te687ti1ng", "4sti1ng", "Test679564", "Te45774ng", "Ti1ng", "Te2st4i1ng", "Testing", Tecdi1ng"
Key: Testing
Results:

Score = 16 --THE WORST SCORE
Test679564 1 --Key, Value
 
Score = 18
Te45774ng 1
 
Score = 20
Ti1ng 1
 
Score = 23
Tesng 1
Tecdi1ng 1 --Note: two keys scored the same value here
 
Score = 28
Te687ti1ng 1
 
Score = 29
4sti1ng 1
 
Score = 31
Te2st4i1ng 1
 
Score = 39
Testi1ng 1
 
Score = 49 --THE BEST SCORE
Testing 1
