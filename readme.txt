The Royal Game of UR

This game is a two-player race to get all 7 of your counters from one end of the board to the other, first played thousands of years ago in the Middle East. 

https://en.wikipedia.org/wiki/Royal_Game_of_Ur

Versions are available here for the Altair 8800 (16k Basic), ZX Spectrum 48k, ZX81 (16k), Sinclair QL and 
Cambridge Z88. Except for the Altair, they all use the BASIC that was supplied in the machine, and all use the same game 
engine. The Z88 and QL versions make use of the more advanced BASIC features such as parameterised procedures.

The display of each version is basically the same layout, but with differences for each computers 
graphic capabilities.

The version notes here are displayed in the order they were developed. All were written using VS code and then copied into the relevant format by various means described below.

Altair 8800
===========
A listing [URaltair.bas] is available in the downloads, this is for the Microsoft 16k BASIC. It was developed using the Altairduino and the 16k ROM Basic option.

Sinclair ZX Spectrum 48k
========================
Two listings are available, one for the graphics definition [URspec48charset.bas] and the other is the game [URspec48game.bas]. There is also Z80 snapshot file [URspec48.z80] in the downloads. These were developed using BasinC and tested on Spectaculator and a real ZX Spectrum.

Sinclair ZX81 (16k)
===================
A listing [URzx81.bas] is available along with a p file [URzx81.P], for loading into an emulator or real ZX81. Development was done using the zxtext2p command line application. It was tested on the EightyOne emulator.

Sinclair QL
===========
A listing [URql.bas] is available along with a MDV file [URql.mdv]. This was developed in the Qemulator and has only been tested in the emulator.

Cambridge Z88
=============
A listing [URz88.bbc] and snapshot file [URz88snap.z88] are available, developed in BBC Basic for Windows and tested in the OZvm emulator.
