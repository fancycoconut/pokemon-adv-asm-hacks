# Emerald Major Tileset Hack

## Hack 1 - Making the game use a enlarged tileset

To enlarge the major tileset like in Fire Red, we must edit this routine. It looks way too different from Ruby's uh? Well, this is because later games were more protected. Below I've commented the parts to hack to make it load the major tileset like Fire Red.

```asm
08088d78  b500 push {lr}
08088d7a  6940 ldr r0, [r0, #0x14]
08088d7c  2280 mov r2, #0x80 @ mov r2, #0xA
08088d7e  0092 lsl r2, r2, #0x02 @ lsl r2, r2, #0x6
08088d80  1c11 add r1, r2, #0x0
08088d82  f7ff bl $08088c78
08088d86  bc01 pop {r0}
08088d88  4700 bx r0
08088d8a  0000 lsl r0, r0, #0x00
```

### Why change it to what I've commented?

Because on Emerald the `0x06004000` (Where the major tileset is loaded in the VRAM) is calculated. How?

The above routine left shifts the r2 value by 2. So, 80 left shifted by 2 is 0x200; the value is again left shifted by 0x5 in another routine making it 0x4000. That 0x4000 is added to `0x06000000` (VRAM base address) in another routine just before it is taken as the value to load the tileset. So, to change that we simply need to re-calculate the value added to the base address of the VRAM. That's all you have to change.

My changes were 0xA left shifted by 0x6, which gives 0x280 and 0x280 left shifted by 0x5 is 0x5000. So, to hack it insert 0A 22 92 01 at 0x88d7c.

## Hack 2 - Making the game use more tileset blocks

~ Coming Soon - TODO ~

## Step 3 - Changing Advance Map's ini setting

Finally we need Advance Map to display the correct tileset size, so 

we need to hack it's ini file. Find `AdvanceMap.ini` in the ini folder and 

find this:

```text
[Version:BPE]
mainfile=ini/Main.ini
mapsfile=ini/Maps.ini
TilesetIni=ini/EmTilesets.ini
Tilesethoehe=32 @ This value must be 40
Teil1Bloecke=$200
SpritePalettenAnz=27
AnzMapNamen=213
AnzTilesets=74
SuchByte=$00
SuchBeginn=$6B0000
AnzItems=376
```
