# RS Door Animation Hack

Calling Routine:

```asm
@ Animation tiles loader:
08058378  b500 push {lr}
0805837a  4903 ldr r1, [$08058388] (=$06007f00)
0805837c  2240 mov r2, #0x40
0805837e  f188 bl $081e07e8
08058382  bc01 pop {r0}
08058384  4700 bx r0
08058386  0000 lsl r0, r0, #0x00
```

Door Animations Table @ 0x830F9B4

Format is:

[4 bytes - Unknown] [Pointer to Graphics] [Pointer to Palette Data]

Palette Data is separated into 8 bytes, 1 byte representing the palette layer in Background Palettes 0 to F (0 to 15). Why 8 bytes? 1 byte for 1 part of the door graphics.
