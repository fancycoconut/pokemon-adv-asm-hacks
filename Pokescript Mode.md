# Pokescript Mode

How to execute a script via ASM.

### Pokemon Ruby

```asm
ldr r0, =0x8900000 @ Script Offset
ldr r7, =0x80655B9 @ bl $080655B8 - Execute Script
bl .BranchLink
```
