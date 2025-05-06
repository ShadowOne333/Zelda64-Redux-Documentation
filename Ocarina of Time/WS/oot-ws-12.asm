// gamemasterplc: N64 "Ocarina of Time" Widescreen Hack
// GhostlyDark: Port to ndec decompressed ROM plus improvements
// Admentus: Epona carrots position

arch n64.cpu
endian msb // N64 MIPS requires Big-Endian Encoding (Most Significant Bit)
output "Ocarina of Time v1.2 WS GhostlyDark.z64", create
origin $00000000; insert "ootdec12.z64" // Include Decompressed 1.2 Legend of Zelda, The - Ocarina of Time ROM

include "LIB/N64.INC" // Include N64 Definitions

constant SCREEN_WIDTH(424)
constant SCREEN_HEIGHT(240)
constant BYTES_PER_PIXEL(2)
constant EXPANSION_RAM_SIZE(8388608)
constant DEFAULT_RAM_SIZE(4194304)

origin $00007548
dw SCREEN_WIDTH //VI_WIDTH Register

origin $00007560
dw (SCREEN_WIDTH*512)/320 //VI_X_SCALE Register

origin $00007568
dw SCREEN_WIDTH*2 //VI_ORIGIN Offset

origin $00A95B38
lui at, 0xC3D4 //Minimum X Position of Z Targeting Target (-424.0f)

origin $00A95B44
lui at, 0x4354 //X Position Scale of Z Targeting Target (212.0f)

origin $00A95B4C
lui at, 0x43D4 //Maximum X Position of Z Targeting Target  (424.0f)

origin $00A966E4
addiu a3, a3, ((SCREEN_WIDTH-320)/2) //Center Boss Names
nop //Pad Code to Original Space

origin $00A98AA4
lui at, 0x4354 //3D to 2D X Position Scale  (212.0f)

origin $00A9A66C
li t9, ($E4000000|SCREEN_WIDTH << 14|SCREEN_HEIGHT << 2) //Lens of Truth Texture Rectangle

origin $00A9A688
li t8, (1408 << 16|1600) //Texture Coordinates for Lens of Truth Texture Rectangle

origin $00AC8878
addiu a3, r0, (SCREEN_WIDTH/2) //X Position of Area Names in Dungeon Intros

origin $00AD1E88
addiu t6, r0, SCREEN_WIDTH*2 //Line Offset for Reading Depth Buffer
multu t6, a1 //Calculate Line Offset for Depth Buffer Read
mflo t6 //Get Line Offset for Depth Buffer Read
sll t7, a0, 1 //Get Pixel Offset on Line of Depth Buffer
addu t8, t6, t7 //Get Offset of Current Pixel of Depth Buffer
li v1, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address
addu v1, v1, t8 //Get Address of Current Pixel of  Depth Buffer
jr ra //Return to Caller
lhu v0, 0(v1) //Read Pixel of Depth Buffer

origin $00AD5E1C
lui at, 0x43D4 //Viewport Width for Lens Flare Check  (424.0f)

origin $00AD66A4
li t7, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Sun Filter Fill Rectangle

origin $00AD6ECC
li t0, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Weather Effect Background Fill Rectangle

origin $00AD6F4E
dh 0xF6B7 //Lightning Effect Background Fill Rectangle for Ganon (0xF64F)

origin $00AD6FE6
dh 0xF6B7 //Lightning Effect Background Fill Rectangle (0xF64F)

origin $00AD865C
li t0, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Intro Start Background Fill Rectangle

origin $00AD873C
li t9, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Intro Fades Fill Rectangle

origin $00ADB8D8
lui at, 0xC336 //X Position of Beating Heart (-182.0f)

origin $00ADC82C
li r30, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address for Corona Check

origin $00ADC850
lui at, 0x4354 //Viewport Width for Corona Check  (212.0f)

origin $00ADC95C
addiu t3, r0, SCREEN_WIDTH*2 //Width of Line for Corona Check
multu t3, t2 //Calculate Offset of Current Line for Corona Check
mflo t3 //Get Offset of Current Line for Corona Check

origin $00ADD2E0
addiu a0, a0, SCREEN_WIDTH-116 //X Offset for Dungeon Map Icons

origin $00AE2114
j $80106730 //Call Function to Adjust Dungeon Minimap Arrows

origin $00AE33F8
addiu t7, v0, 8 //Run a Replaced Opcode
sw t7, 688(a1) //Run another Replaced Opcode
li t6, ($E4000000|(SCREEN_WIDTH-50)+8 << 14|(SCREEN_HEIGHT-86)+8 << 2) //Lower-Right of Zora's Fountain Dungeon Icon
li t8, ((SCREEN_WIDTH-50) << 14|SCREEN_HEIGHT-86 << 2) //Upper-Left of Zora's Fountain Dungeon Icon

origin $00AE9F60
addiu t7, t0, 8 //Run a Replaced Opcode
sw t7, 688(s1) //Run another Replaced Opcode
li t6, ($E4000000|(SCREEN_WIDTH-188)+22 << 14|(17+22) << 2) //Lower-Right of Start Button
li t9, ((SCREEN_WIDTH-188) << 14|(17) << 2) //Upper-Left of Start Button

origin $00AEB648
addiu t7, r0, SCREEN_WIDTH //Viewport Width of Scaling/Rotating 2D Elements

origin $00AEEB58
addiu t5, r0, ((SCREEN_WIDTH/2)-20) //Starting X Position of Timer

origin $00AF5CBC
addiu t9, r0, ((SCREEN_WIDTH-320)*2) //X Position of Left Edge of Prerendered Background

origin $00AF5090
li t1, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address for RDP

origin $00B077FC
addiu t7, r0, SCREEN_WIDTH //Viewport Width of Main Menu

origin $00B0A06C
lui at, ($E400|SCREEN_WIDTH >> 2) //Upper-Half of Sepia Effect Texture Rectangle

origin $00B0E7F2
dh 0x3FE3 //z_fbdemo_wipe1.c transition width from 4.0f to 16.0f

origin $00B0E7F6
dh 0x8E39 //z_fbdemo_wipe1.c transition height from 3.0f to 9.0f

origin $00B0E826
dh 0x4394 //z_fbdemo_wipe1.c transition scale from 400.0f to 296.0f

origin $00B0ED8E
dh 0x3FE3 //z_fbdemo_circle.c transition width from 4.0f to 16.0f

origin $00B0ED92
dh 0x8E39 //z_fbdemo_circle.c transition height from 3.0f to 9.0f

origin $00B0EDCA
dh 0x4394 //z_fbdemo_circle.c transition scale from 400.0f to 296.0f

origin $00B12578
li t7, ($80000000|DEFAULT_RAM_SIZE) //Background Texture Address for Pause Screen

origin $00B12484
addiu t9, r0, SCREEN_WIDTH //Fadeout View Width

origin $00B12590
addiu a1, r0, SCREEN_WIDTH //Framebuffer Width for Pause Screen

origin $00B12994
li t7, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Copy Address for Pause Screen

origin $00B129F4
addiu t7, r0, 3 //Skip Stage 2 of Pause to Fix Random Freezes

origin $00B13074
lui at, 0x4354 //Viewport Width for Alternate 3D to 2D Conversion  (212.0f)

origin $00B14E14
nop //Fix Display List Buffer Overflow on Pause Screen

origin $00B15E80
nop //Fix Equipment Preview Corruption on Pause Screen

origin $00B16A0C
lui a3, (($80000000|DEFAULT_RAM_SIZE) >> 16) //Depth Buffer Address Upper-Half for Segment Addressing

origin $00B16A4C
ori a3, a3, (($80000000|(DEFAULT_RAM_SIZE)) & 0xFFFF) //Depth Buffer Address Lower-Half for Segment Addressing

origin $00B17C64
addiu t6, r0, SCREEN_WIDTH //Framebuffer Width for Video

origin $00B1A200
nop //Move Framebuffers to Expansion Pak RAM

origin $00B1A210
lui t6, (($80000000|EXPANSION_RAM_SIZE) >> 16) //End of Last Framebuffer in RAM

origin $00B1A270
li at, (0-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL*2)) //Offset of First Framebuffer from End of RAM

origin $00B1A288
li at, (0-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) //Offset of Second Framebuffer from End of RAM

origin $00B23728
addiu a0, a0, ((SCREEN_WIDTH-320)/2) //X Offset of Crash Handler Boxes

origin $00B2389C
addiu a0, a0, ((SCREEN_WIDTH-320)/2) //X Offset of Crash Handler Text

origin $00B25620
addiu a0, r0, 30 //X Position of First Line of Crash Cause Text

origin $00B25638
addiu a0, r0, 30 //X Position of Second Line of Crash Cause Text

origin $00B25658
addiu a0, r0, 30 //X Position of Third Line of Crash Cause Text

origin $00B4C34C
addiu t3, r0, (48+((SCREEN_WIDTH-320)/2)) //X Position of Selection Cursor in Textbox

origin $00B52858
addiu t9, r0, (20+((SCREEN_WIDTH-320)/2)) //X Position of Credits Text

origin $00B52898
addiu t9, r0, (50+((SCREEN_WIDTH-320)/2)) //X Position of Japanese Text in Textbox

origin $00B528B8
addiu t6, r0, (65+((SCREEN_WIDTH-320)/2)) //X Position of English Text in Textbox

origin $00B53124
addiu t7, r0, (34+((SCREEN_WIDTH-320)/2)) //X Position of Song Textbox Background

origin $00B57F04
addiu v0, r0, (SCREEN_WIDTH-160) //X Position of B Button and Item Icon

origin $00B57F14
addiu t2, r0, (SCREEN_WIDTH-158) //X Position of B Button Item Quantity

origin $00B57F18
addiu v1, r0, (SCREEN_WIDTH-134) //X Position of A Button

origin $00B584A8
addiu t8, r0, SCREEN_WIDTH-198 //X Position of Start Button Text in Japanese

origin $00B584B4
addiu t6, r0, SCREEN_WIDTH-200 //X Position of Start Button Text in English

origin $00B582F4
addiu t6, r0, SCREEN_WIDTH-73 //X Position of C-Up Navi Text

origin $00B584D8
addiu t9, r0, SCREEN_WIDTH-66 //X Position of C-Up Button

origin $00B58504
addiu t9, r0, SCREEN_WIDTH-93 //X Position of C-Left Button

origin $00B58510
addiu t7, r0, SCREEN_WIDTH-71 //X Position of C-Down Button

origin $00B5851C
addiu t9, r0, SCREEN_WIDTH-49 //X Position of C-Right Button

origin $00B5857C
addiu t9, r0, SCREEN_WIDTH-93 //X Position of C-Left Item Icon

origin $00B58588
addiu t7, r0, SCREEN_WIDTH-71 //X Position of C-Down Item Icon

origin $00B58594
addiu t9, r0, SCREEN_WIDTH-49 //X Position of C-Right Item Icon

origin $00B58838
addiu t6, r0, ((SCREEN_WIDTH/2)-2) //X Position of Continue Text Arrow

origin $00B589D4
addiu t7, r0, SCREEN_WIDTH-169 //X Position of Save Icon on Pause Screen in Japanese

origin $00B589E8
addiu t9, r0, SCREEN_WIDTH-172 //X Position of Save Icon on Pause Screen in English

origin $00B58AF0
addiu t8, r0, SCREEN_WIDTH-116 //X Position of Dungeon Map in HUD

origin $00B58BCC
addiu t6, r0, (78+((SCREEN_WIDTH-320)/2)) //X Position of Song Icon Textbox

origin $00B58C40
addiu a2, r0, SCREEN_WIDTH-71 //X Position of C-Down Item Quantity

origin $00B58C74
addiu t8, r0, (98+((SCREEN_WIDTH-320)/2)) //X Position of Song Playback Guide

origin $00B58DC4
addiu t6, r0, SCREEN_WIDTH-92 //X Position of C-Left Item Quantity

origin $00B58DE0
addiu t9, r0, SCREEN_WIDTH-48 //X Position of C-Right Item Quantity

origin $00B58E88
addiu t9, r0, ((SCREEN_WIDTH/2)-96) //X Position of Game Over Text

origin $00B58360
dw 0x240F00A4 //X Position of Epona Carrots

origin $00B6C814
dh SCREEN_WIDTH-104 //X Position of Hyrule Field Minimap
dh SCREEN_WIDTH-104 //X Position of Kakariko Village Minimap
dh SCREEN_WIDTH-102 //X Position of Graveyard Minimap
dh SCREEN_WIDTH-118 //X Position of Zora's River Minimap
dh SCREEN_WIDTH-118 //X Position of Kokiri Forest Minimap
dh SCREEN_WIDTH-70 //X Position of Sacred Meadow Minimap
dh SCREEN_WIDTH-104 //X Position of Lake Hylia Minimap
dh SCREEN_WIDTH-86 //X Position of Zora's Domain Minimap
dh SCREEN_WIDTH-86 //X Position of Zora's Fountain Minimap
dh SCREEN_WIDTH-104 //X Position of Gerudo Valley Minimap
dh SCREEN_WIDTH-86 //X Position of Haunted Wasteland Minimap
dh SCREEN_WIDTH-86 //X Position of Desert Colossus Minimap
dh SCREEN_WIDTH-104 //X Position of Gerudo's Fortress Minimap
dh SCREEN_WIDTH-86 //X Position of Lost Woods Minimap
dh SCREEN_WIDTH-86 //X Position of Hyrule Castle Area Minimap
dh SCREEN_WIDTH-70 //X Position of Death Mountain Trail Minimap
dh SCREEN_WIDTH-104 //X Position of Death Mountain Crater Minimap
dh SCREEN_WIDTH-86 //X Position of Goron City Minimap
dh SCREEN_WIDTH-86 //X Position of Lon Lon Ranch Minimap
dh SCREEN_WIDTH-86 //X Position of Outside Ganon's Castle Minimap

origin $00B6C878
dh ((108*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Hyrule Field Minimap

origin $00B6C880
dh ((100*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Kakariko Village Minimap

origin $00B6C888
dh ((89*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Graveyard Minimap

origin $00B6C890
dh ((72*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Zora's River Minimap

origin $00B6C898
dh ((66*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Kokiri Forest Minimap

origin $00B6C8A0
dh ((122*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Sacred Meadow Minimap

origin $00B6C8A8
dh ((108*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Lake Hylia Minimap

origin $00B6C8B0
dh ((112*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Zora's Domain Minimap

origin $00B6C8B8
dh ((115*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Zora's Fountain Minimap

origin $00B6C8C0
dh ((106*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Gerudo Valley Minimap

origin $00B6C8C8
dh ((110*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Haunted Wasteland Minimap

origin $00B6C8D0
dh ((93*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Desert Colossus Minimap

origin $00B6C8D8
dh ((85*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Gerudo's Fortress Minimap

origin $00B6C8E0
dh ((110*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Lost Woods Minimap

origin $00B6C8E8
dh ((103*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Hyrule Castle Area Minimap

origin $00B6C8F0
dh ((124*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Death Mountain Trail Minimap

origin $00B6C8F8
dh ((103*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Death Mountain Crater Minimap

origin $00B6C900
dh ((110*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Goron City Minimap

origin $00B6C908
dh ((112*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Lon Lon Ranch Minimap

origin $00B6C910
dh ((107*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Outside Ganon's Castle Minimap

origin $00B6C9FA
dh SCREEN_WIDTH-51 //X Position of Bottom of the Well Dungeon Icon

origin $00B6CA00
dh SCREEN_WIDTH-47 //X Position of Deku Tree Dungeon Icon
dh SCREEN_WIDTH-41 //X Position of Sacred Meadow Dungeon Icon
dh SCREEN_WIDTH-61 //X Position of A Dungeon Icon

origin $00B6CA08
dh SCREEN_WIDTH-60 //X Position of Entrypoint 1 of Zora's Fountain Dungeon Icon

origin $00B6CA0E
dh SCREEN_WIDTH-85 //X Position of Spirit Temple Dungeon Icon

origin $00B6CA16
dh SCREEN_WIDTH-53 //X Position of Death Mountain Dungeon Icon

origin $00B6CA18
dh SCREEN_WIDTH-59 //X Position of Death Mountain Crater Dungeon Icon

origin $00B6CA1E
dh SCREEN_WIDTH-60 //X Position of Ganon's Castle Dungeon Icon

origin $00B6CA20
dh SCREEN_WIDTH-26 //X Position of Another Dungeon Icon
dh SCREEN_WIDTH-61 //X Position of Lake Hylia Dungeon Icon

origin $00B6CA26
dh SCREEN_WIDTH-77 //X Position of A Third Dungeon Icon

origin $00B7C050 //Equivalent to 0x80106730 in RAM
lh t8, 0(t7) //Get Position of Arrows for Dungeon Minimap
j $8006C7FC //Return to Game Code
addiu t8, t8, ((SCREEN_WIDTH-320)*5) //Update Position for Dungeon Minimap Arrows

origin $00B89150
dh (54+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 1 X Position
dh (74+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 2 X Position
dh (50+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 3 X Position
dh (72+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 4 X Position

origin $00B89200
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 0 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 1 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 2 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 3 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 4 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 5 Textbox X Position

origin $00B9DEE0
li s7, (((SCREEN_WIDTH/2)-63) << 14) //Left Corner of Nintendo 64 Text
li s6, ($E4000000|((SCREEN_WIDTH/2)+129) << 14) //Right Corner of Nintendo 64 Text
li s4, 0x002FC004 //Run a Replaced Opcode
li s3, 0xF5883000 //Run Another Replaced Opcode
li s2, 0x070BF056 //Run a Third Replaced Opcode
li t4, 0x01000000 //Run a Fourth Replaced Opcode

origin $00B9EF60
addiu a1, r0, (((SCREEN_WIDTH/2)-64)/8) //X Position of ZELDA MAP SELECT Text on Map Select

origin $00B9EFB8
addiu a1, r0, (((SCREEN_WIDTH/2)-88)/8) //X Position of Map Names on Map Select

origin $00B9F0A0
addiu a1, r0, ((SCREEN_WIDTH/2)/8) //X Position of OPT=%d Text on Map Select

origin $00B9F102
dh 0x0010 //X Position of Map Select Loading Messages (0x000A)

origin $00B9F3FC
addiu t9, r0, SCREEN_WIDTH //Max X Position for Text Rendering on Map Select

origin $00BAF6BC
li t8, ($E4000000|(SCREEN_WIDTH/2)+74 << 14|SCREEN_HEIGHT-20 << 2) //Lower-Right Corner of Decide and Cancel on Menu
li t3, ((SCREEN_WIDTH/2)-70 << 14|SCREEN_HEIGHT-36 << 2) //Upper-Left Corner of Decide and Cancel on Menu
addiu t7, v0, 8 //Run a Replaced Opcode
sw t7, 704(t2) //Run another Replaced Opcode

origin $00BC71A8
dh ((66*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Left C Button Item HUD Slide

origin $00BC71AA
dh ((90*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Down C Button Item HUD Slide

origin $00BC71AC
dh ((114*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Right C Button Item HUD Slide

origin $00BE2BC4
addiu a3, r0, (SCREEN_WIDTH/2) //X Position of Area Names in Intros

origin $00C701FC
lui at, 0x43C5 //X Position of Right Arrow in Shops (394.0f)

origin $00C70244
lui at, 0x43BD //X Position of Right Arrow Analog Stick in Shops (378.0f)

origin $00CFB7CA
dh 0xF6B7 //Din's Fire overlay width (0xF64F)

origin $00DE1E6E
dh 0xF6B7 //Fire Arrow overlay width (0xF64F)

origin $00DE3D56
dh 0xF6B7 //Ice Arrow overlay width (0xF64F)

origin $00DE5C32
dh 0xF6B7 //Light Arrow overlay width (0xF64F)

origin $00E6C83C
addiu t8, r0, ((SCREEN_WIDTH/2)-41) //X Position of Press Start Text

origin $00E6C88C
addiu t8, r0, ((SCREEN_WIDTH/2)-61) //X Position of No Controller Text

origin $00E6E3C0
addiu s4, r0, ((SCREEN_WIDTH/2)-96) //X Position of Flame Effect on Game Logo

origin $00E6E4F4
addiu a1, r0, SCREEN_WIDTH/2 //X Position of Game Logo

origin $00E6E51C
addiu a1, r0, SCREEN_WIDTH/2 //X Position of Disk Icon on Title Screen

origin $00E6E6E8
addiu t3, r0, ((SCREEN_WIDTH/2)-6) //X Position of The Legend of Text Shadow

origin $00E6E730
addiu t1, r0, ((SCREEN_WIDTH/2)-8) //X Position of Ocarina of Time Text Shadow

origin $00E6E7CC
addiu t8, r0, ((SCREEN_WIDTH/2)-7) //X Position of The Legend of Text

origin $00E6E828
addiu t5, r0, ((SCREEN_WIDTH/2)-9) //X Position of Ocarina of Time Text

origin $00E6EBCC
li t5, ($E4000000|(SCREEN_WIDTH/2)+74 << 14|(SCREEN_HEIGHT/2)+40 << 2) //Lower-Right Corner of Japanese Subtitle of Logo
li t2, ((SCREEN_WIDTH/2)-54 << 14|(SCREEN_HEIGHT/2)+24 << 2) //Upper-Left Corner of Japanese Subtitle of Logo
addiu t1, t9, 8 //Run a Replaced Opcode
sw t1, 416(sp) //Run another Replaced Opcode

origin $00E6EDB0
li t8, ($E4000000|(SCREEN_WIDTH/2)+62 << 14|SCREEN_HEIGHT-26 << 2) //Lower-Right Corner of Title Screen Copyright
li t3, ((SCREEN_WIDTH/2)-66 << 14|SCREEN_HEIGHT-42 << 2) //Upper-Left Corner of Title Screen Copyright
addiu t1, t2, 8 //Run a Replaced Opcode
sw t1, 416(sp) //Run another Replaced Opcode

origin $00E96C00
li t8, ($E4000000|(SCREEN_WIDTH/2)+40 << 14|(SCREEN_HEIGHT/2)-7 << 2) //Lower-Right Corner of The End Graphic
li t7, ((SCREEN_WIDTH/2)-40 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left Corner of The End Graphic
addiu t6, v1, 8 //Run a Replaced Opcode
sw t6, 688(a1) //Run another Replaced Opcode

origin $00E96D44
li t7, ($E4000000|(SCREEN_WIDTH/2)+60 << 14|(SCREEN_HEIGHT/2)+63 << 2) //Lower-Right Corner of Ending The Legend of Zelda Graphic
li t9, ((SCREEN_WIDTH/2)-60 << 14|(SCREEN_HEIGHT/2)+40 << 2) //Upper-Left Corner of Ending The Legend of Zelda Graphic
addiu t8, v1, 8 //Run a Replaced Opcode
sw t8, 688(a1) //Run another Replaced Opcode

origin $00E96E80
li t8, ($E4000000|(SCREEN_WIDTH/2)+56 << 14|(SCREEN_HEIGHT/2)+72 << 2) //Lower-Right Corner of Ending Ocarina of Time Graphic
li t7, ((SCREEN_WIDTH/2)-56 << 14|(SCREEN_HEIGHT/2)+57 << 2) //Upper-Left Corner of Ending Ocarina of Time Graphic
addiu t6, v1, 8 //Run a Replaced Opcode
sw t6, 688(a1) //Run another Replaced Opcode

origin $00E9A898
dw ($E4000000|SCREEN_WIDTH/2 << 14|(SCREEN_HEIGHT/2)+17 << 2) //Lower-Right of Left Side of Nintendo Logo
dw ((SCREEN_WIDTH/2)-63 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left of Left Side of Nintendo Logo

origin $00E9A8E8
dw ($E4000000|(SCREEN_WIDTH/2)+63 << 14|(SCREEN_HEIGHT/2)+17 << 2) //Lower-Right of Right Side of Nintendo Logo
dw (SCREEN_WIDTH/2 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left of Right Side of Nintendo Logo

origin $00E9A938
dw ($E4000000|(SCREEN_WIDTH/2)+48 << 14|(SCREEN_HEIGHT/2)-25 << 2) //Lower-Right of Presented By Text
dw ((SCREEN_WIDTH/2)-47 << 14|(SCREEN_HEIGHT/2)-40 << 2) //Upper-Left of Presented By Text

origin $00EB5062
dh 0xE46A //Song of Storms Effect (0xE450)

origin $00EC3890
dw 0x449C4000 //Epona's Song Effect (0x44A64000)

origin $00EC3894
dw 0x449C4000 //Epona's Song Effect (0x44A64000)

origin $00EC4FE0
dw 0x449C4000 //Saria's Song Effect (0x44A64000)

origin $00EC4FE4
dw 0x449C4000 //Saria's Song Effect (0x44A64000)

origin $00EF7AE0
dw 0x449C4000 //Scarecrow Song / Zelda Escape Effect (0x44A64000)

origin $00EF7AE4
dw 0x449C4000 //Scarecrow Song / Zelda Escape Effect (0x44A64000)

origin $00F6BB10
dw ($E4000000|SCREEN_WIDTH << 14| SCREEN_HEIGHT << 2) //Texture Rectangle for Sand Effect in Haunted Wasteland
