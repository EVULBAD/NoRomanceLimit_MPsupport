-- these appear to be console commands.
------------------------------
userLUT = {
    {"minthara", eMinthara},
    {"gale", eGale},
    {"wyll", eWyll},
    {"astarion", eAstarion},
    {"karlach", eKarlach},
    {"laezel", eLaezel},
    {"lazel", eLaezel},
    {"shadowheart", eShadowHeart},
    {"halsin", eHalsin}
}
durgeLUT = {
    "",
    "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604",
    "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
    "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255",
    "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c",
    "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12",
    "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679",
    ""
}

function guessEnumFromInput(name)
    name = string.lower(name)
    for k, v in pairs(userLUT) do
        if name == v[1] then
            return v[2]
        end
    end
    for k, v in pairs(userLUT) do
        if string.sub(v[1],1,3) == string.sub(name,1,3) then
            print(string.format("It looks like you are trying to say %s?", v[1]))
            return v[2]
        end
    end
    return nil
end

function Date(name, state, uuid)
    toon = guessEnumFromInput(name)
    if not toon then
        print("unknown input.")
        return
    end
    if toon == eMinthara then
        print("Please, use partnered with minthara instead. Dating Minthara causes problems with other companions' romance progression.")
        return
    end
    if state then
        SetFlag(date_flags[toon], uuid)
        GetFlagStash(uuid)[toon + 10][1] = 1
        -- PersistentVars[toon+10] = true
    else
        ClearFlag(date_flags[toon], uuid)
        GetFlagStash(uuid)[toon + 10][1] = 0
        -- PersistentVars[toon+10] = false
    end
    print("Done.")
    PrintAll()
end

function Partner(name, state, uuid)
    toon = guessEnumFromInput(name)
    if not toon then
        print("unknown input.")
        return
    end
    if state then
        SetFlag(partner_flags[toon], uuid)
        GetFlagStash(uuid)[toon][2] = 1
        -- PersistentVars[toon] = true
    else
        ClearFlag(partner_flags[toon], uuid)
        GetFlagStash(uuid)[toon][2] = 0
        -- PersistentVars[toon] = false
    end
    print("Done.")
    PrintAll()
end

function SetDUrgeParticipant(name)
    toon = guessEnumFromInput(name)
    if not toon then
        print("unknown input.")
        return
    end
    if string.len(durgeLUT[toon]) == 0 then
        print("This character is not allowed.")
        return
    end
    if original_toon ~= durgeLUT[toon] then
        original_toon = Osi.DB_ORI_DarkUrge_FavouriteCharacter:Get(nil)[1][1]
        Osi.DB_ORI_DarkUrge_FavouriteCharacter(durgeLUT[toon])
        Osi.DB_ORI_DarkUrge_FavouriteCharacter:Delete(original_toon)
    end
end

function CheckNight(name)
    if string.sub(name, 1, 5) ~= "NIGHT" then
        print("Warning: The name of the night should start with NIGHT.")
    end

    still_in_db = false
    for _, value in ipairs(Osi.DB_CampNight:Get(nil,nil)) do
        if value[1] == name then
            still_in_db = true
        end
    end
    if still_in_db == false then
        print("This event is not queued. Either you have not entered the act in which this scene belongs, or it will not be available in this playthrough anymore.")
        return
    end


    
    local allowedSites = ""
    for _, value in ipairs(Osi.DB_CampNight_Camp:Get(nil,nil)) do
        if value[1] == name then
            allowedSites = allowedSites .. value[2] .. ","
        end
    end
    print(string.format("Allowed campsites of the event: %s", allowedSites))
    print(string.format("Your current campsite is: %s.", Osi.DB_ActiveCamp:Get(nil)[1][1]))

    for _, value in ipairs(Osi.DB_CampNight_Requirement_Approval:Get(nil,nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires at least %s approval with %s.", value[3], stripUUID(value[2])))    
        end
    end
    
    local all_flagsets = {}
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil,nil)))
    all_flagsets = mergeLists(all_flagsets, filterFlagSet(name, Osi.DB_CampNight_Requirement:Get(nil,nil,nil,nil,nil,nil,nil,nil)))

    if #all_flagsets > 0 then
        print("The event requires one of the following flagsets to be all true. True is indicated as [O]; False [X].")
        print(" -- ")
        for _, flagset in ipairs(all_flagsets) do
            local allSatisfied = true
            for _, flag in ipairs(flagset) do
                local satisfied
                if Osi.GetFlag(flag, uuid) > 0 then
                    satisfied = '[O]'
                else
                    satisfied = '[X]'
                    allSatisfied = false
                end
                print(string.format("%s %s", satisfied, flag))
            end
            if allSatisfied then
                print(" (All True!)")
            end
            print(" -- ")
        end
    end
    local romanceNightEntry = Osi.DB_CampNight_RomanceNight:Get(name, nil,nil,nil)
    if #romanceNightEntry > 0 then
        local flagname = romanceNightEntry[1][4]
        if string.sub(flagname, 1, 4) ~= "NULL" then
            local satisfied
            if Osi.GetFlag(flagname, uuid) > 0 then
                satisfied = '[O]'
            else
                satisfied = 'Not set!'
            end
            print(string.format("In addition, flag %s must be set (%s).", flagname, satisfied))
        end
    end

    for _, value in ipairs(Osi.DB_CampNight_Requirement_Partner:Get(nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires partnered with %s.", stripUUID(value[2])))
        end
    end
    for _, value in ipairs(Osi.DB_CampNight_Requirement_Dating:Get(nil,nil)) do
        if value[1] == name then
            print(string.format("This event requires dating %s.", stripUUID(value[2])))
        end
    end
end

function filterFlagSet(name, flagsets)
    local results = {}
    for _, value in ipairs(flagsets) do
        if value[1] ~= name then
            goto continue
        end
        local result = {}
        for i, valueCond in ipairs(value) do
            if i ~= 1 then
                table.insert(result, valueCond)                
            end
        end
        table.insert(results, result)
        ::continue::
    end
    return results
end

function SetPartneredMinthara(uuid)
    StashPartneredStatus(true, uuid)
    SetFlag("ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8", uuid)
    RestorePartneredStatus({}, uuid)
    restoreStableRelationship({}, uuid)
    FixAll(uuid)
    PrintAll()
end

function SetDatingMinthara()
    print("Do not set dating minthara flag, this flag is evil!")
end
