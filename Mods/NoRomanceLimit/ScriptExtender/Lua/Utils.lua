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

-- avatarName = nil
function getAvatar()
    -- if avatarName == nil then
        ---- by changing the  first [i] from [1] to [2], the avatar printed is the second avatar in the squadlist; in this case, chugg.
        -- avatarName = Osi.DB_Avatars:Get(nil)[1][1]
    -- end
    avatarName = GetHostCharacter()
    return avatarName
end

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
    
    -- TESTING
    for k, v in pairs(squad) do
        print(k .. " = " .. v)
    end

    return squad
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
    for i, val in ipairs(origin_names) do
        print(string.format("%s: Date %s partner %s (stash Rela %s Date %s)", 
        origin_names[i], GetFlag(date_flags[i], getAvatar()), GetFlag(partner_flags[i], getAvatar()), PersistentVars[i], PersistentVars[i+12]))
    end
    print(string.format("partnered %s", GetFlag(isPartneredFlag, getAvatar())))
    if FullPrint then
        _D(PersistentVars)
    end
end

function FixPersistentVars()
    local refPVars = {false, false, false, false, false, false, false, false, false, 0, false, false} 
    if not PersistentVars or  #PersistentVars < #refPVars then
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