# RS Major Tileset Hack

## Hack 1 - Making the game use a enlarged tileset

To enlarge the major tileset like in Fire Red, we must edit this routine.

```asm
08056d38  b500 push {lr}
08056d3a  4903 ldr r1, [$08056d48] (=$06004000)
08056d3c  6940 ldr r0, [r0, #0x14]
08056d3e  f7ff bl $08056c98
08056d42  bc01 pop {r0}
08056d44  4700 bx r0
08056d46  0000 lsl r0, r0, #0x00
```

`0x06004000` is the location where Tileset 2 data begins in the VRAM for Ruby, on Fire Red it starts at `0x06005000`. So, to change it - just edit it to `0x06005000`.

This pointer is at 0x56d48 in reversed format. So, to make Ruby use a Fire Red sized major tileset just insert:
0050 0006 at 0x56d48

## Hack 2 - Making the game use more tileset blocks

~ Coming Soon~

## Step 3 - Changing Advance Map's ini setting

Finally we need Advance Map to display the correct tileset size, so we need to hack it's ini. Find 'AdvanceMap.ini' in the ini folder and find this:

```text
[Version:AXV]
mainfile=ini/Main.ini
mapsfile=ini/Maps.ini
TilesetIni=ini/Tilesets.ini
Tilesethoehe=32 @ This value must be 40
Teil1Bloecke=$200
SpritePalettenAnz=27
AnzMapNamen=87
AnzTilesets=57
SuchByte=$FF
SuchBeginn=$6B0000
AnzItems=348
```
