# Tileset Animation Routines

The following are tileset animation routines for Pokemon Ruby.

## Tileset 0 Animation Routine { Major Tileset }

```asm
@ Routine called by the Tileset Header
@ ------------------------------------------------------------------
08072fc4  4905 ldr r1, [$08072fdc] (=$030006c2)
08072fc6  2000 mov r0, #0x0
08072fc8  8008 strh r0, [r1, #0x0]
08072fca  4905 ldr r1, [$08072fe0] (=$030006c4)
08072fcc  2280 mov r2, #0x80
08072fce  0052 lsl r2, r2, #0x01
08072fd0  1c10 add r0, r2, #0x0
08072fd2  8008 strh r0, [r1, #0x0]
08072fd4  4903 ldr r1, [$08072fe4] (=$030006cc)
08072fd6  4804 ldr r0, [$08072fe8] (=$08073015) @ Animation Routine
08072fd8  6008 str r0, [r1, #0x0]
08072fda  4770 bx lr
```

## Main Animation Routine

```asm
08073014  b530 push {r4,r5,lr}
08073016  0405 lsl r5, r0, #0x10
08073018  20f0 mov r0, #0xf0
0807301a  0300 lsl r0, r0, #0x0c
0807301c  4028 and r0, r5
0807301e  0c04 lsr r4, r0, #0x10
08073020  2c00 cmp r4, #0x0
08073022  d102 bne $0807302a
08073024  0d28 lsr r0, r5, #0x14
08073026  f000 bl $08073070 @ Flower Animation
0807302a  2c01 cmp r4, #0x1
0807302c  d102 bne $08073034
0807302e  0d28 lsr r0, r5, #0x14
08073030  f000 bl $08073098 @ Water Animation
08073034  2c02 cmp r4, #0x2
08073036  d102 bne $0807303e
08073038  0d28 lsr r0, r5, #0x14
0807303a  f000 bl $080730c0 @ Shore-line Sand Animation
0807303e  2c03 cmp r4, #0x3
08073040  d102 bne $08073048
08073042  0d28 lsr r0, r5, #0x14
08073044  f000 bl $080730e8 @ Waterfall Animation
08073048  2c04 cmp r4, #0x4
0807304a  d102 bne $08073052
0807304c  0d28 lsr r0, r5, #0x14
0807304e  f000 bl $0807361c @ Water Animation2
08073052  bc30 pop {r4,r5}
08073054  bc01 pop {r0}
```

## Flower Animation

```asm
08073070  b500 push {lr}
08073072  0400 lsl r0, r0, #0x10
08073074  21c0 mov r1, #0xc0
08073076  0289 lsl r1, r1, #0x0a
08073078  4001 and r1, r0
0807307a  4805 ldr r0, [$08073090] (=$08376f24) @ Image Table
0807307c  0b89 lsr r1, r1, #0x0e
0807307e  1809 add r1, r1, r0
08073080  6808 ldr r0, [r1, #0x0]
08073082  4904 ldr r1, [$08073094] (=$06003f80) @ Location
08073084  2280 mov r2, #0x80 @ Animation Size
08073086  f7ff bl $08072e24 @ Animation Function
0807308a  bc01 pop {r0}
0807308c  4700 bx r0
```

## Water Animation

```asm
08073098  b500 push {lr}
0807309a  0400 lsl r0, r0, #0x10
0807309c  0c00 lsr r0, r0, #0x10
0807309e  2107 mov r1, #0x7
080730a0  4008 and r0, r1
080730a2  4905 ldr r1, [$080730b8] (=$08378d34) @ Image Table
080730a4  0080 lsl r0, r0, #0x02
080730a6  1840 add r0, r0, r1
080730a8  6800 ldr r0, [r0, #0x0]
080730aa  4904 ldr r1, [$080730bc] (=$06003600) @ Location
080730ac  22f0 mov r2, #0xf0
080730ae  0092 lsl r2, r2, #0x02 @ Animation Size
080730b0  f7ff bl $08072e24 @ Animation Function
080730b4  bc01 pop {r0}
080730b6  4700 bx r0
```

## Shore-line Sand Animation

```asm
080730c0  b500 push {lr}
080730c2  0400 lsl r0, r0, #0x10
080730c4  21e0 mov r1, #0xe0
080730c6  02c9 lsl r1, r1, #0x0b
080730c8  4001 and r1, r0
080730ca  4805 ldr r0, [$080730e0] (=$08379614) @ Image Table
080730cc  0b89 lsr r1, r1, #0x0e
080730ce  1809 add r1, r1, r0
080730d0  6808 ldr r0, [r1, #0x0]
080730d2  4904 ldr r1, [$080730e4] (=$06003a00) @ Location
080730d4  22a0 mov r2, #0xa0
080730d6  0052 lsl r2, r2, #0x01 @ Animation Size
080730d8  f7ff bl $08072e24 @ Animation Function
080730dc  bc01 pop {r0}
080730de  4700 bx r0
```

## Waterfall Animation

```asm
080730e8  b500 push {lr}
080730ea  0400 lsl r0, r0, #0x10
080730ec  21c0 mov r1, #0xc0
080730ee  0289 lsl r1, r1, #0x0a
080730f0  4001 and r1, r0
080730f2  4805 ldr r0, [$08073108] (=$08379934) @ Image Table
080730f4  0b89 lsr r1, r1, #0x0e
080730f6  1809 add r1, r1, r0
080730f8  6808 ldr r0, [r1, #0x0]
080730fa  4904 ldr r1, [$0807310c] (=$06003e00) @ Location
080730fc  22c0 mov r2, #0xc0 @ Animation Size
080730fe  f7ff bl $08072e24 @ Animation Function
08073102  bc01 pop {r0}
08073104  4700 bx r0
```

## Water Animation 2

```asm
0807361c  b500 push {lr}
0807361e  0400 lsl r0, r0, #0x10
08073620  21c0 mov r1, #0xc0
08073622  0289 lsl r1, r1, #0x0a
08073624  4001 and r1, r0
08073626  4805 ldr r0, [$0807363c] (=$08379e44) @ Image Table
08073628  0b89 lsr r1, r1, #0x0e
0807362a  1809 add r1, r1, r0
0807362c  6808 ldr r0, [r1, #0x0]
0807362e  4904 ldr r1, [$08073640] (=$06003c00) @ Location
08073630  22a0 mov r2, #0xa0
08073632  0052 lsl r2, r2, #0x01 @ Animation Size
08073634  f7ff bl $08072e24 @ Animation Function
08073638  bc01 pop {r0}
0807363a  4700 bx r0
```

## TODO

@ Tileset 1 Animation Routine {Secondary Tileset}
@ Routine called by the Tileset Header
@ ------------------------------------------------------------------
