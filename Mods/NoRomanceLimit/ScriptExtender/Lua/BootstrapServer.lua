eMinthara = 1
eGale = 2
eWyll = 3
eAstarion = 4
eKarlach = 5
eShadowHeart = 6
eLaezel = 7
eHalsin = 8

Ext.Require("Utils.lua")
Ext.Require("Fixes.lua")
Ext.Require("FlagsFcns.lua")
Ext.Require("UserFcns.lua")
Ext.Require("ScheduleN.lua")
Ext.Require("UserSpells.lua")
-- Dprint commands will print to console when FullPrint is true.
FullPrint = false

-- EVULBAD ADDITION
-- these will hold the flags for each individual character.
flagStash1 = {}
flagStash2 = {}
flagStash3 = {}
flagStash4 = {}
flagStash5 = {}
flagStash6 = {}
flagStash7 = {}
flagStash8 = {}
flagStash9 = {}
flagStash10 = {}
flagStash11 = {}
flagStash12 = {}

-- and this will hold the information regarding which character's flags are in which table. each "nil" will get replaced with a character's uuid.
flagStashList = {
    {nil, flagStash1},
    {nil, flagStash2},
    {nil, flagStash3},
    {nil, flagStash4},
    {nil, flagStash5},
    {nil, flagStash6},
    {nil, flagStash7},
    {nil, flagStash8},
    {nil, flagStash9},
    {nil, flagStash10},
    {nil, flagStash11},
    {nil, flagStash12}
}

-- these are non-playable characters. i'm presuming these don't get to be in relationships with origin companions in the same way.
IgnorePlayerList = {
    "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a", "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba", "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b", "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"
}
-- EVULBAD ADDITION

-- EVULBAD EDIT
-- want to change name to "DefaultVars". might need to have a set for each character...
PersistentVars = {false, false, false, false, false, 
                  false, false, false, -- toon relationship flag
                  true, -- 9 first time installation flag
                  0, -- 10stable relationship counter 
                  false, -- 11Minthara dating flag,
                  false,  -- 12restore at the end/start of the next dialog.
                  false, false, false, false, -- starting from 13
                  false, false, false, false, -- (new) dating flags
                  false, -- 21 brain defeated
                }

isPartneredFlag = "ORI_State_Partnered_6c1a31e8-1d3d-42a5-af4f-72ef7a798f74"

listMainCompanionDialogEntry = {
    {"Minthara_InParty_13d72d55-0d47-c280-9e9c-da076d8876d8",eMinthara},
    {"Gale_InParty2_6beb1b10-845f-49fa-6d6d-f425eaa42574", eGale},
    {"Wyll_InParty_6dff0a1f-1a51-725d-6e9a-52b5742ba9e6", eWyll},
    {"Astarion_InParty_53aba16e-55bb-a0fc-a444-522e237dbe46", eAstarion},
    {"Karlach_InParty_12459660-b66e-9b0b-9963-670e0993543d", eKarlach},
    {"ShadowHeart_InParty_95ca3833-09d0-5772-b16a-c7a5e9208fe5",eShadowHeart},
    {"Laezel_InParty2_93bf58f5-5111-9730-1ee2-62dfb0b00c96",eLaezel}
}
halsinCompanionDialog = 'CAMP_Halsin2_c0ab0f6f-3ffc-d06d-0d6d-d1aaef70dfe4'

listOfAllFirstSecondRomance = {
    {"CAMP_AstarionHunger_SCO_Companion_359981f9-d660-96e2-3e94-218e92d5e479", eAstarion}, 
    {"CAMP_Shadowheart_Romance1_SD_Invitation_b33a13f6-5550-c891-a92b-4d6cf916a445",eShadowHeart}, 
    {"CAMP_Astarion_Romance1_SD_Invitation_d0b45fa8-138a-1939-9ce3-0fae91864feb",eAstarion}, 
    {"CAMP_BurningUpForYou_CFM_ROM_a5177ed5-add2-f4f2-18b1-18d134d8aab6",eKarlach}, 
    {"CAMP_Astarion_SD_ROM_SecondNight_693a16c6-9b9d-fee9-db37-7207ab63c913",eAstarion},  
    {"CAMP_GalesLastNightAlive_SD_ROM_e6067557-2187-7493-c9b6-363ef6dd8334",eGale},
    {"CAMP_Karlach_SD_ROM_ForgingOfTheHeart_c2fbbf85-71d0-d4aa-07df-21abbb9f303a",eKarlach}, 
    {"CAMP_Astarion_SD_ROM_BloodMerchantAftermath_30d45668-4bcf-d514-5e04-5f843d1b538b",eAstarion}, 
    {"CAMP_Wyll_CRD_HavenRomance_859821c9-666b-6f28-f59c-0394f49b0281",eWyll},  
    {"CAMP_Wyll_SD_HavenRomance_ROM_859821c9-666b-6f28-f59c-0394f49b0281",eWyll},
    {"CAMP_Laezel_Romance1_SD_Invitation_264413a4-e515-8e4d-3755-3f84c3fb1b11",eLaezel},
    {"CAMP_Laezel_ROM_SleepingSecondNight_b1ebeae3-7a76-5d36-4506-f30d0bfdc965",eLaezel}, 
    {"CAMP_Laezel_ROM_SD_Romance2_WokenUpByLaezel_ce8ea48c-688d-7484-283f-c801c82172b3",eLaezel},
    {'CAMP_Gale_CRD_SpellTeaching2_4d0a0d4e-0812-98c1-f2a6-94013578ce97', eGale},
    {'CAMP_Gale_CRD_SpellTeaching_4d0a0d4e-0812-98c1-f2a6-94013578ce97', eGale}
}
listOfAllThirdRomance = {
    {"CAMP_HalsinRomanceAct3_SD_ROM_3d042271-f13a-fc4a-50b3-6f7e51f1b7ba", eHalsin},
    {"CAMP_Laezel_ROM_Romance3_MorningIVB_46a83c6e-ff94-7478-7935-9c1db48c1c9f", eLaezel},
    {"CAMP_Karlach_CRD_ROM_Date_2bf0d0c0-495c-6866-d5ad-d37dd4fa3648", eKarlach},
    {"CAMP_Astarion_SD_ROM_BlackMassAftermath_cdc9ae59-c30e-3819-4060-d46263681631", eAstarion},
    {"CAMP_Shadowheart_CRD_NightfallRomance_4e995131-a9dc-24f7-5e0a-5cb703b3df43", eShadowHeart},
    {"CAMP_Shadowheart_CRD_SharedFuture_d60d0152-14ff-b185-942b-d48182f66bf0", eShadowHeart},
    {"CAMP_Gale_CRD_BeMyGod_df11dcbe-6478-06f8-efe6-f763ee87d5c4", eGale},
    {"CAMP_Shadowheart_SkinnyDipping_SD_ROM_700d677f-1bfd-1c83-8530-0db12875c33b", eShadowHeart},
    {"CAMP_Shadowheart_CRD_SharRomance_c1cefc29-3ca9-414f-9351-ee98a6103c2c", eShadowHeart},
    {"CAMP_Wyll_CRD_Act3Romance_599fe884-f39f-a3b5-7a86-ca239e016a05", eWyll}
}

origin_names = {
    "Minthara","Gale", "Wyll", "Astarion", "Karlach", "ShadowHeart", "Laezel",  "Halsin"
}
origin_uuids = {
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604",
    "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
    "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255",
    "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c",
    "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679",
    "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"
} 
date_flags = {
    "ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040",
    "ORI_State_DatingGale_75d0e041-c16c-d089-6d89-64354fa4c9d9",
    "ORI_State_DatingWithWyll_f1520748-1d36-4500-9f8a-0da4207f8dd5",
    "ORI_State_DatingAstarion_ba298c56-26b6-4918-9bd4-616668d369d8",
    "ORI_State_DatingKarlach_f24c3f3e-7287-4908-84bf-ba314921f5ee",
    "ORI_State_DatingShadowheart_e87f1e21-a758-47ae-8c0e-9e715eb289b5",
    "ORI_State_DatingLaezel_86eaa84a-350b-401b-8b43-b53eeb534579",
    ""
}
partner_flags = {
    "ORI_State_PartneredWithMinthara_39ac48fa-b440-47e6-a436-6dc9b10058d8",
    "ORI_State_PartneredWithGale_e008e20d-d642-42ed-9008-297b6273aa21",
    "ORI_State_PartneredWithWyll_5db4c1b6-3c42-43ae-aa85-1844acbf5a1d",
    "ORI_State_PartneredWithAstarion_30819c8d-b39d-42e7-acd1-2a8c2c309994",
    "ORI_State_PartneredWithKarlach_d9ff60fa-0af9-45d7-99b4-bd7c3f80ed12",
    "ORI_State_PartneredWithShadowheart_3808ae35-ad4e-465b-800b-63d32b77211e",
    "ORI_State_PartneredWithLaezel_d169a786-6e56-4f0d-a2eb-33c48d8d1160",
    "ORI_State_PartneredWithHalsin_7b53fe60-bb16-48a9-ae5c-9bce1dfac1a9",
}
waspartner_flags = {
    "ORI_State_WasPartneredWithMinthara_8d0460d6-b00a-4947-bbd0-ad0c085a530f",
    "ORI_State_WasPartneredWithGale_60e14eb3-cce6-43c3-b893-b9b687e3d88f",
    "ORI_State_WasPartneredWithWyll_2652ff35-a62d-4947-b14b-11050ccfd329",
    "ORI_State_WasPartneredWithAstarion_5a60943f-979b-4120-9b60-9e9b29529402",
    "ORI_State_WasPartneredWithKarlach_48f2a4d4-23f4-4514-b894-e225152d7a48",
    "ORI_State_WasPartneredWithShadowheart_542e6cf4-bfd1-471d-b4b5-693d630376cb",
    "ORI_State_WasPartneredWithLaezel_6d402d9b-7af9-43ea-b0eb-98e9612dde27",
    "ORI_State_WasPartneredWithHalsin_ee6b727d-243e-4189-b572-1d782ea78df8",
}
dumpdate_flags = {
    "ORI_State_ChosePartnerOverMinthara_25202f13-55d3-4d13-b0c2-1245a90d99f2",
    "ORI_State_ChosePartnerOverGale_ff5cbe4e-d3a8-4cc6-86fa-f336f15e4304",
    "ORI_State_ChosePartnerOverWyll_f0b08362-76b7-4cf9-bd01-874fc1d8bf1c",
    "ORI_State_ChosePartnerOverAstarion_529d4115-ef78-49aa-b1f2-24994e4e75e3",
    "ORI_State_ChosePartnerOverKarlach_8e5ba2d7-146c-4751-a62a-4bd98e8f279e",
    "ORI_State_ChosePartnerOverShadowheart_3928d3fc-b2c8-44ac-850d-e269177f8c0a",
    "ORI_State_ChosePartnerOverLaezel_35c95a6d-4145-4903-ad73-a773df0e6892",
    ""
}

Ext.Osiris.RegisterListener("DialogStarted", 2, "before", function(dialog, instanceid)
    uuid = Osi.DialogGetInvolvedPlayer(instanceid, 2)
    
    if PersistentVars[21] == true then
        return
    end

    DPrint(string.format("DialogStarted %s, %s", dialog, instanceid))

    if isInList(dialog, listOfAllFirstSecondRomance) then
        -- for index, uuid in ipairs(PlayerStash) do
            -- getting rid of StashPartneredStatus for now since it may be deprecated by my flagStashes.
            -- StashPartneredStatus(true, uuid)
            -- this line clears the partnerships. necessary!
            ClearPartnerships({}, uuid)
            FixAfterFlagToggling(uuid)
        -- end
    --[[
    -- i'm not sure this is necessary considering it just stashes the partnered status if the companion is halsin.
    elseif dialog == halsinCompanionDialog then
        for index, uuid in ipairs(PlayerStash) do
            -- StashPartneredStatus(true, uuid)
        end
        ]]
    else
        for _, value in ipairs(listOfAllFirstSecondRomance) do
            if value[1] == dialog then
                -- for index, uuid in ipairs(PlayerStash) do
                    -- StashPartneredStatus(true, uuid)
                    ClearPartnerships({}, uuid)
                    FixAfterFlagToggling(uuid)
                -- end
            end
        end
        --[[ 
        for _, value in ipairs(listOfAllThirdRomance) do
            if value[1] == dialog then
                for index, uuid in ipairs(PlayerStash) do
                    -- StashPartneredStatus(true, uuid)
                end
                break
            end
        end
        ]]
        for _, value in ipairs(listMainCompanionDialogEntry) do
            if value[1] == dialog then
                --for index, uuid in ipairs(PlayerStash) do
                    -- StashPartneredStatus(true, uuid)
                    ClearPartnerships({eHalsin, value[2]}, uuid)
                    ClearDatingExceptHalsin(value[2], uuid)
                    FixAfterFlagToggling(uuid)
                --end
                break
            end
        end
    end
    
end)

Ext.Osiris.RegisterListener("DialogEnded", 2, "after", function(dialog, instanceid)
    uuid = Osi.DialogGetInvolvedPlayer(instanceid, 2)
    
    if PersistentVars[21] == true then
        return
    end
    DPrint(string.format("DialogEnded %s, %s", dialog, instanceid))

    -- for index, uuid in ipairs(PlayerStash) do
        MinthyFixNew(uuid) -- bug in se causes flags to be weird when set in dialog directly?
        FixPartneredDBAndFlags(uuid)
    -- end

    if dialog == "CAMP_MizoraMorningAfter_CFM_ROM_69ddc432-0293-98b1-e512-baff8b160f12" then
        -- for index, uuid in ipairs(PlayerStash) do
            RestorePartneredStatus({}, uuid)
            FixAfterFlagToggling(uuid)
        -- end
    --[[ 
    elseif dialog == "CAMP_Wyll_CRD_Act3Romance_599fe884-f39f-a3b5-7a86-ca239e016a05" then
        -- Wyll breaks up with avatar is Duke is dead
        for index, uuid in ipairs(PlayerStash) do
            -- StashPartneredStatus(false, uuid)
        end
    ]]
    elseif dialog == halsinCompanionDialog then 
        -- for index, uuid in ipairs(PlayerStash) do
            RestorePartneredStatus(eHalsin, uuid)
            FixAfterFlagToggling(uuid)
        -- end
    else
        for _, value in ipairs(listOfAllFirstSecondRomance) do
            if value[1] == dialog then
                -- for index, uuid in ipairs(PlayerStash) do
                    RestorePartneredStatus(value[2], uuid)
                    RestoreDating(value[2], uuid)
                    FixAfterFlagToggling(uuid)
                -- end
                break
            end
        end
        for _, value in ipairs(listOfAllThirdRomance) do
            if value[1] == dialog then
                -- for index, uuid in ipairs(PlayerStash) do
                    RestorePartneredStatus(value[2], uuid)
                    FixAfterFlagToggling(uuid)
                -- end
                break
            end
        end
        for _, value in ipairs(listMainCompanionDialogEntry) do
            if value[1] == dialog then
                DPrint(value[1])
                -- for index, uuid in ipairs(PlayerStash) do
                    RestorePartneredStatus(value[2], uuid)
                    RestoreDating(value[2], uuid)
                    FixAfterFlagToggling(uuid)
                -- end
                DPrintAll()
                break
            end
        end
    end

    --[[ 
    for index, uuid in ipairs(PlayerStash) do
        -- StashPartneredStatus(false, uuid)
    end
    ]]

end)

-- Ext.Osiris.RegisterListener("DialogStartRequested", 2, "before", function(target, player)
--     _D(target)
--     _D(player)
-- end)

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    -- EVULBAD ADDITION
    PlayerStash = GetSquad()

    for index, uuid in ipairs(PlayerStash) do
        print(index, uuid)

        for index, value in ipairs(IgnorePlayerList) do
            if value == uuid then
                playerIgnore = true
            end
        end

        if playerIgnore == true then
            print("player in ignore list. skipping")
        else
            tableIndex = 1
            for i, val in ipairs(origin_names) do
                if index == 1 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash1}

                    flagStash1[#flagStash1 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash1[tableIndex][1], flagStash1[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 2 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash2}

                    flagStash2[#flagStash2 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash2[tableIndex][1], flagStash2[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 3 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash3}

                    flagStash3[#flagStash3 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash3[tableIndex][1], flagStash3[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 4 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash4}

                    flagStash4[#flagStash4 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash4[tableIndex][1], flagStash4[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 5 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash5}

                    flagStash5[#flagStash5 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash5[tableIndex][1], flagStash5[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 6 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash6}

                    flagStash6[#flagStash6 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash6[tableIndex][1], flagStash6[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 7 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash7}

                    flagStash7[#flagStash7 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash7[tableIndex][1], flagStash7[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 8 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash8}

                    flagStash8[#flagStash8 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash8[tableIndex][1], flagStash8[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 9 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash9}

                    flagStash9[#flagStash9 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash9[tableIndex][1], flagStash9[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 10 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash10}

                    flagStash10[#flagStash10 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash10[tableIndex][1], flagStash10[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 11 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash11}

                    flagStash11[#flagStash11 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash11[tableIndex][1], flagStash11[tableIndex][2]))

                    tableIndex = tableIndex + 1
                elseif index == 12 then
                    dateFlag = GetFlag(date_flags[i], uuid)
                    relaFlag = GetFlag(partner_flags[i], uuid)
                    flagStashList[index] = {uuid, flagStash12}

                    flagStash12[#flagStash12 + 1] = {dateFlag, relaFlag}
                    print(string.format("%s: date %s, rela %s", val, flagStash12[tableIndex][1], flagStash12[tableIndex][2]))

                    tableIndex = tableIndex + 1
                end
            end
        end
    end
    -- EVULBAD ADDITION

     -- upgrade patch
    for i = 1, 21 do
        -- print(PersistentVars[i])
        if PersistentVars[i] == nil then
            PersistentVars[i] = false
        end
    end

    if PersistentVars[10] == false then
        PersistentVars[10] = 0
    end

    FixPersistentVars()
    for index, uuid in ipairs(PlayerStash) do
        FixAll(uuid)
        -- StashPartneredStatus(true, uuid)
    end
    Osi.DB_Dialogs_StartDatingDialog:Delete(nil)

    -- EVULBAD ADDITION
    -- for loop that goes through PlayerStash and gives all players the NoRomanceLimitFolder spell.
    for _, k in pairs(PlayerStash) do
        Osi.AddSpell(k, "NoRomanceLimitFolder", 1, 1)
    end
    -- EVULBAD ADDITION

    -- EVULBAD REMOVAL
    -- AddSpell(getAvatar(), "NoRomanceLimitFolder", 1, 1)

end)


-- this is when you start long rest
Ext.Osiris.RegisterListener("RequestEndTheDaySuccess", 0, "before", function () 
    DPrint("RequestEndTheDaySuccess")
    for index, uuid in ipairs(PlayerStash) do
        RestorePartneredStatus(uuid)
        restoreStableRelationship(uuid)
    end
    Fix_Databases() -- once per game
    for index, uuid in ipairs(PlayerStash) do
        FixAll(uuid)
    end
end)

-- Ext.Osiris.RegisterListener("LongRestStarted", 0, "before", function ()
--     DPrint("LongRestStarted")
--     StashPartneredStatus(true, getAvatar())
-- end)

Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)
    if PersistentVars[21] == true then
        return
    end

    DPrint(string.format("FlagSet %s %s %s", flag, speaker, dialogInstance))

    if flag == "ORI_State_DatingMinthara_de1360cd-894b-40ea-95a7-1166d675d040" then
        for index, uuid in ipairs(PlayerStash) do
            MinthyFixNew(uuid)
        end
    end
    if #Osi.DB_Avatars:Get(nil) > 0 then
        for index, uuid in ipairs(PlayerStash) do
            FixPartneredDBAndFlags(uuid)
        end
    end
end)
-- Ext.Osiris.RegisterListener("FlagSet", 3, "before", function(flag, speaker, dialogInstance)

--     DPrint(string.format("FlagSetBB %s %s %s", flag, speaker, dialogInstance))
-- end)
-- Ext.Osiris.RegisterListener("FlagCleared", 3, "after", function(flag, speaker, dialogInstance)
--     DPrint(string.format("FlagCleared %s %s %s", flag, speaker, dialogInstance))
-- end)
-- Ext.Osiris.RegisterListener("FlagCleared", 3, "before", function(flag, speaker, dialogInstance)
--     DPrint(string.format("FlagClearedBB %s %s %s", flag, speaker, dialogInstance))
-- end)



-- Ext.Osiris.RegisterListener("PROC_END_GameFinale_BeginFatesGroupDialogues", 0, "before", function()
--     PersistentVars[21] = true
--     print("Fates dialog will now start. Romance states before restore:")
--     PrintAll()
--     EpilogFix()
    
-- end)
Ext.Osiris.RegisterListener("PROC_END_GameFinale_StartEpilogue", 0, "before", function()
    PersistentVars[21] = true
    print("Epilogue will now start. Romance states after before patch:") -- this seems bugged
    PrintAll()
end)
Ext.Osiris.RegisterListener("PROC_END_GameFinale_StartEpilogue", 0, "after", function()
    print("Epilogue started. Romance states after original game logic")
    PrintAll()
    for index, uuid in ipairs(PlayerStash) do
        Osi.RealtimeObjectTimerLaunch(uuid, "NoRomanceLimitEpilogFix", 200)
    end
end)

-- band aid for minthara, unbelievable I have to do this
-- Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function()
--     DPrint("LongRestFinished")
--     Osi.RealtimeObjectTimerLaunch(getAvatar(), "NoRomanceLimitAfterLongRest", 200)
    
-- end)

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function(object, timer)
    if timer == 'NoRomanceLimitEpilogFix' then
        for index, uuid in ipairs(PlayerStash) do
            EpilogFix(uuid)
        end
        print("Romance states restored to:")
        PrintAll()
    end
end)

-- spell listeners added here! function is found in UserSpells.lua
AddUserSpellListeners()

-- halsin patch: force queue halsin romance execution if you check with partner
Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)

    if flag == "CAMP_Halsin_CRD_Romance_CheckWithExistingPartner_b523a2ba-8abf-4116-a5c1-636c77920ca3" then
        Osi.DB_CampNight_Requirement:Delete("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", nil)
        for index, uuid in ipairs(PlayerStash) do
            Osi.SetFlag(partner_flags[eHalsin], uuid)
        end
    end

end)

print("NoRomanceLimit Mod V9.10.EB loaded!")
print("Please report unexpected behavior to EVULBAD since you are playing his edited version of this mod. :3\nnexusmods.com/baldursgate3/mods/1529?tab=posts is a good place to go if the bugs are a result of the base mod, though.")