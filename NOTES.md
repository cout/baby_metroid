NOTES
=====

Links
-----

Elevators - https://m2k2.taigaforum.com/post/smile_releasehelp_thread1041.html#smile_releasehelp_thread1041
Editing graphics - nintoaster says to check out yychr

Compression
-----------

* https://everything2.com/title/Nintendo+compression
* https://github.com/Maseya/MushROMs
* https://github.com/bonimy/MushROMs/issues/35
* https://www.romhacking.net/documents/243/

Memory Banks
============

Data
----

| Bank     | Contents                            |
| -------- | ----------------------------------- |
| $83      | Door headers                        |
| $84      | Item PLMs, shot block PLMs          |
| $86      | Enemy projectile headers            |
| $8F      | Room headers, room PLMs             |
| $94      | Block reaction handlers, PLM tables |
| $A0      | Enemy headers                       |
| $A1      | Enemy population lists              |
| $B4      | Enemy graphics sets                 |

Graphics
--------

| Bank     | Contents                            |
| -------- | ----------------------------------- |
| $83      | Area palettes                       |
| $8A      | Layer 3 tilemaps                    |
| $8C      | Title/cutscene graphics             |
| $8D      | Enemy projectile spritemaps         |
| $8E      | Menu BG tiles                       |
| $92      | Samus spritemaps                    |
| $95..$9A | Tiles/palettes                      |
| $9B..$9F | Samus tiles                         |
| $AB..$B3 | Enemy tiles                         |
| $B5      | Map tilemaps                        |
| $B6      | Menu tiles                          |
| $B7      | Mother brain tiles                  |
| $B9..$BA | CRE (common room element) tiles     |
| $C1..$C2 | Tile tables                         |
| $C2..$CE | Palettes (compressed)               |

Code
----

| Bank     | Contents                            |
| -------- | ----------------------------------- |
| $80      | Hardware interaction                |
| $81      | Menus                               |
| $82      | Gameplay functions                  |
| $85      | Message boxes                       |
| $86      | Enemy projectiles                   |
| $87      | Animated tiles, G4 statue           |
| $88      | Layer blending                      |
| $89      | Palette blending                    |
| $8B      | Brightness/zoom                     |
| $90      | Samus movement                      |
| $91      | Samus pose transition               |
| $93      | Samus projectiles                   |
| $94      | Samus block collision               |
| $95      | Samus death sequence                |
| $A0      | Enemy processing                    |
| $A2..$AA | Enemy AI                            |
| $B4      | Debug                               |
| $CF..$DF | SPC                                 |

Data Structures
===============

Areas
-----

| Area | Name         |
| ---- | ------------ |
| 0    | Crateria     |
| 1    | Brinstar     |
| 2    | Norfair      |
| 3    | Wrecked Ship |
| 4    | Maridia      |
| 5    | Tourian      |
| 6    | Ceres        |
| 7    | Debug        |

Rooms
-----

| Structure         | Bank | Offset            |
| ----------------- | ---- | ----------------- |
| Room header       | 8F   | 91F8              |
| Room state header | 8F   | after room header |

Room header (bank 8F starting at $91F8):

| Offset | Size | Description              |
| ------ | ---- | ------------------------ |
| 0      | 1    | Room index               |
| 1      | 1    | Area                     |
| 2      | 1    | X position on map        |
| 3      | 1    | Y position on map        |
| 4      | 1    | Width (in screens)       |
| 5      | 1    | Height (in screens)      |
| 6      | 1    | Up scroller              |
| 7      | 1    | Down scroller            |
| 8      | 1    | Special graphics bitflag |
| 9      | 2    | Doorout pointer          |

### Room state function list

The room state function list follows the room header; it consists of a
series of entries with a 2-byte pointer to a state function, a variable
payload, and a 2-byte pointer to a room state header.  The size of the
payload depends on which state function is used.  The list terminates
with a state function of $E5E6.

Common state functions:

| State func | Description            | Payload            |
| ---------- | ---------------------- | ------------------ |
| E5EB       | Door (unused)          | ?                  |
| E5FF       | Main area boss         | none               |
| E612       | Event                  | event id (2 bytes) |
| E640       | Morph (unused)         | ?                  |
| E652       | Morph+missiles         | none               |
| E669       | Power bombs            | none               |
| E678       | Speed booster (unused) | ?                  |

### Room state header

Room state header (bank 8F starting at $91F8):

| Offset | Size | Description                |
| ------ | ---- | -------------------------- |
|  0h    | 3    | Level data                 |
|  3h    | 1    | Tileset                    |
|  4h    | 1    | Music data index           |
|  5h    | 1    | Music track index          |
|  6h    | 2    | FX pointer                 |
|  8h    | 2    | Enemy population pointer   |
|  Ah    | 2    | Enemy graphics set pointer |
|  Ch    | 2    | Layer 2 scroll             |
|  Eh    | 2    | Room scroll                |
| 10h    | 2    | Room var (used for BT)     |
| 12h    | 2    | Room main asm              |
| 14h    | 2    | Room PLM list              |
| 16h    | 2    | Library background         |
| 18h    | 2    | Room setup asm             |

### Room PLMs

The room PLM list is a list of PLMs for the room, terminated by 0000h.
The format of each entry in this list is:

| Offset | Size | Description                     |
| ------ | ---- | ------------------------------- |
| 0      | 2    | Pointer to PLM                  |
| 2      | 1    | Row (X) of PLM block            |
| 3      | 1    | Col (Y) of PLM block            |
| 4      | 2    | Room argument (or scroll data?) |

There is no room to add a new entry to the end of the list, but it
should be possible to explicitly call $84:846A in the room setup routine
to manually spawn a room PLM.

### Current room state

The state of the current room is stored in memory as:

| Addresss  | Bytes | Description               |
| --------- | ----- | ------------------------- |
| $7E:078D  | 2     | Entry door pointer        |
| $7E:078F  | 2     | Door BTS                  |
| $7E:079B  | 2     | Room header pointer       |
| $7E:079D  | 2     | Room index                |
| $7E:079F  | 2     | Area                      |
| $7E:07A1  | 2     | X position on map         |
| $7E:07A3  | 2     | Y position on map         |
| $7E:07A5  | 2     | Room width (in blocks)    |
| $7E:07A7  | 2     | Room height (in blocks)   |
| $7E:07A9  | 2     | Room width (in screens)   |
| $7E:07AB  | 2     | Room height (in screens)  |
| $7E:07AD  | 2     | Up scroller               |
| $7E:07AF  | 2     | Down scroller             |
| $7E:07B5  | 2     | Door out pointer          |
| $7E:07B9  | 2     | Area of room (in blocks)  |
| $7E:07BB  | 2     | Room state header pointer |
| $7E:07BD  | 2     | Level data pointer        |
| $7E:07C0  | 3     | Room tile table pointer   |
| $7E:07C3  | 3     | Room tiles pointer        |
| $7E:07C6  | 3     | Room tilemap pointer      |
| $7E:07C9  | 2     | Music track index         |
| $7E:07CB  | 2     | Music data index          |
| $7E:07CD  | 2     | FX pointer                |
| $7E:07CF  | 2     | Enemy population pointer  |
| $7E:07D1  | 2     | Enemy set pointer         |
| $7E:07DF  | 2     | Room main routine         |

TODO: What is the difference between a "graphic set", a "tileset", and a "tile table"?

TODO: room "layer 2 scroll" is copied to $091B; what is this, and how is it different from "room scroll"?

### Level data (Tilemap/BTS)

The level data for each room is stored in a compressed format:

| Bytes  | Description              | Copied to |
| ------ | ------------------------ | --------- |
| 2      | Size of level data       | 7F:0000   |
| size   | Level data (tilemap)     | 7F:0002   |
| size/2 | BTS (for special blocks) | 7F:0002   |

Level data is stored in the following format:

     | ------------------ t = block type
     |  | --------------- y = Y flip
     |  || -------------- x = X flip
     |  ||      | ------- n = block index
     |  ||      |
    /| \||/--- | ---\
    ttttyxnn nnnnnnnn

Custom background ($9602) is stored in a similar format:

        | --------------- y = Y flip
        || -------------- x = X flip
        ||      | ------- n = block index
        ||      |
        ||/--- | ---\
    0000yxnn nnnnnnnn

### Block reactions

The following block reaction tables are defined:

| Address  | Description                    |
| -------- | ------------------------------ |
| $94:82E1 | Post-grapple collision (horiz) |
| $94:8301 | Post-grapple collision (vert)  |
| $94:94D5 | Block collision (horiz)        |
| $94:94F5 | Block collision (vert)         |
| $94:9B40 | Block inside                   |
| $94:A032 | Block bombed                   |
| $94:A175 | Block shot (horiz)             |
| $94:A195 | Block shot (vert)              |
| $94:A83B | Block grappled                 |
| $94:AB90 | Swinging from grappled block   |

Block types (and their respective reaction handlers in bank $94) are:

|      |                 |     Collision      |        Shot/bombed        |          Grapple           |
| Type | Description     | (h)  | (v)  | (i)  | (h)  | (v)  | (b)  | (B)  | (g)  | (s)  | (h)  | (v)   |
| ---- | --------------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ----- |
|   0h | Air             | 84F7 | 84F7 | =    | -    | -    | -    | -    | -    | -    | -    | -     |
|   1h | Slope           | 8FBB | 8FDA | 97BF | A147 | A15E | -    | 9D5D | +    | +    | 82A9 | 82C5  |
|   2h | Spike air       | 9018 | 901A | 98CC | -    | -    | -    | -    | -    | AA9E | -    | -     |
| * 3h | Special air     | 906F | 909D | 9B16 | -    | -    | -    | -    | -    | -    | -    | -     |
| * 4h | Shootable air   | -    | -    | =    | 9E55 | 9E55 | 9E55 | -    | 9E55 | -    | -    | -     |
|   5h | Horiz extension | --   | --   | --   | --   | --   | --   | --   | --   | --   | -    | -     |
|   6h | Unused air      | -    | 84F7 | =    | -    | -    | -    | -    | -    | -    | -    | -     |
|   7h | Bombable air    | 92F9 | 9313 | =    | 9FD6 | 9FD6 | 9FD6 | -    | 9FD6 | -    | -    | -     |
|   8h | Solid block     | 8F49 | 8F82 | =    | +    | +    | +    | +    | +    | +    | 82BE | 82DA  |
|   9h | Door block      | 938B | 93CE | =    | +    | +    | +    | +    | +    | +    | 82BE | 82DA  |
|   Ah | Spike block     | 904B | 905D | =    | +    | +    | +    | +    | A7FD | AB17 | 82BE | 82DA  |
| * Bh | Special block   | 90CB | 9102 | =    | +    | +    | 9D71 | +    | +    | +    | 82BE | 82DA  |
| * Ch | Shootable block | 8F49 | 8F82 | =    | 9E73 | 9E73 | 9E73 | +    | 9E73 | +    | 82BE | 82DA  |
|   Dh | Vert extension  | !    | !    | !    | !    | !    | !    | !    | !    | !    | 82BE | 82DA  |
|   Eh | Grapple block   | 8F49 | 8F82 | =    | +    | +    | +    | +    | A7D1 | +    | 82BE | 82DA  |
|   Fh | Bombable block  | 932D | 934C | =    | 9FF4 | 9FF4 | 9FF4 | +    | 9FF4 | +    | 82BE | 82DA  |

Legend:
* *: BTS ("Behind The Scenes"; customizable via PLM tables)
* h: horizontal shot, collision, or post-grapple collision
* v: vertical shot, collision, or post-grapple collision
* i: inside block
* b: bombed block
* B: bomb spread
* g: grappled
* s: swinging
* -: clear carry (either 8F45 or 9D59)
* +: set carry (either 8F47 or 9D5B)
* =: set normal momentum indices (97D0 or 98DC)
* --: horizontal extension (9411)
* !: vertical extension (9447)

BTS is set to 0 for non-special blocks.

For special blocks, BTS is the index into the PLM tables in bank $94.

### Slopes

Slopes use BTS to determine the type of slope:

     +-------- Y flip
     |+------- X flip
     ||  +---- Shape
     ||  |
     ||/-+\
    7YXsssss

The possible slope shapes are:

|       |        |   Slope definition   |                    |
| Shape | Type   | (Samus)  | (Enemies) | Description        |
| ----- | ------ | -------- | --------- | ------------------ |
|    0h | quad   | $94:8E54 | $A0:C434  | top empty          |
|    1h | quad   | $94:8E58 | $A0:C438  | left empty         |
|    2h | quad   | $94:8E5C | $A0:C43C  | top-left empty     |
|    3h | quad   | $94:8E60 | $A0:C440  | bottom-right solid |
|    4h | quad   | $95:8E64 | $A0:C444  | all quads solid    |
|    5h | sloped |          |           |                    |
|    6h | sloped |          |           |                    |
|    7h | sloped |          |           |                    |
|    8h | sloped |          |           |                    |
|    9h | sloped |          |           |                    |
|    Ah | sloped |          |           |                    |
|    Bh | sloped |          |           |                    |
|    Ch | sloped |          |           |                    |
|    Dh | sloped |          |           |                    |
|    Eh | sloped |          |           |                    |
|    Fh | sloped |          |           |                    |
|   10h | sloped |          |           |                    |
|   11h | sloped |          |           |                    |
|   12h | sloped |          |           |                    |
|   13h | sloped |          |           |                    |
|   14h | sloped |          |           |                    |
|   15h | sloped |          |           |                    |
|   16h | sloped |          |           |                    |
|   17h | sloped |          |           |                    |
|   18h | sloped |          |           |                    |
|   19h | sloped |          |           |                    |
|   1Ah | sloped |          |           |                    |
|   1Bh | sloped |          |           |                    |
|   1Ch | sloped |          |           |                    |
|   1Dh | sloped |          |           |                    |
|   1Eh | sloped |          |           |                    |
|   1Fh | sloped |          |           |                    |

### FX

The room FX pointer points to a list of 16-byte FX entries in bank $83.

Each entry has the form:

| Offset | Size | Description                                |
| ------ | ---- | ------------------------------------------ |
| 0h     | 2    | Door pointer                               |
| 2h     | 2    | Base Y position                            |
| 4h     | 2    | Target Y position                          |
| 6h     | 2    | Y velocity                                 |
| 8h     | 1    | Timer                                      |
| 9h     | 1    | Type                                       |
| Ah     | 1    | FX A: Default layer blending configuration |
| Bh     | 1    | FX B: FX layer 3 blending configuration    |
| Ch     | 1    | FX C: FX liquid options                    |
| Dh     | 1    | Palette FX bitset                          |
| Eh     | 1    | Animated tiles bitset                      |
| Fh     | 1    | Palette blend                              |

The list is terminated with a door pointer of 0000h.

#### FX Types

The following FX types are available:

| Type | Description    | Tilemap | FX Routine | FX A |     FX B    | FX C |
| ---- | -------------- | ------- | ---------- | ---- | ----------- | ---- |
|   2h | Lava           |         |            |      | 1Eh         |      |
|   4h | Acid           | 8A:8840 | 88:B279    |      | 1Eh         |      |
|   6h | Water          | 8A:9080 | 88:C3FF    |      | 14h/16h/18h |      |
|   8h | Spores         | 8A:A100 | 88:DA11    |      | Ah          |      |
|   Ah | Rain           | 8A:A940 | 88:D950    |      | Eh          |      |
|   Ch | Fog            |         | 88:DB08    |      | 30h         |      |
|  20h | Scrolling sky  |         | 88:A7D8    |      |             |      |
|  22h | Scrolling sky  |         | 88:A61B    |      |             |      |
|  24h | Fireflea       |         | 88:B07C    |      | 2h          |      |
|  26h | G4             |         | 88:DB8A    |      | 18h         |      |
|  28h | Ceres Ridley   |         | 88:D8DE    |      | 2h          |      |
|  2Ah | Ceres elevator |         | 88:D928    |      | 2h          |      |
|  2Ch | Haze           |         | 88:DDC7    |      |             |      |

#### Palette Blends

Palette blends are defined in the table at $89:AA02:

| Value | Description                     |
| ----- | ------------------------------- |
|    2h | Tourian acid/lava rooms         |
|   22h | Landing site before power bombs |
|   42h | Yellow Maridia                  |
|   48h | Water rooms                     |
|   62h | Fog and rain                    |
|   E2h | Lower green/pink Maridia        |
|   E8h | Sandy Maridia                   |
|   EEh | Upper green/pink Maridia        |

#### FX State

FX1 state for the current room is:

| Address  | Bytes | Description              |
| -------- | ----- | ------------------------ |
| $7E:1964 | 2     | FX tilemap pointer       |
| $7E:1966 | 2     | Current FX entry pointer |
| $7E:1968 | 2     | Current FX entry offset  |
| $7E:196A | 2     | Palette bitset           |
| $7E:196E | 2     | FX type                  |
| $7E:1978 | 2     | Base Y position          |
| $7E:197A | 2     | Target Y position        |
| $7E:197C | 2     | Y velocity               |
| $7E:197E | 2     | Liquid options           |
| $7E:1980 | 2     | Timer                    |
| $7E:1982 | 2     | Default layer blend      |
| $7E:1984 | 2     | Layer 3 blend            |
| $7E:C232 | 6     | Palette (3 colors)       |

TODO: Is there a difference between FX1/2/3 and FX A/B/C?

PLMs
----

PLMs ("Post-Load Modifications") are the primary mechanism for making
changes to a room after it has been loaded.  PLMs are used for the shot
and collision reaction handlers for special blocks (type 3h and Bh).

There are different kinds of PLM headers.  A room or block PLM header
has two parts:

| Offset | Size | Description          |
| ------ | ---- | -------------------- |
| 0      | 2    | Setup routine        |
| 2      | 2    | Instruction list     |

A door PLM header is similar:

| Offset | Size | Description          |
| ------ | ---- | -------------------- |
| 0      | 2    | Setup routine        |
| 2      | 2    | Instruction list (?) |
| 4      | 2    | Instruction list (?) |

The setup routine is invoked when the PLM is spawned; the instruction
list is executed piecewise as the game progresses.

PLMs can be spawned:
* By a special block reaction handler (using one of the PLM tables)
* For scroll PLMs when the room is loaded
* By the door transition handler to process the transition, close the
  door, etc. (in this case the PLM is dynamically generated, which is
  interesting)
* For other events, by invoking $84:83D7 or $84:84E7 to spawn a PLM
  programmatically.

### Special Block Reaction Tables

The following special block reaction tables tables are defined:

| Address  | Types  | Bank | Description                | R? | Type |
| -------- | ------ | ---- | -------------------------- | -- | ---- |
| $94:9139 | 3h, Bh | $94  | Samus block collision      |    | PLM  |
| $94:91D9 | 3h, Bh | $94  | Samus block collision      | *  | PLM  |
| $94:936B | 7h, Fh | $94  | Samus block collision      |    | PLM  |
| $94:9966 | 3h     | $84  | Inside block               |    | Jump |
| $94:9A06 | 3h     | $84  | Inside block               | *  | PLM  |
| $94:9DA4 | Bh     | $94  | Block bombed               |    | PLM  |
| $94:9DC4 | Bh     | $94  | Block bombed               | *  | PLM  |
| $94:9EA6 | 4h, Ch | $94  | Block shot/bombed/grappled |    | PLM  |
| $94:9F46 | 4h, Ch | $94  | Block shot/bombed/grappled | *  | PLM  |

(R indicates the table is region-dependent)

Some of the reaction tables are jump tables; in these cases the table
holds a pointer to the routine that handles the reaction (TODO: there
are other jump tables too; these should be included as well).  The
routines that the jump tables point to are located in bank $94.

PLM table entries point to an instruction list to execute whenever a
collision or shot occurs; this instruction list is called a PLM.  Most
of the PLMs are located in bank $84; the inside-block PLMs are located
in bank $94.

The following block reaction PLMs are defined in the vanilla ROM:

| BTS | Block Type 3h/Bh  | Col. | Ins. | Bomb | Block Type 4h/Ch   | Shot |
| --- | ----------------- | ---- | ---- | ---- | ------------------ | ---- |
| 00h | 1x1 crumble (r)   | D044 |      | CFFC | 1x1 shot (r)       | D064 |
| 01h | 2x1 crumble (r)   | D048 |      | D000 | 2x1 shot (r)       | D068 |
| 02h | 1x2 crumble (r)   | D04C |      | D004 | 1x2 shot (r)       | D06C |
| 03h | 2x2 crumble (r)   | D050 |      | D008 | 2x2 shot (r)       | D070 |
| 04h | 1x1 crumble       | D054 |      | CFFC | 1x1 shot           | D074 |
| 05h | 1x2 crumble       | D058 |      | D000 | 1x2 shot           | D078 |
| 06h | 2x1 crumble       | D05C |      | D004 | 2x1 shot           | D07C |
| 07h | 2x2 crumble       | D060 |      | D008 | 2x2 shot           | D080 |
| 08h | WS treadmill R    |      | 98EA |      | power bomb (r)     | D084 |
| 09h | WS treadmill L    |      | 9910 |      | power bomb         | D088 |
| 0Ah | treadmill R       |      | 9936 |      | super missile (r)  | D08C |
| 0Bh | treadmill L       |      | 9946 |      | super missile      | D090 |
| 0Ch |                   |      |      |      |                    |      |
| 0Dh |                   |      |      |      |                    |      |
| 0Eh | speed boost (r)   | D038 |      | D024 |                    |      |
| 0Fh | speed boost       | D040 |      | D024 |                    |      |
| 10h |                   |      |      |      | shot/bomb/grapple  | B974 |
| ... |                   |      |      |      |                    |      |
| 40h |                   |      |      |      | blue door facing L | C8A2 |
| 41h |                   |      |      |      | blue door facing R | C8A8 |
| 42h |                   |      |      |      | blue door facing U | C8AE |
| 43h |                   |      |      |      | blue door facing D | C8B4 |
| 44h | generic shot PLM  | C83E |      |      | generic shot PLM   | C83E |
| 45h | item              | EED3 |      |      | item               | EED3 |
| 46h | scroll            | B6FF | 9956 |      | blue gate L        | C816 |
| 47h | map station R     | B6D7 |      |      | blue gate R        | C81A |
| 48h | map station L     | B6DB |      |      | red gate R         | C80E |
| 49h | energy station R  | B6E3 |      |      | red gate R         | C812 |
| 4Ah | energy station L  | B6E7 |      |      | green gate L       | C806 |
| 4Bh | missile station R | B6EF |      |      | green gate R       | C80A |
| 4Ch | missile station L | B6F3 |      |      | yellow gate L      | C81E |
| 4Dh | save station      | B76B |      |      |                    |      |
| 4Eh |                   |      |      |      |                    |      |
| 4Fh | animals escape    |      |      |      | animals escape     | B9C1 |

Legend:
* L/R/U/D: left/right/up/down
* (r): respawning

There are also area-dependent PLMs:

| Area | BTS | Col. | Ins. | Shot | Description                    |
| ---- | --- | ---- | ---- | ---- | ------------------------------ |
| 0    | 80  |      | B70F |      | Crateria ice physics           |
| 1    | 80  | B633 | B6CB |      | Brinstar floor plant           |
| 1    | 81  | B633 |      |      | Brinstar nothing               |
| 1    | 82  | D030 |      |      | Brinstar slow crumble          |
| 1    | 83  | D034 |      |      | Brinstar slower crumble        |
| 1    | 84  | D03C |      |      | Brinstar speed boost block (r) |
| 1    | 85  | D040 |      |      | Brinstar speed boost block     |
| 2    | 80  |      | B653 |      | Norfair nothing                |
| 2    | 81  |      | B657 |      | Norfair nothing                |
| 2    | 82  |      | B65B |      | Norfair nothing                |
| 2    | 83  | D6DA |      |      | Norfair chozo hand trigger     |
| 4    | 80  | B72B | B713 |      | Maridia quicksand surface      |
| 4    | 81  | B72B | B713 |      | Maridia quicksand surface      |
| 4    | 82  | B72B | B713 |      | Maridia quicksand surface      |
| 4    | 83  | B737 | B71F |      | Maridia submerging quicksand   |
| 4    | 84  | B73B | B723 |      | Maridia slow sand falls        |
| 4    | 85  | B73F | B727 |      | Maridia fast sand falls        |
| 7    | 80  |      | B70F |      | Debug ice physics              |

### PLM Initialization

A PLM is initialized by the setup routine referenced in the PLM header.

The PLM setup routine is called with:
* X = PLM ID (pointer to the PLM header)
* Y = List offset for current PLM (same as $1C27)

The setup routine should set the carry flag to treat the block as solid
or leave the carry flag clear to treat it as air.

### PLM State

Each PLM has access to the following variables (where Y is the list
offset for the PLM):

| Address    | Description                             | Size |
| ---------- | --------------------------------------- | ---- |
| $7E:0DC4   | Current block index                     | 2    |
| $7E:1C27   | List offset for current PLM             | 2    |
| $7E:1C29   | Calculated PLM X position               | 2    |
| $7E:1C2B   | Calculated PLM Y position               | 2    |
| $7E:1C2F   | PLM special graphics pointer (bank $89) | 2    |
| $7E:1C37+y | List - PLM header table                 | 80   |
| $7E:1C87+y | List - Tilemap offset of PLM's block    | 80   |
| $7E:1CD7+y | List - PLM Pre-instruction              | 80   |
| $7E:1D27+y | List - Next PLM instruction             | 80   |
| $7E:1D77+y | List - Variable-use PLM value           | 80   |
| $7E:1DC7+y | List - PLM room argument                | 80   |
| $7E:1E17+y | List - Variable-use PLM value           | 80   |
| $7E:DE1C+y | List - Draw timer                       | 80   |
| $7E:DE6C+y | List - Draw instruction pointer         | 80   |
| $7E:DEBC+y | List - Link instruction                 | 80   |
| $7E:DF0C+y | List - Item PLM graphics index          | 80   |

### PLM Instruction List

A PLM instruction list consists of variable-width PLM instructions.  A
PLM instruction has the following format:

| Condition         | Opcode meaning (bytes) | Operand meaning              (bytes) |
| ----------------- | ---------------------- | ------------------------------------ |
| Opcode >= 8000h   | PLM instruction    (2) | n/a                              (0) |
| Opcode &lt; 8000h | timer              (2) | Pointer to draw instruction list (2) |
| Opcode == 0000h   | terminate              | n/a                              (0) |

A PLM instruction list is NOT terminated.

### PLM Draw Instruction List

A draw instruction list is used to animate blocks as they change.  The
list consists of variable-width draw instructions.  A draw instruction
operand has the following format:

    | ------------------- column (1) or row (0)
    |             | ----- number of tiles to change
    |             |
    |         /-- | --\
    FEDC BA98 7654 3210

The draw instruction is followed by the new level data (tilemap) values
to be applied.

A draw instruction list is terminated by 0000h.

### PLM Pre-instruction

The PLM pre-instruction is a pointer to a subroutine that is each time a
PLM instruction is processed, just before processing the instruction.

### PLM Instruction Routines

The following general-purpose routines can be used as instructions in PLM instruction lists:

| Address | Description                          | Arguments (Bytes)                 | Arg Bytes |
| ------- | ------------------------------------ | --------------------------------- | --------- |
| 86B4    | sleep                                |                                   |           |
| 86BC    | delete                               |                                   |           |
| 86C1    | set pre-instruction                  | pre-instruction (2)               | 2         |
| 86CA    | clear pre-instruction                |                                   |           |
| 86EB    | call subroutine with arg             | subroutine (3), arg (2)           | 5         |
| 870B    | call subroutine                      | subroutine (3)                    | 3         |
| 8724    | goto                                 | instruction ptr (2)               | 2         |
| 8729    | goto (rel)                           | offset (2)                        | 2         |
| 873F    | dec timer and goto unless 0          | instruction ptr (2)               | 2         |
| 8747    | dec timer and goto unless 0 (rel)    | offset (2)                        | 2         |
| 874E    | set timer                            | timer value (1)                   | 1         |
| 875A    | set timer (16-bit)                   | timer value (2)                   | 2         |
| 8763    | nop                                  |                                   |           |
| 8764    | load item plm graphics               | TODO                              | 10?       |
| 87E5    | copy to vram                         | TODO                              | 7         |
| 880E    | goto if boss bits set                | TODO                              | 2         |
| 8821    | set boss bits for current area       | boss mask (1)                     | 1         |
| 882D    | goto if event is set                 | instruction ptr (2), event (1)    | 3         |
| 883E    | set event                            | event (1)                         | 1         |
| 8848    | goto if PLM room arg chozo bit set   | instruction ptr (2)               | 2         |
| 8865    | set PLM room arg chozo bit           |                                   |           |
| 887C    | goto if PLM room arg item bit set    | instruction ptr (2)               | 2         |
| 8869    | set PLM room arg item bit            |                                   |           |
| 88B0    | pick up beam and display msg         | beam (2), msg (1)                 | 3         |
| 88F3    | pick up equipment and display msg    | item (2), msg (1)                 | 3         |
| 8891    | pick up item and add grapple to hud  | item (2)                          | 2         |
| 8A24    | link instruction                     | instruction ptr (2)               | 2         |
| 8A2E    | call instruction                     | instruction ptr (2)               | 2         |
| 8A3E    | return from call                     |                                   |           |
| 8A72    | goto if PLM room arg door bit set    | instruction ptr (2)               | 2         |
| 8865    | set PLM room arg door bit and goto   | hit cond (1), instr ptr (2)       | 2         |
| 8ACD    | inc PLM room arg and goto if >=      | cond (1), instr ptr (2)           | 2         |
| 8AF1    | set PLM bts                          | new bts value (1)                 | 1         |
| 8B17    | draw PLM block                       |                                   |           |
| 8BD1    | queue music track                    | track (1)                         | 1         |
| 8BDD    | clear music queue and queue track    | track (1)                         | 1         |
| 8C07    | queue sound from library 1 (max 6)   | sound (1)                         | 1         |
| 8C10    | queue sound from library 2 (max 6)   | sound (1)                         | 1         |
| 8C19    | queue sound from library 3 (max 6)   | sound (1)                         | 1         |
| 8D41    | goto if samus is close               | cols (1), rows (1), instr ptr (2) | 4         |
| BBDD    | clear PLM timer                      |                                   |           |
| BBE1    | spawn enemy projectile               | projectile (2)                    | 2         |
| BBF0    | wake enemy projectile at PLM's pos   | unused (2)                        | 2         |
| D155    | goto if PLM room arg &lt;            | instruction ptr (2), cond (2)     | 4         |
| D5E6    | disable samus controls               |                                   |           |
| D5EE    | enable samus controls                |                                   |           |

### Modifying a block

TODO: I am still learning how this works.

AFAICT the instruction lists in Bank 84 have drawing instructions and
following the drawing instructions have 8B17.  But I don't understand
how that works -- how can we execute 8B17 to draw the PLM block if we
haven't finished executing the drawing instructions?

### PLM Deletion

To delete a PLM, do one of the following:
* Store #$0000 at $7E:1C37+y
* Use a delete instruction (such as $86BC)

### Tileset

The tileset is an index into the tileset pointer table at $8F:E7A7.

The tileset pointer table stores pointers into the tileset table at
$8F:E6A2.

| Tileset | Address  | Tile table | Tiles    | Palette  | Description                       |
| ------- | -------- | ---------- | -------- | -------- | --------------------------------- |
| 0h      | $8F:E6A2 | $C1:B6F6   | $BA:C629 | $C2:AD7C | Upper Crateria                    |
| 1h      | $8F:E6AB | $C1:B6F6   | $BA:C629 | $C2:AE5D | Red Crateria                      |
| 2h      | $8F:E6B4 | $C1:BEEE   | $BA:F911 | $C2:AF43 | Lower Crateria                    |
| 3h      | $8F:E6BD | $C1:BEEE   | $BA:F911 | $C2:B015 | Old Tourian                       |
| 4h      | $8F:E6C6 | $C1:C5CF   | $BB:AE9E | $C2:B0E7 | Wrecked Ship - power on           |
| 5h      | $8F:E6CF | $C1:C5CF   | $BB:AE9E | $C2:B1A6 | Wrecked Ship - power off          |
| 6h      | $8F:E6D8 | $C1:CFA6   | $BB:E6B0 | $C2:B264 | Green/blue Brinstar               |
| 7h      | $8F:E6E1 | $C1:D8DC   | $BC:A5AA | $C2:B35F | Red Brinstar / Kraid's lair       |
| 8h      | $8F:E6EA | $C1:D8DC   | $BC:A5AA | $C2:B447 | Pre Tourian entrance corridor     |
| 9h      | $8F:E6F3 | $C1:E361   | $BD:C3F9 | $C2:B5E4 | Heated Norfair                    |
| Ah      | $8F:E6FC | $C1:E361   | $BD:C3F9 | $C2:B6BB | Unheated Norfair                  |
| Bh      | $8F:E705 | $C1:F4B1   | $BE:B130 | $C2:B83C | Sandless Maridia                  |
| Ch      | $8F:E70E | $C2:855F   | $BE:E78D | $C2:B92E | Sandy Maridia                     |
| Dh      | $8F:E717 | $C2:9B01   | $BF:D414 | $C2:BAED | Tourian                           |
| Eh      | $8F:E720 | $C2:9B01   | $BF:D414 | $C2:BBC1 | Mother Brain's room               |
| Fh      | $8F:E729 | $C2:A75E   | $C0:B004 | $C2:C104 | Blue Ceres                        |
| 10h     | $8F:E732 | $C2:A75E   | $C0:B004 | $C2:C1E3 | White Ceres                       |
| 11h     | $8F:E73B | $C2:A75E   | $C0:E22A | $C2:C104 | Blue Ceres elevator               |
| 12h     | $8F:E744 | $C2:A75E   | $C0:E22A | $C2:C1E3 | White Ceres elevator              |
| 13h     | $8F:E74D | $C2:A75E   | $C1:8DA9 | $C2:C104 | Blue Ceres Ridley's room          |
| 14h     | $8F:E756 | $C2:A75E   | $C1:8DA9 | $C2:C1E3 | White Ceres Ridley's room         |
| 15h     | $8F:E75F | $C2:A27B   | $C0:860B | $C2:BC9C | Map room / Tourian entrance       |
| 16h     | $8F:E768 | $C2:A27B   | $C0:860B | $C2:BD7B | Wrecked Ship map room - power off |
| 17h     | $8F:E771 | $C2:A27B   | $C0:860B | $C2:BE58 | Blue refill room                  |
| 18h     | $8F:E77A | $C2:A27B   | $C0:860B | $C2:BF3D | Yellow refill room                |
| 19h     | $8F:E783 | $C2:A27B   | $C0:860B | $C2:C021 | Save room                         |
| 1Ah     | $8F:E78C | $C1:E189   | $BC:DFF0 | $C2:B510 | Kraid's room                      |
| 1Bh     | $8F:E795 | $C1:F3AF   | $BD:FE2A | $C2:B798 | Crocomire's room                  |
| 1Ch     | $8F:E80E | $C2:960D   | $BF:9DEA | $C2:BA2C | Draygon's room                    |

### Music

TODO

Enemies
-------

### Enemy population

Each room state header has an enemy population pointer (SMM calls this
the enemy set, but pjboy uses enemy set to refer to the enemy graphic
list, so I've avoided that term altogether).  The enemy population
pointer points to a list in bank $A1 of 16-byte enemy population
entries:

| Offset | Bytes | Description              | Stored at  |
| ------ | ----- | ------------------------ | ---------- |
| 0h     | 2     | Enemy pointer            | $7E:0F78+y |
| 2h     | 2     | X pos in room            | $7E:07FA+y |
| 4h     | 2     | Y pos in room            | $7E:0F7E+y |
| 6h     | 2     | Init parameter           | $7E:0F92+y |
| 8h     | 2     | Initial properties       | $7E:0F86+y |
| Ah     | 2     | Initial Extra properties | $7E:0F88+y |
| Ch     | 2     | Parameter 1              | $7E:0FB4+y |
| Eh     | 2     | Parameter 2              | $7E:0FB6+y |

The list is terminated with:

| Offset | Bytes | Description                   |
| ------ | ----- | ----------------------------- |
| 0h     | 2     | $FFFF                         |
| 2h     | 1     | Kill quota to open grey doors |

The enemy pointer is a 16-byte offset into bank $A0, pointing to the
enemy header for the enemy to be spawned.

#### Enemy property bits

The enemy property bits are:


    +-------------------- (F) whether hitbox is solid to Samus
    |+------------------- (E) automatically respawn
    ||+------------------ (D) whether to process enemy's graphic AI
    |||+----------------- (C) enemy can block plasma shots
    |||| +--------------- (B) enemy processes offscreen
    |||| |+-------------- (A) enemy ignores Samus/projectiles
    |||| ||+------------- (9) whether enemy should be deleted
    |||| |||+------------ (8) invisible?
    |||| ||||        +--- (2) orientation (geemers)
    |||| ||||        |+-- (1) orientation (geemers)
    |||| ||||        ||
    FEDC BA98 7654 3210

#### Extra property bits

Extra property bits are:

    +-------------------- (F) graphics need to be updated
    |               +---- (2) enable multiple hitbox/reactions (extended spritemaps?)
    |               | +-- (0) disable processing of movement AI
    |               | |
    FEDC BA98 7654 3210

### Enemy graphics set

There is also a corresponding enemy graphics set in bank $B4; it must
also be updated for the enemies to have the correct graphics.  The
format for each entry is:

| Offset | Bytes | Description      |
| ------ | ----- | ---------------- |
| 0h     | 2     | Enemy pointer    |
| 2h     | 2     | Palette?         |

The list is terminated with $FFFF.

### Enemy header

At the end of bank $A0 is a list of enemy headers; these define the
characteristics for each enemy in the game.

The format of the enemy header is:

| Offset | Bytes | Description               |
| ------ | ----- | ------------------------- |
| 0h     | 2     | Tile data size            |
| 2h     | 2     | Palette                   |
| 4h     | 2     | Health                    |
| 6h     | 2     | Damage                    |
| 8h     | 2     | X Radius                  |
| Ah     | 2     | Y Radius                  |
| Ch     | 1     | Bank                      |
| Dh     | 1     | Hurt AI time              |
| Eh     | 2     | Cry                       |
| 10h    | 2     | Boss Value                |
| 12h    | 2     | Init AI routine           |
| 14h    | 2     | Number of parts           |
| 16h    | 2     | 0000h                     |
| 18h    | 2     | Main AI routine           |
| 1Ah    | 2     | Grapple AI routine        |
| 1Ch    | 2     | Hurt AI routine           |
| 1Eh    | 2     | Frozen AI routine         |
| 20h    | 2     | Time is frozen AI routine |
| 22h    | 2     | Death animation           |
| 24h    | 8     | 00000000h                 |
| 28h    | 2     | Power bomb reaction       |
| 2Ah    | 2     | 0000h                     |
| 2Ch    | 8     | 00000000h                 |
| 30h    | 2     | Enemy touch routine       |
| 32h    | 2     | Enemy shot routine        |
| 34h    | 2     | 0000h                     |
| 36h    | 1     | Tile data                 |
| 39h    | 1     | Layer                     |
| 3Ah    | 2     | Drop chances              |
| 3Ch    | 2     | Vulnerabilities           |
| 3Eh    | 2     | Enemy name                |

TODO: I do not know if the enemy headers need to be contiguous or if
there can be a gap (I believe it is OK to store the headers anywhere in
bank $A0 but have not confirmed).

TODO: Tile data size is NOT the number of bytes in tile data.

### Enemy state

The 64-byte in-memory enemy state is initialized as follows (where y is
the enemy offset, i.e. $000 for the first enemy $040 for the second
enemy, $080 for the third enemy, etc.):

| Bytes | Description         | Stored at  | Initial value        |
| ----- | ------------------- | ---------- | -------------------- |
| 2     | Pointer (ID)        | $7E:0F78+y | [pop entry + 00h]    |
| 2     | X pos               | $7E:0F7A+y | [pop entry + 02h]    |
| 2     | X subpixel pos      | $7E:0F7C+y | 0?                   |
| 2     | Y pos               | $7E:0F7E+y | [pop entry + 04h]    |
| 2     | Y subpixel pos      | $7E:0F80+y | 0?                   |
| 2     | X radius            | $7E:0F82+y | [enemy header + 08h] |
| 2     | Y radius            | $7E:0F84+y | [enemy header + 0Ah] |
| 2     | Properties          | $7E:0F86+y | [pop entry + 08h]    |
| 2     | Extra properties    | $7E:0F88+y | [pop entry + 0Ah]    |
| 2     | Active AI bitmask   | $7E:0F8A+y | 0000                 |
| 2     | Health              | $7E:0F8C+y | [enemy header + 04h] |
| 2     | Graphics flags      | $7E:0F8E+y | ?                    |
| 2     | Instruction timer   | $7E:0F90+y | 0                    |
| 2     | Instruction pointer | $7E:0F92+y | ?                    |
| 2     | Action delay?       | $7E:0F94+y | 1                    |
| 2     | Palette index       | $7E:0F96+y | ($7E:7006+x) & $0E00 |
| 2     | VRAM tiles index    | $7E:0F98+y | ($7E:7006+x) & $01FF |
| 2     | Layer               | $7E:0F9A+y | [enemy header + 39h] |
| 2     | Flash timer         | $7E:0F9C+y | 0                    |
| 2     | Frozen timer        | $7E:0F9E+y | 0                    |
| 2     | Invicibility timer  | $7E:0FA0+y | 0                    |
| 2     | Shake timer         | $7E:0FA2+y | 0                    |
| 2     | Frame counter       | $7E:0FA4+y | 0                    |
| 1     | Bank                | $7E:0FA6+y | [enemy header + 0Ch] |
| 1     | Unused?             | $7E:0FA7+y | [enemy header + 0Dh] |
| 12    | AI variables        | $7E:0FA8+y | 0                    |
| 2     | Parameter 1         | $7E:0FB4+y | [pop entry + 0Ch]    |
| 2     | Parameter 2         | $7E:0FB6+y | [pop entry + 0Eh]    |

### Other common variables

| Addresss | Bytes | Description          |
| -------- | ----- | -------------------- |
| $7E:0E54 | 2     | Current enemy index  |

### Init routine

It is important in the init routine to set the instruction pointer,
otherwise the game will hang.

### AI routines

In addition to the init AI routine, there are five other AI routines;
which is invoked on any frame depends on which bits are set in the
active AI handler bitmask.

Active AI handler bitmask is:

                   | ---- (3) Time is frozen AI
                   || --- (2) Frozen AI
                   ||| -- (1) Hurt AI
                   |||| - (0) Grapple AI
                   ||||
    FEDC BA98 7654 3210

The lowest set bit of the bitmask controls the active AI handler.  If
the active AI handler is 0, then main AI is used.

Enemy Projectiles
-----------------

### Enemy projectile header

Headers for enemy projectiles are in bank $86.  The format is:

| Offset | Bytes | Description               |
| ------ | ----- | ------------------------- |
| 0h     | 2     | Init AI routine           |
| 2h     | 2     | Pre-instruction routine   |
| 4h     | 2     | Instruction list          |
| 6h     | 1     | X radius                  |
| 7h     | 1     | Y radius                  |
| 8h     | 2     | Properties                |
| Ah     | 2     | Hit instruction list      |
| Ch     | 2     | Shot instruction list     |

### Enemy projcetile properties

    +---------- projectile collision detection
    |+--------- projectile is deleted on contact?
    ||+-------- collisions with Samus disabled
    |||+------- high priority
    ||||
    8765 4321

TODO - see $A0:9443 for "enemy projectile deleted on contact"
$A0:9A34 - upper bits are "don't detect collision with projectiles, die
on contact, enable collisions with Samus, high priority"


### Spawning an enemy projectile

An enemy projectile is spawned by invoking $86:8097 with:

| Register | Value                                        |
| -------- | -------------------------------------------- |
| Y        | Projectile ID (address of projectile header) |
| A        | Projectile initialization parameter          |

The init AI routine will be called with Y=projectile offset.

### Enemy projectile state

Projectile have the following in-memory state (kept as lists rather than
a structure for each projectile):

| Address    | Bytes | Description                     | Initial value        |
| ---------- | ----- | ------------------------------- | -------------------- |
| $7E:0C18+y | 2     | Projectile type                 |                      |
| $7E:18A6   | 2     | Current projectile index        |                      |
| $7E:1997+y | 2     | Projectile ID                   | X                    |
| $7E:19BB+y | 2     | VRAM tiles index                | 0000h                |
| $7E:19DF+y | 2     | Timer                           | uninitialized        |
| $7E:1A03+y | 2     | Pre-instruction                 | [X + 2]              |
| $7E:1A27+y | 2     | ?                               | 0000h                |
| $7E:1A4B+y | 2     | X position                      | uninitialized        |
| $7E:1A6F+y | 2     | X subpixel position             | 0000h                |
| $7E:1A93+y | 2     | Y position                      | uninitialized        |
| $7E:1AB7+y | 2     | Y subpixel position             | uninitialized        |
| $7E:1ADB+y | 2     | ?                               | uninitialized        |
| $7E:1AFF+y | 2     | ?                               | 0000h                |
| $7E:1B23+y | 2     | ?                               | 0000h                |
| $7E:1B47+y | 2     | Instruction list pointer        | [X + 4]              |
| $7E:1B6B+y | 2     | Spritemap pointer               | 8000h                |
| $7E:1B8F+y | 2     | Instruction delay               | uninitialized        |
| $7E:1BB3+y | 2     | X / Y radius                    | [X + 6]              |
| $7E:1BD7+y | 2     | Properties                      | [X + 8]              |
| $7E:1BFB+y | 2     | ?                               | 0000h                |
| $7E:F380+y | 2     | Projectile/projectile collision |                      |

### Enemy projectile init routine

The init routine is invoked when the projectile is spawned.  It is
called with Y = offset into state lists for the projectile.

### Enemy projectile pre-instruction routine

The projectile pre-instruction routine is like the main AI for an enemy.
It is a routine that is invoked every time the projectile is processed,
just before the instruction list is processed.

It is called with X = offset into the state lists for the projectile
(note the difference with the init routine which uses Y as the offset).

Graphics
========

Palettes
--------

Palette memory:

| Address  | Bytes | Description                                           |
| -------- | ----- | ----------------------------------------------------- |
| $7E:C000 | 512   | Actual palette; uploaded to CGRAM before drawing      |
| $7E:C200 | 512   | Target palette; this is copied to $7E:C000 before NMI |
| $7E:C400 | 2     | Palette change fraction, numerator                    |
| $7E:C402 | 2     | Palette change fraction, denominator                  |
| $7E:C404 | 2     | Current index for C000/C200                           |

The palettes are allocated as follows:

| Actual   | Target   | FX   | OAM  | Colors | Type   | Index | Notes                        |
| -------- | -------- | -----|----- | ------ | ------ | ----- | ---------------------------- |
| $7E:C000 | $7E:C200 |      |      | 16     | BG1/2  | 0     | CRE, grey doors              |
| $7E:C020 | $7E:C220 |      |      | 16     | BG1/2  | 1     | CRE, green doors             |
| $7E:C000 | $7E:C210 |      |      | 4?     | BG3    | 0     |                              |
| $7E:C008 | $7E:C210 |      |      | 4?     | BG3    | 1     |                              |
| $7E:C010 | $7E:C210 |      |      | 4?     | BG3    | 2     |                              |
| $7E:C018 | $7E:C218 |      |      | 4?     | BG3    | 3     |                              |
| $7E:C020 | $7E:C220 |      |      | 4?     | BG3    | 4     |                              |
| $7E:C028 | $7E:C228 |      |      | 4?     | BG3    | 5     |                              |
| $7E:C030 | $7E:C230 |      |      | 4?     | BG3    | 6     |                              |
| $7E:C038 | $7E:C238 |      |      | 4?     | BG3    | 7     |                              |
| $7E:C040 | $7E:C240 | 040h |      | 16?    | BG1/2? | 2?    | Red doors                    |
| $7E:C060 | $7E:C260 | 060h |      | 16     | BG1/2  | 3     | Blue doors                   |
| $7E:C080 | $7E:C280 | 080h |      | 16     | BG1/2  | 4     |                              |
| $7E:C0A0 | $7E:C2A0 | 0A0h |      | 16     | BG1/2  | 5     |                              |
| $7E:C0C0 | $7E:C2C0 | 0C0h |      | 16     |        | 6?    |                              |
| $7E:C0E0 | $7E:C2E0 | 0E0h |      | 16     |        | 7?    |                              |
| $7E:C100 | $7E:C300 | 100h | 000h | 15?    | Sprite | 0     | Enemy hurt palette?          |
| $7E:C120 | $7E:C320 | 120h | 200h | 15?    | Sprite | 1     | Enemies                      |
| $7E:C140 | $7E:C340 | 140h | 400h | 15?    | Sprite | 2?    | Enemies                      |
| $7E:C160 | $7E:C360 | 160h | 600h | 15?    | Sprite | 3     | Enemies                      |
| $7E:C180 | $7E:C380 | 180h | 800h | 15?    |        | 4?    | Samus                        |
| $7E:C1A0 | $7E:C3A0 | 1A0h | A00h | 15?    | Sprite | 5     | Common sprites               |
| $7E:C1C0 | $7E:C3C0 | 1C0h | C00h | 15?    |        | 6?    | Current beam?                |
| $7E:C1E0 | $7E:C3E0 | 1E0h | E00h | 15?    |        | 7?    | Bosses?                      |

Useful functions:
* $A9:D2E4 - Write [A] colors from [DB]:[Y] to colour index [X]
* $B4:98DA - Debug sprite palette viewer
* $B4:9925 - Debug background palette viewer

Tilesets
--------

A tile is the pixel grid for a drawable entity.

A tileset is a group of tiles.  Each layer can use one tileset, so
different rooms use different tilesets depending on which room elements
need to be drawn.

Elements common to all rooms are called Common Room Elements (CRE).  CRE
tiles are stored in the CRE tileset.  The CRE tileset is stored in
compressed form in bank $B9.

The Scene Elements (SCE) are part of the tileset specified in a room's
state header; this is an index into the tileset pointer table at
$8F:E7A7.  There are a total of 29 different tilesets in the vanilla
ROM.

The tileset pointer table holds pointers into the tileset table at
$8F:E6A2.  The entries in the tileset table have the following format:

| Offset | Size | Description        |
| ------ | ---- | ------------------ |
| 0h     | 3    | Tile table pointer |
| 3h     | 3    | Tiles pointer      |
| 6h     | 3    | Palette pointer    |

The tile table, tiles, and palette are all stored in compressed form.

The tile table is an array of tile table entries.  The format of a tile
table entry is:

| Offset | Size | Description        |
| ------ | ---- | ------------------ |
| 0h     | 2    | Top left           |
| 2h     | 2    | Top right          |
| 4h     | 2    | Bottom left        |
| 6h     | 2    | Bottom right       |


Spritemaps
----------

A spritemap is a structure that represents the tiles to use for a single
animation frame.  It is stored as an array of spritemap entries,
preceded by a 2-byte count of the number of entries in the array:

| Offset | Size | Description       |
| ------ | ---- | ----------------- |
| 0      | 2    | Number of entries |
| 2      | 5    | Entry 0           |
| ...    | 5    | Entry ...

The format of a spritemap entry is:

    | -------------------------------------------- s: size bit
    |    | --------------------------------------- S: debug size bit
    |    |      | -------------------------------- x: X offset from center
    |    |      |        | ----------------------- y: Y offset from center
    |    |      |        |     | ----------------- Y: Y flip
    |    |      |        |     || ---------------- X: X flip
    |    |      |        |     || | -------------- p: priority
    |    |      |        |     || | | ------------ P: palette
    |    |      |        |     || | |      | ----- t: tile number
    |    |      |        |     || | |      |
    |    | /--- | --\ /- | --\ ||/+/+\/--- | --\
    s0000S0x.xxxxxxxx yyyyyyyy YXppPPPt.tttttttt
    \-----word------/ \-byte-/ \-----word------/

The format is similar to (the same as?) used for OAM sprite properties
(TODO - I think it's the first byte is the size and the next for bytes
are the OAM properties for the sprite slot);
see:
* https://sneslab.net/wiki/YXPPCCCT)
* https://wiki.superfamicom.org/snes-sprites
* https://wiki.superfamicom.org/sprites
* https://snes.nesdev.org/wiki/Sprites

TODO: What is the format of x and y for negative coordinates?  Is it
ones-complement or twos-complement?

Extended spritemaps
-------------------

Larger drawables use extended spritemaps, which connect many smaller
spritemaps into a single larger one.  It also holds the hitboxes for the
entity.

Samus
-----

In addition to spritemaps, Samus uses tile definitions, tile definition
lists, animation definitions, animation definition lists, spritemap
tables, and spritemap table index lists.  All of these are located in
bank $92.

Tilemaps
--------

Tiles are the pixel graphics graphics for room tiles.  A tilemap maps
tiles to a room, a map, or to layer 3 graphics.

A tileset is a pixel grid that contains a group of tiles.  It is stored
in compressed form.

Complete Lists
==============

PLM Instruction Routines
------------------------

| Address | Description                          | Arguments (Bytes)              | Arg Bytes |
| ------- | ------------------------------------ | ------------------------------ | --------- |
| 86B4    | sleep                                |                                |           |
| 86BC    | delete                               |                                |           |
| 86C1    | set pre-instruction                  | pre-instruction (2)            | 2         |
| 86CA    | clear pre-instruction                |                                |           |
| 86D1    | call subroutine                      | subroutine (3)                 | 3         |
| 86EB    | call subroutine with arg             | subroutine (3), arg (2)        | 5         |
| 870B    | call subroutine                      | subroutine (3)                 | 3         |
| 8724    | goto                                 | instruction ptr (2)            | 2         |
| 8729    | goto (rel)                           | offset (2)                     | 2         |
| 873F    | dec timer and goto unless 0          | instruction ptr (2)            | 2         |
| 8747    | dec timer and goto unless 0 (rel)    | offset (2)                     | 2         |
| 874E    | set timer                            | timer value (1)                | 1         |
| 875A    | set timer (16-bit)                   | timer value (2)                | 2         |
| 8763    | nop                                  |                                |           |
| 8764    | load item plm graphics               | TODO                           | 10?       |
| 87E5    | copy to vram                         | TODO                           | 7         |
| 880E    | goto if boss bits set                | TODO                           | 2         |
| 8821    | set boss bits for current area       | boss mask (1)                  | 1         |
| 882D    | goto if event is set                 | instruction ptr (2), event (1) | 3         |
| 883E    | set event                            | event (1)                      | 1         |
| 8848    | goto if PLM room arg chozo bit set   | instruction ptr (2)            | 2         |
| 8865    | set PLM room arg chozo bit           |                                |           |
| 887C    | goto if PLM room arg item bit set    | instruction ptr (2)            | 2         |
| 8869    | set PLM room arg item bit            |                                |           |
| 88B0    | pick up beam and display msg         | beam (2), msg (1)              | 3         |
| 88F3    | pick up equipment and display msg    | item (2), msg (1)              | 3         |
| 8891    | pick up item and add grapple to hud  | item (2)                       | 2         |
| 8968    | collect energy tank                  | tank capacity (2)              | 2         |
| 8986    | collect reserve tank                 | tank capacity (2)              | 2         |
| 89A9    | collect missile tank                 | tank capacity (2)              | 2         |
| 89D2    | collect super missile tank           | tank capacity (2)              | 2         |
| 89FB    | collect power bomb tank              | tank capacity (2)              | 2         |
| 8A24    | link instruction                     | instruction ptr (2)            | 2         |
| 8A2E    | call instruction                     | instruction ptr (2)            | 2         |
| 8A3E    | return from call                     |                                |           |
| 8A40    | wait until enemy 0 is dead           |                                |           |
| 8A59    | wait until enemy 1 is dead           |                                |           |
| 8A72    | goto if PLM room arg door bit set    | instruction ptr (2)            | 2         |
| 8865    | set PLM room arg door bit and goto   | hit cond (1), instr ptr (2)    | 2         |
| 8ACD    | inc PLM room arg and goto if >=      | cond (1), instr ptr (2)        | 2         |
| 8AF1    | set PLM bts                          | new bts value (1)              | 1         |
| 8B05    | draw PLM block                       |                                |           |
| 8B17    | draw PLM block                       |                                |           |
| 8B55    | process air scroll                   |                                |           |
| 8B93    | process solid scroll                 |                                |           |
| 8BD1    | queue music track                    | track (1)                      | 1         |
| 8BDD    | clear music queue and queue track    | track (1)                      | 1         |
| 8C07    | queue sound from library 1 (max 6)   | sound (1)                      | 1         |
| 8C10    | queue sound from library 2 (max 6)   | sound (1)                      | 1         |
| 8C19    | queue sound from library 3 (max 6)   | sound (1)                      | 1         |
| 8C22    | queue sound from library 1 (max 15)  | sound (1)                      | 1         |
| 8C2B    | queue sound from library 2 (max 15)  | sound (1)                      | 1         |
| 8C34    | queue sound from library 3 (max 15)  | sound (1)                      | 1         |
| 8C3D    | queue sound from library 2 (max 3)   | sound (1)                      | 1         |
| 8C46    | queue sound from library 2 (max 3)   | sound (1)                      | 1         |
| 8C4F    | queue sound from library 3 (max 3)   | sound (1)                      | 1         |
| 8C58    | queue sound from library 1 (max 9)   | sound (1)                      | 1         |
| 8C61    | queue sound from library 2 (max 9)   | sound (1)                      | 1         |
| 8C6A    | queue sound from library 3 (max 9)   | sound (1)                      | 1         |
| 8C73    | queue sound from library 1 (max 1)   | sound (1)                      | 1         |
| 8C7C    | queue sound from library 2 (max 1)   | sound (1)                      | 1         |
| 8C85    | queue sound from library 3 (max 1)   | sound (1)                      | 1         |
| 8C8F    | activate map station                 |                                |           |
| 8CAF    | activate energy station              |                                |           |
| 8CD0    | activate missile station             |                                |           |
| 8CF1    | activate save station and goto if no | instruction ptr (2)            | 2         |
| 8D39    | resume music in 6 seconds            |                                |           |
| 8D41    | goto if samus is close               | columns (1), rows (1)          | 2         |
| 8D89    | move PLM down one block              |                                |           |
| AB00    | move PLM down one block              |                                |           |
| AB51    | set scrolls 0 and 1 to blue          |                                |           |
| AB59    | move PLM down one block              |                                |           |
| ABD6    | move PLM right one block             |                                |           |
| AC9D    | deal 2 damage to samus               |                                |           |
| ACB1    | give samus 30 iframes                |                                |           |
| AD43    | draw 56 tiles of rightward treadmill |                                |           |
| AD58    | draw 56 tiles of leftward treadmill  |                                |           |
| AE35    | goto if energy refill done           | instruction ptr (2)            | 2         |
| AEBF    | goto if missile refill done          | instruction ptr (2)            | 2         |
| B00E    | move samus to save station           |                                |           |
| B024    | display game saved message           |                                |           |
| B030    | finish at save station               |                                |           |
| B9B9    | set animals rescued event            |                                |           |
| BA6F    | goto if samus does not have bombs    | instruction ptr (2)            | 2         |
| ABD6    | move PLM right four blocks           |                                |           |
| BBDD    | clear trigger                        |                                |           |
| BBE1    | spawn enemy projectile               | projectile (2)                 | 2         |
| BBF0    | wake enemy projectile at PLM's pos   | unused (2)                     | 2         |
| BE3F    | set grey door pre-instruction        |                                |           |
| D155    | set FX base Y position = 733         |                                |           |
| D155    | goto if PLM room arg &lt;            | instruction ptr (2), cond (2)  | 4         |
| D03B    | shatter mother brain glass           | TODO                           | 8         |
| D357    | break BT statue with arg             | argument (2)                   | 2         |
| D3C7    | queue song 1 music track             |                                |           |
| D3D7    | transform WS chozo spikes to slopes  |                                |           |
| D3F4    | revert WS chozo slopes to spikes     |                                |           |
| D476    | drain acid lake                      |                                |           |
| D489    | set FX base Y position = 722         |                                |           |
| D4BE    | nop                                  |                                |           |
| D525    | enable water physics                 |                                |           |
| D52C    | spawn glass tube crack projectile    |                                |           |
| D536    | earthquake                           |                                |           |
| D543    | spawn glass shards and air bubbles   |                                |           |
| D5E6    | disable samus controls               |                                |           |
| D5EE    | enable samus controls                |                                |           |
| D7AA    | shoot eye door projectile with arg   | argument (2)                   | 2         |
| D790    | spawn eye door sweat with arg        | argument (2)                   | 2         |
| D79F    | spawn two eye door smoke             |                                |           |
| D7B6    | spawn one eye door smoke             |                                |           |
| D7C3    | move PLM up, blue door facing right  |                                |           |
| D7DA    | move PLM up, blue door facing left   |                                |           |
| DB8E    | damage Drayon turret                 |                                |           |
| DBBE    | damage Drayon turret facing dn/rt    |                                |           |
| DBF7    | damage Drayon turret facing up/rt    |                                |           |
| DC36    | damage Drayon turret                 |                                |           |
| DC60    | damage Drayon turret facing dn/lt    |                                |           |
| DC9F    | damage Drayon turret facing up/lt    |                                |           |
| E04F    | draw item frame 0                    |                                |           |
| E067    | draw item frame 0                    |                                |           |
| E29D    | clear charge beam counter            |                                |           |
| E63B    | set FX Y velocity to -31             |                                |           |

Code Analysis
=============

Main game loop
--------------

The top-level loop game loop is at $82:893D.  Each pass through the loop
it:
* Pre-game-state initialization
* Looks up game state ($7E:0998) in the game state function table
    ($82:8981) to get the game state function
* Calls the game state function
* Post-game-state processing
* Wait for NMI

Some states may run their own loops; others return the to the main loop
each iteration.

Each iteration through the loop is approximately one frame, though an
iteration may take more than one frame.

Loading the game
----------------

Subroutine $82:8000 is used to initialize gameplay in these states:
* 06h - load game data
* 1Fh - ???
* 28h - load demo

There are two main initialization paths: $82:800B is used for the title
screen demo reel, and $82:801D is used for normal gameplay.  For normal
gameplay, the following paths are taken depending on the value of
$7E:D914:
* 05h - starting on Ceres station $(82:8041)
* 1Fh - landing on Zebes ($82:8032)
* 22h - already on Zebes ($82:805F)

All of these branches converge at $805F, where common-path
initialization happens.

After common-path initialization, there are a few main branches:
* $82:8146 for the demo ($7E:0998 == 22h)
* $82:80BC for landing on zebes animation ($7E:D914 == 22h)
* $82:80F3 for normal gameplay

All three branches follow this pattern:
* Queue music (if landing on zebes)
* Transfer enemy tiles to VRAM and initialize enemies
* Initialize the demo (if game state 6)
* Increment game state
* Copy target palette ($7E:C200) to actual palette ($7E:C000)
* Set up Samus for Ceres ($90:F1E9) if starting at Ceres ($7E:D914 == 1Fh)
* Set up Samus for Zebes ($90:F23C) if starting on Zebes

After returning to the main game state loop, the next state function to
be invoked will be one of the following:
* $82:8B20 - start zebes gameplay (game state 07h)
* $82:8367 - start ceres gameplay (game state 20h)
* $82:852D - start demo (game state 29h)

Starting gameplay
-----------------

The start Ceres gameplay function ($82:8367):
* Draws the escape timer (if the destruct sequence has been activated)
* Runs the main gameplay function ($82:8B44)
* If Samus has reached the the elevator increments game state to start
    the fadeout sequence (game state 21h, game function $82:8388)

The start Zebes gameplay function ($82:8B20) runs the main gameplay function
($82:8B44) while the screen is fading in, thein increments the game
state.

The start demo function ($82:852D) sets max brightness (no fadein), then
increments the game state.

After these functions have run, the next state will be:
* $82:8B20 - main gameplay (game state 08h)
* $82:8388 - ceres cutscene (game state 21h)
* $82:8548 - run demo (game state 2Ah)

Main gameplay
-------------

The main gameplay subroutine at $82:8B44.  It is invoked by the main
loop for each frame during the main gameplay state; it is also invoked
by other game state functions.

Overview:
* $80:8EB6 - Determine which enemies to process
* $B4:9809 - Invoke debug handler ($B4:9809)
* $82:8B54 - Processing (see below; can be disabled by debug)
* $80:9B44 - Handle HUD tilemap
* $80:A3AB - Calculate layer 2 position and BG scrolls; update BG
    graphics when scrolling
* $8F:E8BD - Invoke room function (stored at $7E:07DF)
* $82:DB69 - Handle Samus low health and increment game time
* $A0:8687 - Handle room shaking
* $A0:9169 - Decrement Samus hurt timers, clear active enemy indices

Processing subroutines:
* $8D:C527 - Invoke palette FX object handler
* $90:E692 - Physics processing function (stored at $7E:0A42)
* $A0:9785 - Samus/projectile interaction (*)
* $A0:8FD4 - Main enemy routine
* $90:E722 - Samus movement function (stored at $7E:A044)
* $86:8104 - Enemy projectile handler
* $84:85B4 - PLM handler
* $87:8065 - Animated tiles object handler
* $A0:9895 - Samus/projectile collision detection (*)
* $A0:996C - Enemy/projectile collision detection
* $A0:A306 - Enemy power bomb interaction
* $90:94EC - Main scrolling routine
* $80:A9AC - Debug scrolling (*)
* $A0:884D - Draw Samus, projectiles, enemies, and enemy projectiles
* $A0:9726 - Queue enemy BG2 tilemap VRAM transfer

Subroutines marked with (*) can be enabled or disabled by debug.

The main gameplay state can be exited by:
* Transition block (game state 09h)
* Pausing (game state 0Dh)
* Dying (game state 13h)
* Reserve tanks (game state 1Bh)
* Escape timer up (game state 23h)

Drawing
-------

Drawing is handled by the NMI interrupt handler at $80:9583.

Overview:
* $80:933A - update OAM and CGRAM
* $80:9376 - transfer Samus tiles to VRAM
* $80:9416 - animated tile object VRAM transfers
* $80:91EE - update IO registers
* $80:95AA - handle HDMA queue
* $80:8BBA - handle mode 7 transfers
* $80:8C83 - handle VRAM write table and scrolling DMAs (calls $8CD8 and $8DAC)
* $80:8EA2 - handle VRAM read table
* $80:95D8 - enable HDMA
* $80:9459 - read controller input
* $80:95E2 - reset NMI flag and lag counter
* $80:95ED - increment counters

The following DMA write are performed:

| Sub   | Ch | Source                  | Size       | Register      | Offset     | Description       |
| ----- | -- | ----------------------- | ---------- | ------------- | ---------- | ----------------- |
| $933A | 0  | $7E:0370                | 544        | $2104 (OAM)   |            |                   |
| $933A | 1  | $7E:C000                | 544        | $2104 (CGRAM) |            |                   |
| $9376 | 1  | ($0721):($071F)         | ($0722)    | $2118 (VRAM)  | $6000      | Samus top         |
| $9376 | 1  | ($0721):($071F)+($0722) | ($0724)    | $2118 (VRAM)  | $6100      | Samus top         |
| $9376 | 1  | ($0721):($071F)         | ($0722)    | $2118 (VRAM)  | $6080      | Samus bottom      |
| $9376 | 1  | ($0721):($071F)+($0722) | ($0724)    | $2118 (VRAM)  | $6180      | Samus bottom      |
| $9416 | 0  | 87:($1F25+2n)           | ($1F31+2n) | $2118 (VRAM)  | ($1F47+2n) | animated tile     |
| $8C83 | 1  | ($00D4):($00D2+7n)      | ($00D0+7n) | $2118 (VRAM)  | ($00D5+7n) | room tiles?       |
| $8CD8 | 1  | 7E:C8C8                 | ($0956)    | $2118 (VRAM)  | ?          | BG1 hscroll tiles |
| $8CD8 | 1  | 7E:C908                 | ($0956)    | $2118 (VRAM)  | ?          | BG1 hscroll tiles |
| $8CD8 | 1  | 7E:$(095E)              | ($0958)    | $2118 (VRAM)  | ?          | BG1 hscroll tiles |
| $8CD8 | 1  | 7E:$(0960)              | ($0958)    | $2118 (VRAM)  | ?          | BG1 hscroll tiles |
| $8CD8 | 1  | 7E:C9D0                 | ($0972)    | $2118 (VRAM)  | ?          | BG2 hscroll tiles |
| $8CD8 | 1  | 7E:CA10                 | ($0972)    | $2118 (VRAM)  | ?          | BG2 hscroll tiles |
| $8CD8 | 1  | 7E:$(097A)              | ($0974)    | $2118 (VRAM)  | ?          | BG2 hscroll tiles |
| $8CD8 | 1  | 7E:$(097C)              | ($0974)    | $2118 (VRAM)  | ?          | BG2 hscroll tiles |
| $8C83 | 1  | 7E:C948                 | ($0964)    | $2118 (VRAM)  | ?          | BG1 vscroll tiles |
| $8C83 | 1  | 7E:C98C                 | ($0964)    | $2118 (VRAM)  | ?          | BG1 vscroll tiles |
| $8C83 | 1  | 7E:$(096C)              | ($0966)    | $2118 (VRAM)  | ?          | BG1 vscroll tiles |
| $8C83 | 1  | 7E:$(096E)              | ($0966)    | $2118 (VRAM)  | ?          | BG1 vscroll tiles |
| $8C83 | 1  | 7E:CA50                 | ($0980)    | $2118 (VRAM)  | ?          | BG2 vscroll tiles |
| $8C83 | 1  | 7E:CA94                 | ($0980)    | $2118 (VRAM)  | ?          | BG2 vscroll tiles |
| $8C83 | 1  | 7E:$(0988)              | ($0982)    | $2118 (VRAM)  | ?          | BG2 vscroll tiles |
| $8C83 | 1  | 7E:$(098A)              | ($0982)    | $2118 (VRAM)  | ?          | BG2 vscroll tiles |

The following registers are set by $80:91EE:

| Register(s)  | Value            | Description                                 |
| ------------ | ---------------- | ------------------------------------------- |
| $4200        | ($7E:0084)       | Interrupt and auto-joypad enable            |
| $2100        | ($7E:0051)       | Forced blank and brightness                 |
| $2101        | ($7E:0052)       | Sprite size and tiles base address          |
| $2105        | ($7E:0055)       | Mode and BG tile size                       |
| $2106        | ($7E:0057)       | Mosaic size and enable                      |
| $2107..$210A | ($7E:0058..005C) | BG1..BG4 tilemap base address and size      |
| $210B..$210C | ($7E:005D..005E) | BG tiles base address                       |
| $211A        | ($7E:005F)       | Mode 7 settings                             |
| $2123..$2124 | ($7E:0060..0061) | Window BG1..BG4 mask settings               |
| $2125        | ($7E:0062)       | Window sprites/math mask settings           |
| $2126..$2129 | ($7E:0063..0066) | Window 1/2 left/right positions             |
| $212B        | ($7E:0068)       | Window 1/2 sprites/color math mask logic    |
| $212C        | ($7E:0069)       | Main screen layers                          |
| $212D        | ($7E:006A)       | Subscreen layers (LSB copied from $69)      |
| $212E        | ($7E:006C)       | Window area main screen disable             |
| $212F        | ($7E:006D)       | Window area subscreen disable               |
| $2130..$2131 | ($7E:006F..0072) | Color math control registers A/B            |
| $2132        | ($7E:0074..0076) | Color math subscreen backdrop color         |
| $2133        | ($7E:0077)       | Display resolution                          |
| $210D..$2114 | ($7E:00B1..00BF) | BG1..BG4 X/Y scroll                         |
| $07EC        | ($7E:0056)       | Fake mode and BG tile size                  |
| $211B..$211F | ($7E:0078..007F) | Mode 7 transformation matrix parameter A..D |
| $211F..$2120 | ($7E:007F..0082) | Mode 7 transformation matrix coordinate X/Y |

Music
-----

Room music is controlled by bytes 4 and 5 of the room state header.

$82:DEF2 loads the state header; it is called indirectly by the game
state function for game states 6/1F/28h ($82:8000) and Bh ($82:E288).
It copies the following from the room state header:
* byte 4 (room music data index) -> $7E:07CB
* byte 5 (room music track index) -> $7E:07C9

The primary path for loading room music after a door transition is
through $82:E07A.  It loads the music/data track index from $07CB/9 and
calls $80:8FC1 to queue the track.

There are a few different paths to queue the music:
* $82:E071 is used to load room music after a door transition.  It loads
  the music data/track index from $07CB/9 and calls $80:8FC1 to queue
  the track.
* $82:E0D5 is used to load room music after a door block is hit.  It
  loads the music data/track index from $07CB/9 and calls $80:8FF7 to
  queue the track.
* $82:E118 is used by item fanfare to queue room music after some number
  of frames (usually 360); it uses $80:8FC1 to queue the track.

There are also other subroutines that queue music; they all call either
$80:8FC1 or $80:8FF7 to queue the track.  Many boss functions call
$80:8FC1 to queue elevator music when the boss fight has ended.

At some point later after the track has been queued, $80:8F0C is called
to upload music from the queue to the APU.  It splits the music entry in
$7E:07F6 into music track index and music data index.  The music track
index is used as an offste into the music pointer table at $8F:E7E1.

The music pointer table only has enough space for 24 tracks.  Any of
those tracks can be played upon entering a room by setting byte 4 of the
room state header to the desired index.

PLMs
----

Bank $94 contains block PLM subroutines:

| Subroutine | Description                                                 |
| ---------- | ----------------------------------------------------------- |
| $94:906F   | Samus block collision reaction - horizontal - special air   |
| $94:909D   | Samus block collision reaction - vertical - special air     |
| $94:90CB   | Samus block collision reaction - horizontal - special block |
| $94:9102   | Samus block collision reaction - vertical - special block   |

These routines are listed in the collision reaction tables:

| Address  | Description                                          |
| -------- | ---------------------------------------------------- |
| $94:94D5 | Samus block collision reaction pointers - horizontal |
| $94:94F5 | Samus block collision reaction pointers - vertical   |

Subroutines $94:9515 and $94:952C find the 4-bit block type in the
reaction table; for special air (block type 0h) and special blocks
(block type Bh) the PLM subroutine is invoked.

The collision reaction functions are invoked in the following
conditions:

| Subroutine | Direction  | Condition               |
| ---------- | ---------- | ----------------------- |
| $94:96E3   | vertical   | Change of pose          |
| $94:9763   | vertical   | Move samus vertically   |
| $94:967F   | horizontal | Wall jump pose          |
| $94:971E   | horizontal | Move samus horizontally |

Vertical block collision has an oscillator; on even frames it invokes
$94:959E, and on odd frames it invokes $94:95F5.  Horizontal block
collision does not have an oscillator.

Subroutine $84:84E7 spawns PLMs.  The address of the PLM is passed in
register A.  First, it finds an empty PLM slot and assigns its index to
register X.  It then stores the following into memory:

| Address    | Description                   |
| ---------- | ----------------------------- |
| $7E:1C27+x | 0                             |
| $7E:1C37+x | PLM ID                        |
| $7E:1C87+x | PLM block index (n*2)         |
| $7E:1CD7+x | PLM pre-instruction           |
| $7E:1D27+x | PLM instruction list pointer  |
| $7E:1D77+x | 0                             |
| $7E:DE1C+x | PLM instruction timer = 1     |
| $7E:DE6C+x | PLM instruction timer = $8DA0 |
| $7E:DF0C+x | 0                             |

At the end of the function it executes the first instruction in the PLM,
which is always a pointer to a subroutine, usually to play a sound.

The PLM itself is processed by $84:85DA (TODO: I don't know what
conditions this routine is called under).  The PLM processor is similar
to the enemy instruction processor.  If the high bit is set, it assumes
it is a pointer to a subroutine, and it jumps to that subroutine, with
Y pointing to the subroutine's argument, which follows the pointer in
the PLM's instruction list.

Each PLM draw instruction consists of a 2-byte timer and a 2-byte draw
instruction list pointer.  The draw list instruction is handled by
$84:861E.

Each draw list instruction is either a column instruction (high bit is
set) or a row instruction (high bit is not set).  The LSB is the number
of tiles to change.  The draw instruction is followed by the new level
data values.

TODO: Some draw instructions (e.g. A219) have "FF 00" and "FF 01"
following an nistruction; I don't yet know what this means.

The draw instruction list is always terminated by $0000.

Room PLMs
---------

Room PLMs are spawned by $84:846A.  It is called when the room is
loaded, before the room setup routine is called (see $82:E7D3).

Important memory locations
--------------------------

83:88FE - Door headers
83:A18A - Door headers
85:869B - message definitions
93:83C1 - projectile data pointers
93:8431 - projectile data table
A0:CEBF - enemy headers
A1:8000 - enemy population for each room
B4:8000 - enemy sets and set names
B4:B00E - enemy names
B4:DD89 - enemy names
B4:EC1C - enemy vulnerabilities
B4:F1F4 - enemy drop chances
8F:91F8 - room headers, scroll data, and doorout data
8F:C125 - PLM populations for each room
8F:C98E - room headers, scroll data, and door lists

Interesting memory locations
----------------------------

80:C4B5 - load stations
80:CD35 - elevator bits for each area
80:FFC0 - game header
81:812B - SRAM offsets for each save slot
81:8131 - SRAM map data
81:D2D6 - pointer to each area's map rooms
81:A40E - area select map foreground palettes
81:AA1C - area select map label positions
81:AA34 - room select map expanding square velocities
81:AA94 - room select map expanding square timers
81:AAA0 - file select map area index table
81:AF32 - map scroll arrow data
81:FF00 - special thanks
82:9717 - map data
82:D521 - Samus wireframe tilemaps
83:8000 - FX (?)
83:9AC2 - FX (?)
83:ABF0 - FX type tilemap pointers
83:AC18 - FX type function pointers
84:B62F - PLM entries
85:877F - message tilemaps
89:8000 - item PLM graphics
90:8E26 - liquid physics types for each area
90:9E8B - Samus physics constants
90:9F55 - Samus X speed table (normal)
90:A08D - Samus X speed table (in water)
90:A1DD - Samus X speed table (in lava/acid)
94:892B - slope definitions
A0:8187 - common enemy speeds (linearly increasing)
A0:838F - common enemy speeds (quadratically increasing)
A0:872D - BG shake displacements
B4:E2F6 - debug enemy population data
B5:8000 - map tilemaps

Interesting subroutines
-----------------------
80:8111 - RNG
80:8146 - update held input
80:81A6 - set boss (defeated) bits in current area
80:81C0 - clear boss bits in current area
80:81DC - check boss bits
80:81FA - mark event
80:8212 - unmark event
80:8233 - check event
80:8338 - wait for NMI
80:841C - boot
80:A07B - start gameplay
80:A149 - resume gameplay
80:A9DE - update level/background data column (documents visually how
level data looks in RAM)
80:AD1D - door fix
80:B0FF - decompression
80:C437 - load from save station
80:CD07 - set elevator as used

81:8000 - save to SRAM
81:8085 - load from SRAM
81:82E4 - load map
81:B2CB - new save file

82:8000 - load game data (game state 6)
82:8B44 - Game state 8 (main gameplay)

84:85B4 - PLM handler
84:8DAA - draw PLM
84:86B4 - lots of instruction lists and PLM entries

85:8080 - message box

86:8000 - enable enemy projectiles
86:800B - disable enemy projectiles
86:8016 - clear enemy projectiles
86:8027 - spawn enemy projectile using enemy graphics
86:8097 - spawn enemy projectiles using room graphics
86:8104 - enemy projectile handler
86:8125 - process enemy projectile

88:8000 - layer blending

91:FDAE - collision due to change of pose
91:FE9C - solid enemy collision due to pose change (collision from
sides)
91:FE9E - solid enemy collision due to pose change (collision from
above)
91:FEDF - solid enemy collision due to pose change (collision from
below)

93:8000 - initialize projectile

A0:8000..8686 - routines common to all memory banks
A0:8A1E - load enemies
A0:8FD4 - main enemy routine
A0:920E - spawn enemy drops
A0:922B - delete enemy (and any connected enemies)
A0:9275 - spawn enemy
A0:9758 - enemy collision handler
          A0:9B7F - enemy / projectile collision handler (extended spritemap)
          A0:9D23 - enemy / bomb collision handler (extended spritemap)
          A0:9A5A - enemy / Samus collision handler (extended spritemap)
          A0:A143 - enemy / projectile collision handler
          A0:A236 - enemy / bomb collision handler
          A0:A07A - enemy / Samus collision handler
A0:9894 - enemy projectile / Samus collision detection
A0:996C - enemy projectile / projectile collision detection
A0:A306 - power bomb interaction
A0:A477 - normal enemy touch AI (plus death animation)
A0:A497 - normal enemy touch AI (no death animation)
A0:A4A1 - normal enemy touch AI subroutine
A0:A597 - normal enemy power bomb AI
A0:A6A7 - normal enemy shot AI
A0:A6DE - handles beam damage, freezing, and sound
A0:A8F0 - samus/solid enemy collision detection
A0:AE29 - determine direction of Samus from enemy

Enemy projectiles
-----------------

86:90C1 - Crocomire spike wall pieces
86:9E90 - walking lava seahorse fireball
86:A3B2 - pre-Phantoon room
86:B1C0 - Golden Torizo egg
86:B31A - Golden Torizo super missile
86:B428 - Golden Torizo eye beam
86:B4B1 - old Tourian escape shaft fake wall explosion
86:B5CB - lava seahorse fireball
86:BBC7 - nuclear waffle body
86:BD5A - Norfair lavaquake rocks
86:D02E - kago's bugs
86:DAFE - spike shooting plant spikes
86:E0E0 - lava thrown by lavaman
86:E6D2 - save station electricity
86:EBA0 - Botwoon's body
86:EC48 - Botwoon's spit
86:EC95 - yapping maw's body
86:F498 - sparks
8D:B743 - eye door projectile
8D:8BC2/$8BD0/$8BDE/$8BEC - skree particle
8D:8F8F - Crocomire's projectile
8D:9634/$9642 - Ridley's fireball
8D:9650/$965E/$966C/$967A/$9688/$9696 - Ridley's fireball / Mother Brain's bomb explosion
8D:8F9D - Crocomire bridge crumbling
8D:90C1 - Crocomire spike wall pieces
8D:9C29 - Phantoon destroyable fireballs) / enemy projectile $9C37 (Phantoon starting fireballs
8D:9C37 - Phantoon starting fireballs
8D:9C45/$9C53/$9C61/$D02E - Kraid rocks / Kago's bugs
8D:9C6F - rocks when Kraid rises - right
8D:CB4B - Mother Brain's blue ring lasers
8D:CB59 - Mother Brain's bomb
8D:CB67/$CB75 - Mother Brain's death beam
8D:CC5B - Mother Brain's top-right tube falling
8D:CC69 - Mother Brain's top-left tube falling
8D:CC77 - Mother Brain's top-middle-left tube falling
8D:CC85 - Mother Brain's top-middle-right tube falling
8D:9E90 - walking lava seahorse fireball
8D:9DB0 - mini Kraid spit
8D:9DBE - mini Kraid spikes - left
8D:9DCC - mini Kraid spikes - right
8D:8BFA/$8C08/$8C16/$8C24 - metal skree particle
8D:D02E - Kago's bugs
8D:A395 - Ceres elevator platform
8D:A379
8D:8E6C
8D:8E50 - Draygon's gunk
8D:8E5E/$8E6C - Draygon's wall turret projectiles / ???
8D:8E50 - Draygon's gunk
8D:8E5E/$8E6C - Draygon's wall turret projectiles / ???
8D:9734 - Ceres falling debris - light coloured
8D:9742 - Ceres falling debris - dark coloured
8D:A189 - pirate claw
8D:A17B - pirate / Mother Brain laser
8D:AB07
8D:A95B/$A969 - Bomb Torizo low-health drool / enemy projectile $A977
8D:AD5E/$AD6C/$AD7A - torizo chozo orbs
8D:AD5E/$AD6C/$AD7A - torizo chozo orbs) / enemy projectile $B428 (Golden Torizo eye beam
8D:AEA8/$AEB6 - torizo sonic boom
8D:8F8F - Crocomire's projectile
8D:9C45 - rocks Kraid spits at you
8D:A9A1 - Bomb Torizo low-health explosion
8D:A985 - Bomb Torizo explosive swipe
8D:B1C0 - Golden Torizo egg
8D:AD5E/$AD6C/$AD7A - torizo chozo orbs
8D:B428 - Golden Torizo eye beam
8D:D02E - Kago's bugs
8D:A993 - Bomb Torizo statue breaking
8D:B31A - Golden Torizo super missile
8D:AFE5 - Torizo landing dust cloud - right foot
8D:AFF3 - Torizo landing dust cloud - left foot
8D:B1C0 - Golden Torizo egg
8D:B5CB - lava seahorse fireball
8D:B743 - eye door projectile
8D:B751 - eye door sweat
8D:BA5C - Tourian statue unlocking particle water splash
8D:BA86 - Tourian statue unlocking particle tail
8D:BA6A - Tourian statue eye glow
8D:BA78 - Tourian statue unlocking particle
8D:BA94 - Tourian statue's soul
8D:BABE - Tourian statue - base decoration
8D:BAA2 - Tourian statue - Ridley
8D:BAB0 - Tourian statue - Phantoon
8D:BBC7 - Nuclear waffle body
8D:BD5A - Norfair lavaquake rocks
8D:BE25/BE33/BE41
8D:BE25/BE33
8D:BE25
8D:C17E - Mother Brain's room turrets
8D:C18C - Mother Brain's room turret bullets
8D:CB83 - Mother Brain's rainbow beam charging
8D:CB91/CB9F - Mother Brain's drool
8D:CB2F - Mother Brain's purple breath - big
8D:CB3D - Mother Brain's purple breath - small
8D:CB21 - Mother Brain's exploded escape door particles
8D:CBBB
8D:CEFC - Mother Brain's glass shattering - shard
8D:CF0A - Mother Brain's glass shattering - sparkle
8D:CF18 - ki hunter acid spit - left
8D:CF18/CF26 - ki hunter acid spit
8D:CF26 - ki hunter acid spit - right
8D:D298 - Maridia floater's spikes
8D:D2A6/D2B4/D2C2/D2D0/D2DE - Wrecked Ship robot laser
8D:D904 - n00b tube crack
8D:D904 - n00b tube crack
8D:D912 - n00b tube shards
8D:D920 - n00b tube released air bubbles
8D:D920 - n00b tube released air bubbles
8D:DAFE - spike shooting plant spikes
8D:DBF2
8D:DE6C - Spore Spawn's stalk
8D:DE88 - spore spawners
8D:DE7A - spores
8D:DFBC/DFCA - nami/fune fireball
8D:E0E0 - lava thrown by lavaman
8D:AF68 - Wrecked Ship chozo spike clearing footsteps
8D:AF84 - Tourian statue dust clouds
8D:8E5E/8E6C - Draygon's wall turret projectiles / ???
8D:A9AF - Torizo death explosion
8D:B4B1 - old Tourian escape shaft fake wall explosion
8D:DE7A - spores
8D:E517/E525 - eye door smoke
8D:A387 - Ceres elevator pad
8D:A9AF - Torizo death explosion
8D:AB07 - enemy projectile
8D:C18C - Mother Brain's room turret bullets
8D:C18C - Mother Brain's room turret bullets
8D:AF76
8D:B31A - Golden Torizo super missile
8D:CB4B - Mother Brain's blue ring lasers
8D:F345 - enemy death explosion
8D:E64B/E659 - downwards shot gate
8D:E667/E675 - upwards shot gate
8D:E6D2 - save station electricity
8D:EBA0 - Botwoon's body
8D:EBA0 - Botwoon's body
8D:EBA0 - Botwoon's body
8D:EC48 - Botwoon's spit
8D:EC95 - yapping maw's body
8D:F345 - enemy death explosion
8D:F337/F345 - pickup / enemy death explosion
8D:F337/F345 - pickup / enemy death explosion
8D:F337/F345 - pickup / enemy death explosion
8D:F337/F345 - pickup / enemy death explosion
8D:F337/F345 - pickup / enemy death explosion
8D:F345 - enemy death explosion
8D:F498 - sparks

