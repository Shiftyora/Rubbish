![Rubbish (1)](https://user-images.githubusercontent.com/110542397/182639062-9979ce72-fadd-4769-8947-2e1186edae3c.png)

# Rubbish 
Rubbish is a bin collector to help prevent [memory/resource leaks](https://en.wikipedia.org/wiki/Memory_leak) by managing connections in designated bins.

### Installation
Rubbish can be installed by downloading the following file.
Shiftyora's Rubbish | Lastest Update [Version:0.1.0] |
--- | --- |
Source | [v0.1.0](https://github.com/Shiftyora/Rubbish/files/9252559/Shiftyora-Rubbish.zip) |

### API Manual

The **Rubbish Module** can be required just like any other, but be careful, this is _not how you use Rubbish Methods_!
```lua
local Rubbish = require(...)
```

### `Rubbish.bin()`
The Rubbish Module is built on things called _bins_, or _trash cans_. You store your connections in this bin and you can empty it when you are done.
```lua
local Rubbish = require(...)

local MyBin = Rubbish.bin()

-- You can create as much bins as you want!
local GreenTeamBin = Rubbish.bin()
local RedTeamBin = Rubbish.bin()
```


### `RubbishBin(...)`
The RubbishBin call is used for integrating connections into your bin.
```lua
local Rubbish = require(...)
local MyBin = Rubbish.bin()

MyBin("ConnectionName", game.Players.PlayerAdded:Connect(function(Player)
  print(("%s has joined!"):format(Player.Name))
end))
```

### `RubbishBin:Empty()`
Done with those connections, throw it away and keep your memory being handled correctly.
```lua
local Rubbish = require(...)
local PlayerBins = Rubbish.bin()

PlayerBins("PlayerAdded", 
  game.Players.PlayerAdded:Connect(function(Player)
    print(("%s Player Joined"):format(Player.Name))
  end)
)

task.wait(10)

PlayerBins:Empty() -- The "PlayerAdded" connection will no longer work.
```
You can store _multiple_ connections in the same bin.
```lua
local Rubbish = require(...)
local PlayerBins = Rubbish.bin()

PlayerBins("PlayerAdded", 
  game.Players.PlayerAdded:Connect(function(Player)
    print(("%s Player Joined"):format(Player.Name))
    
    PlayerBins("PlayerChatted", Player.Chatted:Connect(function(Message) print(("Player said %s"):format(Message)) end))
  end)
)

PlayerBins("PlayerRemoved",
  game.Players.PlayerRemoving:Connect(function(Player)
    print(("%s Player Removed"):format(Player.Name))
  end)
end))

task.wait(10)

PlayerBins:Empty() -- The "PlayerAdded", "PlayerRemoved" & "PlayerChatted" connections will no longer work.
```

### Deprecated

### `RubbishBin:CreateVariableSignal(): {}`
Empties Bin one remote signal. __This was deprecated due to having to replicate on the client, and can be easily replicated in a Script.__
```lua
local Rubbish = require(...)
local BackToLobby : RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("BackToLobby")
local TeamBins = Rubbish.bin()

TeamBins("TeamChanged", 
  Player.Team.Changed:Connect(function()
    print("Team Changed")
  end)
end)

TeamBins:CreateVariableSignal({
  SignalType = "RemoteEvent",
  SignalReceiver = BackToLobby
}) -- When BackToLobby is fired, TeamBins is emptied.
```

### `Rubbish.dump(): {}`
Creates a dumpsite to empty several bins at once. __May add unnecessary memory to the Rubbish Module.__
```lua
local Rubbish = require(...)

local myRubbishSite = Rubbish.dump({
  GreenBin = Rubbish.bin(),
  BlueBin = Rubbish.bin(),
  BlackBin = Rubbish.bin(),
})

myRubbishSite.GreenBin("PlayerAdded", ...)
myRubbishSite.BlueBin("PlayerRemoving", ...)
myRubbishSite.BlackBin("PlayerChatted", ...)

myRubbishSite:Melt() -- Empties all bins associated.
```
