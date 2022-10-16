@ Pure Gold Titlescreen Hack
@ Version 1.0.1
@ By ZodiacDaGreat
@ -------------------------------------------------------------------
.code 16
.thumb

.Main:
  push {r4-r5, r7, lr}
@ Clear Palettes
  ldr r0, .NullRAM
  mov r1, #0x0
  mov r2, #0x40
  lsl r2, r2, #0x4 @ 0x400
  ldr r7, .PaletteLoader
  bl .BranchLink

@ Play music
  mov r0, #0x19
  lsl r0, r0, #0x4
  add r0, r0, #0xD
  ldr r7, .PlayMusic
  bl .BranchLink

@ Setting up screen
  ldr r0, .REG_DISPCNT
  mov r1, #0x9D
  lsl r1, r1, #0x8
  add r1, r1, #0x40 @ 0x9D40
  strh r1, [r0]

@ Removing blending and window out
  add r0, r0, #0x12 @ REG_BG0VOFS
  mov r1, #0x0
  strh r1, [r0]
  add r0, r0, #0x6 @ REG_BG2HOFS
  strh r1, [r0]
  add r0, r0, #0x2 @ REG_BG2VOFS
  strh r1, [r0]
  add r0, r0, #0x36 @ REG_BLDCNT
  strh r1, [r0]
  sub r0, r0, #0x6 @ REG_WINOUT
  mov r1, #0x35
  lsl r1, r1, #0x8
  add r1, r1, #0x1D @ 0x351D
  strh r1, [r0]

@ Setting up background 0
  ldr r0, .REG_BG0CNT
  mov r1, #0x3F
  lsl r1, r1, #0x7 @ 0x1F80
  strh r1, [r0]

@ Setting up background 2
  add r0, r0, #0x4
  mov r1, #0x1D
  lsl r1, r1, #0x8
  add r1, r1, #0xA @ 0x1D0A
  strh r1, [r0]

@ Setting up background 3
  add r0, r0, #0x2
  mov r1, #0x5
  lsl r1, r1, #0x9
  add r1, r1, #0xB @ 0xA0B
  strh r1, [r0]

@ Loading Pokemon logo palette
  ldr r0, .LogoPalette
  mov r1, #0x0
  mov r2, #0x1A
  lsl r2, r2, #0x4 @ 0x1A0
  ldr r7, .PaletteLoader
  bl .BranchLink

@ Loading Pokemon logo tileset and tilemap
  ldr r0, .LogoTileset
  ldr r1, .LogoTilesetBase
  swi 0x12 @ LZ77UnCompVRAM

  ldr r0, .LogoTilemap
  ldr r1, .LogoTilemapBase
  swi 0x12 @ LZ77UnCompVRAM

@ Loading titlescreen palette
  ldr r0, .TitlescreenPalette
  mov r1, #0xD0
  mov r2, #0x40
  ldr r7, .PaletteLoader
  bl .BranchLink

@ Loading titlescreen tileset and tilemap
  ldr r0, .TitlescreenTileset
  ldr r1, .TitlescreenTilesetBase
  swi 0x12 @ LZ77UnCompVRAM

  ldr r0, .TitlescreenTilemapBG2
  ldr r1, .TitlescreenTilemapBG2Base
  swi 0x12 @ LZ77UnCompVRAM

  ldr r0, .TitlescreenTilemapBG3
  ldr r1, .TitlescreenTilemapBG3Base
  swi 0x12 @ LZ77UnCompVRAM

@ Loading Ho-Oh and it's palette
  ldr r0, .HoOhPalette
  mov r1, #0xFF
  add r1, r1, #0x1 @ r1 = 0x100
  mov r2, #0x20
  ldr r7, .PaletteLoader
  bl .BranchLink

  ldr r0, .HoOh1
  ldr r1, .OBJRAM
  mov r2, #0x2
  lsl r2, r2, #0x9 @ r2 = 0x200
  mov r4, #0x0
  swi 0xB @ CpuSet

@ Erasing all existing sprite data in OAM
  ldr r1, .OBJAttribute @ Attribute 0
  mov r0, r1
  add r0, r0, #0xA0
  mov r2, #0x4F
  swi 0xB @ CpuSet

@ Setting up the Ho-Oh sprite
  mov r0, #0x4D @ Y Coordinate
  strh r0, [r1]

  mov r0, #0xA6 @ X Coodinate
  mov r2, #0xC0
  lsl r2, r2, #0x8
  orr r0, r0, r2
  strh r0, [r1, #0x2] @ Attribute 1

  mov r0, #0x0
  strh r0, [r1, #0x4] @ Attribute 2
  mov r5, #0x0 @ Frame Counter

@ Getting keypress and doing animations
.KeypressLoop:
  swi 0x5
  add r5, r5, #0x1

@ Scrolling BG3 - Clouds layer
  ldr r0, .REG_BG0CNT
  add r0, r0, #0x14
  strh r5, [r0]

  mov r0, r5
  mov r1, #0xD
  swi 0x6
  cmp r1, #0x0
  bne .CheckKey

@ Doing animations
  bl .HoOhAnimation
  bl .StartAnimation

.CheckKey:
@ Check Keypress
  ldr r0, .REG_KEYINPUT
  ldrh r2, [r0]
  mov r1, #0x1 @ A button
  and r2, r2, r1
  cmp r2, #0x0
  beq .Exit
  ldrh r2, [r0]
  mov r1, #0x8 @ Start button
  and r2, r2, r1
  cmp r2, #0x0
  beq .Exit

@ Checking Music
  ldr r0, .MusicInfo
  ldrb r0, [r0, #0x4]
  cmp r0, #0x0
  beq .Restart
  b .KeypressLoop

.Exit:
@ Play Ho-Oh's Cry
  mov r0, #0xFA @ Ho-Oh's Cry
  ldr r7, .PlayCry
  bl .BranchLink

@ Resetting Horizontal scroll for BG3
  ldr r0, .REG_BG0CNT
  add r0, r0, #0x14
  mov r1, #0x0
  strh r1, [r0]

@ Turn off music
  mov r0, #0x0
  ldr r7, .PlayMusic
  bl .BranchLink

@ Call game menu
  ldr r0, .GamestartMenu
  ldr r7, .Loader
  bl .BranchLink
  b .Finish

.Restart:
  ldr r0, .REG_DISPCNT
  mov r1, #0x0
  strh r1, [r0]
  swi 0x5

  ldr r0, .ResetGame
  ldr r7, .Loader
  bl .BranchLink

.Finish:
  pop {r4-r5, r7, pc}

.BranchLink:
  bx r7

@ -------------------------------------------------------------------
.StartAnimation:
  push {r3, lr}
  ldr r0, .Palette
  mov r1, #0x7
  lsl r1, r1, #0x6 @ 0x1C0
  add r0, r0, r1
  add r0, r0, #0x4
  mov r3, r0
  ldrh r1, [r0]

  ldrh r2, [r0, #0x8] @ Palette 0x3DEF
  cmp r1, r2
  beq .Copy

  mov r0, r3
  mov r1, #0x0
  str r1, [r0]
  str r1, [r0, #0x4]
  b .Endme

.Copy:
  mov r0, r3
  add r0, r0, #0xA
  mov r1, r3
  mov r2, #0x4
  swi 0xB @ CpuSet

.Endme:
  pop {r3, pc}

@ -------------------------------------------------------------------
.HoOhAnimation:
  push {lr}
  ldr r1, .OBJRAM
  mov r2, #0x2
  lsl r2, r2, #0x9
  cmp r4, #0x1
  beq .Frame1

  ldr r0, .HoOh2
  mov r4, #0x1
  b .ExitFunc

.Frame1:
  ldr r0, .HoOh1
  mov r4, #0x0

.ExitFunc:
  swi 0xB
  pop {pc}

@ -------------------------------------------------------------------
.align 2
.REG_DISPCNT:                                         .word 0x04000000
.REG_BG0CNT:                                          .word 0x04000008
.REG_KEYINPUT:                                        .word 0x04000130
.Palette:                                             .word 0x0202EEC8
.NullRAM:                                             .word 0x02042000
.OBJRAM:                                              .word 0x06010000
.OBJAttribute:                                        .word 0x030017AC
.MusicInfo:                                           .word 0x03007380

.PaletteLoader:                                       .word 0x08073A59
.Loader:                                              .word 0x080003CD
.ResetGame:                                           .word 0x0813BA45
.PlayMusic:                                           .word 0x081DDEF9
.PlayCry:                                             .word 0x08075045
.GamestartMenu:                                       .word 0x080096F1

.TitlescreenPalette:                                  .word 0x08393210
.TitlescreenTileset:                                  .word 0x08900000
.TitlescreenTilesetBase:                              .word 0x06008000
.TitlescreenTilemapBG2:                               .word 0x089FFF98
.TitlescreenTilemapBG2Base:                           .word 0x0600E800
.TitlescreenTilemapBG3:                               .word 0x089FFBA0
.TitlescreenTilemapBG3Base:                           .word 0x06005000

.LogoPalette:                                          .word 0x08A00260
.LogoTileset:                                          .word 0x08A00434
.LogoTilesetBase:                                      .word 0x06000000
.LogoTilemap:                                          .word 0x08A01DF0
.LogoTilemapBase:                                      .word 0x0600F800

.HoOhPalette:                                          .word 0x08B00000
.HoOh1:                                                .word 0x08B00064
.HoOh2:                                                .word 0x08B0088C
@ -------------------------------------------------------------------
@ To use this routine, repoint the pointers in the following offsets
@ to the offset where you place this routine(s)

@ v1.0.1 uses only offset 0x7C450.
@ 0x7C450 - Repoint the pointer to the main loader
@ Fill 0x7C1E4 0x7E 00s
@ Put 00 00 at 0x7C40C

@ -------------------------------------------------------------------
@ v1.0.0 stuff
@ 0x9FD8 - Repoint the pointer to the main loader
@ 0xBA6B4 - Repoint the pointer to the main loader
@ 0x13B804 - Repoint the pointer to the main loader

@ Notes
@ -------------------------------------------------------------------
@ 0807C130 - Original R/S titlescreen routine, this is called by the
@ function at 0x0807C0F0, this function calls the pointer at 0x7C118

@ 0807C454 - This is the play music function.
@ -------------------------------------------------------------------
