local Shifty = game:GetService("ReplicatedStorage"):WaitForChild("Shifty")

local Rubbish = {}
Rubbish.LeaveDumpTrace = false
Rubbish.ForgetBinsOnCleared = false

Rubbish.__index = Rubbish

function Rubbish.bin()
	return setmetatable(Rubbish, {	__call = function(self, def, state)
		assert(def, ("Rubbish.bin() - You did not call a definer!"))
		assert(state, ("Rubbish.bin() - You did not call a statement!"))
		self[def] = state
		if Rubbish.LeaveDumpTrace then
			print(("Connected %s into bin."):format(def))
		end
		return self[def]
	end,	
			})
end
if then
function Rubbish:Empty()
	assert(self, ("Rubbish:Empty() - Impossible empty request, attempted to empty nil, need binclass. [local MyBin = Rubbish.bin() MyBin:Empty()]"))
	for def, state in pairs(self) do
		if typeof(state) == "RBXScriptConnection" then
			state:Disconnect()
			if Rubbish.LeaveDumpTrace then
				print(("Disconnected %s"):format(def))
			end
			def = nil
		end
	end
	
	if Rubbish.ForgetBinsOnCleared then
		for i, _ in pairs(self) do
			i = nil
		end
		if Rubbish.LeaveDumpTrace then
			print("Forgot bin, emptied!")
		end
	end
end

return Rubbish
