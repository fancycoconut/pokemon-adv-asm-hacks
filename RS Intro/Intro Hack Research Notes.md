# Intro Hack Research Notes

* 0x9F58 => Contains the value 0x800A1F5, Must be edited to fit in the set time. Then call 0x800A1F5.
* 0x03004B20 => Stores the pointer to the next routine to be executed. [r4]

080B623C => Perhaps the Hero/Heroine Naming routine.

```asm
mov r0, #0x1
ldr r7, =0x807D645 @ fadescreen 0x1
bl .BranchLink
ldr r7, =0x806A461 @ Special 0x9A
bl .BranchLink
ldr r7, =0x80655F1 @ waitstate
bl .BranchLink
```

## Changing intro music - routine:

```asm
0800a29e  20bb mov r0, #0xbb
0800a2a0  0040 lsl r0, r0, #0x01 @ r0 = 0x176 (Intro Song)
0800a2a2  f06b bl $08075474 @ MusicPlayerFunc?
```
