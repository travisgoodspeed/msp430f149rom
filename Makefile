# We don't yet have a solution to this one.  Maybe it's somewhere in
# my notes from grad school?

all: solve

solve: msp430f149.txt
## Matches later MSP430s, looking for entry point at zero.
	gatorom msp430f149.txt --solve-string 04,0c,0e,0c --solve -w 16
## Matches early MSP430s, looking for the magic check of 0xA5b8 in R5.
	gatorom msp430f149.txt --solve-string 35,90,b8,a5 --solve -w 16 -o msp430f149.bin
ascii: msp430f149.txt
	gatorom msp430f149.txt -A -i
msp430f149.bin: solve


msp430f149.txt: msp430f149.jpg msp430f149.jpg.json
# -d does a DRC, and ought to fail if the result is wrong.
# Rerun with -V if you need to figure out a failure.
	maskromtool msp430f149.jpg -a msp430f149.txt -platform offscreen -e -d
open:
# Just opens in a GUI.
	maskromtool msp430f149.jpg
r2: msp430f149.bin
	r2 -a msp430 -m 0xc00 msp430f149.bin
clean:
	rm -f msp430f149.txt msp430f149.bin

