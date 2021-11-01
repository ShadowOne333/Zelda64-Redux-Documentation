// N64 "Majora's Mask" Widescreen Hack by gamemasterplc
// Port to properly decompressed ROM and additional work by GhostlyDark

arch n64.cpu
endian msb // N64 MIPS requires Big-Endian Encoding (Most Significant Bit)
output "Majora's Mask WS GhostlyDark.z64", create
origin $00000000; insert "mmdec.z64" // Include Decompressed Majora's Mask ROM

include "LIB/N64.INC" // Include N64 Definitions

constant SCREEN_WIDTH(424)
constant SCREEN_HEIGHT(240)
constant BYTES_PER_PIXEL(2)
constant EXPANSION_RAM_SIZE(8388608)
constant DEFAULT_RAM_SIZE(4194304)

origin $00018FC8
dw SCREEN_WIDTH //VI_WIDTH Register Value for NTSC Mode

origin $00018FE0
dw ((SCREEN_WIDTH*512)/320) //VI_X_SCALE Register Value for NTSC Mode

origin $00018FE8
dw SCREEN_WIDTH*BYTES_PER_PIXEL //VI_FRAMEBUFFER_OFFSET Register Value for NTSC Mode

origin $00019010
dw SCREEN_WIDTH //VI_WIDTH Register Value for MPAL Mode

origin $00019030
dw ((SCREEN_WIDTH*512)/320) //VI_X_SCALE Register Value for MPAL Mode

origin $00019038
dw SCREEN_WIDTH*BYTES_PER_PIXEL //VI_FRAMEBUFFER_OFFSET Register Value for MPAL Mode

origin $00B4B874
lui at, 0x4354 //X Position Scale of Z Targeting Cursor (212.0f)

origin $00B4C350
addiu a3, a3, ((SCREEN_WIDTH-320)/2) //X Offset of Boss Names
nop //Pad Code to Original Space

origin $00B4EE08
lui at, 0x4354 //X Position Scale of 3D to 2D Conversions

origin $00B943F8
lui at, 0x4354 //X Position Scale of Stars in Sky

origin $00B97C70
lui at, 0xC336 //X Offset of Beating Heart (-182.0f)

origin $00B9A2A8
lui at, 0x4354 //X Offset of Current Position Arrow on Map (212.0f)

origin $00B9C2A8
addiu t0, r0, SCREEN_WIDTH-25 //X Position of Map

origin $00B9C810
lui at, 0x4354 //X Offset of Starting Position Arrow on Map (212.0f)

origin $00B9F2DC
li at, ($E4000000|((SCREEN_WIDTH/2)-55) << 14) //Texture Rectangle for Dungeon Map Floor Numbers

origin $00B9F2EC
lui at, ((((SCREEN_WIDTH/2)-80) << 14) >> 16) //Upper-Left of Dungeon Map Floor Numbers

origin $00B9F4B8
addiu a3, r0, ((SCREEN_WIDTH/2)-53) //X Position of Right Edge of Current Floor Number Selection on Dungeon Map

origin $00B9F4C8
addiu a2, r0, ((SCREEN_WIDTH/2)-81) //X Position of Left Edge of Current Floor Number Selection on Dungeon Map

origin $00B9F560
li at, ($E4000000|((SCREEN_WIDTH/2)-55) << 14) //Texture Rectangle for Last Floor Number Selection

origin $00B9F570
lui at, ((((SCREEN_WIDTH/2)-80) << 14) >> 16) //Upper-Left of Last Floor Number Selection

origin $00B9F888
addiu a1, t0, ((SCREEN_WIDTH/2)-16) //X Position of Map on Map Screen in Pause Menu

origin $00BAD608
addiu t7, r0, SCREEN_WIDTH //Width of Rotate/Scale HUD Viewport

origin $00BAD8A0
addiu a1, r0, SCREEN_WIDTH-184 //X Position of Start Button

origin $00BADA4C
li t7, ($E4000000|SCREEN_WIDTH-139 << 14|39 << 2) //Define Texture Rectangle Command for Start Button Icon
li t6, (SCREEN_WIDTH-194 << 14|21 << 2) //Upper-Left Corner of Start Button Icon
addiu t9, v1, 8 //Run Some
sw t9, 672(s0) //Replaced Opcodes

origin $00BADB08
addiu a1, r0, SCREEN_WIDTH-66 //X Position of C-Up Button

origin $00BADD24
li t6, ($E4000000|SCREEN_WIDTH-41 << 14|30 << 2) //Define Texture Rectangle Command for Tatl Icon
li t8, (SCREEN_WIDTH-73 << 14|18 << 2) //Upper-Left Corner of Tatl Icon
addiu t7, v1, 8 //Run Some
sw t7, 672(s0) //Replaced Opcodes

origin $00BAF12C
addiu t7, r0, SCREEN_WIDTH-83 //X Position of Right Edge of A Button Shadow

origin $00BAF13C
addiu a3, r0, SCREEN_WIDTH-128 //X Position of A Button Shadow

origin $00BAF2D0
addiu t6, r0, SCREEN_WIDTH-85 //X Position of Right Edge of A Button

origin $00BAF2E0
addiu a3, r0, SCREEN_WIDTH-130 //X Position of A Button

origin $00BAF380
addiu t3, r0, SCREEN_WIDTH-85 //X Position of Right Edge of A Button Text

origin $00BAF390
addiu a3, r0, SCREEN_WIDTH-130 //X Position of A Button Text

origin $00BAFE94
addiu t6, r0, ((SCREEN_WIDTH/2)-64) //X Position of Hour Markers on Clock

origin $00BAFF5C
addiu t9, r0, ((SCREEN_WIDTH/2)-64) //X Position of Clock Exterior

origin $00BB0674
addiu t7, r0, ((SCREEN_WIDTH/2)-20) //X Position of Day Box

origin $00BB0704
addiu t7, r0, ((SCREEN_WIDTH/2)-23) //X Position of Day Number

origin $00BB0B34
lui t9, (($ED000000|(SCREEN_WIDTH/2)-60 << 14) >> 16) //Define Scissor for Sun/Moon Graphics on Clock

origin $00BB0B70
lui at, (((SCREEN_WIDTH/2)+60 << 14) >> 16)  //Define Scissor Lower-Right for Sun/Moon Graphics on Clock

origin $00BB0E98
lui t9, (($ED000000|(SCREEN_WIDTH/2)-60 << 14) >> 16) //Define Scissor for Hour on Clock

origin $00BB0ED4
lui at, (((SCREEN_WIDTH/2)+60 << 14) >> 16)  //Define Scissor Lower-Right for Hour on Clock

origin $00BB4D9C
addiu t2, r0, ((SCREEN_WIDTH/2)-50) //X Position of Epona Carrot Meter

origin $00BB721C
li t6, ($F6000000|(SCREEN_WIDTH/2)+91 << 14|151 << 2) //Define Fill Rectangle Command for Picture Border
li t8, ((SCREEN_WIDTH/2)-91 << 14|22 << 2) //Upper-Left Corner of Picture Border Rectangle
addiu t7, a1, 8 //Run Some
sw t7, 672(s0) //Replaced Opcodes

origin $00BB72E0
lui ra, (((SCREEN_WIDTH/2)-80 << 14) >> 16) 
lui t5, (($E4000000|(SCREEN_WIDTH/2)+80 << 14) >> 16) 

origin $00BD5470
addiu t7, r0, SCREEN_WIDTH //Viewport Width of 3D Viewport

origin $00BD976C
lui a0, (($80000000|(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)+$500) >> 16) //Load Address Upper-Half for Skybox Texture

origin $00BD9778
ori a0, a0, (($80000000|(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)+$500) & 0xFFFF) //Load Address Lower-Half for Skybox Texture

origin $00BD979C
li t8, ($80000000|(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)+$500) //Source Address for Skybox Texture

origin $00BDF218
addiu t6, r0, (((SCREEN_WIDTH-320)/2)+48) //X Position of Cursor in Textbox

origin $00BE757C
addiu t3, r0, (((SCREEN_WIDTH-320)/2)+20) //X Position of Text in Credits

origin $00BE7598
addiu t6, r0, (((SCREEN_WIDTH-320)/2)+65) //X Position of Text in Normal Textbox

origin $00BE7AF0
addiu t4, r0, (((SCREEN_WIDTH-320)/2)+65) //X Position of Text in Pause Screen Textbox

origin $00BE8744
addiu t0, r0, (((SCREEN_WIDTH-320)/2)+34) //X Offset of Song Textbox

origin $00BE9150
li t9, ($E4000000|(((SCREEN_WIDTH-320)/2)+94) << 14|(SCREEN_HEIGHT)-42 << 2) //Texture Rectangle Command for Textbox Song Marker
li t7, ((((SCREEN_WIDTH-320)/2)+78) << 14|(SCREEN_HEIGHT)-74 << 2) //Upper-Left Corner for Textbox Song Marker

origin $00BE9DF0
addiu a3, r0, (((SCREEN_WIDTH-320)/2)+98) //X Offset of Song Guide Notes

origin $00BEA054
addiu a3, r0, (((SCREEN_WIDTH-320)/2)+98) //X Offset of Song Notes

origin $00BEA5E8
lui at, (($E4000000|SCREEN_WIDTH << 14) >> 16) //Texture Rectangle Definition for Stage Name Box

origin $00BEA644
li t8, ((65280/SCREEN_WIDTH) << 16|1024) //DSDX for Stage Name Box Texture Rectangle

origin $00BEAAF0
addiu a2, r0, ((SCREEN_WIDTH/2)-2) //X Position of Long Textbox End of Text Marker

origin $00BEC87C
addiu a2, a2, (((SCREEN_WIDTH-320)/2)-1) //X Offset of Selection Cursor in Deposit/Withdraw Textbox

origin $00BEC988
addiu a2, a2, (((SCREEN_WIDTH-320)/2)-1) //X Offset of Selection Cursor in Code Number Textbox

origin $00BECBFC
addiu a2, r0, ((SCREEN_WIDTH/2)-2) //X Position of End of Text Marker

origin $00BECC38
addiu a2, r0, ((SCREEN_WIDTH/2)-2) //X Position of End of Text Marker in Shop

origin $00BFB34C
addiu t9, r0, SCREEN_WIDTH/2 //X Offset of Left Edge of Lens of Truth Circle

origin $00BFB378
addiu t9, v1, ((SCREEN_WIDTH/2)-1) //X Offset of Right Edge of Lens of Truth Circle

origin $00BFB3B4
lui at, 0x4354 //Lens of Truth Circle Resize Starting Width (212.0f)

origin $00BFB3C0
lui at, 0x42B9 //Width of Lens of Truth Circle (92.5f)

origin $00BFB480
lui at, 0x43D4 //Lens of Truth Orthographic Width (424.0f)

//origin $00BFB9A0
//jr ra //Disable Motion Blur
//nop //Delay Slot for Previous Instruction
//Revert: BFB9A0 --> 27 BD FF C0 AF BF 00 14 00

origin $00BFC380
addiu t8, r0, ((SCREEN_WIDTH/2)+79) //X Position of Right Edge of Camera Capture

origin $00BFC3A0
addiu a2, r0, SCREEN_WIDTH //Camera Capture Screen Width

origin $00BFC3A8
addiu a3, r0, ((SCREEN_WIDTH/2)-80) //X Position of Left Edge of Camera Capture

origin $00BFEB24
addiu t5, r0, SCREEN_WIDTH //Scissor Width of Fadeout Overlays

//origin $00BFEB8C
//addiu t7, r0, 0 //Disable Flashback Scene Overlay
//Revert: BFEB8C --> 90 4F 00 03

origin $00C07D38
jr ra //Pause Screen Crash Prevention
nop //Delay Slot for Previous Instruction

origin $00C09678
addiu v1, r0, ((SCREEN_WIDTH/2)-80) //X Position of Left Border of Camera UI

origin $00C09684
addiu a2, r0, ((SCREEN_WIDTH/2)+60) //X Position of Right Border of Camera UI

origin $00C097A0
addiu t7, r0, ((SCREEN_WIDTH/2)-18) //X Position of Camera Lens Indicator of Camera UI

origin $00C097C8
addiu t1, r0, ((SCREEN_WIDTH/2)+44) //X Position of Camera Information in Camera UI

origin $00C0AE08
lui a0, (((SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL*2)+63) >> 16) //Size of Depth Buffers for Allocation Upper-Half

origin $00C0AE14
ori a0, a0, (((SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL*2)+63) & 0xFFFF) //Size of Depth Buffers for Allocation Lower-Half

origin $00C0AE28
lui a0, ((SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL) >> 16) //Offset of Second Depth Buffer Upper-Half

origin $00C0AE30
ori a0, a0, ((SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL) & 0xFFFF) //Offset of Second Depth Buffer Lower-Half

origin $00C0ED00
addiu t2, r0, SCREEN_WIDTH //Internal Rendering Framebuffer Width

origin $00C0EED0
li t7, ($80000000|EXPANSION_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*2)) //Address of Second Framebuffer in RAM

origin $00C0F47C
addiu t9, r0, SCREEN_WIDTH //Screen Width for Line Offset Calculation on No Expansion Pak Screen
multu a2, t9 //Calculate Line Offset for Drawing No Expansion Pak Screen
mflo t9 //Get Line Offset for Drawing No Expansion Pak Screen

origin $00C0F5F8
addiu s1, r0, SCREEN_WIDTH //Width of Screen for No Expansion Pak Screen Clear

origin $00C0F664
li a1, 0x2072650 //Virtual ROM Address of No Expansion Pak Screen Assets
li a0, ($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)-4736) //Load Address of No Expansion Pak Screen Assets

origin $00C0F67C
lui a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) >> 16) //Upper-Half of Framebuffer Address for No Expansion Pak Screen Clear

origin $00C0F684
ori a0, a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) & 0xFFFF) //Lower-Half of Framebuffer Address for No Expansion Pak Screen Clear
li t9, ($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)-4736)  //Address of N64 Expansion Pak Not Installed Texture
lui a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) >> 16) //Upper-Half of Framebuffer Address for Drawing N64 Expansion Pak Not Installed Texture

origin $00C0F69C
ori a0, a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) & 0xFFFF) //Lower-Half of Framebuffer Address for Drawing N64 Expansion Pak Not Installed Texture

origin $00C0F6A4
addiu a1, r0, ((SCREEN_WIDTH/2)-64) //X Position of N64 Expansion Pak Not Installed Texture

origin $00C0F6B4
li t1, ($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)-2368) //Address of See The Expansion Pak Instruction Booklet Texture
lui a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) >> 16) //Upper-Half of Framebuffer Address for Drawing See The Expansion Pak Instruction Booklet Texture

origin $00C0F6C8
ori a0, a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) & 0xFFFF) //Lower-Half of Framebuffer Address for Drawing See The Expansion Pak Instruction Booklet Texture

origin $00C0F6D0
addiu a1, r0, ((SCREEN_WIDTH/2)-64) //X Position of See The Expansion Pak Instruction Booklet Texture

origin $00C0F6E8
lui a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) >> 16) //Upper-Half of Framebuffer Address for No Expansion Pak Screen

origin $00C0F6F0
ori a0, a0, (($80000000|DEFAULT_RAM_SIZE-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) & 0xFFFF) //Lower-Half of Framebuffer Address for No Expansion Pak Screen

origin $00C55F04
dh SCREEN_WIDTH-162 //X Position of B-Button Text in Situation 1
dh SCREEN_WIDTH-165 //X Position of B-Button Text in Situation 2

origin $00C55F14
dh SCREEN_WIDTH-153 //X Position of B Button
dh SCREEN_WIDTH-93 //X Position of C-Left
dh SCREEN_WIDTH-71 //X Position of C-Down
dh SCREEN_WIDTH-49 //X Position of C-Right

origin $00C56044
dh SCREEN_WIDTH-158 //X Position of B-Button Quantity
dh SCREEN_WIDTH-92 //X Position of C-Left Quantity
dh SCREEN_WIDTH-70 //X Position of C-Down Quantity
dh SCREEN_WIDTH-48 //X Position of C-Right Quantity

origin $00C66908
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 1
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 2
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 3
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 4
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 5
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 6
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 7
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 8
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 9
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 10
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 11
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 12
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 13
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 14
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 15
dh (((SCREEN_WIDTH-320)/2)+34) //X Position of Textbox Type 16

origin $00C7A988
lui at, (($E4000000|((SCREEN_WIDTH/2)+128) << 14) >> 16) //Texture Rectangle Definition for N64 Logo

origin $00C7AAA4
lui at, ((((SCREEN_WIDTH/2)-64) << 14) >> 16) //Texture Rectangle Definition for N64 Logo

origin $00C7B8E8
addiu a1, r0, (((SCREEN_WIDTH/2)-64) >> 3) //X Position of Zelda Map Select Text

origin $00C7B940
addiu a1, r0, (((SCREEN_WIDTH/2)-88) >> 3) //X Position of Stage Names in Zelda Map Select

origin $00C7BA28
addiu a1, r0, ((SCREEN_WIDTH-160) >> 3) //X Position of OPT Value on Zelda Map Select

origin $00C7BD78
addiu a1, r0, ((SCREEN_WIDTH-136) >> 3) //X Position of Day Number on Zelda Map Select

origin $00C7BF74
addiu t7, r0, SCREEN_WIDTH //Scissor Width for Zelda Map Select

origin $00C8ECA8
dh ((SCREEN_WIDTH/2)-70) //Main Menu Please Wait Text X Position
dh ((SCREEN_WIDTH/2)-70) //Main Menu Decide and Cancel Text X Position
dh ((SCREEN_WIDTH/2)-74)  //Main Menu Decide and Save Text X Position

origin $00C8F53C
li t6, ($F6000000|SCREEN_WIDTH << 14|SCREEN_HEIGHT << 2) //Fill Rectangle for Dawn of a New Day Screen

origin $00C8F79C
li t7, ($E4000000|(SCREEN_WIDTH/2) << 14|((SCREEN_HEIGHT/2)+21) << 2) //Texture Rectangle for Dawn of a New Day Texture Left Half
li t8, (((SCREEN_WIDTH/2)-128) << 14|((SCREEN_HEIGHT/2)-43) << 2) //Upper-Left for Dawn of a New Day Texture Left Half
addiu t6, v0, 8 //Run Some
sw t6, 688(v1) //Replaced Opcodes

origin $00C8F960
li t6, ($E4000000|((SCREEN_WIDTH/2)+128) << 14|((SCREEN_HEIGHT/2)+21) << 2) //Texture Rectangle for Dawn of a New Day Texture Right Half
li t7, ((SCREEN_WIDTH/2) << 14|((SCREEN_HEIGHT/2)-43) << 2) //Upper-Left for Dawn of a New Day Texture Right Half
addiu t9, v0, 8 //Run Some
sw t9, 688(v1) //Replaced Opcodes

origin $00C8FAFC
li t8, ($E4000000|((SCREEN_WIDTH/2)+72) << 14|((SCREEN_HEIGHT/2)+56) << 2) //Texture Rectangle for Hours Remaining Texture
li t9, (((SCREEN_WIDTH/2)-72) << 14|((SCREEN_HEIGHT/2)+24) << 2) //Upper-Left for Hours Remaining Texture
addiu t7, v0, 8 //Run Some
sw t7, 688(v1) //Replaced Opcodes

origin $00C97784
addiu s1, r0, ((SCREEN_WIDTH/2)-44) //X Position of Max Number of Dungeon Collectible

origin $00C9791C
addiu t8, r0, ((SCREEN_WIDTH/2)-53) //X Position of Slash Shadow for Dungeon Collectible

origin $00C97958
li t8, ($E4000000|((SCREEN_WIDTH/2)-46) << 14|SCREEN_HEIGHT-79 << 2) //Texture Rectangle for Dungeon Collectible Slash

origin $00C97990
li t9, (((SCREEN_WIDTH/2)-54) << 14|SCREEN_HEIGHT-95 << 2) //Upper-Left of Dungeon Collectible Slash

origin $00C979E0
addiu s1, r0, ((SCREEN_WIDTH/2)-72) //X Position of Current Number of Dungeon Collectible

origin $00C981F0
li t7, ($E4000000|((SCREEN_WIDTH/2)-74) << 14|SCREEN_HEIGHT-76 << 2) //Texture Rectangle for Dungeon Collectible Icon on Pause Screen
li t9, (((SCREEN_WIDTH/2)-106) << 14|SCREEN_HEIGHT-100 << 2) //Upper-Left of Dungeon Collectible Icon on Pause Screen
addiu t5, v0, 8 //Run Some
sw t5, 688(s0) //Replaced Opcodes

origin $00C98464
addiu t9, r0, ((SCREEN_WIDTH/2)-98) //X Position of Link Icon on Dungeon Map Screen

origin $00C984F8
addiu t8, r0, ((SCREEN_WIDTH/2)-52) //X Position of Boss Icon on Dungeon Map Screen

origin $00CA58F4
dh (((SCREEN_WIDTH-320)/2)+95) //X Position of Arrow Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+62) //X Position of Bomb Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+95) //X Position of Bombchu Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+128) //X Position of Deku Stick Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+161) //X Position of Deku Nut Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+194) //X Position of Magic Bean Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+62) //X Position of Powder Keg Count on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+95) //X Position of Pictures Taken on Pause Screen

origin $00CA5934
dh ((((SCREEN_WIDTH-320)/2)+66)*10) //Destination X Position of Pause Screen Item Slide Animation into Slot 1
dh ((((SCREEN_WIDTH-320)/2)+90)*10) //Destination X Position of Pause Screen Item Slide Animation into Slot 2
dh ((((SCREEN_WIDTH-320)/2)+114)*10) //Destination X Position of Pause Screen Item Slide Animation into Slot 3

origin $00CA5A4C
dh (((SCREEN_WIDTH-320)/2)+86) //X Position of Link Icon Spot 1 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+104) //X Position of Link Icon Spot 2 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+145) //X Position of Link Icon Spot 3 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+153) //X Position of Link Icon Spot 4 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+163) //X Position of Link Icon Spot 5 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+159) //X Position of Link Icon Spot 6 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+157) //X Position of Link Icon Spot 7 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+199) //X Position of Link Icon Spot 8 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+208) //X Position of Link Icon Spot 9 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+210) //X Position of Link Icon Spot 10 on Pause Screen
dh (((SCREEN_WIDTH-320)/2)+210) //X Position of Link Icon Spot 11 on Pause Screen

origin $00CA5B84
dh ((((SCREEN_WIDTH-320)/2)+66)*10) //Destination X Position of Pause Screen Mask Slide Animation into Slot 1
dh ((((SCREEN_WIDTH-320)/2)+90)*10) //Destination X Position of Pause Screen Mask Slide Animation into Slot 2
dh ((((SCREEN_WIDTH-320)/2)+114)*10) //Destination X Position of Pause Screen Mask Slide Animation into Slot 3

origin $00DE0724
addiu s2, r0, ((SCREEN_WIDTH/2)-103) //X Position of Majora's Mask Fire Shadow on Logo Screen

origin $00DE0860
addiu a1, r0, ((SCREEN_WIDTH/2)-36) //X Position of Majora Mask Graphic on Logo Screen

origin $00DE0A38
addiu s2, r0, ((SCREEN_WIDTH/2)-103) //X Position of Majora's Mask Fire on Logo Screen

origin $00DE0BE0
addiu t8, r0, ((SCREEN_WIDTH/2)-9) //X Position of Majora's Mask Shadow on Logo Screen

origin $00DE0CE0
addiu t5, r0, ((SCREEN_WIDTH/2)-9) //X Position of Majora's Mask on Logo Screen

origin $00DE0D20
addiu a1, r0, ((SCREEN_WIDTH/2)+17) //X Position of Zelda on Logo Screen

origin $00DE0E30
addiu t8, r0, ((SCREEN_WIDTH/2)-2) //X Position of The Legend of on Logo Screen

origin $00DE0EE8
addiu t9, r0, ((SCREEN_WIDTH/2)-66) //X Position of Copyright on Logo Screen

origin $00DE10F8
li t7, ($E4000000|(SCREEN_WIDTH/2)+132 << 14|(SCREEN_HEIGHT)-55 << 2) //Texture Rectangle Command for N64 Controller Not Connected Text First Line Shadow
li t9, ((SCREEN_WIDTH/2)-124 << 14|(SCREEN_HEIGHT)-64 << 2) //Upper-Left Corner for N64 Controller Not Connected Text First Line Shadow
addiu t5, t6, 8 //Run a
sw t5, 456(sp) //Replaced Opcode

origin $00DE1174
li t9, ($E4000000|(SCREEN_WIDTH/2)+131 << 14|(SCREEN_HEIGHT)-56 << 2) //Texture Rectangle Command for N64 Controller Not Connected Text First Line
li t8, ((SCREEN_WIDTH/2)-125 << 14|(SCREEN_HEIGHT)-65 << 2) //Upper-Left Corner for N64 Controller Not Connected Text First Line
addiu t7, t5, 8 //Run a
sw t7, 456(sp) //Replaced Opcode

origin $00DE1288
li t9, ($E4000000|(SCREEN_WIDTH/2)+76 << 14|(SCREEN_HEIGHT)-42 << 2) //Texture Rectangle Command for N64 Controller Not Connected Text Second Line Shadow
li t8, ((SCREEN_WIDTH/2)-68 << 14|(SCREEN_HEIGHT)-51 << 2) //Upper-Left Corner for N64 Controller Not Connected Text Second Line Shadow
addiu t7, t5, 8 //Run a
sw t7, 456(sp) //Replaced Opcode

origin $00DE12EC
li t8, ($E4000000|(SCREEN_WIDTH/2)+75 << 14|(SCREEN_HEIGHT)-43 << 2) //Texture Rectangle Command for N64 Controller Not Connected Text Second Line
li t6, ((SCREEN_WIDTH/2)-69 << 14|(SCREEN_HEIGHT)-52 << 2) //Upper-Left Corner for N64 Controller Not Connected Text Second Line
addiu t9, t7, 8 //Run a
sw t9, 456(sp) //Replaced Opcode

origin $00DE14A4
addiu s2, r0, ((SCREEN_WIDTH/2)-40) //X Position of No Controller Text Shadow

origin $00DE153C
addiu s2, r0, ((SCREEN_WIDTH/2)-41) //X Position of No Controller Text

origin $00D24E20 //D24E23 --> C5
lui at, 0x43C5 //X Position of Right Arrow in Trading Post

origin $00D24E68 //D24E6B --> BD
lui at, 0x43BD //X Position of Analog Stick Next to Right Arrow in Trading Post

origin $00E78E84 //E78E87 --> C5
lui at, 0x43C5 //X Position of Right Arrow in Shops (e.g. Bomb Shop)

origin $00E78ECC //E78ECF --> BD
lui at, 0x43BD //X Position of Analog Stick Next to Right Arrow in Shops (e.g. Bomb Shop)

origin $01126A70
dw ($E4000000|SCREEN_WIDTH << 14|SCREEN_HEIGHT << 2) //Texture Rectangle for Sand Effect



//Patch manually.

//BB169B --> AB //Final countdown background
//C56180 --> 00 B3 00 BC 00 C4 00 CB 00 D4 00 DC 00 E3 00 EC //Final countdown numbers

//Cutscene effect fixes
//C0AE16 --> B0 //Redux (reduce corruption)
//C0AE29 --> 01
//C0AE31 --> 21
//C0F666 --> 01 EB 34 A5 A0 00

//C99773 --> 50 //Warp screen black overlay
//C99787 --> 19 //Warp screen black overlay

//F06E4B --> A7 //Skull Kid timer position

//Granny story DMA changes
//1A680 --> 00 A9 A0 00 00 A9 A0 10 FF FF FF FF FF FF FF FF
//20530 --> 02 ED B0 00 02 F0 CF 00 02 ED B0 00 00 00 00 00 02 F0 D0 00 02 F0 D0 10 FF FF FF FF FF FF FF FF 02 F0 E0 00 02 F0 E0 10 FF FF FF FF FF FF FF FF 02 F0 F0 00 02 F0 F0 10 FF FF FF FF FF FF FF FF 02 F1 00 00 02 F1 00 10 FF FF FF FF FF FF FF FF 02 F1 10 00 02 F1 10 10 FF FF FF FF FF FF FF FF 02 F1 20 00 02 F1 20 10 FF FF FF FF FF FF FF FF 02 F1 30 00 02 F1 30 10 FF FF FF FF FF FF FF FF 02 F1 40 00 02 F1 40 10 FF FF FF FF FF FF FF FF 02 F1 50 00 02 F1 50 10 FF FF FF FF FF FF FF FF 02 F1 60 00 02 F1 60 10 FF FF FF FF FF FF FF FF 02 F1 70 00 02 F1 70 10 FF FF FF FF FF FF FF FF 02 F1 80 00 02 F1 80 40 FF FF FF FF FF FF FF FF //vanilla
//20530 --> 02 ED B0 00 02 F0 CF 00 02 ED B0 00 00 00 00 00 02 EE 70 00 02 EE 70 40 FF FF FF FF FF FF FF FF 02 F0 D0 00 02 F0 D0 10 FF FF FF FF FF FF FF FF 02 F0 E0 00 02 F0 E0 10 FF FF FF FF FF FF FF FF 02 F0 F0 00 02 F0 F0 10 FF FF FF FF FF FF FF FF 02 F1 00 00 02 F1 00 10 FF FF FF FF FF FF FF FF 02 F1 10 00 02 F1 10 10 FF FF FF FF FF FF FF FF 02 F1 20 00 02 F1 20 10 FF FF FF FF FF FF FF FF 02 F1 30 00 02 F1 30 10 FF FF FF FF FF FF FF FF 02 F1 40 00 02 F1 40 10 FF FF FF FF FF FF FF FF 02 F1 50 00 02 F1 50 10 FF FF FF FF FF FF FF FF 02 F1 60 00 02 F1 60 10 FF FF FF FF FF FF FF FF 02 F1 70 00 02 F1 70 10 FF FF FF FF FF FF FF FF 02 F1 80 00 02 F1 80 40 FF FF FF FF FF FF FF FF 03 80 00 00 03 83 00 00 03 80 00 00 00 00 00 00 //Redux
//20530 --> 02 ED B0 00 02 F0 CF 00 02 ED B0 00 00 00 00 00 02 ED C0 00 02 ED C0 10 FF FF FF FF FF FF FF FF 02 ED D0 00 02 ED D0 10 FF FF FF FF FF FF FF FF 02 ED E0 00 02 ED E0 10 FF FF FF FF FF FF FF FF 02 ED F0 00 02 ED F0 10 FF FF FF FF FF FF FF FF 03 80 00 00 03 86 00 00 03 80 00 00 00 00 00 00 03 90 00 00 03 90 0E 50 03 90 00 00 00 00 00 00 03 90 10 00 03 90 11 00 03 90 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 EE 70 00 02 EE 70 40 FF FF FF FF FF FF FF FF //Redux 2021-03

//Granny story 
//A9A000 --> 67 19 00 03 25 F8 FF FF FF A0 B8 00 01 80 A3 00 EF
//BB5787 --> A8 //Granny story width
//BB5927 --> 6A //Granny story transition
//BB75BE --> 02 EE 3C 0E 02 F1 24 63 B0 00 25 CE CF
//C562CA --> 8D 80 07 03 1B 00 07 03 1D

//Granny story image data
//2EDB000 --> Inject 16_9-story-static.bin

//Mostly unknown. Some of them fix light effects.
//B98E2F --> 54
//BA4F6B --> A7
//BD81DE --> D4
//BD8247 --> 13
//BD827F --> D3
//BD82AF --> D4
//BD82E7 --> D4
//BD82FF --> 02
//BD830F --> 6A
//BD836A --> 06 A0
//BD840A --> 34 B8
//BEC8FE --> 00 33
//BECA16 --> 00 33
//BF06BF --> 61