# Boolean Masking Implementation Sandbox Examples
This repository contains experiments for SCA/Boolean masking implementation, which
are formally verified using coco-alma and/or maskverif.

## Examples Directory
- and_no_refresh: Simple Boolean multiplier (AND) using refresh and no refresh. 
	* First order secure proven by coco-alma.
- coco-alma: DOM Boolean multiplier.
	* First order secure proven by coco-alma.
- dom_mul: Same as above, but written slightly different.
	* First order secure proven by coco-alma.
- maskverif: DOM Boolean multiplier without registers.
	* Issues found by maskverif.

## Disclaimer
The repository is just to have a reference/starting point. I struggled a 
lot in trying to build some meaningful example reading the literature. 
I'm probably a fool and this is actually very easy to do, but just in
case anyone else stumbles like me, here is some help. Just analyse
the `script.sh` inside each folder and the RTL to get an understanding
of how to reproduce some of the classical examples.

I'll update this repository with more examples as my journey progresses.
