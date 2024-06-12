function FixAll(uuid)
    -- make everything consistent to flag values
    ClearUnusedDatingFlags(uuid)
    FixDoubleDating(uuid)
    FixPartneredDBAndFlags(uuid)
    ManageDatingEntry()
    ManageCanStartDatingEntry()
    ClearDumpDialogs(uuid)
    restoreStableRelationship(uuid)
end

function FixAfterFlagToggling(uuid)
    FixDatingDB(uuid)
    FixPartneredDBAndFlags(uuid)
    ClearUnusedDatingFlags(uuid)
    ClearDumpDialogs(uuid)
end

function GetFlagStash(uuid)
    for index, value in ipairs(flagStashList) do
        if flagStashList[1][1] == uuid then
            return flagStash1
        elseif flagStashList[2][1] == uuid then
            return flagStash2
        elseif flagStashList[3][1] == uuid then
            return flagStash3
        elseif flagStashList[4][1] == uuid then
            return flagStash4
        elseif flagStashList[5][1] == uuid then
            return flagStash5
        elseif flagStashList[6][1] == uuid then
            return flagStash6
        elseif flagStashList[7][1] == uuid then
            return flagStash7
        elseif flagStashList[8][1] == uuid then
            return flagStash8
        end
    end
end

function FixDatingDB(uuid)
    for index = eMinthara, eLaezel do
        if GetFlag(date_flags[index], uuid) ~= 0 then
            Osi.DB_ORI_Dating(uuid, origin_uuids[index])
            Osi.DB_ORI_WasDating:Delete(uuid, origin_uuids[index])
        end
    end
end

function FixPartneredDBAndFlags(uuid)
    local isPartnered = false
    for index = eMinthara, eLaezel do
        if GetFlag(partner_flags[index], uuid) ~= 0 then
            isPartnered = true
            Osi.DB_ORI_Partnered(uuid, origin_uuids[index])
            Osi.ClearFlag(waspartner_flags[index], uuid)
        end
    end
    
    local isPartneredHalsin = GetFlag(partner_flags[eHalsin], uuid) > 0
    if isPartnered or isPartneredHalsin then
        Osi.SetFlag(isPartneredFlag, uuid)
        restoreStableRelationship(uuid)
        if isPartnered and isPartneredHalsin then
            Osi.SetFlag("ORI_State_PartneredWithHalsinSecondary_6af0be74-d032-4a20-876a-11bab5f86db2", uuid)
        end
    else
        Osi.ClearFlag(isPartneredFlag, uuid)
    end
end

-----------
-- fixes during each flag toggle
-----------
function ClearUnusedDatingFlags(uuid)
    -- StashPartneredStatus(true, uuid)
    for i, value in ipairs(origin_names) do
        if GetFlag(partner_flags[i], uuid) > 0 then
            ClearFlag(date_flags[i], uuid)
            Osi.DB_ORI_WasDating:Delete(origin_uuids[i],nil)
            Osi.DB_ORI_WasDating:Delete(nil,origin_uuids[i])
        end
    end
end

function ClearDumpDialogs(uuid)
    ClearFlag("ORI_State_ChosePartnerOverMinthara_25202f13-55d3-4d13-c2b0-45120da9f299", uuid)
    ClearFlag("ORI_State_ChosePartnerOverLaezel_35c95a6d-4145-4903-73ad-73a70edf9268", uuid)
    ClearFlag("ORI_State_ChosePartnerOverShadowheart_3928d3fc-b2c8-44ac-0d85-69e27f170a8c", uuid)
    ClearFlag("ORI_State_ChosePartnerOverAstarion_529d4115-ef78-49aa-f2b1-99244e4ee375", uuid)
    ClearFlag("ORI_State_ChosePartnerOverKarlach_8e5ba2d7-146c-4751-2aa6-d94b8f8e9e27", uuid)
    ClearFlag("ORI_State_ChosePartnerOverWyll_f0b08362-76b7-4cf9-01bd-4f87d8c11cbf", uuid)
    ClearFlag("ORI_State_ChosePartnerOverGale_ff5cbe4e-d3a8-4cc6-fa86-36f35ef10443", uuid)
end

------------------------------
-- stable relationships
------------------------------
function restoreStableRelationship(uuid)
    -- if character has more than 3 relationships, set these stable relationship flags. i'm not exactly sure what these are? but they seem important.
    if PersistentVars[10] > 3 then
        SetFlag("ORI_State_StableRelationship_d904563d-2660-4b0c-c88a-8b743cbe9530", uuid)
        SetFlag("ORI_State_StableRelationship_d904563d-2660-4b0c-8ac8-748bbe3c3095", uuid)
    end
end

function stableRelationshipAdvance(uuid)
    DPrint(string.format(" stable rel @ %d => +1", PersistentVars[10]))
    -- seems isInRelationship is broken
    if GetFlag(isPartneredFlag, uuid) > 0 then
        PersistentVars[10] = PersistentVars[10]  + 1
    else
        PersistentVars[10] = 0
    end
end

--------------------------
-- database fixes
--------------------------

function FixDoubleDating(uuid)
    -- once per game
    for _, person in ipairs(origin_uuids) do 
        Osi.DB_ORI_FreeDating(person)
    end
    Osi.ClearFlag("ORI_State_DoubleDating_41320aeb-8e1a-433d-a82e-3d78aff578da", uuid) 
end

function Fix_Databases()
    -- Once Per Act
    ManageCanStartDatingEntry()
    ManageDatingEntry()
end

function ManageCanStartDatingEntry()
    for _, list in ipairs(Osi.DB_CampNight_Requirement_CanStartDating:Get(nil,nil)) do
        if ShouldManageCanStartDatingEntry(list) then
            Osi.DB_CampNight_Requirement_CanStartDating:Delete(list[1], list[2])
            print(string.format("NoRomanceLimit - Removing Requirement ReqCanStartDate for %s", list[1]))
        end
    end
end

function ManageDatingEntry()
    for _, list in ipairs(Osi.DB_CampNight_Requirement_Dating:Get(nil,nil)) do
        if ShouldManageDatingEntry(list) then
            Osi.DB_CampNight_Requirement_Dating:Delete(list[1], list[2])
            FixRomNightFlagCheckForNight(list[1])
            print(string.format("NoRomanceLimit - Removing Requirement ReqDating %s ", list[1]))
        end
    end
end

function FixRomNightFlagCheckForNight(night_uuid)
    -- the queueing mechanism requires that for a dating->stable scene, the 4th paramter is non null, 
    -- or it will check for other partners. Add the isDating flag to make it happy
    for _,value in ipairs(Osi.DB_CampNight_RomanceNight:Get(nil,nil,nil,nil)) do
        if value[1] == night_uuid and value[4] == "NULL_00000000-0000-0000-0000-000000000000" then
            romance_toon = value[2]
            for i, toon_uuid in ipairs(origin_uuids) do
                if toon_uuid == romance_toon then
                    Osi.DB_CampNight_RomanceNight(value[1],value[2],value[3],date_flags[i])
                end
            end
            Osi.DB_CampNight_RomanceNight:Delete(value[1],value[2],value[3],value[4])
        end
    end
end

function ShouldManageDatingEntry(entry, uuid)
    night_uuid = entry[1]
    origin_uuid = entry[2]
-- QRY
-- QRY_CampNight_MeetsRequirements_Dating((FLAG)_Var1) [KEEP0] [implicitly satisfied?]
-- AND
-- DB_CampNight_Requirement_Dating(_Var1, _Var2)
-- AND
-- DB_ORI_Dating(_Var3, _Var2) [Keep1]
-- AND NOT
-- QRY_PartneredWithOther(_Var3, _Var2)
-- AND
-- DB_InCamp(_Var3) 
-- AND NOT
-- DB_Avatars(_Var2) [Keep2]
-- AND NOT
-- QRY_PreventMPDialogue(_Var2, _Var3)
-- THEN
-- DB_NOOP(1);
    if
        -- 1
        isSublistInListOfLists({uuid, origin_uuid}, Osi.DB_ORI_Dating:Get(nil,nil)) and
        -- 2
        origin_uuid ~= uuid
    then
        return true
    end
    return false
end

function ShouldManageCanStartDatingEntry(entry, uuid)
    night_uuid = entry[1]
    origin_uuid = entry[2]
-- QRY
-- QRY_CampNight_MeetsRequirements_StartDating((FLAG)_Var1)
-- AND
-- DB_CampNight_Requirement_CanStartDating(_Var1, _Var2) [KEEP0] [implicitly satisfied?]
-- AND NOT
-- DB_ORI_Dating(_, _Var2) [Removed] due to origin cannot date multiple in SP
-- AND NOT
-- DB_Avatars(_Var2) [KEEP2] avatar cannot date himself
-- AND NOT
-- DB_ORI_Partnered(_Var4, _) 
-- AND
-- GetFlag(ORI_State_DoubleDating_41320aeb-8e1a-433d-a82e-3d78aff578da, _Var4, 0) 
-- AND NOT
-- DB_ORI_WasDating(_Var4, _Var2) [KEEP3]
-- AND NOT
-- QRY_PreventMPDialogue(_Var2, _Var4) [Removed for now] no MP
-- THEN
-- DB_NOOP(1);
    if
        -- 0
        -- 2
        origin_uuid ~= uuid and
        -- 3
        not isSublistInListOfLists({uuid, origin_uuid}, Osi.DB_ORI_WasDating:Get(nil,nil))
    then
        return true
    end
    return false
end

relationEndedFlags = {
"END_GameFinale_State_PartnershipEndedMinthara_421d45a7-3c15-486a-b856-e3ea4a705882",
"END_GameFinale_State_PartnershipEndedGale_fa62b0f8-c884-4f68-b507-b70b9277b6de",
"END_GameFinale_State_PartnershipEndedWyll_3b60022c-b8a5-445e-b66a-21154f9fd73b",
"END_GameFinale_State_PartnershipEndedAstarion_144c7dec-fc84-44e9-851f-d81d9c87c75c",
"END_GameFinale_State_PartnershipEndedKarlach_f9ec7b63-c6c9-4ca4-b7ff-bdfea27bc780",
"END_GameFinale_State_PartnershipEndedShadowheart_b123048b-07de-4b06-884e-a12b54e984e1",
"END_GameFinale_State_PartnershipEndedLaezel_48bdbcad-da83-44c1-b3fe-5d4b227e8ba0",
"END_GameFinale_State_PartnershipEndedHalsin_887340d1-4dd3-4b99-81e6-2c942e61b06e"
}

function RestorePartneredEpilogFor(toon, uuid)
    ClearFlag(relationEndedFlags[toon], uuid)
    SetFlag(partner_flags[toon], uuid)
end

function EpilogClearedToonFlag(toon, uuid)
    -- PersistentVars[toon] == true 
    return GetFlag(partner_flags[toon], uuid) == 0 and GetFlagStash(uuid)[toon][2] == 1
end

function EpilogFix(uuid)
    if GetFlag("ORI_DarkUrge_State_WasPartneredGoneMad_fb3ab877-e2c3-4887-8e27-7050dc1b5171", uuid) > 0 then
        print("NoRomanceLimit: Mad DUrge - skipping romance patches")
        return
    end
    -- because it is weird.
    if uuid == origin_uuids[eGale] and GetFlag("ORI_Gale_State_IsGod_ec94f9a4-b032-ce25-f4eb-ecf4ed37d65d", uuid) > 0 then
        print("NoRomanceLimit: Gale god - skipping romance patches")
        return
    end

    -- undo endgame logic
    -- Karlach: romance is possible if  
    --  She went to the hells and you accompanied
    --  She did not go to the hells (is illithid)?
    if EpilogClearedToonFlag(eKarlach, uuid) then
        if GetGloFlag("END_GameFinale_Event_KarlachReturnedToHell_bbec205a-5b1e-8488-f03a-10f0caaa5471") then
            if uuid == origin_uuids[eWyll] then
                if GetFlag("ORI_Wyll_State_FollowKarlachToHells_e91a4ad5-e2f5-b336-f583-9f480ee7544e", uuid) then
                    RestorePartneredEpilogFor(eKarlach, uuid)
                end
            end
            if GetFlag("END_GameFinale_Event_AccompanyKarlachToHell_35150cbf-2c72-1049-37ed-14dbc3736135", uuid) then
                RestorePartneredEpilogFor(eKarlach, uuid)
            end
        else
            RestorePartneredEpilogFor(eKarlach, uuid)
        end
    end
    -- gale: break up if is god
    if EpilogClearedToonFlag(eGale, uuid) and GetFlag("ORI_Gale_State_IsGod_ec94f9a4-b032-ce25-f4eb-ecf4ed37d65d", uuid) == 0 then
        RestorePartneredEpilogFor(eGale, uuid)
    end
    -- laezel: break up if leaves Faerun
    -- leave faurun as laezel is ignored
    if EpilogClearedToonFlag(eLaezel, uuid) and #Osi.DB_GlobalFlag:Get("END_GameFinale_State_LaezelLeavesFaerun_896fb62a-4f56-41d8-a173-7d06c4cb9209") == 0 then
        RestorePartneredEpilogFor(eLaezel, uuid)
    end
    -- Wyll: break up if wyll in avernus, and toon is not. 
    if EpilogClearedToonFlag(eWyll, uuid) then
        restore_wyll = false
        if not GetGloFlag("ORI_Wyll_State_FollowKarlachToHells_e91a4ad5-e2f5-b336-f583-9f480ee7544e") then
            restore_wyll = true
            ClearFlag()
        elseif GetFlag("END_GameFinale_Event_AccompanyKarlachToHell_35150cbf-2c72-1049-37ed-14dbc3736135", uuid) then
            restore_wyll = true
        end
        if RestorePartneredEpilogFor(eWyll, uuid) then
            RestorePartneredEpilogFor(eWyll, uuid)
        end
    end

    -- simple guys: if broke up then restore relationship.
    for _, toon in ipairs({eMinthara, eAstarion, eShadowHeart, eHalsin}) do
        if EpilogClearedToonFlag(toon, uuid) then
            RestorePartneredEpilogFor(toon, uuid)
        end
    end
    FixAll()
end