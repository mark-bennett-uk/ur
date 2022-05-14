  10 REM *********************************
  11 REM *     The Royal Game of UR      *
  12 REM *             V1.1              *
  13 REM *       ZX Spectrum 48k         *
  14 REM *     by Mark Bennett 2022      *
  15 REM * github.com/mark-bennett-uk/ur *
  16 REM *********************************
  40 REM ***** set up character space *****
  41 REM **********************************
  50 LET ramtop = PEEK 23730 + 256 * PEEK 23731
  60 LET chars = ramtop + 1 - 256
  70 POKE 23606, chars-256 * INT (chars / 256)
  80 POKE 23607, INT (chars / 256)
 100 REM ***** variables *****
 101 REM *********************
 102 DIM b(16)
 103 DIM c(16)
 104 DIM p(7)
 105 DIM q(7)
 106 DIM t(14)
 107 DIM f(2)
 108 DIM w(7)
 120 LET s$ = ""
 121 LET l$ = ""
 200 REM ***** initialise *****
 201 REM **********************
 210 RANDOMIZE
 270 LET e = 1
 280 LET a = 1 : GOSUB 2000 : REM board - initialise
 282 LET a = 2 : GOSUB 2000 : REM board - draw border
 284 LET a = 4 : GOSUB 2000 : REM board - draw all squares
 285 LET a = 1 : GOSUB 5000 : REM engine - initialise
 286 LET a = 6 : GOSUB 2000 : REM board - draw start counters p1
 287 LET a = 7 : GOSUB 2000 : REM board - draw start counters p2
 400 REM ***** player selection *****
 401 REM ****************************
 410 INPUT "PLAYER 1 ";INVERSE 1;"H";INVERSE 0;"UMAN OR ";INVERSE 1;"C";INVERSE 0;"OMPUTER? "; l$
 420 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 410
 430 LET f(1) = 1
 440 IF l$ = "C" OR l$ = "c" THEN LET f(1) = 2
 450 INPUT "PLAYER 2 ";INVERSE 1;"H";INVERSE 0;"UMAN OR ";INVERSE 1;"C";INVERSE 0;"OMPUTER? "; l$
 460 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 450
 470 LET f(2) = 1
 480 IF l$ = "C" OR l$ = "c" THEN LET f(2) = 2
1000 REM ***** main loop *****
1001 REM *********************

1010 REM ***** player 1 *****
1011 REM ********************
1020 LET a = 2 : GOSUB 5000 : REM engine - roll dice
1030 GOSUB 1900
1040 PRINT AT 19,0; "PLAYER 1 ROLLS "; STR$ d
1050 LET a = 3 : GOSUB 5000 : REM engine - get possible moves
1060 IF d = 0 OR u = 0 THEN PRINT AT 20,0; "NO VALID MOVES" : PAUSE 100 : GOTO 1180
1070 IF f(1) = 2 THEN GOTO 1110 : REM computer player
1080 LET m = 0
1090 INPUT "PLAYER 1 COUNTER TO MOVE "; m
1092 IF m < 1 OR m > 7 THEN GOTO 1090
1094 IF t((m * 2) - 1) = -1 THEN GOTO 1090
1100 GOTO 1130
1110 GOSUB 3000 : REM computer move selection
1120 PRINT AT 20,0; "PLAYER 1 MOVES COUNTER "; STR$ m
1130 LET a = 4 : GOSUB 5000 : REM engine - make move
1135 LET n = r
1140 LET a = 5 : GOSUB 2000 : REM board - make move
1150 LET a = 5 : GOSUB 5000 : REM engine - detect win
1160 IF r = 1 THEN PRINT AT 21,0; "PLAYER 1 WINS" : INPUT "PRESS ENTER TO PLAY AGAIN"; l$ : GOTO 200
1170 IF u > 0 AND n = 1 THEN GOTO 1010 : REM rosette rethrow
1180 LET e = 2

1210 REM ***** player 2 *****
1211 REM ********************
1220 LET a = 2 : GOSUB 5000 : REM engine - roll dice
1230 GOSUB 1900
1240 PRINT AT 19,0; "PLAYER 2 ROLLS "; STR$ d
1250 LET a = 3 : GOSUB 5000 : REM engine - get possible moves
1260 IF d = 0 OR u = 0 THEN PRINT AT 20,0; "NO VALID MOVES" : PAUSE 100 : GOTO 1380
1270 IF f(2) = 2 THEN GOTO 1310 : REM computer player
1280 LET m = 0
1290 INPUT "PLAYER 2 COUNTER TO MOVE "; m
1292 IF m < 1 OR m > 7 THEN GOTO 1290
1294 IF t((m * 2) - 1) = -1 THEN GOTO 1290
1300 GOTO 1330
1310 GOSUB 3000 : REM computer move selection
1320 PRINT AT 20,0; "PLAYER 2 MOVES COUNTER "; STR$ m
1330 LET a = 4 : GOSUB 5000 : REM engine - make move
1335 LET n = r
1340 LET a = 5 : GOSUB 2000 : REM board - make move
1350 LET a = 5 : GOSUB 5000 : REM engine - detect win
1360 IF r = 2 THEN PRINT AT 21,0; "PLAYER 2 WINS" : INPUT "PRESS ENTER TO PLAY AGAIN"; l$ : GOTO 200
1370 IF u > 0 AND n = 1 THEN GOTO 1210 : REM rosette rethrow
1380 LET e = 1

1390 GOTO 1010

1900 REM ***** clear text display *****
1901 REM ******************************
1910 PRINT AT 19,0; "                        "
1911 PRINT AT 20,0; "                        "
1912 PRINT AT 21,0; "                        "
1915 RETURN

2000 REM ***** draw board *****
2001 REM **********************
2002 REM a = action
2003 LET r = 0
2010 IF a = 1 THEN GOTO 2100 : REM initialise
2011 IF a = 2 THEN GOTO 2200 : REM draw border
2012 IF a = 3 THEN GOTO 2300 : REM draw square
2013 IF a = 4 THEN GOTO 2500 : REM draw all squares
2014 IF a = 5 THEN GOTO 2600 : REM make move
2015 IF a = 6 THEN GOTO 2800 : REM draw start counters p1
2016 IF a = 7 THEN GOTO 2850 : REM draw start counters p2
2017 IF a = 8 THEN GOTO 2900 : REM draw end counters p1
2018 IF a = 9 THEN GOTO 2950 : REM draw end counters p2
2100 REM ***** initialise *****
2101 REM **********************
2102 BORDER 1
2103 PAPER 1:INK 6:BRIGHT 0:CLS
2104 PRINT AT 0,2; "THE ROYAL GAME OF UR"
2110 PRINT AT 2,0; "P1"
2120 PRINT AT 16,0; "P2"
2130 RETURN

2200 REM ***** draw border *****
2201 REM ***********************
2202 REM no parameters
2203 REM no return values
2210 PRINT AT 5,2; CHR$ 150; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 149
2211 PRINT AT 5,20; CHR$ 150; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 149
2212 PRINT AT 6,2; CHR$ 146
2213 PRINT AT 6,14; CHR$ 144
2214 PRINT AT 6,20; CHR$ 146
2215 PRINT AT 6,26; CHR$ 144
2216 PRINT AT 7,2; CHR$ 146
2218 PRINT AT 7,14; CHR$ 155; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 145; CHR$ 152
2219 PRINT AT 7,26; CHR$ 144
2220 PRINT AT 8,2; CHR$ 146
2221 PRINT AT 8,26; CHR$ 144
2222 PRINT AT 9,2; CHR$ 146
2223 PRINT AT 9,26; CHR$ 144
2224 PRINT AT 10,2; CHR$ 146
2225 PRINT AT 10,26; CHR$ 144
2226 PRINT AT 11,2; CHR$ 146
2227 PRINT AT 11,26; CHR$ 144
2228 PRINT AT 12,2; CHR$ 146
2229 PRINT AT 12,14; CHR$ 154; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 153
2230 PRINT AT 12,26; CHR$ 144
2231 PRINT AT 13,2; CHR$ 146
2232 PRINT AT 13,14; CHR$ 144
2233 PRINT AT 13,20; CHR$ 146
2234 PRINT AT 13,26; CHR$ 144
2235 PRINT AT 14,2; CHR$ 151; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 148
2236 PRINT AT 14,20; CHR$ 151; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 147; CHR$ 148
2240 RETURN

2300 REM ***** draw board square *****
2301 REM *****************************
2302 REM v = 2 to 15 space to draw
2303 REM j = 1 or 2 player to draw
2310 LET k = ((v - 2)* 4) + ((j - 1) * 56) + 2320
2315 GOTO k
2320 PRINT AT 6,12; INK 4; CHR$ 97; CHR$ 98: REM P1 pos 2
2321 PRINT AT 7,12; INK 4; CHR$ 97; CHR$ 98
2322 RETURN
2324 PRINT AT 6,9; INK 5; CHR$ 157; CHR$ 160: REM P1 pos 3
2325 PRINT AT 7,9; INK 5; CHR$ 158; CHR$ 159
2326 RETURN
2328 PRINT AT 6,6; INK 4; CHR$ 97; CHR$ 98: REM P1 pos 4
2329 PRINT AT 7,6; INK 4; CHR$ 97; CHR$ 98
2330 RETURN
2332 PRINT AT 6,3; INK 3; CHR$ 106; CHR$ 105: REM P1 pos 5
2333 PRINT AT 7,3; INK 3; CHR$ 107; CHR$ 108
2334 RETURN
2336 PRINT AT 9,3; INK 7; CHR$ 100; CHR$ 103: REM pos 6
2337 PRINT AT 10,3; INK 7; CHR$ 101; CHR$ 102
2338 RETURN
2340 PRINT AT 9,6; INK 5; CHR$ 157; CHR$ 160: REM pos 7
2341 PRINT AT 10,6; INK 5; CHR$ 158; CHR$ 159
2342 RETURN
2344 PRINT AT 9,9; INK 7; CHR$ 156; CHR$ 156: REM pos 8
2345 PRINT AT 10,9; INK 7; CHR$ 156; CHR$ 156
2346 RETURN
2348 PRINT AT 9,12; INK 3; CHR$ 106; CHR$ 105: REM pos 9
2349 PRINT AT 10,12; INK 3; CHR$ 107; CHR$ 108
2350 RETURN
2352 PRINT AT 9,15; INK 5; CHR$ 157; CHR$ 160: REM pos 10
2353 PRINT AT 10,15; INK 5; CHR$ 158; CHR$ 159
2354 RETURN
2356 PRINT AT 9,18; INK 7; CHR$ 156; CHR$ 156: REM pos 11
2357 PRINT AT 10,18; INK 7; CHR$ 156; CHR$ 156
2358 RETURN
2360 PRINT AT 9,21; INK 4; CHR$ 97; CHR$ 98: REM pos 12
2361 PRINT AT 10,21; INK 4; CHR$ 97; CHR$ 98
2362 RETURN
2364 PRINT AT 9,24; INK 5; CHR$ 157; CHR$ 160: REM pos 13
2365 PRINT AT 10,24; INK 5; CHR$ 158; CHR$ 159
2366 RETURN
2368 PRINT AT 6,24; INK 4; CHR$ 161; CHR$ 162: REM P1 pos 14
2369 PRINT AT 7,24; INK 4; CHR$ 164; CHR$ 163
2370 RETURN
2372 PRINT AT 6,21; INK 3; CHR$ 106; CHR$ 105: REM P1 pos 15
2373 PRINT AT 7,21; INK 3; CHR$ 107; CHR$ 108
2374 RETURN
2376 PRINT AT 12,12; INK 4; CHR$ 97; CHR$ 98: REM P2 pos 2
2377 PRINT AT 13,12; INK 4; CHR$ 97; CHR$ 98
2378 RETURN
2380 PRINT AT 12,9; INK 5; CHR$ 157; CHR$ 160: REM P2 pos 3
2381 PRINT AT 13,9; INK 5; CHR$ 158; CHR$ 159
2382 RETURN
2384 PRINT AT 12,6; INK 4; CHR$ 97; CHR$ 98: REM P2 pos 4
2385 PRINT AT 13,6; INK 4; CHR$ 97; CHR$ 98
2386 RETURN
2388 PRINT AT 12,3; INK 3; CHR$ 106; CHR$ 105: REM P2 pos 5
2389 PRINT AT 13,3; INK 3; CHR$ 107; CHR$ 108
2390 RETURN
2392 PRINT AT 9,3; INK 7; CHR$ 100; CHR$ 103: REM pos 6
2393 PRINT AT 10,3; INK 7; CHR$ 101; CHR$ 102
2394 RETURN
2396 PRINT AT 9,6; INK 5; CHR$ 157; CHR$ 160: REM pos 7
2397 PRINT AT 10,6; INK 5; CHR$ 158; CHR$ 159
2398 RETURN
2400 PRINT AT 9,9; INK 7; CHR$ 156; CHR$ 156: REM pos 8
2401 PRINT AT 10,9; INK 7; CHR$ 156; CHR$ 156
2402 RETURN
2404 PRINT AT 9,12; INK 3; CHR$ 106; CHR$ 105: REM pos 9
2405 PRINT AT 10,12; INK 3; CHR$ 107; CHR$ 108
2406 RETURN
2408 PRINT AT 9,15; INK 5; CHR$ 157; CHR$ 160: REM pos 10
2409 PRINT AT 10,15; INK 5; CHR$ 158; CHR$ 159
2410 RETURN
2412 PRINT AT 9,18; INK 7; CHR$ 156; CHR$ 156: REM pos 11
2413 PRINT AT 10,18; INK 7; CHR$ 156; CHR$ 156
2414 RETURN
2416 PRINT AT 9,21; INK 4; CHR$ 97; CHR$ 98: REM pos 12
2417 PRINT AT 10,21; INK 4; CHR$ 97; CHR$ 98
2418 RETURN
2420 PRINT AT 9,24; INK 5; CHR$ 157; CHR$ 160: REM pos 13
2421 PRINT AT 10,24; INK 5; CHR$ 158; CHR$ 159
2422 RETURN
2424 PRINT AT 12,24; INK 4; CHR$ 161; CHR$ 162: REM P2 pos 14
2425 PRINT AT 13,24; INK 4; CHR$ 164; CHR$ 163
2426 RETURN
2428 PRINT AT 12,21; INK 3; CHR$ 106; CHR$ 105: REM P2 pos 15
2429 PRINT AT 13,21; INK 3; CHR$ 107; CHR$ 108
2430 RETURN

2500 REM ***** draw all squares *****
2501 REM ****************************
2505 LET j = 1
2510 FOR v = 2 TO 15
2520  GOSUB 2300
2530 NEXT v
2535 LET j = 2
2540 FOR v = 2 TO 5
2550  GOSUB 2300
2560 NEXT v
2570 FOR v = 14 TO 15
2580  GOSUB 2300
2590 NEXT v
2595 RETURN

2600 REM ***** move counter *****
2601 REM ************************
2610 REM remove counter
2620 LET v = t((m * 2) - 1)
2640 LET k = ((v - 2)* 4) + ((e - 1) * 56) + 2320
2642 BEEP 0.05, 12
2645 IF e = 1 AND v = 1 THEN GOSUB 2800
2646 IF e = 2 AND v = 1 THEN GOSUB 2850
2650 IF v > 1 AND v < 16 THEN GOSUB k

2700 REM draw counter
2701 LET v = t(m * 2)
2702 BEEP 0.05, 0
2703 IF e = 1 AND v = 16 THEN GOSUB 2900
2704 IF e = 2 AND v = 16 THEN GOSUB 2950
2705 IF v < 1 OR v > 15 THEN RETURN
2710 IF m = 1 THEN LET l$ = CHR$ 91
2711 IF m = 2 THEN LET l$ = CHR$ 92
2712 IF m = 3 THEN LET l$ = CHR$ 93
2713 IF m = 4 THEN LET l$ = CHR$ 94
2714 IF m = 5 THEN LET l$ = CHR$ 95
2715 IF m = 6 THEN LET l$ = CHR$ 96
2716 IF m = 7 THEN LET l$ = "x"

2750 IF v > 1 AND v <= 5 THEN LET x = 3 * (6 - v)
2752 IF v >= 6 AND v <= 13 THEN LET x = 3 * (v - 5)
2753 IF v >= 14 AND v <= 15 THEN LET x = 3 * (22 - v)

2754 LET y = 6
2760 IF v >= 6 AND v <= 13 THEN LET y = 9
2765 IF y = 6 AND e = 2 THEN LET y = 12
2770 IF e = 1 THEN LET z = 5
2775 IF e = 2 THEN LET z = 7

2780 PRINT AT y,x; INK z; "mp"
2782 PRINT AT y + 1,x; INK z; "no"
2785 PRINT AT y,x; INK z; OVER 1; l$
2790 RETURN

2800 REM ***** draw start counters *****
2801 REM *******************************
2802 REM player 1
2805 LET j = 0
2807 PRINT AT 2, 3; INK 2; "   "
2808 PRINT AT 3, 3; INK 2; "   "
2810 FOR i = 1 TO 7
2820  IF p(i) <> 1 THEN GOTO 2840
2821  IF i = 1 THEN LET l$ = CHR$ 91
2822  IF i = 2 THEN LET l$ = CHR$ 92
2823  IF i = 3 THEN LET l$ = CHR$ 93
2824  IF i = 4 THEN LET l$ = CHR$ 94
2825  IF i = 5 THEN LET l$ = CHR$ 95
2826  IF i = 6 THEN LET l$ = CHR$ 96
2827  IF i = 7 THEN LET l$ = "x"
2829  IF j = 0 THEN GOTO 2835
2830  PRINT AT 2, j + 3; INK 5; "rp "
2831  PRINT AT 3, j + 3; INK 5; "so "
2832  PRINT AT 2, j + 3; INK 5; OVER 1; l$
2834  GOTO 2839
2835  PRINT AT 2, j + 3; INK 5; "mp "
2836  PRINT AT 3, j + 3; INK 5; "no "
2837  PRINT AT 2, j + 3; INK 5; OVER 1; l$
2839  LET j = j + 1
2840 NEXT i
2845 RETURN

2850 REM player 2
2855 LET j = 0
2857 PRINT AT 16, 3; INK 7; "   "
2858 PRINT AT 17, 3; INK 7; "   "
2860 FOR i = 1 TO 7
2870  IF q(i) <> 1 THEN GOTO 2890
2871  IF i = 1 THEN LET l$ = CHR$ 91
2872  IF i = 2 THEN LET l$ = CHR$ 92
2873  IF i = 3 THEN LET l$ = CHR$ 93
2874  IF i = 4 THEN LET l$ = CHR$ 94
2875  IF i = 5 THEN LET l$ = CHR$ 95
2876  IF i = 6 THEN LET l$ = CHR$ 96
2877  IF i = 7 THEN LET l$ = "x"
2879  IF j = 0 THEN GOTO 2885
2880  PRINT AT 16, j + 3; INK 7; "rp "
2881  PRINT AT 17, j + 3; INK 7; "so "
2882  PRINT AT 16, j + 3; INK 7; OVER 1; l$
2884  GOTO 2889
2885  PRINT AT 16, j + 3; INK 7; "mp "
2886  PRINT AT 17, j + 3; INK 7; "no "
2887  PRINT AT 16, j + 3; INK 7; OVER 1; l$
2889  LET j = j + 1
2890 NEXT i
2895 RETURN

2900 REM ***** draw end counters *****
2901 REM *****************************
2902 REM player 1
2905 LET j = 0
2910 FOR i = 1 TO 7
2920  IF p(i) <> 16 THEN GOTO 2940
2921  IF i = 1 THEN LET l$ = CHR$ 91
2922  IF i = 2 THEN LET l$ = CHR$ 92
2923  IF i = 3 THEN LET l$ = CHR$ 93
2924  IF i = 4 THEN LET l$ = CHR$ 94
2925  IF i = 5 THEN LET l$ = CHR$ 95
2926  IF i = 6 THEN LET l$ = CHR$ 96
2927  IF i = 7 THEN LET l$ = "x"
2929  IF j = 0 THEN GOTO 2935
2930  PRINT AT 2, j + 21; INK 5; "rp"
2931  PRINT AT 3, j + 21; INK 5; "so"
2932  PRINT AT 2, j + 21; INK 5; OVER 1; l$
2934  GOTO 2939
2935  PRINT AT 2, j + 21; INK 5; "mp"
2936  PRINT AT 3, j + 21; INK 5; "no"
2937  PRINT AT 2, j + 21; INK 5; OVER 1; l$
2939  LET j = j + 1
2940 NEXT i
2945 RETURN
2950 REM player 2
2955 LET j = 0
2960 FOR i = 1 TO 7
2970  IF q(i) <> 16 THEN GOTO 2990
2971  IF i = 1 THEN LET l$ = CHR$ 91
2972  IF i = 2 THEN LET l$ = CHR$ 92
2973  IF i = 3 THEN LET l$ = CHR$ 93
2974  IF i = 4 THEN LET l$ = CHR$ 94
2975  IF i = 5 THEN LET l$ = CHR$ 95
2976  IF i = 6 THEN LET l$ = CHR$ 96
2977  IF i = 7 THEN LET l$ = "x"
2979  IF j = 0 THEN GOTO 2985
2980  PRINT AT 16, j + 21; INK 7; "rp"
2981  PRINT AT 17, j + 21; INK 7; "so"
2982  PRINT AT 16, j + 21; INK 7; OVER 1; l$
2984  GOTO 2989
2985  PRINT AT 16, j + 21; INK 7; "mp "
2986  PRINT AT 17, j + 21; INK 7; "no "
2987  PRINT AT 16, j + 21; INK 7; OVER 1; l$
2989  LET j = j + 1
2990 NEXT i
2999 RETURN

3000 REM ***** computer move choice *****
3001 REM ********************************
3005 REM go though all players counters
3006 PRINT AT 20,0; "THINKING .";
3010 FOR i = 1 TO 7
3011  REM extract from and to positions
3015  LET j = t((i * 2) - 1)
3016  LET k = t(i * 2)
3020  REM skip if cant move
3025  IF j = -1 THEN LET w(i) = -1 : GOTO 3210
3030  LET w(i) = 0
3040  REM add weights for certain conditions
3041  IF j > 5 AND j < 14 AND j <> 9 THEN LET w(i) = w(i) + 30
3043  IF k = 16 AND j < 14 THEN LET w(i) = w(i) + 200
3044  IF k = 16 AND j >= 14 THEN LET w(i) = w(i) + 100
3046  IF k = 15 THEN LET w(i) = w(i) + 50
3047  IF k = 5 THEN LET w(i) = w(i) + 70
3048  IF k = 14 THEN LET w(i) = w(i) + 40
3050  FOR h = 1 TO 7
3051   IF e = 1 AND j > 5 AND q(h) >= j - 4 AND q(h) < j THEN LET w(i) = w(i) + 20
3052   IF e = 2 AND j > 5 AND p(h) >= j - 4 AND p(h) < j THEN LET w(i) = w(i) + 20
3053   IF e = 1 AND w(i) > 20 AND k > 5 AND q(h) > j AND q(h) < k THEN LET w(i) = w(i) - 20
3054   IF e = 2 AND w(i) > 20 AND k > 5 AND p(h) > j AND p(h) < k THEN LET w(i) = w(i) - 20
3059  NEXT h
3180  REM add weights for taking an opponent counter
3182  FOR h = 1 TO 7
3183   IF k > 5 AND k < 14 AND p(h) = k THEN LET w(i) = w(i) + 20
3184   IF k > 5 AND k < 14 AND q(h) = k THEN LET w(i) = w(i) + 20
3185  NEXT h
3200  REM add a random factor
3205  LET w(i) = w(i) + INT(RND * 5)
3207  PRINT ".";
3210 NEXT i
3215 REM find highest weight
3220 LET j = w(1)
3230 FOR i = 1 TO 7
3240  IF w(i) > j THEN LET j = w(i)
3250 NEXT i
3255 REM set m to highest weighted counter
3280 LET m = 1
3290 FOR i = 1 TO 7
3300  IF w(i) = j THEN LET m = i
3310 NEXT i
3320 RETURN

5000 REM ***** UR engine *****
5001 REM *********************
5002 REM a = action, 1 = initialise/reset, 2 = roll dice, 3 = get valid moves, 4 = make move, 5 = detect win
5003 LET r = 0
5010 if a = 1 THEN GOTO 5100
5020 if a = 2 THEN GOTO 5200
5030 if a = 3 THEN GOTO 5300
5040 if a = 4 THEN GOTO 5600
5050 if a = 5 THEN GOTO 5800
5099 RETURN
5100 REM ***** initialise *****
5101 REM **********************
5102 REM no parameters
5103 REM no return values
5110 PRINT AT 19,0;"INITIALISING"
5114 LET b(1) = 7
5116 LET c(1) = 7
5120 FOR i = 2 TO 16
5130  LET b(i) = 0
5140  LET c(i) = 0
5150 NEXT i
5160 FOR i = 1 TO 7
5170  LET p(i) = 1
5180  LET q(i) = 1
5190 NEXT i
5199 RETURN
5200 REM ***** roll dice *****
5201 REM *********************
5202 REM no parameters
5203 REM return d as total roll value and s$ as text string of 4 individual die rolls (0 or 1) 
5210 LET d = 0
5215 LET s$ = ""
5217 BEEP 0.01, -24
5220 FOR i = 1 TO 4
5225  BEEP 0.01, -24
5230  LET j = INT(RND * 2)
5240  LET d = d + j
5250  LET s$ = s$ + STR$ j
5260 NEXT i
5270 BEEP 0.01, -24
5299 RETURN
5300 REM ***** get valid moves *****
5301 REM ***************************
5302 REM return array t of valid board positions [from:to] 
5310 FOR i = 1 TO 14
5320  LET t(i) = -1
5330 NEXT i
5332 LET u = 0
5333 LET o = 0
5335 IF d = 0 THEN GOTO 5599
5340 IF e = 2 THEN GOTO 5460
5350 REM player 1
5360 FOR i = 1 TO 7
5365  IF f(1) = 2 AND p(i) = 1 AND o = 1 THEN GOTO 5440
5366  IF p(i) = 1 THEN LET o = 1
5370  IF p(i) = 16 THEN GOTO 5440
5380  IF p(i) + d > 16 THEN GOTO 5440
5390  IF b(p(i) + d) > 0 AND p(i) + d < 16 THEN GOTO 5440
5400  IF p(i) + d = 9 AND c(9) > 0 THEN GOTO 5440
5410  LET j = (i * 2) - 1
5420  LET t(j) = p(i)
5430  LET t(j + 1) = p(i) + d
5435  LET u = u + 1
5440 NEXT i
5450 GOTO 5599
5460 REM player 2
5470 FOR i = 1 TO 7
5475  IF f(2) = 2 AND q(i) = 1 AND o = 1 THEN GOTO 5550
5476  IF q(i) = 1 THEN LET o = 1
5480  IF q(i) = 16 THEN GOTO 5550
5490  IF q(i) + d > 16 THEN GOTO 5550
5500  IF c(q(i) + d) > 0  AND q(i) + d < 16 THEN GOTO 5550
5510  IF q(i) + d = 9 AND b(9) > 0 THEN GOTO 5550
5520  LET j = (i * 2) - 1
5530  LET t(j) = q(i)
5540  LET t(j + 1) = q(i) + d
5545  LET u = u + 1
5550 NEXT i
5599 RETURN
5600 REM ***** make move *****
5601 REM *********************
5602 REM input m = counter number 1 - 7 
5605 LET j = t((m * 2) - 1)
5610 LET k = t(m * 2)
5620 IF e = 2 THEN GOTO 5720
5625 REM player 1
5630 LET p(m) = k
5635 LET b(j) = b(j) - 1
5637 LET b(k) = b(k) + 1
5640 IF c(k) = 0 OR k < 6 OR k > 13 THEN GOTO 5695
5650 LET c(k) = c(k) - 1
5660 LET c(1) = c(1) + 1
5670 FOR i = 1 TO 7
5675  IF q(i) <> k THEN GOTO 5690
5680  LET q(i) = 1
5685  GOSUB 2850
5690 NEXT i
5695 GOTO 5792
5720 REM player 2
5730 LET q(m) = k
5735 LET c(j) = c(j) - 1
5737 LET c(k) = c(k) + 1
5740 IF b(k) = 0 OR k < 6 OR k > 13 THEN GOTO 5792
5750 LET b(k) = b(k) - 1
5760 LET b(1) = b(1) + 1
5770 FOR i = 1 TO 7
5775  IF p(i) <> k THEN GOTO 5790
5780  LET p(i) = 1
5785  GOSUB 2800
5790 NEXT i
5792 REM check for rosette
5793 LET r = 0
5795 IF k = 5 OR k = 9 OR k = 15 THEN LET r = 1
5799 RETURN
5800 REM ***** detect win *****
5801 REM **********************
5810 LET r = 0
5820 IF e = 1 AND b(16) = 7 THEN LET r = 1
5830 IF e = 2 AND c(16) = 7 THEN LET r = 2
5840 RETURN

6000 REM variable notes
6001 REM a = engine action
6002 REM b(16) = board position state for player 1 1 = start, 2-15 actual game space positions, 16 = finish (number of counters in that position)
6003 REM c(16) = board position state for player 2 1 = start, 2-15 actual game space positions, 16 = finish (number of counters in that position)
6004 REM d = dice roll
6005 REM e = current player 1 or 2
6006 REM f(2) = player type 1 = human 2 = computer
6007 REM g = used in move pick
6008 REM h = used in move pick
6009 REM i = loop counter
6010 REM j = loop counter or temporary value
6011 REM k = loop counter or temporary value
6012 REM l$ = temporary value
6013 REM m = move selected from list
6014 REM n
6015 REM o = start counter move done
6016 REM p(7) = counter positions for player 1 1 = start 2-15 = on board 16 = finished
6017 REM q(7) = counter positions for player 2 1 = start 2-15 = on board 16 = finished
6018 REM r = return (status 0 = OK)
6019 REM s$ = string temporary value
6020 REM t(14) = array of possible moves [from:to] for each, -1 if invalid
6021 REM u = possible move count
6022 REM v = option for action or return value from the engine
6023 REM w(7) = weight = move preference for computer players
6024 REM x = used in counter drawing
6025 REM y = used in counter drawing
6026 REM z = used in counter drawing
