// gamemasterplc: N64 "Ocarina of Time" Widescreen Hack
// GhostlyDark: Port to ndec decompressed ROM plus improvements
// Admentus: Epona carrots position
// Marcelo20XX: Start Button position

arch n64.cpu
endian msb // N64 MIPS requires Big-Endian Encoding (Most Significant Bit)
output "Ocarina of Time v1.0 WS GhostlyDark.z64", create
origin $00000000; insert "ootdec.z64" // Include Decompressed 1.0 Legend of Zelda, The - Ocarina of Time ROM

include "LIB/N64.INC" // Include N64 Definitions

constant SCREEN_WIDTH(424)
constant SCREEN_HEIGHT(240)
constant BYTES_PER_PIXEL(2)
constant EXPANSION_RAM_SIZE(8388608)
constant DEFAULT_RAM_SIZE(4194304 + 1048576)

origin $00006FC8
dw SCREEN_WIDTH //VI_WIDTH Register
//00 00 01 40 --> 00 00 01 A8

origin $00006FE0
dw (SCREEN_WIDTH*512)/320 //VI_X_SCALE Register
//00 00 02 00 --> 00 00 02 6A

origin $00006FE8
dw SCREEN_WIDTH*2 //VI_ORIGIN Offset
//00 00 02 80 --> 00 00 03 50

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

origin $00AC8828
addiu a3, r0, (SCREEN_WIDTH/2) //X Position of Area Names in Dungeon Intros

origin $00AD1E38
addiu t6, r0, SCREEN_WIDTH*2 //Line Offset for Reading Depth Buffer
multu t6, a1 //Calculate Line Offset for Depth Buffer Read
mflo t6 //Get Line Offset for Depth Buffer Read
sll t7, a0, 1 //Get Pixel Offset on Line of Depth Buffer
addu t8, t6, t7 //Get Offset of Current Pixel of Depth Buffer
li v1, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address
addu v1, v1, t8 //Get Address of Current Pixel of  Depth Buffer
jr ra //Return to Caller
lhu v0, 0(v1) //Read Pixel of Depth Buffer

origin $00AD5DA0
lui at, 0x43D4 //Viewport Width for Lens Flare Check  (424.0f)

origin $00AD6628
li t7, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Sun Filter Fill Rectangle

origin $00AD6E44
li t0, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Weather Effect Background Fill Rectangle

origin $00AD6F5E
dh 0xF6B7 //Lightning Effect Background Fill Rectangle (0xF64F)

origin $00AD85D4
li t0, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Intro Start Background Fill Rectangle

origin $00AD86B4
li t9, ($F6000000|SCREEN_WIDTH-1 << 14|SCREEN_HEIGHT-1 << 2) //Intro Fades Fill Rectangle

origin $00ADB858
lui at, 0xC336 //X Position of Beating Heart (-182.0f)

origin $00ADC7AC
li r30, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address for Corona Check

origin $00ADC7D0
lui at, 0x4354 //Viewport Width for Corona Check  (212.0f)

origin $00ADC8DC
addiu t3, r0, SCREEN_WIDTH*2 //Width of Line for Corona Check
multu t3, t2 //Calculate Offset of Current Line for Corona Check
mflo t3 //Get Offset of Current Line for Corona Check

origin $00ADD260
addiu a0, a0, SCREEN_WIDTH-116 //X Offset for Dungeon Map Icons

origin $00AE20F4
j $801060A0 //Call Function to Adjust Dungeon Minimap Arrows

origin $00AE33D8
addiu t7, v0, 8 //Run a Replaced Opcode
sw t7, 688(a1) //Run another Replaced Opcode
li t6, ($E4000000|(SCREEN_WIDTH-50)+8 << 14|(SCREEN_HEIGHT-86)+8 << 2) //Lower-Right of Zora's Fountain Dungeon Icon
li t8, ((SCREEN_WIDTH-50) << 14|SCREEN_HEIGHT-86 << 2) //Upper-Left of Zora's Fountain Dungeon Icon

origin $00AEB618
addiu t7, r0, SCREEN_WIDTH //Viewport Width of Scaling/Rotating 2D Elements

origin $00AEEB24
addiu t5, r0, ((SCREEN_WIDTH/2)-20) //Starting X Position of Timer

origin $00AF5C6C
addiu t9, r0, ((SCREEN_WIDTH-320)*2) //X Position of Left Edge of Prerendered Background

origin $00AF5040
li t1, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Address for RDP

origin $00B077FC
addiu t7, r0, SCREEN_WIDTH //Viewport Width of Main Menu

origin $00B09FBC
lui at, ($E400|SCREEN_WIDTH >> 2) //Upper-Half of Sepia Effect Texture Rectangle

origin $00B124C8 //B670
li t7, ($80000000|DEFAULT_RAM_SIZE) //Background Texture Address for Pause Screen

origin $00B123D4
addiu t9, r0, SCREEN_WIDTH //Fadeout View Width

origin $00B124E0
addiu a1, r0, SCREEN_WIDTH //Framebuffer Width for Pause Screen

origin $00B128E4
li t7, ($80000000|DEFAULT_RAM_SIZE) //Depth Buffer Copy Address for Pause Screen

origin $00B12944
addiu t7, r0, 3 //Skip Stage 2 of Pause to Fix Random Freezes

origin $00B12FC4
lui at, 0x4354 //Viewport Width for Alternate 3D to 2D Conversion  (212.0f)

origin $00B14D64
nop //Fix Display List Buffer Overflow on Pause Screen

origin $00B15DD0
nop //Fix Equipment Preview Corruption on Pause Screen

origin $00B1695C
lui a3, (($80000000|DEFAULT_RAM_SIZE) >> 16) //Depth Buffer Address Upper-Half for Segment Addressing

origin $00B1699C
ori a3, a3, (($80000000|(DEFAULT_RAM_SIZE)) & 0xFFFF) //Depth Buffer Address Lower-Half for Segment Addressing

origin $00B17BC4
addiu t6, r0, SCREEN_WIDTH //Framebuffer Width for Video

origin $00B1A270
nop //Move Framebuffers to Expansion Pak RAM

origin $00B1A280
lui t6, (($80000000|EXPANSION_RAM_SIZE) >> 16) //End of Last Framebuffer in RAM

origin $00B1A2E0
li at, (0-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL*2)) //Offset of First Framebuffer from End of RAM

origin $00B1A2F8
li at, (0-(SCREEN_WIDTH*SCREEN_HEIGHT*BYTES_PER_PIXEL)) //Offset of Second Framebuffer from End of RAM

origin $00B23574
addiu a0, a0, ((SCREEN_WIDTH-320)/2) //X Offset of Crash Handler Boxes

origin $00B23548
addiu a0, a0, ((SCREEN_WIDTH-320)/2) //X Offset of Crash Handler Text

origin $00B25600
addiu a0, r0, 30 //X Position of First Line of Crash Cause Text

origin $00B25618
addiu a0, r0, 30 //X Position of Second Line of Crash Cause Text

origin $00B25638
addiu a0, r0, 30 //X Position of Third Line of Crash Cause Text

origin $00B4C35C
addiu t3, r0, (48+((SCREEN_WIDTH-320)/2)) //X Position of Selection Cursor in Textbox

origin $00B5286C
addiu t9, r0, (20+((SCREEN_WIDTH-320)/2)) //X Position of Credits Text

origin $00B528AC
addiu t9, r0, (50+((SCREEN_WIDTH-320)/2)) //X Position of Japanese Text in Textbox

origin $00B528CC
addiu t6, r0, (65+((SCREEN_WIDTH-320)/2)) //X Position of English Text in Textbox

origin $00B53138
addiu t7, r0, (34+((SCREEN_WIDTH-320)/2)) //X Position of Song Textbox Background

origin $00B57EEC
addiu v0, r0, (SCREEN_WIDTH-160) //X Position of B Button and Item Icon

origin $00B57EFC
addiu t2, r0, (SCREEN_WIDTH-158) //X Position of B Button Item Quantity

origin $00B57F00
addiu v1, r0, (SCREEN_WIDTH-134) //X Position of A Button

origin $00B58490
addiu t8, r0, SCREEN_WIDTH-198 //X Position of Start Button Text in Japanese

origin $00B5849C
addiu t6, r0, SCREEN_WIDTH-200 //X Position of Start Button Text in English

origin $00B582DC
addiu t6, r0, SCREEN_WIDTH-73 //X Position of C-Up Navi Text

origin $00B584C0
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

origin $00B58348
dw 0x240F00A4 //X Position of Epona Carrots

origin $00B584EC
dw 0x241900ED //X Position of Start Button

origin $00B6C814
dh SCREEN_WIDTH-104 //X Position of Hyrule Field Minimap
dh SCREEN_WIDTH-104 //X Position of Kakiriko Village Minimap
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
dh ((100*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Kakiriko Village Minimap

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

origin $00B7C000 //Equivalent to 0x801060A0 in RAM
lh t8, 0(t7) //Get Position of Arrows for Dungeon Minimap
j $8006C19C //Return to Game Code
addiu t8, t8, ((SCREEN_WIDTH-320)*5) //Update Position for Dungeon Minimap Arrows

origin $00B890E0
dh (54+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 1 X Position
dh (74+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 2 X Position
dh (50+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 3 X Position
dh (72+((SCREEN_WIDTH-320)/2)) //Textbox Icon Type 4 X Position

origin $00B89190
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 0 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 1 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 2 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 3 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 4 Textbox X Position
dh (34+((SCREEN_WIDTH-320)/2)) //Textbox Type 5 Textbox X Position

origin $00B9DEB0
li s7, (((SCREEN_WIDTH/2)-63) << 14) //Left Corner of Nintendo 64 Text
li s6, ($E4000000|((SCREEN_WIDTH/2)+129) << 14) //Right Corner of Nintendo 64 Text
li s4, 0x002FC004 //Run a Replaced Opcode
li s3, 0xF5883000 //Run Another Replaced Opcode
li s2, 0x070BF056 //Run a Third Replaced Opcode
li t4, 0x01000000 //Run a Fourth Replaced Opcode

origin $00B9EF30
addiu a1, r0, (((SCREEN_WIDTH/2)-64)/8) //X Position of ZELDA MAP SELECT Text on Map Select

origin $00B9EF88
addiu a1, r0, (((SCREEN_WIDTH/2)-88)/8) //X Position of Map Names on Map Select

origin $00B9F070
addiu a1, r0, ((SCREEN_WIDTH/2)/8) //X Position of OPT=%d Text on Map Select

origin $00B9F3CC
addiu t9, r0, SCREEN_WIDTH //Max X Position for Text Rendering on Map Select

origin $00BAF68C
li t8, ($E4000000|(SCREEN_WIDTH/2)+74 << 14|SCREEN_HEIGHT-20 << 2) //Lower-Right Corner of Decide and Cancel on Menu
li t3, ((SCREEN_WIDTH/2)-70 << 14|SCREEN_HEIGHT-36 << 2) //Upper-Left Corner of Decide and Cancel on Menu
addiu t7, v0, 8 //Run a Replaced Opcode
sw t7, 704(t2) //Run another Replaced Opcode

origin $00BC7178
dh ((66*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Left C Button Item HUD Slide

origin $00BC717A
dh ((90*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Down C Button Item HUD Slide

origin $00BC717C
dh ((114*10)+(((SCREEN_WIDTH-320)*5))) //X Destination Position of Right C Button Item HUD Slide

origin $00BE2B10
addiu a3, r0, (SCREEN_WIDTH/2) //X Position of Area Names in Intros

origin $00C7005C
lui at, 0x43C5 //X Position of Right Arrow in Shops (394.0f)

origin $00C700A4
lui at, 0x43BD //X Position of Right Arrow Analog Stick in Shops (378.0f)

origin $00CFB43A
dh 0xF6B7 //Din's Fire overlay width (0xF64F)

origin $00DE1A0E
dh 0xF6B7 //Fire Arrow overlay width (0xF64F)

origin $00DE38F6
dh 0xF6B7 //Ice Arrow overlay width (0xF64F)

origin $00DE57D2
dh 0xF6B7 //Light Arrow overlay width (0xF64F)

origin $00E6C2FC
addiu t8, r0, ((SCREEN_WIDTH/2)-41) //X Position of Press Start Text

origin $00E6C34C
addiu t8, r0, ((SCREEN_WIDTH/2)-61) //X Position of No Controller Text

origin $00E6DE80
addiu s4, r0, ((SCREEN_WIDTH/2)-96) //X Position of Flame Effect on Game Logo

origin $00E6DFB4
addiu a1, r0, SCREEN_WIDTH/2 //X Position of Game Logo

origin $00E6DFDC
addiu a1, r0, SCREEN_WIDTH/2 //X Position of Disk Icon on Title Screen

origin $00E6E1A8
addiu t3, r0, ((SCREEN_WIDTH/2)-6) //X Position of The Legend of Text Shadow

origin $00E6E1F0
addiu t1, r0, ((SCREEN_WIDTH/2)-8) //X Position of Ocarina of Time Text Shadow

origin $00E6E28C
addiu t8, r0, ((SCREEN_WIDTH/2)-7) //X Position of The Legend of Text

origin $00E6E2E8
addiu t5, r0, ((SCREEN_WIDTH/2)-9) //X Position of Ocarina of Time Text

origin $00E6E68C
li t5, ($E4000000|(SCREEN_WIDTH/2)+74 << 14|(SCREEN_HEIGHT/2)+40 << 2) //Lower-Right Corner of Japanese Subtitle of Logo
li t2, ((SCREEN_WIDTH/2)-54 << 14|(SCREEN_HEIGHT/2)+24 << 2) //Upper-Left Corner of Japanese Subtitle of Logo
addiu t1, t9, 8 //Run a Replaced Opcode
sw t1, 416(sp) //Run another Replaced Opcode

origin $00E6E870
li t8, ($E4000000|(SCREEN_WIDTH/2)+62 << 14|SCREEN_HEIGHT-26 << 2) //Lower-Right Corner of Title Screen Copyright
li t3, ((SCREEN_WIDTH/2)-66 << 14|SCREEN_HEIGHT-42 << 2) //Upper-Left Corner of Title Screen Copyright
addiu t1, t2, 8 //Run a Replaced Opcode
sw t1, 416(sp) //Run another Replaced Opcode

origin $00E966B0
li t8, ($E4000000|(SCREEN_WIDTH/2)+40 << 14|(SCREEN_HEIGHT/2)-7 << 2) //Lower-Right Corner of The End Graphic
li t7, ((SCREEN_WIDTH/2)-40 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left Corner of The End Graphic
addiu t6, v1, 8 //Run a Replaced Opcode
sw t6, 688(a1) //Run another Replaced Opcode

origin $00E967F4
li t7, ($E4000000|(SCREEN_WIDTH/2)+60 << 14|(SCREEN_HEIGHT/2)+63 << 2) //Lower-Right Corner of Ending The Legend of Zelda Graphic
li t9, ((SCREEN_WIDTH/2)-60 << 14|(SCREEN_HEIGHT/2)+40 << 2) //Upper-Left Corner of Ending The Legend of Zelda Graphic
addiu t8, v1, 8 //Run a Replaced Opcode
sw t8, 688(a1) //Run another Replaced Opcode

origin $00E96930
li t8, ($E4000000|(SCREEN_WIDTH/2)+56 << 14|(SCREEN_HEIGHT/2)+72 << 2) //Lower-Right Corner of Ending Ocarina of Time Graphic
li t7, ((SCREEN_WIDTH/2)-56 << 14|(SCREEN_HEIGHT/2)+57 << 2) //Upper-Left Corner of Ending Ocarina of Time Graphic
addiu t6, v1, 8 //Run a Replaced Opcode
sw t6, 688(a1) //Run another Replaced Opcode

origin $00E9A348
dw ($E4000000|SCREEN_WIDTH/2 << 14|(SCREEN_HEIGHT/2)+17 << 2) //Lower-Right of Left Side of Nintendo Logo
dw ((SCREEN_WIDTH/2)-63 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left of Left Side of Nintendo Logo

origin $00E9A398
dw ($E4000000|(SCREEN_WIDTH/2)+63 << 14|(SCREEN_HEIGHT/2)+17 << 2) //Lower-Right of Right Side of Nintendo Logo
dw (SCREEN_WIDTH/2 << 14|(SCREEN_HEIGHT/2)-30 << 2) //Upper-Left of Right Side of Nintendo Logo

origin $00E9A3E8
dw ($E4000000|(SCREEN_WIDTH/2)+48 << 14|(SCREEN_HEIGHT/2)-25 << 2) //Lower-Right of Presented By Text
dw ((SCREEN_WIDTH/2)-47 << 14|(SCREEN_HEIGHT/2)-40 << 2) //Upper-Left of Presented By Text

origin $00EB4A62
dh 0xE46A //Song of Storms Effect (0xE450)

origin $00F6BB10
dw ($E4000000|SCREEN_WIDTH << 14| SCREEN_HEIGHT << 2) //Texture Rectangle for Sand Effect in Haunted Wasteland
