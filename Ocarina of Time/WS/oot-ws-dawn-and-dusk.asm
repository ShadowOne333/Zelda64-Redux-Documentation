// gamemasterplc: N64 "Ocarina of Time" Widescreen Hack
// GhostlyDark: Port to ndec decompressed ROM plus improvements
// Dawn and Dusk v2.0 WS fixes

arch n64.cpu
endian msb // N64 MIPS requires Big-Endian Encoding (Most Significant Bit)
output "Dawn and Dusk WS GhostlyDark.z64", create
origin $00000000; insert "dawn-and-dusk.z64" // Include Decompressed 1.0 Legend of Zelda, The - Ocarina of Time ROM

include "LIB/N64.INC" // Include N64 Definitions

constant SCREEN_WIDTH(424)

origin $00B6C81A
dh 0x0140 //Minimap position

origin $00B6C84A
dh 0x00FA //Minimap position

origin $00B6C890
dh ((86*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Zora's River Minimap

origin $00B6C898
dh ((123*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Kokiri Forest Minimap

origin $00B6C8B8
dh ((82*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Zora's Fountain Minimap

origin $00B6C8C8
dh ((132*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Haunted Wasteland Minimap

origin $00B6C8F8
dh ((86*10)+(((SCREEN_WIDTH-320)*5))) //X Position of Arrows on Death Mountain Crater Minimap
