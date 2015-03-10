
--General definitions
local len = string.len
local char = string.char
local sub = string.sub
local tostring = tostring

--Split a string into an array of characters
local function get_characters(str)
	local characters = {}
	for i = 1, len(str) do
		characters[i] = sub(str, i, i)
	end
	return characters
end

--The CharHub Class
local CharHub = {}
local CharHub_MT = { __index = CharHub }

--CharHub constructor
function CharHub.new()
	local hub = {}
	for i = 0, 255 do
		hub[char(i)] = {}
	end
	setmetatable(hub, CharHub_MT)
	return hub
end

--Add a string and value to the list
function CharHub.add(hub, key, value)
	--Make sure the input is a string
	key = tostring(key)
	
	--Break it into characters
	local characters = get_characters(key)
	
	--Next we are going to add the characters to the character list
	--in reverse order so that be can keep a linked list in the 
	--correct direction. nxt is the link, and index is the full
	--key and value pair added to every link for identification.
	local nxt
	local index = {
		key = key;
		value = value;
	}
	
	--From the last character to the first
	for i = #characters, 1, -1 do
		--Create a link
		nxt = {
			char = characters[i];
			nxt = nxt;
			index = index;
		}
		
		--Add the link to the correct character's array in the hub
		local char = hub[char]
		char[#char+1] = nxt
	end
end

function CharHub.search(hub, key)
	--Make sure the key is a string
	key = tostring(key)
	
	--Break the key into a character array
	local characters = get_characters(key)
	
	--Setup the results table. This could be optimized.
	local results = {}
	for i = 1, len(key)^2 do
		results[i] = {}
	end
	
	--for each character
	for i = 1, #characters do
		--Setup and array of all words containing that letter
		local temp_results = hub[characters[i]]
		
		--for each word containing the letter
		for j = 1, #temp_results do
			
			--Find the score of the word by counting how many 
			--consecutive letters there are
			local result = temp_results[j]
			
			--For the rest of the characters in the key
			for k = i + 1, #characters + 1 do
				
				--get the next character in the word and check 
				--if it matches
				local nxt = result.nxt
				
				--If it matches, go to the next character
				if nxt and nxt.char == characters[k] and nxt.char then
					result = nxt
					
				--If not, add the score to the word
				else
					local index = result.index
					--If the word has already been scored, add the two scores
					if results[index] then
						local n = results[index]
						results[index] = n + k - 1
						results[n][index] = nil
						results[n+k-1][index] = true
						
					--Otherwise just set the score
					else
						results[index] = k-1
						results[k-1][index] = true
					end
					
					--And continue onto the next word or character in the key
					break
				end
			end
		end
	end
	
	--Finally, clean up the table of results
	for key, val in next, results do
		if type(val) == "number" or not next(val) then
			results[key] = nil
		end
	end
	
	--And return it
	return results
end

return CharHub
