@ Day Night System
@ Version 1.0.0
@ By interdpth
@ Optimised By ZodiacDaGreat
@ -------------------------------------------------------------------
.code 16
.thumb

  bl .AgbMain
  ldr r0, .Var1
  ldrb r0, [r0]
  ldr r3, .Off_8B01018
  cmp r0, #0x0
  bne .loc_8B01016
  ldrh r1, [r7, #0x28]
  mov r0, #0x1
  and r0, r0, r1
  ldr r3, .Off_8B0101C

.loc_8B01016:
  mov pc, r3

@ -------------------------------------------------------------------
.RTC_Cmd:

  push {r4-r7, lr}
  lsl r4, r0, #0x1
  mov r3, #0x7
  mov r7, #0x2
  ldr r2, .IOPORTDATA
  mov r6, #0x4
  mov r5, #0x5

.loc_80001D2:
  mov r0, r4
  asr r0, r0, r3
  and r0, r0, r7
  lsl r0, r0, #0x10
  lsr r0, r0, #0x10
  mov r1, r0
  orr r1, r6
  strh r1, [r2]
  strh r1, [r2]
  strh r1, [r2]
  orr r0, r5
  strh r0, [r2]
  sub r3, r3, #0x1
  cmp r3, #0x0
  bge .loc_80001D2

  mov r0, #0x0
  pop {r4-r7}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.RTC_Data:
  
  push {r4-r7, lr}
  mov r4, r0
  lsl r4, r4, #0x1
  mov r3, #0x0
  mov r7, #0x2
  ldr r2, .IOPORTDATA
  mov r6, #0x4
  mov r5, #0x5

.loc_800020C:
  mov r0, r4
  asr r0, r0, r3
  and r0, r0, r7
  lsl r0, r0, #0x10
  lsr r0, r0, #0x10
  mov r1, r0
  orr r1, r6
  strh r1, [r2]
  strh r1, [r2]
  strh r1, [r2]
  orr r0, r0, r5
  strh r0, [r2]
  add r3, r3, #0x1
  cmp r3, #0x7
  ble .loc_800020C

  mov r0, #0x0
  pop {r4-r7}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.RTC_Read:

  push {r4-r7, lr}
  mov r5, #0x0
  mov r2, #0x0
  ldr r3, .IOPORTDATA
  mov r6, #0x4
  mov r7, #0x5
  mov r0, #0x2
  mov r12, r0

.loc_8000248:
  add r4, r2, #0x1
  mov r0, #0x4

.loc_800024C:
  strh r6, [r3]
  sub r0, r0, #0x1
  cmp r0, #0x0
  bge .loc_800024C
  strh r7, [r3]
  ldrh r1, [r3]
  mov r0, r12
  and r0, r0, r1
  lsl r0, r0, #0x10
  lsr r0, r0, #0x10
  lsl r0, r0, r2
  orr r5, r5, r0
  mov r2, r4
  cmp r2, #0x7
  ble .loc_8000248
  asr r5, r5, #0x1
  mov r0, r5
  pop {r4-r7}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.RTC_Check:

  ldr r0, .Off_8000324
  ldr r0, [r0]
  cmp r0, #0x0
  beq .locret_8000282
  mov r0, #0x1

.locret_8000282:
  bx lr

@ -------------------------------------------------------------------
.RTC_Get:

  push {r4-r6, lr}
  mov r6, r0
  ldr r1, .IOPORTDATA
  mov r2, #0x1
  strh r2, [r1]
  ldr r5, .IOPORTDIRECTION
  mov r0, #0x7
  strh r0, [r5]
  strh r2, [r1]
  mov r4, #0x5
  strh r4, [r1]
  mov r0, #0x65
  bl .RTC_Cmd
  strh r4, [r5]
  mov r4, r6
  mov r5, #0x3

.loc_80002AA:
  bl .RTC_Read
  strb r0, [r4]
  add r4, r4, #0x1
  sub r5, r5, #0x1
  cmp r5, #0x0
  bge .loc_80002AA
  ldr r1, .IOPORTDIRECTION
  mov r0, #0x5
  strh r0, [r1]
  add r4, r6, #0x4
  mov r5, #0x2

.loc_80002C2:
  bl .RTC_Read
  strb r0, [r4]
  add r4, r4, #0x1
  sub r5, r5, #0x1
  cmp r5, #0x0
  bge .loc_80002C2
  mov r0, #0x0
  pop {r4-r6}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.RTC_TurnOn:

  push {r4, r5, lr}
  ldr r0, .IOPORTCNT
  mov r1, #0x1
  strh r1, [r0]
  sub r0, r0, #0x4
  strh r1, [r0]
  mov r5, #0x5
  strh r5, [r0]
  ldr r4, .IOPORTDIRECTION
  mov r0, #0x7
  strh r0, [r4]
  mov r0, #0x63
  bl .RTC_Cmd
  strh r5, [r4]
  bl .RTC_Read
  ldr r1, .Off_8000324
  str r0, [r1]
  bl .RTC_Check
  ldr r1, .Off_8000328
  str r0, [r1]
  ldr r0, .Off_800032C
  bl .RTC_Get
  mov r0, #0x0
  pop {r4, r5}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.UNBCD:

  mov r2, #0xF
  and r2, r2, r0
  asr r0, r0, #0x4
  lsl r1, r0, #0x2
  add r1, r1, r0
  lsl r1, r1, #0x1
  add r2, r2, r1
  mov r0, r2
  bx lr

@ -------------------------------------------------------------------
.RTC_GetTime:

var_14 = -0x14
var_13 = -0x13
var_12 = -0x12
var_11 = -0x11
var_10 = -0x10
var_F = -0xF
var_E = -0xE

  push {r4, r5, lr}
  sub sp, sp, #0x8
  mov r5, r0
  ldr r0, .Off_8000328
  ldr r0, [r0]
  cmp r0, #0x0
  bne .loc_8000378
  mov r1, #0x0
  ldr r0, .Dword_8000374
  strh r0, [r5]
  mov r0, #0x6
  strb r0, [r5, #0x2]
  mov r0, #0x1A
  strb r0, [r5, #0x3]
  mov r0, #0x1
  strb r0, [r5, #0x4]
  mov r0, #0xC
  strb r0, [r5, #0x5]
  strb r1, [r5, #0x6]
  strb r1, [r5, #0x7]
  b .Endme

.loc_8000378:
  mov r0, sp
  bl .RTC_Get
  mov r0, sp
  ldrb r0, [r0, #0x14+var_14]
  bl .UNBCD
  ldr r1, .Var2
  add r0, r0, r1
  strh r0, [r5]
  mov r0, sp
  ldrb r0, [r0, #0x14+var_13]
  bl .UNBCD
  strb r0, [r5, #0x2]
  mov r0, sp
  ldrb r1, [r0, #0x14+var_12]
  mov r4, #0x3F
  mov r0, r4
  and r0, r0, r1
  bl .UNBCD
  strb r0, [r5, #0x3]
  mov r0, sp
  ldrb r1, [r0, #0x14+var_11]
  mov r0, r4
  and r0, r0, r1
  bl .UNBCD
  strb r0, [r5, #0x4]
  mov r0, sp
  ldrb r0, [r0, #0x14+var_10]
  and r4, r4, r0
  mov r0, r4
  bl .UNBCD
  strb r0, [r5, #0x5]
  mov r0, sp
  ldrb r0, [r0, #0x14+var_F]
  bl .UNBCD
  strb r0, [r5, #0x6]
  mov r0, sp
  ldrb r0, [r0, #0x14+var_E]
  bl .UNBCD
  strb r0, [r5, #0x7]
  ldr r2, .DayWeekHourMin
  ldrb r3, [r5, #0x6]
  ldrb r0, [r2, #0x2]
  add r1, r3, r0
  strb r1, [r5, #0x6]
  lsl r0, r1, #0x18
  lsr r0, r0, #0x18
  cmp r0, #0x3B
  bls .loc_80003F6
  mov r0, r1
  sub r0, r0, #0x3C
  strb r0, [r5, #0x6]
  ldrb r0, [r5, #0x5]
  add r0, r0, #0x1
  strb r0, [r5, #0x5]

.loc_80003F6:
  ldrb r3, [r5, #0x5]
  ldrb r0, [r2, #0x1]
  add r1, r3, r0
  strb r1, [r5, #0x5]
  lsl r0, r1, #0x18
  lsr r0, r0, #0x18
  cmp r0, #0x17
  bls .loc_8000412
  mov r0, r1
  sub r0, r0, #0x18
  strb r0, [r5, #0x5]
  ldrb r0, [r5, #0x4]
  add r0, r0, #0x1
  strb r0, [r5, #0x4]

.loc_8000412:
  ldrb r2, [r2]
  ldrb r1, [r5, #0x4]
  add r0, r2, r1
  mov r1, #0x7
  bl .modsi3
  strb r0, [r5, #0x4]

.Endme:
  mov r0, #0x0
  add sp, sp, #0x8
  pop {r4, r5}
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.DoCode:

  push {lr}
  bl .RTC_Check
  cmp r0, #0x0
  bne .loc_800043E
  bl .RTC_TurnOn

.loc_800043E:
  ldr r0, .RTC
  bl .RTC_GetTime
  mov r0, #0x0
  pop {r1}
  bx r1

@ -------------------------------------------------------------------
.AgbMain:

  push {lr}
  bl .DoCode
  pop {r0}
  bx r0

@ -------------------------------------------------------------------
.modsi3:

  mov r3, #0x1
  cmp r1, #0x0
  beq .Ldiv0
  bpl .Over1
  neg r1, r1

.Over1:
  push {r4}
  push {r0}
  cmp r0, #0x0
  bpl .Over2
  neg r0, r0

.Over2:
  cmp r0, r1
  bcc .Lgot_result
  mov r4, #0x1
  lsl r4, r4, #0x8
  lsl r4, r4, #0x4
  lsl r4, r4, #0x10

.Loop1:
  cmp r1, r4
  bcs .Lbignum
  cmp r1, r0
  bcs .Lbignum
  lsl r1, r1, #0x4
  lsl r3, r3, #0x4
  b .Loop1

.Lbignum:
  lsl r4, r4, #0x3

.Loop2:
  cmp r1, r4
  bcs .Loop3
  cmp r1, r0
  bcs .Loop3
  lsl r1, r1, #0x1
  lsl r3, r3, #0x1
  b .Loop2

.Loop3:
  mov r2, #0x0
  cmp r0, r1
  bcc .Over3
  sub r0, r0, r1

.Over3:
  lsr r4, r1, #0x1
  cmp r0, r4
  bcc .Over4
  sub r0, r0, r4
  mov r12, r3
  mov r4, #0x1
  ror r3, r4
  orr r2, r3
  mov r3, r12

.Over4:
  lsr r4, r1, #0x2
  cmp r0, r4
  bcc .Over5
  sub r0, r0, r4
  mov r12, r3
  mov r4, #0x2
  ror r3, r4
  orr r2, r3
  mov r3, r12

.Over5:
  lsr r4, r1, #0x3
  cmp r0, r4
  bcc .Over6
  sub r0, r0, r4
  mov r12, r3
  mov r4, #0x3
  ror r3, r4
  orr r2, r3
  mov r3, r12

.Over6:
  mov r12, r3
  cmp r0, #0x0
  beq .Over7
  lsr r3, r3, #0x4
  beq .Over7
  lsr r1, r1, #0x4
  b .Loop3

.Over7:
  mov r4, #0xE
  lsl r4, r4, #0x8
  lsl r4, r4, #0x4
  lsl r4, r4, #0x10
  and r2, r2, r4
  beq .Lgot_result
  mov r3, r12
  mov r4, #0x3
  ror r3, r4
  tst r2, r3
  beq .Over8
  lsr r4, r1, #0x3
  add r0, r0, r4

.Over8:
  mov r3, r12
  mov r4, #0x2
  ror r3, r4
  tst r2, r3
  beq .Over9
  lsr r4, r1, #0x2
  add r0, r0, r4

.Over9:
  mov r3, r12
  mov r4, #0x1
  ror r3, r4
  tst r2, r3
  beq .Lgot_result
  lsr r4, r1, #0x1
  add r0, r0, r4

.Lgot_result:
  pop {r4}
  cmp r4, #0x0
  bpl .Over10
  neg r0, r0

.Over10:
  pop {r4}
  mov pc, lr

.Ldiv0:
  push {lr}
  bl .div0
  mov r0, #0x0
  pop {pc}

.div0:
  mov pc, lr

@ -------------------------------------------------------------------
.align 2
.Var1:                                               .word 0x03003530
.Off_8B01018:                                        .word 0x08000445
.Off_8B0101C:                                        .word 0x0800042D

.IOPORTDATA:                                         .word 0x080000C4
.IOPORTDIRECTION:                                    .word 0x080000C6
.IOPORTCNT:                                          .word 0x080000C8

.Off_8000324:                                        .word 0x03005547
.Off_8000328:                                        .word 0x03005504
.Off_800032C:                                        .word 0x03005505
.Dword_8000374:                                      .word 0x000007D9
.Var2:                                               .word 0x000007D0

.RTC:                                                .word 0x0300553D
.DayWeekHourMin:                                     .word 0x03005537

@ -------------------------------------------------------------------
@ To apply this insert 014B 9F46 0000 [Offset Reversed] at
@ 0x41E
@ -------------------------------------------------------------------
