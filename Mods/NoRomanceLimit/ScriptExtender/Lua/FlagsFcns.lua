function ClearDatingExceptHalsin (skip_enum)
    for i = eMinthara , eLaezel do
        if  (skip_enum ~= i) then
            ClearFlag(date_flags[i], getAvatar())
    
        end
    end
    -- clear dumping ppl dialogs
    for i = eMinthara , eLaezel do
        ClearFlag(dumpdate_flags[i], getAvatar())
    end
    -- set/unset dating flag
    if skip_enum > 0 and skip_enum < eLaezel then
        if (GetFlag(date_flags[skip_enum],getAvatar()) > 0) then
            SetFlag("ORI_State_Dating_a3346d5b-c54b-4c73-bf18-0a2bf90c35da", getAvatar())
        else
            ClearFlag("ORI_State_Dating_a3346d5b-c54b-4c73-bf18-0a2bf90c35da", getAvatar())

        end
    end
end

function RestoreDating (skip_enum)
    for i = eGale , eLaezel do -- no Minthy flag restore
        if PersistentVars[i+12] == true and (skip_enum ~= i) and
            GetFlag(partner_flags[i], getAvatar()) == 0 
        then
            SetFlag(date_flags[i], getAvatar())
            DPrint( "Restore dating with" .. origin_names[i])
        end
    end
end

function MinthyFixNew()
    if GetFlag("ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040", getAvatar()) > 0 then
        print("NoRomanceLimit: Replacing Minthy Dating flag with Partnered flag.")
        ClearFlag("ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040", getAvatar())
        SetFlag("ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8", getAvatar())
        PersistentVars[1] = true
        RestorePartneredStatus()
        FixAfterFlagToggling()
    end
end

function ClearPartnerships(exceptions)
    DPrint(" ClearPartnerships:")
    DPrint(exceptions)
    
    if exceptions == nil then
        exceptions = {}
    end
    for i, flag in pairs(partner_flags) do
        if isInList(i, exceptions) then
            goto continue
        end
        ClearFlag(flag, getAvatar())
        ::continue::
    end
    local shouldClearPartnered = true
    for i, toon in pairs(exceptions) do
        if GetFlag(partner_flags[toon], getAvatar()) > 0 then
            shouldClearPartnered = false
        end
    end
    if shouldClearPartnered then
        ClearFlag(isPartneredFlag, getAvatar())        
    end
end

-- new problem; stashed relationship flags. i have a feeling these will complicate things when dialogue gets suppressed.
function StashPartneredStatus(keepUnsetFlags)
    DPrint(" StashPartnered(and dating)Status:")
    if GetFlag(date_flags[eMinthara], getAvatar()) > 0 then
        PersistentVars[11] = true
    end
    for index, partner_flag in ipairs(partner_flags) do
        if GetFlag(partner_flag, getAvatar()) ~= 0 then
            PersistentVars[index] = true
        elseif not keepUnsetFlags then
            PersistentVars[index] = false
        end
    end
    for index, date_flag in ipairs(date_flags) do
        if GetFlag(date_flag, getAvatar()) ~= 0 then
            PersistentVars[index+12] = true
        elseif not keepUnsetFlags then
            PersistentVars[index+12] = false
        end    
        
    end
end

function RestorePartneredStatus(skip_enum)
    DPrint(" StashPartneredStatus:")
    DPrint(skip_enum)
    if skip_enum == nil then
        skip_enum = 9999
    end
    -- for index, stash_result in ipairs(PersistentVars) do
    for index = eMinthara, eHalsin do
        DPrint(index)
        if PersistentVars[index] and (skip_enum ~= index) and (GetFlag(partner_flags[index], getAvatar()) == 0) then
            DPrint(string.format("NoRomanceLimit: Restoring stable relationship with %s", origin_names[index]))
            DTraceback()
            
            ClearFlag(waspartner_flags[index], getAvatar())
            SetFlag(partner_flags[index], getAvatar())
        end
    end
    DPrint("RestorePartneredStatus Done")
    DPrintAll()
end

