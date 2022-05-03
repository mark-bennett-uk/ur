  10 REM *********************************
  11 REM *     The Royal Game of UR      *
  12 REM *           ZX81 16k            *
  13 REM *     by Mark Bennett 2022      *
  14 REM * github.com/mark-bennett-uk/ur *
  15 REM *********************************
 100 REM ***** variables *****
 101 REM *********************
 102 DIM b(16) : REM board position state for player 1 1 = start, 2-15 actual game space positions, 16 = finish (number of counters in that position)
 103 DIM c(16) : REM board position state for player 2 1 = start, 2-15 actual game space positions, 16 = finish (number of counters in that position)
 104 DIM p(7) : REM counter positions for player 1 1 = start 2-15 = on board 16 = finished
 105 DIM q(7) : REM counter positions for player 2 1 = start 2-15 = on board 16 = finished
 106 DIM t(14) : REM array of possible moves [from:to] for each, -1 if invalid
 107 DIM f(2) : REM player type 1 = human 2 = computer
 108 DIM w(7) : REM weight = move preference for computer players
 120 LET s$ = ""
 121 LET l$ = ""
 200 REM variable notes
 201 LET a = 0
 204 LET d = 0 : REM dice roll
 205 LET e = 1 : REM current player 1 or 2
 207 LET g = 0
 208 LET h = 0
 209 LET i = 0
 210 LET j = 0
 211 LET k = 0
 213 LET m = 0 : REM move selected from list
 214 LET n = 0 
 215 LET o = 0
 218 LET r = 0 : REM return (status 0 = OK)
 221 LET u = 0 : REM possible move count
 222 LET v = 0 : REM option for action or return value from the engine
 224 LET x = 0
 225 LET y = 0
 226 LET z = 0
 700 REM ***** initialise *****
 701 REM **********************
 710 RANDOMIZE
 780 GOSUB 2100 : REM board - initialise
 782 GOSUB 2200 : REM board - draw border
 784 GOSUB 2500 : REM board - draw all squares
 785 GOSUB 5100 : REM engine - initialise
 786 GOSUB 2800 : REM board - draw start counters p1
 787 GOSUB 2850 : REM board - draw start counters p2
 800 REM ***** player selection *****
 801 REM ****************************
 810 PRINT AT 20, 0; "PLAYER 1 HUMAN OR COMPUTER? "
 815 INPUT l$
 820 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 810
 830 LET f(1) = 1
 840 IF l$ = "C" OR l$ = "c" THEN LET f(1) = 2
 850 PRINT AT 20, 0; "PLAYER 2 HUMAN OR COMPUTER? "
 855 INPUT l$
 860 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 850
 870 LET f(2) = 1
 880 IF l$ = "C" OR l$ = "c" THEN LET f(2) = 2
1000 REM ***** main loop *****
1001 REM *********************
1010 REM ***** player 1 *****
1011 REM ********************
1020 GOSUB 5200 : REM engine - roll dice
1030 GOSUB 1900
1040 PRINT AT 19,0; "PLAYER 1 ROLLS "; STR$ d
1050 GOSUB 5300 : REM engine - get possible moves
1060 IF d = 0 OR u = 0 THEN GOTO 1062
1061 GOTO 1070
1062 PRINT AT 20,0; "NO VALID MOVES"
1063 PAUSE 100
1064 GOTO 1180
1070 IF f(1) = 2 THEN GOTO 1110 : REM computer player
1080 LET m = 0
1090 PRINT AT 20,0; "PLAYER 1 COUNTER TO MOVE "
1091 INPUT m
1092 IF m < 1 OR m > 7 THEN GOTO 1090
1094 IF t((m * 2) - 1) = -1 THEN GOTO 1090
1100 GOTO 1130
1110 GOSUB 3000 : REM computer move selection
1120 PRINT AT 20,0; "PLAYER 1 MOVES COUNTER "; STR$ m
1130 GOSUB 5600 : REM engine - make move
1135 LET n = r
1140 GOSUB 2600 : REM board - make move
1150 GOSUB 5800 : REM engine - detect win
1160 IF r = 1 THEN GOTO 1162
1161 GOTO 1170 
1162 PRINT AT 21,0; "PLAYER 1 WINS, PRESS ENTER"
1163 INPUT l$
1164 GOTO 200
1170 IF u > 0 AND n = 1 THEN GOTO 1010 : REM rosette rethrow
1180 LET e = 2
1210 REM ***** player 2 *****
1211 REM ********************
1220 GOSUB 5200 : REM engine - roll dice
1230 GOSUB 1900
1240 PRINT AT 19,0; "PLAYER 2 ROLLS "; STR$ d
1250 GOSUB 5300 : REM engine - get possible moves
1260 IF d = 0 OR u = 0 THEN GOTO 1262
1261 GOTO 1270
1262 PRINT AT 20,0; "NO VALID MOVES"
1263 PAUSE 100
1264 GOTO 1380
1270 IF f(2) = 2 THEN GOTO 1310 : REM computer player
1280 LET m = 0
1290 PRINT AT 20,0; "PLAYER 2 COUNTER TO MOVE "
1291 INPUT m
1292 IF m < 1 OR m > 7 THEN GOTO 1290
1294 IF t((m * 2) - 1) = -1 THEN GOTO 1290
1300 GOTO 1330
1310 GOSUB 3000 : REM computer move selection
1320 PRINT AT 20,0; "PLAYER 2 MOVES COUNTER "; STR$ m
1330 GOSUB 5600 : REM engine - make move
1335 LET n = r
1340 GOSUB 2600 : REM board - make move
1350 GOSUB 5800 : REM engine - detect win
1360 IF r = 2 THEN GOTO 1362 
1361 GOTO 1370
1362 PRINT AT 21,0; "PLAYER 2 WINS, PRESS ENTER"
1363 INPUT l$
1364 GOTO 200
1370 IF u > 0 AND n = 1 THEN GOTO 1210 : REM rosette rethrow
1380 LET e = 1
1390 GOTO 1010
1900 REM ***** clear text display *****
1901 REM ******************************
1910 PRINT AT 19,0; "                               "
1911 PRINT AT 20,0; "                               "
1912 PRINT AT 21,0; "                               "
1915 RETURN
2000 REM ***** draw board *****
2001 REM **********************
2100 REM ***** initialise *****
2101 REM **********************
2103 CLS
2104 PRINT AT 0,2; "THE ROYAL GAME OF UR"
2110 PRINT AT 2,0; "P1 "; CHR$ 7; CHR$ 132
2111 PRINT AT 3,3; CHR$ 130; CHR$ 129
2120 PRINT AT 16,0; "P2 "; CHR$ 8; CHR$ 8
2121 PRINT AT 17,3; CHR$ 8; CHR$ 8
2130 RETURN
2200 REM ***** draw border *****
2201 REM ***********************
2210 PRINT AT 5,2; CHR$ 7; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 132
2211 PRINT AT 5,20; CHR$ 7; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 132
2212 PRINT AT 6,2; CHR$ 5
2213 PRINT AT 6,14; CHR$ 133
2214 PRINT AT 6,20; CHR$ 5
2215 PRINT AT 6,26; CHR$ 133
2216 PRINT AT 7,2; CHR$ 5
2218 PRINT AT 7,14; CHR$ 2; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 3; CHR$ 1
2219 PRINT AT 7,26; CHR$ 133
2220 PRINT AT 8,2; CHR$ 5
2221 PRINT AT 8,26; CHR$ 133
2222 PRINT AT 9,2; CHR$ 5
2223 PRINT AT 9,26; CHR$ 133
2224 PRINT AT 10,2; CHR$ 5
2225 PRINT AT 10,26; CHR$ 133
2226 PRINT AT 11,2; CHR$ 5
2227 PRINT AT 11,26; CHR$ 133
2228 PRINT AT 12,2; CHR$ 5
2229 PRINT AT 12,14; CHR$ 135; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 4
2230 PRINT AT 12,26; CHR$ 133
2231 PRINT AT 13,2; CHR$ 5
2232 PRINT AT 13,14; CHR$ 133
2233 PRINT AT 13,20; CHR$ 5
2234 PRINT AT 13,26; CHR$ 133
2235 PRINT AT 14,2; CHR$ 130; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 129
2236 PRINT AT 14,20; CHR$ 130; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 131; CHR$ 129
2240 RETURN
2300 REM ***** draw board square *****
2301 REM *****************************
2302 REM v = 2 to 15 space to draw
2303 REM j = 1 or 2 player to draw
2310 LET k = ((v - 2)* 4) + ((j - 1) * 56) + 2320
2315 GOTO k
2320 PRINT AT 6,12; "++" : REM P1 pos 2
2321 PRINT AT 7,12; "++"
2322 RETURN
2324 PRINT AT 6,9; "++" : REM P1 pos 3
2325 PRINT AT 7,9; "++"
2326 RETURN
2328 PRINT AT 6,6; "++" : REM P1 pos 4
2329 PRINT AT 7,6; "++"
2330 RETURN
2332 PRINT AT 6,3; "OO" : REM P1 pos 5
2333 PRINT AT 7,3; "OO"
2334 RETURN
2336 PRINT AT 9,3; "++" : REM pos 6
2337 PRINT AT 10,3; "++"
2338 RETURN
2340 PRINT AT 9,6; "++" : REM pos 7
2341 PRINT AT 10,6; "++"
2342 RETURN
2344 PRINT AT 9,9; "++" : REM pos 8
2345 PRINT AT 10,9; "++"
2346 RETURN
2348 PRINT AT 9,12; "OO" : REM pos 9
2349 PRINT AT 10,12; "OO"
2350 RETURN
2352 PRINT AT 9,15; "++" : REM pos 10
2353 PRINT AT 10,15; "++"
2354 RETURN
2356 PRINT AT 9,18; "++" : REM pos 11
2357 PRINT AT 10,18; "++"
2358 RETURN
2360 PRINT AT 9,21; "++" : REM pos 12
2361 PRINT AT 10,21; "++"
2362 RETURN
2364 PRINT AT 9,24; "++" : REM pos 13
2365 PRINT AT 10,24; "++"
2366 RETURN
2368 PRINT AT 6,24; "++" : REM P1 pos 14
2369 PRINT AT 7,24; "++"
2370 RETURN
2372 PRINT AT 6,21; "OO" : REM P1 pos 15
2373 PRINT AT 7,21; "OO"
2374 RETURN
2376 PRINT AT 12,12; "++" : REM P2 pos 2
2377 PRINT AT 13,12; "++"
2378 RETURN
2380 PRINT AT 12,9; "++" : REM P2 pos 3
2381 PRINT AT 13,9; "++"
2382 RETURN
2384 PRINT AT 12,6; "++" : REM P2 pos 4
2385 PRINT AT 13,6; "++"
2386 RETURN
2388 PRINT AT 12,3; "OO" : REM P2 pos 5
2389 PRINT AT 13,3; "OO"
2390 RETURN
2392 PRINT AT 9,3; "++" : REM pos 6
2393 PRINT AT 10,3; "++"
2394 RETURN
2396 PRINT AT 9,6; "++" : REM pos 7
2397 PRINT AT 10,6; "++"
2398 RETURN
2400 PRINT AT 9,9; "++" : REM pos 8
2401 PRINT AT 10,9; "++"
2402 RETURN
2404 PRINT AT 9,12; "OO" : REM pos 9
2405 PRINT AT 10,12; "OO"
2406 RETURN
2408 PRINT AT 9,15; "++" : REM pos 10
2409 PRINT AT 10,15; "++"
2410 RETURN
2412 PRINT AT 9,18; "++" : REM pos 11
2413 PRINT AT 10,18; "++"
2414 RETURN
2416 PRINT AT 9,21; "++" : REM pos 12
2417 PRINT AT 10,21; "++"
2418 RETURN
2420 PRINT AT 9,24; "++" : REM pos 13
2421 PRINT AT 10,24; "++"
2422 RETURN
2424 PRINT AT 12,24; "++" : REM P2 pos 14
2425 PRINT AT 13,24; "++"
2426 RETURN
2428 PRINT AT 12,21; "OO" : REM P2 pos 15
2429 PRINT AT 13,21; "OO"
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
2645 IF e = 1 AND v = 1 THEN GOSUB 2800
2646 IF e = 2 AND v = 1 THEN GOSUB 2850
2650 IF v > 1 AND v < 16 THEN GOSUB k
2700 REM draw counter
2701 LET v = t(m * 2)
2703 IF e = 1 AND v = 16 THEN GOSUB 2900
2704 IF e = 2 AND v = 16 THEN GOSUB 2950
2705 IF v < 1 OR v > 15 THEN RETURN
2750 IF v > 1 AND v <= 5 THEN LET x = 3 * (6 - v)
2752 IF v >= 6 AND v <= 13 THEN LET x = 3 * (v - 5)
2753 IF v >= 14 AND v <= 15 THEN LET x = 3 * (22 - v)
2754 LET y = 6
2760 IF v >= 6 AND v <= 13 THEN LET y = 9
2765 IF y = 6 AND e = 2 THEN LET y = 12
2770 IF e = 1 THEN PRINT AT y,x; STR$ m; CHR$ 132
2771 IF e = 1 THEN PRINT AT y + 1,x; CHR$ 130; CHR$ 129
2775 IF e = 2 THEN PRINT AT y,x; STR$ m; CHR$ 8
2782 IF e = 2 THEN PRINT AT y + 1,x; CHR$ 8; CHR$ 8
2790 RETURN
2800 REM ***** draw start counters *****
2801 REM *******************************
2802 REM player 1
2807 PRINT AT 2, 6; 
2810 FOR i = 1 TO 7
2820  IF p(i) = 1 THEN PRINT STR$ i;
2840 NEXT i
2842 PRINT " "
2845 RETURN
2850 REM player 2
2857 PRINT AT 16, 6;
2860 FOR i = 1 TO 7
2870  IF q(i) = 1 THEN PRINT STR$ i;
2890 NEXT i
2892 PRINT " "
2895 RETURN
2900 REM ***** draw end counters *****
2901 REM *****************************
2902 REM player 1
2905 PRINT AT 2,20;
2910 FOR i = 1 TO 7
2920  IF p(i) = 16 THEN PRINT STR$ i;
2940 NEXT i
2945 RETURN
2950 REM player 2
2955 PRINT AT 16,20;
2960 FOR i = 1 TO 7
2970  IF q(i) = 16 THEN PRINT STR$ i;
2990 NEXT i
2999 RETURN
3000 REM ***** computer move choice *****
3001 REM ********************************
3006 PRINT AT 20,0; "THINKING .";
3010 FOR i = 1 TO 7
3011  LET w(i) = -1
3012  REM extract from and to positions
3015  LET j = t((i * 2) - 1)
3016  LET k = t(i * 2)
3020  REM skip if cant move
3025  IF j = -1 THEN GOTO 3210
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
3216 REM find highest weight
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
5100 REM ***** initialise *****
5101 REM **********************
5110 PRINT AT 20,0;"INITIALISING"
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
5203 REM return d as total roll value and s$ as text string of 4 individual die rolls (0 or 1) 
5210 LET d = 0
5215 LET s$ = ""
5220 FOR i = 1 TO 4
5230  LET j = INT(RND * 2)
5240  LET d = d + j
5250  LET s$ = s$ + STR$ j
5260 NEXT i
5299 RETURN
5300 REM ***** get valid moves *****
5301 REM ***************************
5302 REM return array t of valid board positions [from:to] 
5310 FOR i = 1 TO 14
5320  LET t(i) = -1
5330 NEXT i
5332 LET u = 0
5335 IF d = 0 THEN GOTO 5599
5340 IF e = 2 THEN GOTO 5460
5350 REM player 1
5360 FOR i = 1 TO 7
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

