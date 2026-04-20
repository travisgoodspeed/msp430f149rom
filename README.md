Howdy y'all,

This is a photograph of the mask ROM in an MSP430F149, along with
annotation of its bit positions for
[MaskRomTool](https://github.com/travisgoodspeed/maskromtool/tree/master).

Decoding uses the same bit layout as the
[MSP430F449](https://github.com/travisgoodspeed/maskromtool/tree/master/gatotests/msp430).
Thanks to asander@ for contributing that decoder.  Preferring generic
solutions, `make solve` ought to give you the right parameters for any
MSP430.

When properly decoded, the disassembly should begin like this.  The
first word is the ROM entry point and early disablement of the
interrupts.

```
[0x00000c00]> pd 40
            0x00000c00      020c                                ; Entry at 0x02C.
            0x00000c02      b240805a2001   mov 0x5a80, 0x0120
            0x00000c08      32c2           dint                 ; Disable interrupts.
            0x00000c0a      31901a02       cmp 0x021a, sp
        ┌─< 0x00000c0e      0928           jnc $+0x0014
        │   0x00000c10      3190020c       cmp 0x0c02, sp
       ┌──< 0x00000c14      062c           jc $+0x000e
       ││   0x00000c16      3012b8a5       push 0xa5b8
       ││   0x00000c1a      3541           pop r5
       ││   0x00000c1c      3590b8a5       cmp 0xa5b8, r5
```

Latter MSP430 decodings look a little different.  Note the two entry
words at the beginning and the clearing of r11, which stores the
privilege.

```
c00:  04 0c         .word  0x0c04          ; Low priv entry.
c02:  0e 0c         .word  0x0c0e          ; High priv entry if r11=0xFFFF.
c04:  31 40 20 02   mov  #0x0220,  r1
c08:  0b 43         clr  r11               ; Reduce privs.
c0a:  c0 43 0a f6   mov.b  #0,  0xf60a
c0e:  32 c2         dint
```

--Travis Goodspeed

