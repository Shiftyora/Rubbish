--[[
Shifty is a multi-purpose module loader which supports custom module integration, 
workspace set-up, replicating modules/folders & content importing.

Shifty API:

Shifty :ImportModule(): string ~~ (does not accept paths!)
- Imports a Module from the Shifty librar, custom integrated library, or player modules (IfClient()!).
~ local Random = Shifty:ImportModule("Random")
~ local BaseCamera = Shifty:ImportModule("BaseCamera")

Shifty :ImportContent(): {}
- Imports content from the ROBLOX Library, this method takes one parametre:
~ Shifty:ImportContent(500) -> "rbxassetid://500"

Shifty :Import(...): Object, Presync
- Imports content from the game, workspace, or any module stored in the game which is accessible to Shifty.

Shifty:Import("myWorkspaceFolder/MyPart", false) -> MyPart from myWorkspaceFolder

------------
------------

Shifty's Integrate feature has been deprecated, its source still remains in the sub-files however are outdated and defunct!

]]

local Replication_Folder_Data = "_shiftyReplicated:"
--script.Parent.ClassName = "ShiftyModuleLoader"

local ReplicateModule = require(script:WaitForChild("ReplicateModuleFile"))
local ReplicateFolders = require(script:WaitForChild("ReplicateFoldersUtils"))
local ImportModulesUtils = require(script:WaitForChild("ImportModulesUtils"))

local Shifty = {
	WaitOutTime = 1,
	PresyncContentLoading = false,
	LoadAllModulesOnFocus = true,
}

function Shifty:ImportModule(Module)
	local TimeOut = Shifty.WaitOutTime or 1
	
	if typeof(Module) == "string" then
		return ImportModulesUtils.__loadFromRequest(Module, TimeOut)
	else
		error(("Bad ImportModule argument got %s expected string."):format(Module))
	end
end

function Shifty:ImportContent(Content)
	return ImportModulesUtils.__loadContent(Content)
end

function Shifty:Import(Path, Presync)
	if not Presync then
		return ImportModulesUtils.__loadAsset(Path, false)
	else
		return ImportModulesUtils.__loadAsset(Path, Presync)
	end
end

if Shifty.LoadAllModulesOnFocus then
	ImportModulesUtils.__loadAll()
end

function Shifty:IntegrateModule(Module)
	--[[if typeof(Module) == "Instance" then
		if Shifty:Import("ServerScriptService/Shifty"):FindFirstChild("IntegratedModules") then
			local LibraryImportLocation = Shifty:Import("ServerScriptService/Shifty"):FindFirstChild("IntegratedModules")
			Module.Parent = LibraryImportLocation
		else
			local LibraryImportLocation = Instance.new("Folder", Shifty:Import("ServerScriptService/Shifty"))
			LibraryImportLocation.Name = "IntegratedModules"
			
			Module.Parent = LibraryImportLocation
		end
	else
		warn("IntegrateModule does not take string or number/external require.")
	end]]
	
	error("This method has been deprecated, please manually add your module to Shifty's [Integrated] Folder.")
end

function Shifty:IntegrateLibrary(Library)
	--[[if typeof(Library) == "Instance" then
		if Library:IsA("Folder") then
			if Shifty:Import("ServerScriptService/Shifty"):FindFirstChild("IntegratedLibraries") then
				local LibraryImportLocation = Shifty:Import("ServerScriptService/Shifty"):FindFirstChild("IntegratedModules")
				Library.Parent = LibraryImportLocation
			else
				local LibraryImportLocation = Instance.new("Folder", Shifty:Import("ServerScriptService/Shifty"))
				LibraryImportLocation.Name = "IntegratedModules"

				Library.Parent = LibraryImportLocation
			end
		elseif Library:IsA("Model") then
			for _, LibraryObj in ipairs(Library:GetDescendants()) do
				
			end
		end
	end]]
	error("This method has been deprecated, please manually add your library to Shifty's [Integrated] Folder.")
	
end

function Shifty:GetRepData()
	return Replication_Folder_Data
end

return Shifty
