 100 REM *********************************
 110 REM *     The Royal Game of UR      *
 120 REM *              QL               *
 130 REM *     by Mark Bennett 2022      *
 140 REM * github.com/mark-bennett-uk/ur *
 150 REM *********************************
 160 CLEAR
 170 RANDOMISE
 180 initialise_program
 190 REPEAT games
 200   initialise_variables
 210   initialise_engine
 220   initialise_board
 230   draw_all_squares
 240   draw_start_counters 1
 250   draw_start_counters 2
 260   player_selection
 270   REPEAT main_loop
 290     REPEAT player_turn
 300       roll_dice
 310       PRINT #4, "Player " & player & " rolls" ! dice_roll
 320       get_possible_moves
 330       IF dice_roll = 0 OR move_count = 0 THEN 
 340         PRINT #4, "No valid moves"
 350         PAUSE 100
 360       ELSE
 370         IF f(player) = 2 THEN
 380           computer_move_selection
 390           PRINT #4, "Player " & player & " moves counter" ! selected_move
 395           PAUSE 100
 400         ELSE
 410           REPEAT until_valid_move
 415             REPEAT until_valid_input
 420               INPUT #4, "Player " & player & " counter to move" ! l$
 425               IF l$ <> "" THEN EXIT until_valid_input
 427             END REPEAT until_valid_input
 429             selected_move = l$
 430             IF selected_move >= 1 AND selected_move <= 7 THEN
 433               IF t((selected_move * 2) - 1) > -1 THEN EXIT until_valid_move
 435             END IF
 440           END REPEAT until_valid_move
 450         END IF
 460         engine_make_move
 470         board_make_move
 480         IF detect_win = 1 THEN
 490           PRINT #4, "Player " & player & " wins"
 500           PAUSE 400
 510           EXIT main_loop
 520         END IF
 530       END IF
 540       IF move_count = 0 OR throw_again = 0 THEN EXIT player_turn
 550     END REPEAT player_turn
 555     IF player = 1 THEN
 560       player = 2
 565       not_player = 1
 570     ELSE
 580       player = 1
 590       not_player = 2
 600     END IF
 610   END REPEAT main_loop
 620   INPUT #4, "Press enter to play again" ! l$
 630 END REPEAT games

1000 DEF PROC initialise_board
1001   LOCAL w, h, x, y, c
1005   SCALE #3, 180, 0, 0
1010   CLS #3
1020   INK #3, 4
1030   PRINT #3, "THE ROYAL GAME OF UR"
1040   AT #3, 2, 0 : PRINT #3, "P1 "
1050   AT #3, 16, 0 : PRINT #3, "P2 "
1051   w = 12 * 25 : h = 10 * 10 : x = 12 * 2 : y = 10 * 5 : BLOCK #3, w, h, x, y, 6
1052   w = 12 * 25 - 8 : h = 10 * 10 - 4 : x = 12 * 2 + 4 : y = 10 * 5 + 2 : BLOCK #3, w, h, x, y, 2, 1
1053   w = 12 * 23 : h = 10 * 8 : x = 12 * 3 : y = 10 * 6 : BLOCK #3, w, h, x, y, 6
1054   w = 12 * 7 : h = 10 * 2 : x = 12 * 14 : y = 10 * 6 : BLOCK #3, w, h, x, y, 2, 1
1055   w = 12 * 5 + 8 : h = 10 * 2 : x = 12 * 15 - 4 : y = 10 * 5 + 2 : BLOCK #3, w, h, x, y, 6
1056   w = 12 * 5 : h = 10 * 2 : x = 12 * 15 : y = 10 * 5 : BLOCK #3, w, h, x, y, 1
1057   w = 12 * 7 : h = 10 * 2 : x = 12 * 14 : y = 10 * 12 : BLOCK #3, w, h, x, y, 2, 1
1058   w = 12 * 5 + 8 : h = 10 * 2 : x = 12 * 15-4 : y = 10 * 13 - 2 : BLOCK #3, w, h, x, y, 6
1059   w = 12 * 5 : h = 10 * 2 : x = 12 * 15 : y = 10 * 13 : BLOCK #3, w, h, x, y, 1
1060 END DEF initialise_board

1180 DEF PROC draw_square(px, sx)
1190   LOCAL p, s, w, h, x, y
1200   p = px
1210   s = sx
1215   PAPER #3, 6
1220   SELECT ON p
1230     ON p = 1
1240       SELECT ON s
1250         ON s = 2
1255           INK #3, 4
1260           AT #3, 6, 12 : PRINT #3, "++"
1270           AT #3, 7, 12 : PRINT #3, "++"
1280         ON s = 3
1285           INK #3, 5
1290           AT #3, 6, 9 : PRINT #3, "++"
1300           AT #3, 7, 9 : PRINT #3, "++"
1310         ON s = 4
1315           INK #3, 4
1320           AT #3, 6, 6 : PRINT #3, "++"
1330           AT #3, 7, 6 : PRINT #3, "++"
1340         ON s = 5
1350           w = 12 * 2 : h = 10 * 2 : x = 12 * 3 : y = 10 * 6 : BLOCK #3, w, h, x, y, 6
1360           board_draw_rosette 3, 6
1370         ON s = 6
1375           INK #3, 2
1380           AT #3, 9, 3 : PRINT #3, "++"
1390           AT #3, 10, 3 : PRINT #3, "++"
1400         ON s = 7
1405           INK #3, 5
1410           AT #3, 9, 6 : PRINT #3, "++"
1420           AT #3, 10, 6 : PRINT #3, "++"
1430         ON s = 8
1435           INK #3, 2
1440           AT #3, 9, 9 : PRINT #3, "++"
1450           AT #3, 10, 9 : PRINT #3, "++"
1460         ON s = 9
1470           w = 12 * 2 : h = 10 * 2 : x = 12 * 12 : y = 10 * 9 : BLOCK #3, w, h, x, y, 6
1480           board_draw_rosette 12, 9
1490         ON s = 10
1495           INK #3, 5
1500           AT #3, 9, 15 : PRINT #3, "++"
1510           AT #3, 10, 15 : PRINT #3, "++"
1520         ON s = 11
1525           INK #3,2
1530           AT #3, 9, 18 : PRINT #3, "++"
1540           AT #3, 10, 18 : PRINT #3, "++"
1550         ON s = 12
1555           INK #3, 4
1560           AT #3, 9, 21 : PRINT #3, "++"
1570           AT #3, 10, 21 : PRINT #3, "++"
1580         ON s = 13
1585           INK #3, 5
1590           AT #3, 9, 24 : PRINT #3, "++"
1600           AT #3, 10, 24 : PRINT #3, "++"
1610         ON s = 14
1615           INK #3, 4
1620           AT #3, 6, 24 : PRINT #3, "++"
1630           AT #3, 7, 24 : PRINT #3, "++"
1640         ON s = 15
1650           w = 12 * 2 : h = 10 * 2 : x = 12 * 21 : y = 10 * 6 : BLOCK #3, w, h, x, y, 6
1660           board_draw_rosette 21, 6
1670       END SELECT
1680     ON p = 2
1690       SELECT ON s
1700         ON s = 2
1705           INK #3, 4
1710           AT #3, 12, 12 : PRINT #3, "++"
1720           AT #3, 13, 12 : PRINT #3, "++"
1730         ON s = 3
1735           INK #3, 5
1740           AT #3, 12, 9 : PRINT #3, "++"
1750           AT #3, 13, 9 : PRINT #3, "++"
1760         ON s = 4
1765           INK #3, 4
1770           AT #3, 12, 6 : PRINT #3, "++"
1780           AT #3, 13, 6 : PRINT #3, "++"
1790         ON s = 5
1800           w = 12 * 2 : h = 10 * 2 : x = 12 * 3 : y = 10 * 12 : BLOCK #3, w, h, x, y, 6
1810           board_draw_rosette 3, 12
1820         ON s = 6
1825           INK #3, 2
1830           AT #3, 9, 3 : PRINT #3, "++"
1840           AT #3, 10, 3 : PRINT #3, "++"
1850         ON s = 7
1855           INK #3, 5
1860           AT #3, 9, 6 : PRINT #3, "++"
1870           AT #3, 10, 6 : PRINT #3, "++"
1880         ON s = 8
1885           INK #3, 2
1890           AT #3, 9, 9 : PRINT #3, "++"
1900           AT #3, 10, 9 : PRINT #3, "++"
1910         ON s = 9
1920           w = 12 * 2 : h = 10 * 2 : x = 12 * 12 : y = 10 * 9 : BLOCK #3, w, h, x, y, 6
1930           board_draw_rosette 12, 9
1940         ON s = 10
1945           INK #3, 5
1950           AT #3, 9, 15 : PRINT #3, "++"
1960           AT #3, 10, 15 : PRINT #3, "++"
1970         ON s = 11
1975           INK #3, 2
1980           AT #3, 9, 18 : PRINT #3, "++"
1990           AT #3, 10, 18 : PRINT #3, "++"
2000         ON s = 12
2005           INK #3, 4
2010           AT #3, 9, 21 : PRINT #3, "++"
2020           AT #3, 10, 21 : PRINT #3, "++"
2030         ON s = 13
2035           INK #3, 5
2040           AT #3, 9, 24 : PRINT #3, "++"
2050           AT #3, 10, 24 : PRINT #3, "++"
2060         ON s = 14
2065           INK #3, 4
2070           AT #3, 12, 24 : PRINT #3, "++"
2080           AT #3, 13, 24 : PRINT #3, "++"
2090         ON s = 15
2100           w = 12 * 2 : h = 10 * 2 : x = 12 * 21 : y = 10 * 12 : BLOCK #3, w, h, x, y, 6
2110           board_draw_rosette 21, 12
2120       END SELECT
2130   END SELECT
2135   PAPER #3, 1
2140 END DEF draw_square

2150 DEF PROC draw_all_squares
2160   player = 2
2170   FOR square = 2 TO 15
2180     draw_square player, square
2190   END FOR square
2200   player = 1
2210   FOR square = 2 TO 5
2220     draw_square player, square
2230   END FOR square
2240   FOR square = 14 TO 15
2250     draw_square player, square
2260   END FOR square
2270 END DEF draw_all_squares

2280 DEF PROC board_make_move
2290   LOCAL v, k, x, y
2295   BEEP 30, 100
2300   v = t((selected_move * 2) - 1)
2310   IF player = 1 AND v = 1 THEN draw_start_counters 1
2320   IF player = 2 AND v = 1 THEN draw_start_counters 2
2330   IF player = 1 AND v > 1 AND v < 16 THEN draw_square 1, v
2340   IF player = 2 AND v > 1 AND v < 16 THEN draw_square 2, v
2350   v = t(selected_move * 2)
2360   IF player = 1 AND v = 16 THEN draw_end_counters 1
2370   IF player = 2 AND v = 16 THEN draw_end_counters 2
2380   IF v >= 1 AND v <= 15 THEN
2390     IF v > 1 AND v <= 5 THEN x = 3 * (6 - v)
2400     IF v >= 6 AND v <= 13 THEN x = 3 * (v - 5)
2410     IF v >= 14 AND v <= 15 THEN x = 3 * (22 - v)
2420     y = 6
2430     IF v >= 6 AND v <= 13 THEN y = 9
2440     IF y = 6 AND player = 2 THEN y = 12
2450     board_draw_counter y, x, selected_move
2490   END IF
2495   BEEP 30, 100
2497   PAUSE 30
2500 END DEF board_make_move

2510 DEF PROC draw_start_counters(px)
2520   LOCAL localp
2530   localp = px
2540   SELECT ON localp
2550     ON localp = 1
2560       AT #3, 2, 6
2565       INK #3, 2 
2570       FOR i = 1 TO 7
2580         IF p(1, i) = 1 THEN PRINT #3, i;
2590       END FOR i
2600     ON localp = 2
2610       AT #3, 16, 6
2615       INK #3, 7 
2620       FOR i = 1 TO 7
2630         IF p(2, i) = 1 THEN PRINT #3, i;
2640       END FOR i
2650   END SELECT
2660   PRINT #3, " "
2670 END DEF draw_start_counters

2680 DEF PROC draw_end_counters
2690   LOCAL i
2700   SELECT ON player
2710     ON player = 1
2720       AT #3, 2, 20
2725       INK #3, 2 
2730       FOR i = 1 TO 7
2740         IF p(1, i) = 16 THEN PRINT #3, i;
2750       END FOR i
2760     ON player = 2
2770       AT #3, 16, 20
2775       INK #3, 7 
2780       FOR i = 1 TO 7
2790         IF p(2, i) = 16 THEN PRINT #3, i;
2800       END FOR i
2810   END SELECT
2820 END DEF draw_end_counters

2830 DEF PROC computer_move_selection
2840   LOCAL i, j, from_pos, to_pos, biggest
2850   PRINT #4, "Thinking .";
2860   FOR i = 1 TO 7
2870     w(i) = -1
2880     from_pos = t((i * 2) - 1)
2890     to_pos = t(i * 2)
2900     IF from_pos > -1 THEN
2910       w(i) = 0
2920       IF from_pos > 5 AND from_pos < 14 AND from_pos <> 9 THEN w(i) = w(i) + 30
2930       IF to_pos = 16 AND from_pos < 14 THEN w(i) = w(i) + 200
2940       IF to_pos = 16 AND from_pos >= 14 THEN w(i) = w(i) + 100
2950       IF to_pos = 15 THEN w(i) = w(i) + 50
2960       IF to_pos = 5 THEN w(i) = w(i) + 70
2970       IF to_pos = 14 THEN w(i) = w(i) + 40
2980       FOR j = 1 TO 7
2990         IF player = 1 AND from_pos > 5 AND p(2,j) >= (from_pos - 4) AND p(2, j) < from_pos THEN w(i) = w(i) + 20
3000         IF player = 2 AND from_pos > 5 AND p(1,j) >= (from_pos - 4) AND p(1, j) < from_pos THEN w(i) = w(i) + 20
3010         IF player = 1 AND w(i) > 20 AND to_pos > 5 AND p(2,j) > from_pos AND p(2, j) < to_pos THEN w(i) = w(i) - 20
3020         IF player = 2 AND w(i) > 20 AND to_pos > 5 AND p(1,j) > from_pos AND p(1, j) < to_pos THEN w(i) = w(i) - 20
3030       END FOR j
3040       FOR j = 1 TO 7
3050         IF to_pos > 5 AND to_pos < 14 AND p(1, j) = to_pos THEN w(i) = w(i) + 20
3060         IF to_pos > 5 AND to_pos < 14 AND p(2, j) = to_pos THEN w(i) = w(i) + 20
3070       END FOR j
3080       w(i) = w(i) + RND(5)
3090       PRINT #4, ".";
3100     END IF
3110   END FOR i
3120   PRINT #4, ""
3130   biggest = w(1)
3140   FOR i = 1 TO 7
3150     IF w(i) > biggest THEN biggest = w(i)
3160   END FOR i
3170   selected_move = 1
3180   FOR i = 1 TO 7
3190     IF w(i) = biggest THEN selected_move = i
3200   END FOR i
3210 END DEF computer_move_selection

3220 DEF PROC initialise_engine
3230   LOCAL i
3240   PRINT #4,"Initialising"
3250   b(1, 1) = 7
3260   b(2, 1) = 7
3270   FOR i = 2 TO 16
3280     b(1, i) = 0
3290     b(2, i) = 0
3300   END FOR i
3310   FOR i = 1 TO 7
3320     p(1, i) = 1
3330     p(2, i) = 1
3340   END FOR i
3350 END DEF initialise_engine

3360 DEF PROC roll_dice
3370   LOCAL i
3380   dice_roll = 0
3385   BEEP 10, 24
3386   PAUSE 2
3390   FOR i = 1 TO 4
3395     BEEP 10, 24
3396     PAUSE 2
3400     dice_roll = dice_roll + RND(1)
3410   END FOR i
3415   BEEP 10, 24
3417   PAUSE 20
3420 END DEF roll_dice

3430 DEF PROC get_possible_moves
3440   LOCAL i, j, o
3445   LET o = 0
3450   FOR i = 1 TO 14
3460     t(i) = -1
3470   END FOR i
3480   move_count = 0
3490   IF dice_roll = 0 THEN RETURN
3520   FOR i = 1 TO 7
3525     IF f(player) <> 2 OR p(player, i) <> 1 OR o <> 1 THEN 
3527       IF f(player) = 2 AND p(player, i) = 1 THEN LET o = 1
3530       IF p(player, i) < 16 AND p(player, i) + dice_roll <= 16 THEN 
3540         IF b(player, p(player, i) + dice_roll) = 0 OR p(player, i) + dice_roll = 16 THEN
3550           IF p(player, i) + dice_roll = 9 AND b(not_player, 9) > 0 THEN 
3560           ELSE
3570             j = (i * 2) - 1
3580             t(j) = p(player, i)
3590             t(j + 1) = p(player, i) + dice_roll
3600             move_count = move_count + 1
3605           END IF
3610         END IF
3620       END IF
3630     END IF
3640   END FOR i
3800 END DEF get_possible_moves

3810 DEF PROC engine_make_move
3820   LOCAL i, from_pos, to_pos
3830   from_pos = t((selected_move * 2) - 1)
3840   to_pos = t(selected_move * 2)
3870   p(player, selected_move) = to_pos
3880   b(player, from_pos) = b(player, from_pos) - 1
3890   b(player, to_pos) = b(player, to_pos) + 1
3900   IF b(not_player, to_pos) > 0 AND to_pos >= 6 AND to_pos <= 13 THEN
3910     b(not_player, to_pos) = b(not_player, to_pos) - 1
3920     b(not_player, 1) = b(not_player, 1) + 1
3930     FOR i = 1 TO 7
3940       IF p(not_player, i) = to_pos THEN
3950         p(not_player, i) = 1
3960       END IF
3970     END FOR i
3980     draw_start_counters not_player
3990   END IF
4150   throw_again = 0
4160   IF to_pos = 5 OR to_pos = 9 OR to_pos = 15 THEN throw_again = 1
4170 END DEF engine_make_move

4180 DEF FUNCTION detect_win
4190   IF b(player, 16) = 7 THEN RETURN 1
4210   RETURN 0
4220 END DEF detect_win

4230 DEF PROC initialise_program
4240   MODE 8
4250   PAPER #0, 0 : INK #0, 7 : CLS #0
4260   PAPER #1, 0 : INK #1, 7 : CLS #1
4270   PAPER #2, 0 : INK #2, 7 : CLS #2
4280   OPEN #3, scr_484x180a14x8
4290   PAPER #3, 1 : INK #3, 4
4300   CLS #3
4310   OPEN #4, con_484x60a14x192
4320   PAPER #4, 0 : INK #4, 7
4330   CLS #4
4340 END DEF initialise_program

4350 DEF PROC initialise_variables
4360   DIM b(2, 16) : REM board position population
4380   DIM p(2, 7) : REM counter positions p1 1=start 2-15=board 16=finished
4400   DIM t(14) : REM possible moves [from:to] for each, -1 if invalid
4410   DIM f(2) : REM player type 1 = human 2 = computer
4420   DIM w(7) : REM weight = move preference for computer players
4430   throw_again = 0
4440   player = 1
4445   not_player = 2
4450   move_count = 0
4460   selected_move = 0
4470   square = 0
4480 END DEF initialise_variables

4490 DEF PROC player_selection
4500   LOCAL l$
4510   f(1) = 1
4520   f(2) = 1
4530   REPEAT until_p1_choice_accepted
4540     INPUT #4, "Player 1 Human or Computer?" ! l$
4550     IF l$ = "H" OR l$ = "C" OR l$ = "h" OR l$ = "c" THEN EXIT until_p1_choice_accepted
4560   END REPEAT until_p1_choice_accepted
4570   IF l$ = "C" OR l$ = "c" THEN f(1) = 2
4580   REPEAT until_p2_choice_accepted
4590     INPUT #4, "Player 2 Human or Computer?" ! l$
4600     IF l$ = "H" OR l$ = "C" OR l$ = "h" OR l$ = "c" THEN EXIT until_p2_choice_accepted
4610   END REPEAT until_p2_choice_accepted
4620   IF l$ = "C" OR l$ = "c" THEN f(2) = 2
4630 END DEF player_selection

4640 DEF PROC reset
4650   MODE 4
4660   PAPER 0 : INK 7
4670   CLS
4680 END DEF reset

5000 DEF PROC board_draw_counter(y,x,c)
5001   LOCAL px, py
5010   IF player = 1 THEN INK #3, 2 : ELSE INK #3, 7
5020   px = (x + 1) * 8.9
5030   py = (17 - y) * 10
5040   FILL #3, 1
5050   CIRCLE #3, px, py, 9
5051   FILL #3, 0
5052   INK #3, 0
5053   CIRCLE #3, px, py, 1.2
5054   CIRCLE #3, px + 4, py - 4, 1.2
5055   CIRCLE #3, px + 4, py + 4, 1.2
5056   CIRCLE #3, px - 4, py - 4, 1.2
5070   OVER #3, 1
5080   AT #3, y, x : PRINT #3, c
5085   OVER #3, 0
5090 END DEF board_draw_counter

5100 DEF PROC board_draw_rosette(x,y)
5101   LOCAL px, py
5115   INK #3, 3
5116   px = ((x + 1) * 8.9) + 1
5117   py = ((18 - y) * 9.85) - 7
5130   CIRCLE #3, px + 3, py + 3, 3.7
5140   CIRCLE #3, px - 5, py + 3, 3.7
5150   CIRCLE #3, px + 3, py - 5, 3.7
5160   CIRCLE #3, px - 5, py - 5, 3.7
5190 END DEF board_draw_rosette
