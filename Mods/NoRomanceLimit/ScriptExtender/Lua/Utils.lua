function GetGloFlag(flag)
    return #Osi.DB_GlobalFlag:Get(flag) > 0 
end
function stripUUID(strin)
    return string.sub(strin, 1,  -38)
end
-- EVULBAD ADDTION
function stripUUIDString(strin)
    return string.sub(strin, 1,  -38)
end
function isInList(target, list)
    for _, value in ipairs(list) do
        if value == target then
            return true
        end
    end
    return false
end

function isSublistInListOfLists(sublist,listOfLists, ignorelist)
    if not ignorelist then
        ignorelist = {}
    end

    for _, list in ipairs(listOfLists) do
        local sublistMatch = true

        -- Check if the sublist is present in the list
        for i, item in ipairs(sublist) do
            if list[i] ~= item and not(isInList(i, ignorelist)) then
                sublistMatch = false
                break
            end
        end

        if sublistMatch then
            return true
        end
    end
    return false
end

-- EVULBAD REMOVAL
-- avatarName = nil
-- this function isn't all that useful anymore now that i'm going off of GetHostCharacter() and PlayerStash.
-- function getAvatar()
    -- EVULBAD REMOVAL
    -- if avatarName == nil then
        ---- by changing the  first [i] from [1] to [2], the avatar printed is the second avatar in the squadlist; in this case, chugg.
        -- avatarName = Osi.DB_Avatars:Get(nil)[1][1]
    -- end
    -- EVULBAD REMOVAL

--    avatarName = GetHostCharacter()
--    return avatarName
-- end

-- EVULBAD ADDITION
-- gets all playable characters.
function GetSquad()
    local squad = {}
    local players = Osi.DB_Players:Get(nil)
    for _, player in pairs(players) do
        table.insert(squad, player[1])
    end
    local origins = Osi.DB_Origins:Get(nil)
    for _, origin in pairs(origins) do
        table.insert(squad, origin[1])
    end
    
    local seen = {}
    local i = 1
    while i <= #squad do
        if seen[squad[i]] then
            table.remove(squad, i)
        else
            seen[squad[i]] = true
            i = i + 1
        end
    end

    return squad
end

-- returns true is uuid is in IgnorePlayerList.
function IsIgnoredPlayer(uuid)
    playerIgnore = false

    for index, value in ipairs(IgnorePlayerList) do
        if value == uuid then
            playerIgnore = true
        end
    end

    return playerIgnore
end

-- for parsing a substring in GetPlayerInDialog.
function EscapePattern(pattern)
    if pattern == nil then
        return GetHostCharacter()
    end

    return pattern:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
end

-- the "Osi.DialogGetInvolvedPlayer(instanceid, 2)" function returns the uuid without the part with the text player description. this remedies that.
function GetPlayerInDialog(instanceid)
    local substring = Osi.DialogGetInvolvedPlayer(instanceid, 2)
    local escapedSubstring = EscapePattern(substring)

    for index, value in ipairs(PlayerStash) do
        if string.find(value, escapedSubstring) ~= null then
            return value
        end
    end
end

-- for retrieving flag stashes.
function GetFlagStash(uuid)
    playerIgnore = false

    for index, value in ipairs(IgnorePlayerList) do
        if value == uuid then
            playerIgnore = true
        end
    end

    if playerIgnore == false then
        for _, entry in ipairs(flagStashList) do
            if entry[1] == uuid then
                return entry[2]
            end
        end
    end
end
-- EVULBAD ADDITION

function mergeLists(list1, list2)
    local merged = {}
    
    for _, v in ipairs(list1) do
        table.insert(merged, v)
    end
    
    for _, v in ipairs(list2) do
        table.insert(merged, v)
    end
    
    return merged
end

function DPrintAll()
    if FullPrint then
        PrintAll()
    end
end

function PrintAll()
    for index, uuid in ipairs(PlayerStash) do
        print(index, uuid)
        playerIgnore = false

        for index, value in ipairs(IgnorePlayerList) do
            if value == uuid then
                playerIgnore = true
            end
        end

        if playerIgnore then
            print("player in ignore list. skipping")
        else
            for i, val in ipairs(origin_names) do
                print(string.format("%s: date %s, rela %s", 
                origin_names[i], GetFlag(date_flags[i], uuid), GetFlag(partner_flags[i], uuid)))
            end
            print(string.format("partnered %s", GetFlag(isPartneredFlag, uuid)))
            if FullPrint then
                _D(PersistentVars)
            end
        end
    end
end

function FixPersistentVars()
    local refPVars = {false, false, false, false, false, false, false, false, false, 0, false, false} 
    if not PersistentVars or #PersistentVars < #refPVars then
        for i, value in ipairs(PersistentVars) do
            refPVars[i] = value
        end
        PersistentVars = refPVars
    end
end

function DPrint(str)
    if FullPrint then
        _D(str)
    end
end

function DTraceback()
    DPrint(debug.traceback())
end