namespace AotForm
{
    internal static class Offsets
    {
        internal static uint Il2Cpp;
        internal static uint UnityCpp;
        internal static uint InitBase = 0xA988FDC;
        internal static uint StaticClass = 0x5C;

        // Match Related
        internal static uint CurrentMatch = 0x50;
        internal static uint MatchStatus = 0x8C;
        internal static uint LocalPlayer = 0x94;
        internal static uint LocalPlayerAttributes = 0x4BC;
        internal static uint DictionaryEntities = 0x68;

        // Player
        internal static uint TeamID = 0x29C;
        internal static uint Player_IsDead = 0x50;
        internal static uint Player_Name = 0x2DC;
        internal static uint Player_Data = 0x48;
        internal static uint Player_ShadowBase = 0x18B8;
        internal static uint XPose = 0x78;
        internal static uint AvatarManager = 0x4C0;
        internal static uint Avatar = 0xA8;
        internal static uint Avatar_IsVisible = 0x95;
        internal static uint Avatar_Data = 0x14;
        internal static uint Avatar_Data_IsTeam = 0x59;
        internal static uint Avatar_Data_IsBot = 0x2E4;
        internal static uint PlayerID = 0x268;
        internal static uint BaseProfileInfo = 0x18CC;
        internal static uint IsClientBot = 0x2E4;

        // Camera
        internal static uint FollowCamera = 0x450;
        internal static uint Camera = 0x18;
        internal static uint MainCameraTransform = 0x24C;
        internal static uint AimRotation = 0x400;
        internal static uint ViewMatrix = 0xE8;

        // Loot / ESP Items
        internal static uint Loot_ID = 0x8;
        internal static uint Loot_Pos = 0x48;
        internal static uint LevelObjectManager = 0x60;
        internal static uint LevelObjectList = 0x30;

        // Observer
        internal static uint CurrentObserver = 0xB4;
        internal static uint ObserverPlayer = 0x28;

        // Weapon
        internal static uint Weapon = 0x3F4;
        internal static uint WeaponData = 0x58;
        internal static uint WeaponRecoil = 0xC;
        internal static uint UnkPlayerWeaponInfoClass = 0x4A8;
        internal static uint IsCombineWeapon = 0xD8;
        internal static uint WeaponOnHand = 0x54;
        internal static uint CombineWeaponOnHand = 0x58;
        internal static uint WeaponInfo = 0x64;
        internal static uint WeaponID = 0x14;
        internal static uint Weapon_Damage = 0x8;

        // Silent Aim / Aim Info
        internal static uint LastAimingInfoFromWeapon = 0x978;
        internal static uint StartPosition = 0x38;
        internal static uint RayDir = 0x2C;
        internal static uint LockedAimingCollider = 0x54;
        internal static uint HeadCollider = 0x4A4;

        // Aiming (firing/rotate)
        internal static uint LocalPlayerIsFiring = 0x48C;
        internal static uint SilentAimShoot = 0x48C;
        internal static uint SilentAimRotate = 0x4A0;

        // Aimkill
        internal static uint LocalPlayer_Target = 0x48;
        internal static uint Enemy_Knockdowns = 0x68;
        internal static uint Player_Inventory = 0x1B0;

        // Misc
        internal static uint PlayerAttributes = 0x4B0;
        internal static uint NoReload = 0x99;
        internal static uint RunSpeedUpScale = 0x1D8;
        internal static uint FallingSpeedUpScale = 0x1B8;
        internal static uint GameTimer = 0x10;
        internal static uint FixedDeltaTime = 0x24;
        internal static uint BuffWeaponMoveSpeedScale = 0xBC;
        internal static uint InSnowSlideWayDashing = 0x15E8;
        internal static uint m_ReviveHP = 0xF4;
        internal static uint isBotOffs = 0xC0;

        // Jump / misc
        internal static uint highjumpff = 0x893EC6C;

        // Legacy aim aliases
        internal static uint sAim1 = 0x540;
        internal static uint sAim2 = 0x978;
        internal static uint sAim3 = 0x38;
        internal static uint sAim4 = 0x2C;

        // Portuguese aim aliases
        internal static uint pomba = 0x540;
        internal static uint bisteca = 0x978;
        internal static uint arma = 0x38;
        internal static uint tiro = 0x2C;


        internal static uint TeleportMark_UIInGameScene = 0x8;
        internal static uint TeleportMark_BigMapCtrl = 0x218;
        internal static uint TeleportMark_MapContentCtrl = 0x54;
        internal static uint TeleportMark_LocalMapMarkController = 0x90;
        internal static uint TeleportMark_MarkPos = 0x58;
    }
}
