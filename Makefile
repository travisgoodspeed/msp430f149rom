# We don't yet have a solution to this one.  Maybe it's somewhere in
# my notes from grad school?

all: solve

solve: msp430f149.txt
# Big endian
#gatorom -o msp430f149.bin msp430f149.txt --solve-string c2,32 --solve -o big
# Little endian
#gatorom -o msp430f149.bin msp430f149.txt --solve-string 32,c2 --solve -o little
	gatorom msp430f149.txt --solve-string 04,0c,0e,0c --solve -w 8
	gatorom msp430f149.txt --solve-string 04,0c,0e,0c --solve -w 16
ascii: msp430f149.txt
	gatorom msp430f149.txt -A -i
msp430f149.bin: msp430f149.txt
	gatorom --decode-msp430 -o msp430f149.bin msp430f149.txt

msp430f149.txt: msp430f149.jpg msp430f149.jpg.json
# -d does a DRC, and ought to fail if the result is wrong.
# Rerun with -V if you need to figure out a failure.
	maskromtool msp430f149.jpg -a msp430f149.txt -platform offscreen -e -d
open:
# Just opens in a GUI.
	maskromtool msp430f149.jpg
clean:
	rm -f msp430f149.txt msp430f149.bin

