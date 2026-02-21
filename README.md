Howdy y'all,

This is a photograph of the mask ROM in an MSP430F149, along with
annotation of its bit positions for
[MaskRomTool](https://github.com/travisgoodspeed/maskromtool/tree/master).

Currently the decoding is not quite functional, but the software does
support the
[MSP430F449](https://github.com/travisgoodspeed/maskromtool/tree/master/gatotests/msp430),
so I expect we're a minor patch away from compatibility.  When MRT
becomes compatible, `make solve` ought to give you the right
parameters.

When properly decoded, the disassembly should begin like this:

```
c00:  04 0c         .word  0x0c04          ; Low priv entry.
c02:  0e 0c         .word  0x0c0e          ; High priv entry if r11=0xFFFF.
c04:  31 40 20 02   mov  #0x0220,  r1
c08:  0b 43         clr  r11               ; Reduce privs.
c0a:  c0 43 0a f6   mov.b  #0,  0xf60a
c0e:  32 c2         dint
```

--Travis Goodspeed

