  10 REM *********************************
  20 REM *     The Royal Game of UR      *
  30 REM *       Altair 8800 Basic       *
  40 REM *     by Mark Bennett 2022      *
  50 REM * github.com/mark-bennett-uk/ur *
  60 REM *********************************
  90 CLEAR 200
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
 200 REM ***** player selection *****
 201 REM ****************************
 210 INPUT " Player 1 (H)uman or (C)omputer? "; l$
 220 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 210
 230 LET f(1) = 1
 240 IF l$ = "C" OR l$ = "c" THEN LET f(1) = 2
 250 INPUT " Player 2 (H)uman or (C)omputer? "; l$
 260 IF l$ <> "H" AND l$ <> "C" AND l$ <> "h" AND l$ <> "c" THEN GOTO 250
 270 LET f(2) = 1
 280 IF l$ = "C" OR l$ = "c" THEN LET f(2) = 2
 900 REM ***** initialise *****
 901 REM **********************
 970 LET e = 1
 980 LET a = 1 : GOSUB 5000 : REM engine - initialise
1000 REM ***** main loop *****
1001 REM *********************
1002 REM player 1
1005 GOSUB 2000 : REM draw board
1020 LET a = 2 : GOSUB 5000 : REM engine - roll dice
1040 PRINT " Player 1 rolls"; STR$(d)
1060 LET a = 3 : GOSUB 5000 : REM engine - get possible moves
1110 REM choose move
1115 IF d = 0 OR u = 0 THEN PRINT " No valid moves" : GOTO 1195
1117 IF f(1) = 2 THEN GOTO 1128 : REM computer player
1119 LET m = 0
1120 INPUT " Player 1 counter to move "; m
1122 IF m < 1 OR m > 7 THEN GOTO 1120
1125 IF t((m * 2) - 1) = -1 THEN GOTO 1120
1127 GOTO 1140
1128 GOSUB 3000 : REM computer move selection
1129 PRINT " Player 1 moves counter"; STR$(m)
1140 LET a = 4 : GOSUB 5000 : REM engine - make move
1155 LET k = r
1160 LET a = 5 : GOSUB 5000 : REM engine - detect win
1180 IF r = 0 THEN GOTO 1190
1183 GOSUB 2000 : REM draw board
1184 PRINT
1185 PRINT " Player 1 wins"
1186 PRINT
1187 GOTO 200
1190 IF u > 0 AND k = 1 THEN GOTO 1005 : REM rethrow
1195 LET e = 2
1200 REM player 2
1205 GOSUB 2000 : REM draw board
1220 LET a = 2 : GOSUB 5000 : REM roll dice
1240 PRINT " Player 2 rolls"; STR$(d)
1260 LET a = 3 : GOSUB 5000 : REM engine - get possible moves
1310 REM choose move
1315 IF d = 0 OR u = 0 THEN PRINT " No valid moves" : GOTO 1395
1317 IF f(2) = 2 THEN GOTO 1328 : REM computer player
1319 LET m = 0
1320 INPUT " Player 2 counter to move "; m
1322 IF m < 1 OR m > 7 THEN GOTO 1320
1325 IF t((m * 2) - 1) = -1 THEN GOTO 1320
1327 GOTO 1340
1328 GOSUB 3000 : REM computer move selection
1329 PRINT " Player 2 moves counter"; STR$(m)
1340 LET a = 4 : GOSUB 5000 : REM engine - make move
1355 LET k = r
1360 LET a = 5 : GOSUB 5000 : REM engine - detect win
1380 IF r = 0 THEN GOTO 1390
1383 GOSUB 2000 : REM draw board
1384 PRINT
1385 PRINT " Player 2 wins"
1386 PRINT
1387 GOTO 200
1390 IF u > 0 AND k = 1 THEN GOTO 1205 : REM rethrow
1395 LET e = 1
1399 GOTO 1000
2000 REM ***** draw board *****
2001 REM **********************
2010 REM p1 = +
2020 REM p2 = *
2030 REM board square = O
2040 REM rosette square = #
2050 PRINT
2060 PRINT
2070 REM player 1 status row
2071 LET l$ = ""
2072 FOR i = 1 TO 7
2073 IF p(i) = 1 THEN LET l$ = l$ + RIGHT$(STR$(i), 1)
2074 NEXT i
2075 LET l$ = "(" + l$ + ")"
2078 PRINT "--------------------------------"
2080 PRINT " P1 +"; STR$(b(1)); " "; l$; STR$(b(16))
2100 REM top row
2105 PRINT "================================"
2110 LET l$ = " ##  OO  OO  OO          ##  OO"
2120 FOR i = 1 TO 7
2121 IF p(i) = 5 THEN LET l$ = STR$(i) + "+" + RIGHT$(l$, 28)
2122 IF p(i) = 4 THEN LET l$ = LEFT$(l$, 4) + STR$(i) + "+" + RIGHT$(l$, 24)
2123 IF p(i) = 3 THEN LET l$ = LEFT$(l$, 8) + STR$(i) + "+" + RIGHT$(l$, 20)
2124 IF p(i) = 2 THEN LET l$ = LEFT$(l$, 12) + STR$(i) + "+" + RIGHT$(l$, 16)
2125 IF p(i) = 15 THEN LET l$ = LEFT$(l$, 24) + STR$(i) + "+" + RIGHT$(l$, 4)
2126 IF p(i) = 14 THEN LET l$ = LEFT$(l$, 28) + STR$(i) + "+"
2127 NEXT i
2130 PRINT l$
2140 LET l$ = " ##  OO  OO  OO          ##  OO"
2150 FOR i = 1 TO 7
2151 IF p(i) = 5 THEN LET l$ = " ++" + RIGHT$(l$, 28)
2152 IF p(i) = 4 THEN LET l$ = LEFT$(l$, 4) + " ++" + RIGHT$(l$, 24)
2153 IF p(i) = 3 THEN LET l$ = LEFT$(l$, 8) + " ++" + RIGHT$(l$, 20)
2154 IF p(i) = 2 THEN LET l$ = LEFT$(l$, 12) + " ++" + RIGHT$(l$, 16)
2155 IF p(i) = 15 THEN LET l$ = LEFT$(l$, 24) + " ++" + RIGHT$(l$, 4)
2156 IF p(i) = 14 THEN LET l$ = LEFT$(l$, 28) + " ++"
2160 NEXT i
2170 PRINT l$
2180 PRINT
2200 REM middle row
2210 LET l$ = " OO  OO  OO  ##  OO  OO  OO  OO"
2220 FOR i = 1 TO 7
2221 IF p(i) = 6 THEN LET l$ = STR$(i) + "+" + RIGHT$(l$, 28)
2222 IF p(i) = 7 THEN LET l$ = LEFT$(l$, 4) + STR$(i) + "+" + RIGHT$(l$, 24)
2223 IF p(i) = 8 THEN LET l$ = LEFT$(l$, 8) + STR$(i) + "+" + RIGHT$(l$, 20)
2224 IF p(i) = 9 THEN LET l$ = LEFT$(l$, 12) + STR$(i) + "+" + RIGHT$(l$, 16)
2225 IF p(i) = 10 THEN LET l$ = LEFT$(l$, 16) + STR$(i) + "+" + RIGHT$(l$, 12)
2226 IF p(i) = 11 THEN LET l$ = LEFT$(l$, 20) + STR$(i) + "+" + RIGHT$(l$, 8)
2227 IF p(i) = 12 THEN LET l$ = LEFT$(l$, 24) + STR$(i) + "+" + RIGHT$(l$, 4)
2228 IF p(i) = 13 THEN LET l$ = LEFT$(l$, 28) + STR$(i) + "+"
2231 IF q(i) = 6 THEN LET l$ = STR$(i) + "*" + RIGHT$(l$, 28)
2232 IF q(i) = 7 THEN LET l$ = LEFT$(l$, 4) + STR$(i) + "*" + RIGHT$(l$, 24)
2233 IF q(i) = 8 THEN LET l$ = LEFT$(l$, 8) + STR$(i) + "*" + RIGHT$(l$, 20)
2234 IF q(i) = 9 THEN LET l$ = LEFT$(l$, 12) + STR$(i) + "*" + RIGHT$(l$, 16)
2235 IF q(i) = 10 THEN LET l$ = LEFT$(l$, 16) + STR$(i) + "*" + RIGHT$(l$, 12)
2236 IF q(i) = 11 THEN LET l$ = LEFT$(l$, 20) + STR$(i) + "*" + RIGHT$(l$, 8)
2237 IF q(i) = 12 THEN LET l$ = LEFT$(l$, 24) + STR$(i) + "*" + RIGHT$(l$, 4)
2238 IF q(i) = 13 THEN LET l$ = LEFT$(l$, 28) + STR$(i) + "*"
2239 NEXT i
2240 PRINT l$
2250 LET l$ = " OO  OO  OO  ##  OO  OO  OO  OO"
2260 FOR i = 1 TO 7
2261 IF p(i) = 6 THEN LET l$ = " ++" + RIGHT$(l$, 28)
2262 IF p(i) = 7 THEN LET l$ = LEFT$(l$, 4) + " ++" + RIGHT$(l$, 24)
2263 IF p(i) = 8 THEN LET l$ = LEFT$(l$, 8) + " ++" + RIGHT$(l$, 20)
2264 IF p(i) = 9 THEN LET l$ = LEFT$(l$, 12) + " ++" + RIGHT$(l$, 16)
2265 IF p(i) = 10 THEN LET l$ = LEFT$(l$, 16) + " ++" + RIGHT$(l$, 12)
2266 IF p(i) = 11 THEN LET l$ = LEFT$(l$, 20) + " ++" + RIGHT$(l$, 8)
2267 IF p(i) = 12 THEN LET l$ = LEFT$(l$, 24) + " ++" + RIGHT$(l$, 4)
2268 IF p(i) = 13 THEN LET l$ = LEFT$(l$, 28) + " ++"
2271 IF q(i) = 6 THEN LET l$ = " **" + RIGHT$(l$, 28)
2272 IF q(i) = 7 THEN LET l$ = LEFT$(l$, 4) + " **" + RIGHT$(l$, 24)
2273 IF q(i) = 8 THEN LET l$ = LEFT$(l$, 8) + " **" + RIGHT$(l$, 20)
2274 IF q(i) = 9 THEN LET l$ = LEFT$(l$, 12) + " **" + RIGHT$(l$, 16)
2275 IF q(i) = 10 THEN LET l$ = LEFT$(l$, 16) + " **" + RIGHT$(l$, 12)
2276 IF q(i) = 11 THEN LET l$ = LEFT$(l$, 20) + " **" + RIGHT$(l$, 8)
2277 IF q(i) = 12 THEN LET l$ = LEFT$(l$, 24) + " **" + RIGHT$(l$, 4)
2278 IF q(i) = 13 THEN LET l$ = LEFT$(l$, 28) + " **"
2279 NEXT i
2280 PRINT l$
2290 PRINT
2300 REM bottom row
2310 LET l$ = " ##  OO  OO  OO          ##  OO"
2320 FOR i = 1 TO 7
2321 IF q(i) = 5 THEN LET l$ = STR$(i) + "*" + RIGHT$(l$, 28)
2322 IF q(i) = 4 THEN LET l$ = LEFT$(l$, 4) + STR$(i) + "*" + RIGHT$(l$, 24)
2323 IF q(i) = 3 THEN LET l$ = LEFT$(l$, 8) + STR$(i) + "*" + RIGHT$(l$, 20)
2324 IF q(i) = 2 THEN LET l$ = LEFT$(l$, 12) + STR$(i) + "*" + RIGHT$(l$, 16)
2325 IF q(i) = 15 THEN LET l$ = LEFT$(l$, 24) + STR$(i) + "*" + RIGHT$(l$, 4)
2326 IF q(i) = 14 THEN LET l$ = LEFT$(l$, 28) + STR$(i) + "*"
2327 NEXT i
2330 PRINT l$
2340 LET l$ = " ##  OO  OO  OO          ##  OO"
2350 FOR i = 1 TO 7
2351 IF q(i) = 5 THEN LET l$ = " **" + RIGHT$(l$, 28)
2352 IF q(i) = 4 THEN LET l$ = LEFT$(l$, 4) + " **" + RIGHT$(l$, 24)
2353 IF q(i) = 3 THEN LET l$ = LEFT$(l$, 8) + " **" + RIGHT$(l$, 20)
2354 IF q(i) = 2 THEN LET l$ = LEFT$(l$, 12) + " **" + RIGHT$(l$, 16)
2355 IF q(i) = 15 THEN LET l$ = LEFT$(l$, 24) + " **" + RIGHT$(l$, 4)
2356 IF q(i) = 14 THEN LET l$ = LEFT$(l$, 28) + " **"
2357 NEXT i
2360 PRINT l$
2370 PRINT "================================"
2461 REM player 2 status row
2462 LET l$ = ""
2463 FOR i = 1 TO 7
2464 IF q(i) = 1 THEN LET l$ = l$ + RIGHT$(STR$(i), 1)
2465 NEXT i
2466 LET l$ = "(" + l$ + ")"
2470 PRINT " P2 *"; STR$(c(1)); " "; l$; STR$(c(16))
2485 PRINT "--------------------------------"
2490 RETURN
3000 REM ***** computer move selection *****
3001 REM ***********************************
3005 REM go though all players counters
3010 FOR i = 1 TO 7
3011 REM extract from and to positions
3015 LET j = t((i * 2) - 1)
3016 LET k = t(i * 2)
3020 REM skip if cant move
3025 IF j = -1 THEN LET w(i) = -1 : GOTO 3210
3030 LET w(i) = 0
3040 REM add weights for board positions
3041 IF j > 5 AND j < 14 AND j <> 9 THEN LET w(i) = w(i) + 30
3043 IF k = 16 AND j < 14 THEN LET w(i) = w(i) + 200
3044 IF k = 16 AND j >= 14 THEN LET w(i) = w(i) + 100
3046 IF k = 15 THEN LET w(i) = w(i) + 50
3047 IF k = 5 THEN LET w(i) = w(i) + 70
3048 IF k = 14 THEN LET w(i) = w(i) + 40
3050 FOR h = 1 TO 7
3051 IF e = 1 AND j > 5 AND q(h) >= j - 4 AND q(h) < j THEN LET w(i) = w(i) + 20
3052 IF e = 2 AND j > 5 AND p(h) >= j - 4 AND p(h) < j THEN LET w(i) = w(i) + 20
3053 IF e = 1 AND w(i) > 20 AND k > 5 AND q(h) > j AND q(h) < k THEN LET w(i) = w(i) - 20
3054 IF e = 2 AND w(i) > 20 AND k > 5 AND p(h) > j AND p(h) < k THEN LET w(i) = w(i) - 20
3059 NEXT h
3180 REM add weights for taking an opponents counter
3182 FOR h = 1 TO 7
3183 IF k > 5 AND k < 14 AND p(h) = k THEN LET w(i) = w(i) + 20
3184 IF k > 5 AND k < 14 AND q(h) = k THEN LET w(i) = w(i) + 20
3185 NEXT h
3200 REM add a random factor
3205 LET w(i) = w(i) + INT(RND(1) * 5)
3210 NEXT i
3215 REM find highest weight
3220 LET j = w(1)
3230 FOR i = 1 TO 7
3240 IF w(i) > j THEN LET j = w(i)
3250 NEXT i
3255 REM set m to highest weighted counter
3280 LET m = 1
3290 FOR i = 1 TO 7
3300 IF w(i) = j THEN LET m = i
3310 NEXT i
3320 RETURN
5000 REM ***** UR engine *****
5001 REM *********************
5002 REM a = action 1 - 5
5003 LET r = 0
5010 IF a = 1 THEN GOTO 5100 : REM initialise/reset
5020 IF a = 2 THEN GOTO 5200 : REM roll dice
5030 IF a = 3 THEN GOTO 5300 : REM get valid moves
5040 IF a = 4 THEN GOTO 5600 : REM make move
5050 IF a = 5 THEN GOTO 5800 : REM detect win
5099 RETURN
5100 REM ***** initialise *****
5101 REM **********************
5102 REM no parameters
5103 REM no return values
5110 PRINT " Initialising"
5114 LET b(1) = 7
5116 LET c(1) = 7
5120 FOR i = 2 TO 16
5130 LET b(i) = 0
5140 LET c(i) = 0
5150 NEXT i
5160 FOR i = 1 TO 7
5170 LET p(i) = 1
5180 LET q(i) = 1
5190 NEXT i
5199 RETURN
5200 REM ***** roll dice *****
5201 REM *********************
5202 REM no parameters
5203 REM return d as total roll value and s$ as text string of 4 individual die rolls (0 or 1) 
5210 LET d = 0
5215 LET s$ = ""
5220 FOR i = 1 TO 4
5230 LET j = INT(RND(1) * 2)
5240 LET d = d + j
5250 LET s$ = s$ + STR$(j)
5260 NEXT i
5299 RETURN
5300 REM ***** get valid moves *****
5301 REM ***************************
5302 REM return array t of valid board positions [from:to] 
5310 FOR i = 1 TO 14
5320 LET t(i) = -1
5330 NEXT i
5332 LET u = 0
5335 IF d = 0 THEN GOTO 5599
5340 IF e = 2 THEN GOTO 5460
5350 REM player 1
5360 FOR i = 1 TO 7
5370 IF p(i) = 16 THEN GOTO 5440
5380 IF p(i) + d > 16 THEN GOTO 5440
5390 IF b(p(i) + d) > 0 AND p(i) + d < 16 THEN GOTO 5440
5400 IF p(i) + d = 9 AND c(9) > 0 THEN GOTO 5440
5410 LET j = (i * 2) - 1
5420 LET t(j) = p(i)
5430 LET t(j + 1) = p(i) + d
5435 LET u = u + 1
5440 NEXT i
5450 GOTO 5599
5460 REM player 2
5470 FOR i = 1 TO 7
5480 IF q(i) = 16 THEN GOTO 5550
5490 IF q(i) + d > 16 THEN GOTO 5550
5500 If c(q(i) + d) > 0  AND q(i) + d < 16 THEN GOTO 5550
5510 IF q(i) + d = 9 AND b(9) > 0 THEN GOTO 5550
5520 LET j = (i * 2) - 1
5530 LET t(j) = q(i)
5540 LET t(j + 1) = q(i) + d
5545 LET u = u + 1
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
5675 IF q(i) <> k THEN GOTO 5690
5680 LET q(i) = 1
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
5775 IF p(i) <> k THEN GOTO 5790
5780 LET p(i) = 1
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
6015 REM o
6016 REM p(7) = counter positions for player 1 1 = start 2-15 = on board 16 = finished
6017 REM q(7) = counter positions for player 2 1 = start 2-15 = on board 16 = finished
6018 REM r = return (status 0 = OK)
6019 REM s$ = string temporary value
6020 REM t(14) = array of possible moves [from:to] for each, -1 if invalid
6021 REM u = possible move count
6022 REM v = option for action or return value from the engine
6023 REM w(7) = weight = move preference for computer players
6024 REM x
6025 REM y
6026 REM z
