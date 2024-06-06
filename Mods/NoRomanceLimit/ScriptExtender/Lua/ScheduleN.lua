
function ScheduleNight(night, force)
    if #Osi.DB_InCamp:Get(getAvatar()) > 0 then
        print("Please only call this function outside camp!")
        return
    end

    if #(Osi.DB_CampNight:Get(night, nil)) > 0 then
        print(string.format("Warning: The night %s is queued but has not played.", night))
        if not force then
            print("proceeding anyways...")
            Mods.NoRomanceLimit.CheckNight(night)
            return
        end
    end
    
    CleanNightReqs(night)
    DoSched(night)
    print("Done.")
end

function CleanNightReqs(night)
    Osi.DB_CampNight:Delete(night, nil)
    Osi.DB_CampNight_Camp:Delete(night, nil)
    Osi.DB_CampNight_RomanceNight:Delete(night,nil,nil,nil)
    Osi.DB_CampNight_Requirement_Approval:Delete(night, nil, nil)

    Osi.DB_CampNight_Requirement_CanStartDating:Delete(night, nil)
    Osi.DB_CampNight_Requirement_Dating:Delete(night, nil)
    Osi.DB_CampNight_Requirement_Partner:Delete(night, nil)

    Osi.DB_CampNight_CRD:Delete(night,nil,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil,nil,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil,nil,nil,nil,nil)
    Osi.DB_CampNight_Requirement:Delete(night,nil,nil,nil,nil,nil,nil,nil)
    
end


function DoSched(name)
if name == "NIGHT_Laezel_Romance3_fe454112-39f1-46c5-888c-02c98f4419aa" then
Osi.DB_CampNight("NIGHT_Laezel_Romance3_fe454112-39f1-46c5-888c-02c98f4419aa", 9999);
Osi.DB_CampNight_Camp("NIGHT_Laezel_Romance3_fe454112-39f1-46c5-888c-02c98f4419aa", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Laezel_Romance3_fe454112-39f1-46c5-888c-02c98f4419aa", "ELFSONG");
Osi.DB_CampNight_MorningIVB("NIGHT_Laezel_Romance3_fe454112-39f1-46c5-888c-02c98f4419aa", "CAMP_Laezel_ROM_Romance3_MorningIVB_46a83c6e-ff94-7478-7935-9c1db48c1c9f", "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12");
end
if name == "NIGHT_Karlach_ANightAtTheTown_8d07ffbd-868d-468b-9ac0-84f2d8adaeaa" then
Osi.DB_CampNight("NIGHT_Karlach_ANightAtTheTown_8d07ffbd-868d-468b-9ac0-84f2d8adaeaa", 9999);
Osi.DB_CampNight_Camp("NIGHT_Karlach_ANightAtTheTown_8d07ffbd-868d-468b-9ac0-84f2d8adaeaa", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Karlach_ANightAtTheTown_8d07ffbd-868d-468b-9ac0-84f2d8adaeaa", "ELFSONG");
Osi.DB_CampNight_CRD("NIGHT_Karlach_ANightAtTheTown_8d07ffbd-868d-468b-9ac0-84f2d8adaeaa", "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c", "CAMP_Karlach_CRD_ROM_Date_2bf0d0c0-495c-6866-d5ad-d37dd4fa3648", "NULL_00000000-0000-0000-0000-000000000000");
end
if name == "NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d" then
Osi.DB_CampNight("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", 9999);
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", "FARM");
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", "ELFSONG");
Osi.DB_CampNight_CRD("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679", "CAMP_Shadowheart_CRD_SkinnyDippingRomance_dfb63080-93da-035a-0435-56eee35a63c0", "NULL_00000000-0000-0000-0000-000000000000");
Osi.DB_CampNight_RomanceNight("NIGHT_Shadowheart_Skinnydipping_9f583304-0a1a-498c-acf9-3c8dcc30ee3d", "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679", "CAMP_Shadowheart_SkinnyDipping_SD_ROM_700d677f-1bfd-1c83-8530-0db12875c33b","ORI_Shadowheart_Event_SkinnyDippingRomanceScene_3437a073-b92a-4999-b6b9-e7745865a0c2");
end
if name == "NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad" then
Osi.DB_CampNight("NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad", 9999);
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad", "FARM");
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad", "ELFSONG");
Osi.DB_CampNight_CRD("NIGHT_Shadowheart_SharRomance_692ba0b6-e88d-4215-bbf9-6d89c141d1ad", "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679", "CAMP_Shadowheart_CRD_SharRomance_c1cefc29-3ca9-414f-9351-ee98a6103c2c", "NULL_00000000-0000-0000-0000-000000000000");
end
if name == "NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed" then
Osi.DB_CampNight("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", 9999);
Osi.DB_CampNight_Camp("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", "FARM");
Osi.DB_CampNight_Camp("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", "ELFSONG");
Osi.DB_CampNight_RomanceNight("NIGHT_Halsin_Romance_Execution_a9634ef4-27ec-4a75-be9d-7c738d9768ed", "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323", "CAMP_HalsinRomanceAct3_SD_ROM_3d042271-f13a-fc4a-50b3-6f7e51f1b7ba", "NULL_00000000-0000-0000-0000-000000000000");
end
if name == "NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66" then
Osi.DB_CampNight("NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66", 9999);
Osi.DB_CampNight_Camp("NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66", "FARM");
Osi.DB_CampNight_Camp("NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66", "ELFSONG");
Osi.DB_CampNight_CRD("NIGHT_Gale_BeMyGod_2259ec28-b538-4895-a431-30dc7e2ddf66", "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604", "CAMP_Gale_CRD_BeMyGod_df11dcbe-6478-06f8-efe6-f763ee87d5c4", "NULL_00000000-0000-0000-0000-000000000000");
Osi.DB_OnlyOnce:Delete("ORI_Gale_IPRD_BeMyGod")
end
if name == "NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231" then
Osi.DB_CampNight("NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231", 9999);
Osi.DB_CampNight_Camp("NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231", "FARM");
Osi.DB_CampNight_Camp("NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231", "SLUMS");
Osi.DB_CampNight_Camp("NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231", "ELFSONG");
Osi.DB_CampNight_CRD("NIGHT_Wyll_Act3Romance_0dec1691-512f-4b13-9249-5cce64227231", "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d", "CAMP_Wyll_CRD_Act3Romance_599fe884-f39f-a3b5-7a86-ca239e016a05", "NULL_00000000-0000-0000-0000-000000000000");
end
if name == "NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7" then
DB_CampNight("NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7", 4190);
DB_CampNight_Camp("NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7", "SLUMS");
DB_CampNight_Camp("NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7", "ELFSONG");
DB_CampNight_Camp("NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7", "FARM");
DB_CampNight_RomanceNight("NIGHT_Astarion_BlackMassAftermath_347b8d34-c287-4d15-83c5-7ae6786003c7", "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255", "CAMP_Astarion_SD_ROM_BlackMassAftermath_cdc9ae59-c30e-3819-4060-d46263681631", "NULL_00000000-0000-0000-0000-000000000000");
DB_OriginMayLeaveDialog("S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255", "CAMP_Astarion_SD_ROM_BlackMassAftermath_cdc9ae59-c30e-3819-4060-d46263681631");
end



end