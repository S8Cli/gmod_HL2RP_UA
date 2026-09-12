
local function localChat(ply, args)
	if args == "" then return "" end
	DarkRP.talkToRange(ply, "[LOOC] "..ply:Nick(), args, 200)
	return ""
end
	 
	 
DarkRP.defineChatCommand("looc", localChat)

local function itChat(ply, args)
	if args == "" then return "" end
	DarkRP.talkToRange(ply, args.." ("..ply:Nick()..")","", 200)
	return ""
end
DarkRP.defineChatCommand("it", itChat)