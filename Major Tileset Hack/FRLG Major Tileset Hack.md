# FRLG Major Tileset Hack

This is exactly like Emerald's hack, but in different format. The routine we're interested in is this:

```asm
08059a7c  b500 push {lr}
08059a7e  6940 ldr r0, [r0, #0x14]
08059a80  21c0 mov r1, #0xc0
08059a82  0049 lsl r1, r1, #0x01
08059a84  22a0 mov r2, #0xa0 @ Value 1
08059a86  0092 lsl r2, r2, #0x02 @ Value 2
08059a88  f7ff bl $08059888
08059a8c  bc01 pop {r0}
08059a8e  4700 bx r0
```

0xA0 left shifted by 0x2 = 0x280. 0x280 left shifted by 0x5 is 0x5000. 0x5000 is added to the base VRAM address to give you the location from where tileset is to be loaded. I don't recommend changing Fire Red's though :P Cause there's already enough space.
