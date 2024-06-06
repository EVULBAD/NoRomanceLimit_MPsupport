-- EVULBAD ADDITION
function StashPlayerSpell(caster)
    message = ""
    ignore = false
    stashLength = #PlayerStash
    for index, value in ipairs(PlayerStash) do
        if value == caster then 
            ignore = true
        end
    end
    if ignore == false then
        PlayerStash[stashLength + 1] = caster
        message = "Character has been added to stash.\n\n"
        message = message .. "Current stash:\n"
    else
        message = "Character is already in stash.\n\n"
        message = message .. "Current stash:\n"
    end
    for index, value in ipairs(PlayerStash) do
        if index == stashLength + 1 then
            message = message .. value
        else
            message = message .. value .. "\n"
        end
    end
    Osi.OpenMessageBox(caster, message)
end

-- this function describes the "print" spell available in the action bar which prints the current romance statuses of companions.
function PrintAllSpell(caster)
    message = ""
    for i, val in ipairs(origin_names) do
        if GetFlag(partner_flags[i], caster) > 0then
            message = message .. "Relationship:" .. origin_names[i] .. "\n"
        elseif GetFlag(date_flags[i], caster) > 0 then
            message = message .. "Dating:" .. origin_names[i] .. "\n"
        end
    end
    if string.len(message) == 0 then
        Osi.OpenMessageBox(caster, "Current romance status:\nThou walkest alone.")
    else
        Osi.OpenMessageBox(caster, "Current romance status:\n" .. message)
    end
end

-- this looks like a way to convert uuids into the data type required (enum) to allow events.
function getCompanionEnum(uuid)
    for i, val in ipairs(origin_uuids) do
        if uuid == val then
            return i
        end
    end
    return -1
end

-- this function describes the "durge" spell available in the action bar. i have no idea what this does and i'm scared to use it (spoilers maybe)!
function DurgeSpell(uuid, caster)
    if uuid == "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604" then
        SetDUrgeParticipant('gale')
    elseif uuid == "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d" then
        SetDUrgeParticipant('wyll')
    elseif uuid == "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255" then
        SetDUrgeParticipant('astarion')
    elseif uuid == "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c" then
        SetDUrgeParticipant('karlach')
    elseif uuid == "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12" then
        SetDUrgeParticipant('laezel')
    elseif uuid == "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679" then
        SetDUrgeParticipant('shadowheart')
    else
        Osi.OpenMessageBox(caster, "This character is not allowed.")
        return
    end
    Osi.OpenMessageBox(caster, "Done.")
end

-- this function describes the "date" spell available in the action bar which allows the caster to set the date flags on whatever character they cast it towards.
function DateSpell(uuid, caster)
    -- check companion
    companion = getCompanionEnum(uuid)
    if companion < 0 then
        Osi.OpenMessageBox(caster, "You must select a romanceable companion.")
        return
    end
    -- if we are in a3, print warning message
    if Osi.GetFlag("Act3_Visited_83f7a4a8-0a60-4be3-ab2a-38800f10750b", caster) > 0 then
        Osi.OpenMessageBox(caster, "Warning: It seems you are in Act 3. You cannot Date in A3 as you will be dumped immediately. Use the Partner spell instead. ")
    end

    if Osi.GetFlag(date_flags[companion], caster) > 0 then
        ClearFlag(date_flags[companion], caster)
        Osi.OpenMessageBox(caster,"Dating status with "..uuid.."cleared.")
        StashPartneredStatus(false)
    else
        SetFlag(date_flags[companion], caster)
        Osi.OpenMessageBox(caster,"Dating status with "..uuid.."set.")
        StashPartneredStatus(true)
    end
end

-- this function describes the "partner" spell available in the action bar which allows the caster to set the partner flags on whatever character they cast it towards.
function PartnerSpell(uuid, caster)
    -- check companion
    companion = getCompanionEnum(uuid)
    if companion < 0 then
        Osi.OpenMessageBox(caster, "You must select a romanceable companion.")
        return
    end
    if Osi.GetFlag(partner_flags[companion], caster) > 0 then
        ClearFlag(partner_flags[companion], caster)
        Osi.OpenMessageBox(caster"Partner status with "..uuid.."cleared.", getAvatar)
        StashPartneredStatus(false)
    else
        SetFlag(partner_flags[companion], caster)
        Osi.OpenMessageBox(caster,"Partner status with "..uuid.."set.")
        StashPartneredStatus(true)
    end
end

-- these are listeners that listen for when a spell is cast.
function AddUserSpellListeners ()
    Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function (caster, target, spell, spellType, spellElement, storyActionID)
        if spell == "NoRomanceLimitDate" then
            DateSpell(target, caster)
        elseif spell == "NoRomanceLimitPartner" then
            PartnerSpell(target, caster)
        elseif spell == "NoRomanceLimitDurge" then
            DurgeSpell(target, caster)
        end    
    end)
    
    Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (caster, spell, spellType, spellElement, storyActionID)
        if spell == "NoRomanceLimitPrint" then
            PrintAllSpell(caster)
        elseif spell == "NoRomanceLimitStashPlayer" then
            StashPlayerSpell(caster)
        end
    end)
end