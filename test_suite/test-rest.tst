\ Test the restraint processing 
\set time slow
\rele print CROUTPUT:
#LIST 1
REAL    4.9249  11.0348  15.3223  90.0000  90.0000  90.0000
END
#SPACE
SYM P 21 21 21
END
#LIST 3
READ NSCATTERERS=    4
SCAT TYPE= C         0.003300     0.001600     2.310000    20.843920
CONT                1.020000    10.207510     1.588600     0.568700
CONT                             0.865000    51.651249     0.215600
SCAT TYPE= H         0.000000     0.000000     0.493000    10.510910
CONT                0.322910    26.125731     0.140190     3.142360
CONT                             0.040810    57.799770     0.003040
SCAT TYPE= N         0.006100     0.003300    12.212610     0.005700
CONT                3.132200     9.893310     2.012500    28.997540
CONT                             1.166300     0.582600   -11.529010
SCAT TYPE= O         0.010600     0.006000     3.048500    13.277110
CONT                2.286800     5.701110     1.546300     0.323900
CONT                             0.867000    32.908939     0.250800
END
#LIST 4
SCHEME  9 NPARAM= 0 TYPE=1/2FO 
CONT WEIGHT=   2.0000000 MAX=  10000.0000 ROBUST=N
CONT DUNITZ=N TOLER=      6.0000 DS1=      1.0000
CONT DS2=      1.0000 QUASI=      0.2500
END
#
# Punched on 11/03/16 at 11:20:13
#
#LIST      5                                                                    
READ NATOM =     22, NLAYER =    0, NELEMENT =    0, NBATCH =    0
OVERALL    1.597815  0.050000  0.050000  1.000000 -0.272027         0.0000000
ATOM O             1.   1.000000         0.   0.022787   0.392382   0.816344
CON U[11]=   0.023165   0.048976   0.050752   0.002610   0.000711   0.001690
CON SPARE=       1.00          0   27262979          1                     0
ATOM C             2.   1.000000         0.   0.264040   0.383740   0.834406
CON U[11]=   0.031111   0.024769   0.032160  -0.003190  -0.000338   0.001515
CON SPARE=       1.00          0   27787267          1                     0
ATOM N             3.   1.000000         0.   0.459793   0.408987   0.776060
CON U[11]=   0.022122   0.036908   0.032528   0.002634  -0.003084   0.001358
CON SPARE=       1.00          0   25690115          1                     0
ATOM C             4.   1.000000         0.   0.396783   0.452845   0.690378
CON U[11]=   0.027880   0.031565   0.032000   0.003412   0.000903  -0.000984
CON SPARE=       1.00          0   25690115          1                     0
ATOM C             5.   1.000000         0.   0.263518   0.368848   0.628233
CON U[11]=   0.036678   0.031267   0.031052   0.003556   0.001187   0.002210
CON SPARE=       1.00          0   25165827          1                     0
ATOM O             6.   1.000000         0.   0.270916   0.253970   0.655054
CON U[11]=   0.062110   0.027582   0.036865   0.002381  -0.007355  -0.000883
CON SPARE=       1.00          0   25690115          1                     0
ATOM C             7.   1.000000         0.   0.143769   0.167191   0.596659
CON U[11]=   0.085196   0.037372   0.043648  -0.002112  -0.006427  -0.012855
CON SPARE=       1.00          0   25690115          1                     0
ATOM O             8.   1.000000         0.   0.165078   0.400843   0.559974
CON U[11]=   0.071291   0.038419   0.035651   0.005382  -0.013876  -0.000556
CON SPARE=       1.00          0   25165827          1                     0
ATOM C             9.   1.000000         0.   0.331339   0.586277   0.680106
CON U[11]=   0.040136   0.029209   0.045047   0.004976   0.000650  -0.004393
CON SPARE=       1.00          0   25165827          1                     0
ATOM C            10.   1.000000         0.   0.601360   0.540042   0.650835
CON U[11]=   0.034446   0.049134   0.049586   0.011722   0.005060  -0.009754
CON SPARE=       1.00          0   25165827          1                     0
ATOM C            11.   1.000000         0.   0.360778   0.347552   0.923654
CON U[11]=   0.045786   0.039787   0.031428  -0.001340  -0.000093   0.005476
CON SPARE=       1.00          0   25165827          1                     0
ATOM H            73.   1.000000         1.   0.136163   0.087136   0.633003
CON U[11]=   0.070760   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0     524290          0                     0
ATOM H            72.   1.000000         1.  -0.035024   0.192784   0.593789
CON U[11]=   0.071532   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0     524290          0                     0
ATOM H            71.   1.000000         1.   0.231813   0.163619   0.540773
CON U[11]=   0.082407   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25690114          0                     0
ATOM H            91.   1.000000         1.   0.298191   0.634751   0.735234
CON U[11]=   0.051704   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H            92.   1.000000         1.   0.182449   0.603075   0.635514
CON U[11]=   0.046401   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H           101.   1.000000         1.   0.800588   0.556211   0.685836
CON U[11]=   0.087570   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H           102.   1.000000         1.   0.627086   0.531419   0.585334
CON U[11]=   0.047074   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H           113.   1.000000         1.   0.548422   0.329671   0.925729
CON U[11]=   0.064825   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H           112.   1.000000         1.   0.320041   0.411907   0.962281
CON U[11]=   0.085151   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H           111.   1.000000         1.   0.220924   0.273460   0.938925
CON U[11]=   0.091012   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25165826          0                     0
ATOM H            31.   1.000000         1.   0.627608   0.398644   0.789716
CON U[11]=   0.037649   0.000000   0.000000   0.000000   0.000000   0.000000
CON SPARE=       1.00          0   25690114          0                     0
END                                                                             
#LIST 13
CRYST FRIEDELPAIRS=N TWINNED=N SPREAD=GAUSSIA
DIFFRACTION GEOMETRY=UNKNOWN  RADIATION=XRAYS 
CONDI WAVEL= 0.71073  0.000  0.000  0.5869359  0.6427007  0.0001788 90.000
MATR    0.000000000    0.000000000    0.000000000
CONT    0.000000000    0.000000000    0.000000000
CONT    0.000000000    0.000000000    0.000000000
END
#LIST 23
MODIFY ANOM=Y EXTI=N LAYER=N BATCH=N
CONT  PARTI=N UPDA=N ENANT=Y
MINIMI NSING=    0 F-SQ=Y RESTR=Y REFLEC=Y
ALLCYCLES U[MIN]=        0.00000000
CONT       MIN-R=  0.000000       MAX-R=   100.000
CONT      MIN-WR=  0.000000      MAX-WR=   100.000
CONT   MIN-SUMSQ=  0.030000   MAX-SUMSQ= 10000.000
CONT MIN-MINFUNC=  0.000000 MAX-MINFUNC= 999999986991104.000
INTERCYCLE  MIN-DR= -5.000000       MAX-DR=   100.000
CONT       MIN-DWR= -5.000000      MAX-DWR=   100.000
CONT    MIN-DSUMSQ=-10.000000   MAX-DSUMSQ= 10000.000
CONT  MIN-DMINFUNC=  0.000000 MAX-DMINFUNC= 999999986991104.000
REFINE  SPEC=CONSTRAIN  UPDATE=PARAMETERS  TOL=   0.60000
END
#LIST 28
READ NSLICE=     0 NOMIS=     0 NCOND=     0
MINIMA 
CONT    SINTH/L**2  =   0.01000
CONT    RATIO       =   2.00000
END
#LIST 39
OVERALL         0.00000000        0.00000000        0.00000000        0.00000000
CONT            0.00000000        0.00000000        0.00000000        0.00000000
CONT            0.00000000        0.00000000        0.00000000        0.00000000
READ NINT=     2 NREAL=     1
INT  INFO       0           0           0           0           0           0
CONT                      113           0           1           0           0
INT  OVER       1           1           0           0           0           0
CONT                        0           0           0           0           0
REAL SFLS      0.   1.000000    0.000000    0.000000    0.000000    0.000000
CONT                0.000000    0.000000    0.000000    0.000000    0.000000
END
#
# Punched on 11/03/16 at 11:22:47
#
#LIST     40                                                                    
DEFAULTS TOLTYPE= 1 TOLERANCE= 1.210 MAXBONDS =  12
READ NELEM=    0 NPAIR=    0 NMAKE=    0 NBREAK=    0
END                                                                             
#
# Punched on 11/03/16 at 11:23:09
#
#LIST      6                                                                    
READ NCOEFFICIENT =     5, TYPE = COMPRESSED, UNIT = DATAFILE
INPUT  H  K  L  /FO/  RATIO
MULTIPLIERS  1.0  1.0  1.0       12.465121269     16.281723022
END                                                                             
0 0 2 494 547 4 103 284 6 37 35 512 1 0 2 19 47 3 -12 -16 4 15 20 5 122 430 6 35
47 512 2 0 0 108 79 1 85 635 2 511 753 3 99 544 4 171 570 5 73 231 6 -32 -36 512
3 0 1 671 957 2 71 523 3 123 723 4 254 768 5 84 335 6 27 26 512 4 0 1 374 688 2 
30 105 3 285 780 4 174 649 5 35 55 6 58 81 512 5 0 1 905 722 2 292 844 3 62 255 
4 152 491 5 118 208 512 6 0 0 874 396 1 165 635 2 52 283 3 104 439 4 178 498 5 
-16 -11 512 7 0 1 32 104 2 254 728 3 149 540 4 56 162 5 39 47 512 8 0 0 352 343 
1 200 666 2 310 736 3 210 417 4 256 483 5 25 20 512 9 0 1 330 546 2 294 729 3 97
235 4 113 182 512 10 0 0 11 6 1 106 344 2 118 396 3 87 135 4 112 179 512 11 0 1 
25 30 2 12 12 3 80 116 4 41 38 512 12 0 0 84 133 1 93 224 2 16 13 3 62 74 512 13
0 1 12 7 2 106 188 512 14 0 0 173 168 1 12 5 512 
0 1 1 559 367 2 579 785 3 379 767 4 75 328 5 81 290 6 58 116 512 1 1 -6 38 55 -5
178 491 -4 68 256 -3 140 530 -2 485 763 2 484 784 3 139 658 4 72 306 5 181 476 6
24 19 512 2 1 -6 51 78 -5 124 396 -4 299 641 -3 80 452 -2 317 841 -1 509 900 0 
736 192 1 507 828 2 321 805 3 81 434 4 301 696 5 126 409 6 44 66 512 3 1 -6 22 
19 -5 214 541 -4 131 622 -3 392 758 -2 199 767 -1 297 816 0 422 542 1 295 896 2 
200 763 3 387 912 4 135 661 5 211 612 6 11 5 512 4 1 -6 34 29 -5 80 201 -4 132 
633 -3 154 733 -2 448 846 -1 442 671 0 358 399 1 443 874 2 446 746 3 158 636 4 
131 562 5 77 217 6 12 5 512 5 1 -5 35 45 -4 37 108 -3 236 672 -2 97 491 -1 195 
644 0 72 323 1 191 661 2 97 617 3 232 712 4 36 103 5 40 69 512 6 1 -5 28 30 -4 
170 529 -3 152 578 -2 133 662 -1 181 660 0 548 552 1 178 642 2 132 699 3 150 500
4 172 461 5 38 58 512 7 1 -5 204 315 -4 65 175 -3 221 602 -2 185 643 -1 184 585 
0 123 394 1 189 561 2 190 701 3 220 619 4 66 170 5 205 266 512 8 1 -5 92 176 -4 
112 287 -3 93 333 -2 156 554 -1 184 473 0 279 479 1 184 562 2 157 612 3 94 265 4
110 333 5 92 172 512 9 1 -4 99 149 -3 138 331 -2 120 519 -1 306 461 0 29 48 1 
315 566 2 118 428 3 142 377 4 107 161 512 10 1 -4 66 85 -3 28 20 -2 157 389 -1 
160 440 0 220 369 1 166 445 2 158 372 3 36 51 4 60 71 512 11 1 -4 50 47 -3 25 21
-2 28 64 -1 18 20 0 65 152 1 18 22 2 30 66 3 -15 -9 4 54 51 512 12 1 -3 58 68 -2
75 163 -1 21 21 0 35 54 1 16 9 2 71 182 3 42 67 512 13 1 -2 62 129 -1 50 95 0 47
65 1 49 81 2 55 92 512 14 1 -1 32 37 0 58 83 1 46 71 512 
0 2 1 942 367 2 414 813 3 351 728 4 212 655 5 93 292 6 44 63 512 1 2 -6 55 92 -5
144 352 -4 229 676 -3 326 628 -2 369 825 -1 412 647 0 -6 -7 1 412 797 2 368 783 
3 323 751 4 225 674 5 152 438 6 59 112 512 2 2 -6 4 1 -5 106 338 -4 189 624 -3 
107 496 -2 282 769 -1 423 867 0 615 428 1 424 898 2 283 758 3 111 588 4 185 611 
5 107 343 6 22 15 512 3 2 -6 25 22 -5 76 304 -4 175 733 -3 404 855 -2 296 889 -1
214 802 0 999 729 1 218 870 2 291 864 3 401 841 4 180 758 5 77 230 6 24 14 512 4
2 -6 55 81 -5 125 428 -4 244 648 -3 67 393 -2 329 778 -1 343 731 0 73 327 1 347 
902 2 328 814 3 68 325 4 246 653 5 117 376 6 55 78 512 5 2 -5 126 299 -4 168 566
-3 177 670 -2 344 756 -1 101 507 0 45 179 1 100 649 2 349 932 3 175 656 4 168 
550 5 124 348 512 6 2 -5 111 251 -4 61 185 -3 93 324 -2 310 824 -1 385 674 0 604
550 1 387 647 2 313 836 3 97 429 4 69 219 5 116 246 512 7 2 -5 -24 -21 -4 135 
322 -3 121 480 -2 58 293 -1 165 583 0 289 534 1 166 668 2 56 236 3 122 490 4 137
395 5 -24 -20 512 8 2 -5 15 8 -4 123 228 -3 140 422 -2 238 705 -1 146 381 0 72 
248 1 144 603 2 234 629 3 146 373 4 119 276 5 33 40 512 9 2 -4 80 121 -3 68 107 
-2 145 522 -1 60 178 0 -7 -2 1 63 211 2 140 529 3 70 179 4 82 134 512 10 2 -4 67
92 -3 140 220 -2 105 341 -1 76 275 0 44 102 1 79 262 2 103 399 3 130 317 4 61 62
512 11 2 -4 48 48 -3 37 41 -2 44 118 -1 59 126 0 131 325 1 63 181 2 56 173 3 42 
49 4 39 40 512 12 2 -3 60 75 -2 22 20 -1 143 310 0 33 59 1 139 270 2 21 25 3 48 
70 512 13 2 -2 46 66 -1 56 96 0 19 18 1 63 114 2 46 73 512 14 2 -1 20 13 0 58 94
1 18 11 512 
0 3 1 450 663 2 386 762 3 88 475 4 120 535 5 25 32 6 10 4 512 1 3 -6 59 100 -5 
114 333 -4 79 345 -3 206 707 -2 519 774 0 184 668 2 514 798 3 204 749 4 81 363 5
117 380 6 57 111 512 2 3 -6 11 5 -5 65 170 -4 88 387 -3 55 228 -2 609 704 -1 379
918 0 132 424 1 377 778 2 600 812 3 55 265 4 86 352 5 64 192 6 0 0 512 3 3 -6 67
114 -5 174 556 -4 212 675 -3 152 636 -2 393 848 -1 350 601 1 357 777 2 385 877 3
149 687 4 214 716 5 172 451 6 58 91 512 4 3 -6 33 28 -5 37 72 -4 49 183 -3 192 
774 -2 276 839 -1 250 660 0 170 548 1 250 935 2 282 707 3 195 721 4 50 167 5 21 
28 6 -7 -2 512 5 3 -5 87 229 -4 89 435 -3 57 227 -2 292 765 -1 379 678 0 230 578
1 383 766 2 290 774 3 55 223 4 93 337 5 79 220 512 6 3 -5 46 69 -4 125 379 -3 
154 593 -2 280 789 -1 441 699 0 352 596 1 446 738 2 282 781 3 157 599 4 126 371 
5 53 100 512 7 3 -5 47 83 -4 35 69 -3 156 544 -2 305 761 -1 131 487 0 300 604 1 
131 579 2 306 728 3 155 589 4 30 56 5 41 54 512 8 3 -5 24 12 -4 92 211 -3 108 
330 -2 148 449 -1 324 567 0 51 158 1 321 658 2 145 567 3 103 278 4 90 250 5 19 
14 512 9 3 -4 82 113 -3 73 122 -2 184 432 -1 89 298 0 365 460 1 85 346 2 181 507
3 72 188 4 73 111 512 10 3 -4 47 50 -3 71 120 -2 38 41 -1 148 387 0 102 310 1 
152 405 2 27 65 3 60 128 4 44 50 512 11 3 -3 -8 -1 -2 94 212 -1 72 192 0 261 385
1 60 177 2 84 224 3 59 65 512 12 3 -2 58 91 -1 149 291 0 54 120 1 154 334 2 47 
91 3 -10 -4 512 13 3 -2 61 95 -1 70 146 0 77 160 1 73 129 2 71 134 512 14 3 0 
-21 -18 512 
0 4 1 35 330 2 650 758 3 86 457 4 37 104 5 189 498 6 76 150 512 1 4 -6 38 55 -5 
0 0 -4 358 670 -3 344 736 -2 224 782 -1 568 700 0 10 38 1 552 658 2 221 787 3 
337 796 4 359 590 5 9 5 6 41 61 512 2 4 -6 47 49 -5 86 237 -4 133 542 -3 282 796
-2 367 903 -1 333 943 0 352 726 1 336 778 2 359 824 3 282 717 4 134 551 5 82 249
6 52 76 512 3 4 -6 55 52 -5 57 169 -4 94 463 -3 110 609 -2 144 780 -1 387 777 0 
142 378 1 394 895 2 143 612 3 112 576 4 99 412 5 60 164 6 78 96 512 4 4 -6 54 62
-5 173 543 -4 96 479 -3 89 517 -2 268 889 -1 687 656 0 22 74 1 699 905 2 268 708
3 85 398 4 90 343 5 172 444 6 62 105 512 5 4 -5 28 38 -4 140 588 -3 106 532 -2 
163 665 -1 274 697 0 871 598 1 275 747 2 162 706 3 108 509 4 130 464 5 30 41 512
6 4 -5 65 118 -4 50 130 -3 171 625 -2 205 609 -1 105 373 0 87 377 1 106 615 2 
205 747 3 171 568 4 48 127 5 63 122 512 7 4 -5 101 142 -4 118 338 -3 95 336 -2 
61 229 -1 113 421 0 10 8 1 116 642 2 67 298 3 93 366 4 121 352 5 100 204 512 8 4
-5 25 15 -4 134 205 -3 35 45 -2 236 563 -1 111 359 0 229 555 1 113 533 2 233 611
3 47 97 4 132 381 5 35 39 512 9 4 -4 18 7 -3 61 82 -2 153 451 -1 169 452 0 517 
589 1 171 640 2 149 527 3 60 143 4 16 6 512 10 4 -4 39 30 -3 41 55 -2 110 188 -1
219 371 0 212 394 1 219 519 2 110 371 3 46 76 4 12 4 512 11 4 -3 98 130 -1 92 
248 0 181 329 1 88 271 2 77 250 3 98 206 512 12 4 -3 90 115 -2 35 47 -1 94 235 0
21 27 1 80 226 2 38 67 3 93 168 512 13 4 -2 88 154 -1 15 9 0 124 216 1 22 21 2 
81 142 512 14 4 0 38 39 512 
0 5 1 9 20 2 666 628 3 484 773 4 49 167 5 32 57 6 88 107 512 1 5 -6 42 30 -5 157
355 -4 271 612 -3 291 732 -2 68 373 -1 438 874 0 750 718 1 437 794 2 69 495 3 
288 712 4 271 665 5 152 412 6 44 32 512 2 5 -6 58 64 -5 199 490 -4 258 641 -3 
151 649 -2 202 876 -1 237 980 0 372 776 1 240 777 2 201 728 3 147 709 4 259 683 
5 204 490 6 77 111 512 3 5 -6 68 78 -5 77 269 -4 216 633 -3 98 527 -2 30 135 -1 
365 785 0 909 539 1 367 916 2 34 149 3 100 521 4 214 500 5 76 221 6 48 49 512 4 
5 -5 36 67 -4 57 224 -3 163 710 -2 175 842 -1 384 696 0 465 816 1 384 929 2 171 
685 3 163 660 4 53 154 5 42 68 512 5 5 -5 66 162 -4 193 568 -3 105 527 -2 203 
654 -1 296 496 0 299 536 1 301 785 2 204 674 3 110 485 4 194 531 5 65 143 512 6 
5 -5 95 149 -4 125 364 -3 280 680 -2 83 361 -1 262 548 0 150 522 1 262 827 2 81 
456 3 276 653 4 127 414 5 89 192 512 7 5 -5 85 111 -4 78 225 -3 277 538 -2 147 
484 -1 110 398 0 473 601 1 119 598 2 146 590 3 288 589 4 81 237 5 75 132 512 8 5
-5 47 35 -4 33 32 -3 166 367 -2 85 314 -1 274 526 0 87 357 1 276 726 2 86 356 3 
165 392 4 39 63 5 69 103 512 9 5 -4 98 156 -3 86 179 -2 132 301 -1 335 460 0 249
552 1 338 692 2 138 463 3 81 194 4 111 156 512 10 5 -4 108 127 -3 122 237 -2 133
225 -1 85 251 0 200 417 1 87 304 2 128 402 3 120 198 4 104 128 512 11 5 -3 26 21
-1 73 176 0 93 229 1 72 215 2 60 142 3 36 53 512 12 5 -3 61 76 -2 39 63 -1 87 
184 0 46 107 1 84 202 2 46 80 3 42 60 512 13 5 -2 57 71 -1 63 108 0 114 205 1 52
91 2 54 93 512 
0 6 0 530 626 1 109 692 2 226 838 3 158 669 4 209 638 5 196 463 6 72 91 512 1 6 
-6 -12 -4 -5 71 182 -4 213 572 -3 209 686 -2 276 704 -1 163 999 0 191 885 1 167 
667 2 270 805 3 211 699 4 210 550 5 71 205 6 29 22 512 2 6 -6 40 34 -5 60 197 -4
196 581 -3 125 678 -2 397 799 -1 687 939 0 224 632 1 680 695 2 395 700 3 126 723
4 196 696 5 57 110 6 35 27 512 3 6 -5 97 316 -4 93 430 -3 140 687 -2 25 109 -1 
125 748 0 226 755 1 128 858 2 24 77 3 139 610 4 91 324 5 97 225 512 4 6 -5 113 
333 -4 174 578 -3 210 722 -2 132 702 -1 23 54 0 341 811 1 26 143 2 130 610 3 210
731 4 174 497 5 112 263 512 5 6 -5 88 186 -4 151 459 -3 113 540 -2 298 620 -1 88
349 0 131 643 1 92 596 2 295 734 3 112 488 4 148 458 5 99 230 512 6 6 -5 101 133
-4 40 101 -3 100 403 -2 233 618 -1 129 425 0 525 625 1 134 670 2 231 737 3 97 
339 4 47 106 5 104 225 512 7 6 -5 95 125 -4 143 323 -3 175 412 -2 172 527 -1 225
477 0 126 378 1 226 745 2 178 543 3 176 498 4 144 345 5 73 139 512 8 6 -4 170 
196 -3 176 377 -2 157 439 -1 147 380 0 211 577 1 150 588 2 161 605 3 176 406 4 
175 328 512 9 6 -4 18 10 -3 79 173 -2 99 207 -1 153 371 0 119 412 1 149 570 2 
100 392 3 77 186 4 45 38 512 10 6 -4 20 10 -3 156 204 -2 45 67 -1 117 311 0 40 
89 1 118 426 2 32 73 3 158 288 4 7 1 512 11 6 -3 10 3 -2 155 266 -1 22 27 0 62 
151 1 17 21 2 141 326 3 34 51 512 12 6 -2 57 111 -1 21 17 0 114 234 1 32 47 2 59
92 512 13 6 -1 54 98 0 -13 -8 1 44 66 512 
0 7 1 65 369 2 253 729 3 352 740 4 112 424 5 119 301 512 1 7 -5 76 191 -4 142 
500 -3 101 506 -2 82 507 -1 417 868 0 446 917 1 412 678 2 80 617 3 100 585 4 136
538 5 73 176 512 2 7 -5 97 218 -4 70 258 -3 142 724 -2 224 764 -1 85 624 0 459 
781 1 82 474 2 219 699 3 139 749 4 69 336 5 84 204 512 3 7 -5 28 29 -4 72 298 -3
132 608 -2 443 734 -1 78 491 0 306 855 1 77 568 2 439 770 3 132 625 4 78 287 5 
37 56 512 4 7 -5 85 173 -4 59 203 -3 153 682 -2 255 749 -1 384 585 0 17 49 1 386
836 2 249 766 3 155 664 4 57 153 5 80 172 512 5 7 -5 12 7 -4 188 598 -3 45 194 
-2 120 419 -1 319 560 0 86 484 1 325 864 2 121 564 3 42 140 4 184 575 5 20 17 
512 6 7 -5 18 6 -4 91 289 -3 140 350 -2 51 308 -1 119 413 0 84 410 1 116 638 2 
50 217 3 137 438 4 89 305 5 24 13 512 7 7 -5 59 75 -4 55 108 -3 132 318 -2 139 
616 -1 163 465 0 269 710 1 158 685 2 138 620 3 129 343 4 59 103 5 56 68 512 8 7 
-4 93 155 -3 26 32 -2 82 185 -1 261 445 0 23 46 1 256 676 2 78 335 3 24 30 4 94 
207 512 9 7 -4 72 100 -3 28 36 -2 204 284 -1 98 295 0 112 300 1 91 350 2 199 545
3 32 28 4 69 81 512 10 7 -3 37 40 -2 31 34 -1 141 293 0 90 252 1 134 389 2 41 99
3 43 80 512 11 7 -3 36 31 -2 97 134 -1 89 209 0 142 297 1 87 215 2 89 190 3 35 
55 512 12 7 -2 115 197 -1 88 177 0 75 145 1 80 151 2 119 200 512 13 7 -1 12 7 0 
12 7 1 36 45 512 
0 8 0 866 487 1 136 775 2 89 645 3 85 536 4 119 499 5 18 9 512 1 8 -5 72 102 -4 
91 379 -3 219 707 -2 178 874 -1 510 883 0 416 792 1 508 606 2 175 806 3 218 819 
4 88 403 5 68 100 512 2 8 -5 155 377 -4 153 521 -3 76 428 -2 69 387 -1 421 859 0
303 668 1 411 722 2 74 437 3 70 340 4 154 487 5 153 207 512 3 8 -5 44 64 -4 77 
307 -3 200 677 -2 177 785 -1 91 619 0 168 613 1 93 502 2 175 709 3 200 733 4 73 
267 5 44 42 512 4 8 -5 107 206 -4 113 418 -3 245 697 -2 121 586 -1 251 759 0 346
713 1 253 788 2 117 532 3 244 703 4 109 368 5 112 177 512 5 8 -5 90 181 -4 55 
185 -3 90 405 -2 127 485 -1 250 568 0 27 94 1 248 819 2 125 569 3 93 361 4 53 
171 5 81 116 512 6 8 -5 38 24 -4 31 39 -3 16 16 -2 65 364 -1 345 569 0 299 630 1
344 780 2 68 345 3 16 19 4 31 42 5 39 24 512 7 8 -4 76 101 -3 92 211 -2 241 495 
-1 183 455 0 78 379 1 186 695 2 244 621 3 96 344 4 77 185 512 8 8 -4 69 104 -3 
86 228 -2 89 254 -1 295 336 0 41 105 1 294 735 2 87 357 3 95 170 4 73 138 512 9 
8 -4 11 3 -3 99 144 -2 145 244 -1 73 193 0 129 385 1 76 285 2 140 470 3 105 259 
4 32 21 512 10 8 -3 108 159 -2 75 122 -1 61 144 0 104 276 1 67 202 2 78 199 3 
116 168 512 11 8 -3 128 174 -2 65 136 -1 97 228 0 42 82 1 100 239 2 68 136 3 113
197 512 12 8 -2 72 114 -1 146 257 0 33 60 1 144 251 2 80 151 512 13 8 0 102 159 
512 
0 9 1 134 648 2 -12 -27 3 148 587 4 133 515 5 99 141 512 1 9 -5 68 118 -4 8 7 -3
290 766 -2 221 870 -1 245 871 0 9 20 1 246 784 2 220 725 3 289 795 4 -7 -5 5 60 
82 512 2 9 -5 44 59 -4 99 408 -3 228 707 -2 289 839 -1 39 195 0 197 616 1 37 181
2 285 439 3 226 630 4 97 351 5 23 15 512 3 9 -4 131 486 -3 171 567 -2 246 731 -1
149 780 0 182 808 1 151 661 2 244 619 3 171 640 4 130 402 5 20 10 512 4 9 -5 42 
48 -4 149 439 -3 166 542 -2 96 463 -1 103 525 0 224 686 1 104 535 2 102 498 3 
163 602 4 142 339 5 52 44 512 5 9 -5 47 68 -4 119 328 -3 164 429 -2 179 540 -1 
215 622 0 336 800 1 216 689 2 177 717 3 169 433 4 123 295 5 45 42 512 6 9 -4 59 
82 -3 79 220 -2 97 408 -1 167 533 0 83 453 1 167 637 2 98 479 3 80 290 4 64 144 
5 51 55 512 7 9 -4 71 90 -3 67 172 -2 20 51 -1 237 441 0 187 478 1 245 678 2 7 5
3 73 185 4 76 172 512 8 9 -3 25 27 -2 55 201 -1 82 182 0 88 328 1 76 352 2 54 
222 3 7 3 4 110 149 512 9 9 -4 27 18 -3 96 145 -2 171 426 -1 65 160 0 68 174 1 
61 216 2 169 385 3 99 219 512 10 9 -3 46 43 -2 73 121 -1 105 252 0 49 122 1 107 
266 2 64 145 3 46 77 512 11 9 -2 72 133 -1 50 83 0 50 97 1 45 98 2 68 143 512 12
9 -1 20 13 0 -22 -22 1 0 0 512 
0 10 0 227 525 1 57 281 2 355 756 3 179 688 4 89 311 5 39 33 512 1 10 -5 12 6 -4
132 458 -3 327 709 -2 132 698 -1 99 643 0 75 531 1 99 601 2 128 640 3 329 712 4 
135 445 5 -8 -1 512 2 10 -5 85 169 -4 228 530 -3 181 761 -2 164 718 -1 138 663 0
137 933 1 141 693 2 161 737 3 178 626 4 229 451 5 85 116 512 3 10 -4 53 115 -3 
298 597 -2 123 529 -1 307 769 0 379 775 1 303 703 2 119 597 3 294 663 4 52 70 5 
9 2 512 4 10 -5 103 183 -4 123 312 -3 137 435 -2 60 251 -1 226 716 0 118 582 1 
221 837 2 61 391 3 135 453 4 115 180 5 112 150 512 5 10 -5 24 22 -4 127 353 -3 
72 236 -2 72 290 -1 156 670 0 73 395 1 155 696 2 72 393 3 75 294 4 121 223 5 17 
6 512 6 10 -4 65 84 -3 48 94 -2 197 459 -1 253 527 0 235 589 1 256 755 2 203 529
3 48 106 4 78 97 512 7 10 -4 20 13 -3 147 334 -2 97 342 -1 94 287 0 398 536 1 
101 491 2 93 351 3 146 415 4 10 3 512 8 10 -4 93 122 -3 47 72 -2 150 402 -1 192 
410 0 218 478 1 191 517 2 150 381 3 35 69 4 100 133 512 9 10 -3 81 128 -2 30 30 
-1 110 280 0 40 88 1 109 367 2 39 66 3 78 127 512 10 10 -3 38 40 -1 57 136 0 10 
5 1 57 123 2 -30 -23 3 34 34 512 11 10 -2 44 59 -1 62 125 0 141 273 1 69 156 2 
45 83 512 12 10 -1 113 162 0 -23 -19 1 117 173 512 
0 11 1 51 244 2 183 748 3 39 175 4 142 231 5 6 1 512 1 11 -5 39 58 -4 85 185 -3 
90 473 -2 228 735 -1 439 727 0 217 735 1 436 797 2 229 622 3 82 274 4 92 143 5 
43 39 512 2 11 -5 25 22 -4 20 23 -3 130 552 -2 280 686 -1 339 840 0 187 588 1 
339 749 2 284 654 3 128 363 4 -13 -6 5 46 39 512 3 11 -5 50 64 -4 58 133 -3 66 
257 -2 182 618 -1 72 420 0 145 664 1 74 414 2 181 508 3 66 220 4 56 95 5 42 43 
512 4 11 -5 27 20 -4 83 186 -3 91 350 -2 76 288 -1 28 75 0 156 658 1 32 104 2 74
291 3 92 276 4 83 137 5 -18 -8 512 5 11 -4 26 24 -3 97 320 -2 68 204 -1 260 646 
0 161 511 1 261 812 2 63 417 3 97 352 4 26 22 512 6 11 -4 65 96 -3 66 128 -2 197
486 -1 214 650 0 179 588 1 213 632 2 196 485 3 67 245 4 56 67 512 7 11 -4 6 1 -3
96 179 -2 115 396 -1 226 368 0 323 543 1 228 632 2 115 354 3 100 206 4 20 8 512 
8 11 -3 48 53 -2 76 265 -1 18 17 0 101 299 1 27 53 2 83 157 3 27 34 512 9 11 -3 
60 83 -2 18 11 -1 70 176 0 31 56 1 73 202 2 14 12 3 59 110 512 10 11 -1 64 150 0
4 1 1 67 178 2 75 132 512 11 11 -2 13 6 -1 80 170 0 48 87 1 79 165 2 0 0 512 
0 12 0 241 544 1 14 20 2 80 320 3 241 691 4 20 17 5 27 19 512 1 12 -5 27 21 -4 
47 69 -3 93 411 -2 39 147 -1 166 670 0 62 290 1 165 470 2 36 169 3 97 447 4 33 
27 5 39 29 512 2 12 -5 33 31 -4 71 156 -3 90 356 -2 208 574 -1 146 658 0 114 486
1 148 792 2 210 549 3 90 218 4 66 118 5 6 1 512 3 12 -4 18 20 -3 71 281 -2 28 57
-1 345 723 0 131 595 1 343 532 2 28 65 3 72 300 4 20 14 512 4 12 -4 91 202 -3 79
310 -2 58 232 -1 167 560 0 26 117 1 165 531 2 61 227 3 79 271 4 99 141 512 5 12 
-4 23 19 -3 7 3 -2 45 91 -1 88 370 0 28 100 1 88 356 2 38 84 3 19 33 4 -17 -10 
512 6 12 -4 57 76 -3 72 114 -2 94 307 -1 152 463 0 30 93 1 151 497 2 97 307 3 74
125 4 65 96 512 7 12 -4 -25 -12 -3 120 177 -2 26 46 -1 70 232 0 77 237 1 65 300 
2 28 69 3 117 169 4 32 24 512 8 12 -3 31 29 -2 25 28 -1 164 323 0 19 31 1 161 
320 2 21 38 3 35 64 512 9 12 -3 56 81 -1 48 65 0 85 197 1 39 89 2 50 115 3 49 86
512 10 12 -2 -4 -1 -1 35 63 0 43 90 1 35 66 2 19 16 512 11 12 -1 55 96 0 15 14 1
57 84 512 
0 13 1 92 426 2 296 457 3 139 362 4 83 185 512 1 13 -4 107 216 -3 9 6 -2 125 493
-1 226 476 0 39 233 1 225 461 2 125 409 3 19 22 4 98 135 512 2 13 -4 77 133 -3 
100 301 -2 187 549 -1 114 571 0 232 563 1 118 629 2 180 303 3 101 204 4 71 102 
512 3 13 -4 45 66 -3 33 61 -2 94 371 -1 169 696 0 274 584 1 168 571 2 96 437 3 
37 54 4 49 58 512 4 13 -4 33 37 -3 103 306 -2 83 291 -1 49 210 0 23 52 1 50 220 
2 87 341 3 102 168 4 32 20 512 5 13 -4 122 212 -3 57 111 -2 211 247 -1 158 510 0
110 550 1 160 393 2 206 268 3 47 72 4 126 169 512 6 13 -4 75 84 -3 177 283 -2 46
74 -1 96 332 0 44 157 1 103 201 3 162 202 4 73 91 512 7 13 -3 30 22 -2 16 21 -1 
81 256 1 78 399 2 18 41 3 46 110 512 8 13 -3 33 36 -2 42 59 -1 81 244 0 31 84 1 
81 179 512 9 13 -2 -17 -8 -1 35 71 0 60 146 1 41 82 2 24 32 512 10 13 -1 50 70 0
95 143 1 34 50 512 
0 14 0 65 114 1 211 440 2 19 34 3 43 69 4 37 38 512 1 14 -4 26 24 -3 24 39 -2 
162 442 -1 102 378 0 287 639 1 104 324 2 158 414 3 8 3 4 24 21 512 2 14 -4 63 
112 -3 50 139 -2 65 247 -1 222 544 0 60 190 1 220 684 2 64 266 3 55 96 4 57 81 
512 3 14 -4 45 66 -3 94 273 -2 123 390 -1 177 608 0 181 475 1 178 585 2 126 386 
3 91 146 4 62 68 512 4 14 -4 70 118 -3 163 287 -2 25 42 -1 257 473 0 55 185 1 
253 417 2 28 55 4 85 109 512 5 14 -3 59 106 -2 110 213 -1 41 118 0 179 428 1 33 
85 2 104 161 3 67 116 512 6 14 -3 67 104 -2 -17 -18 -1 109 344 0 16 43 1 107 195
512 7 14 -3 119 182 -2 103 204 -1 79 270 0 67 202 512 8 14 -2 58 88 -1 87 213 1 
91 197 512 9 14 -2 62 80 -1 30 30 0 24 29 512 10 14 0 36 44 512 
0 15 1 168 333 2 24 46 3 45 73 4 42 47 512 1 15 -3 72 148 -2 56 56 -1 88 312 0 
57 337 1 83 217 2 46 118 3 76 176 4 54 69 512 2 15 -4 51 54 -3 79 224 -2 26 43 
-1 221 470 0 52 179 1 232 261 2 10 7 3 84 173 4 36 37 512 3 15 -3 93 208 -2 164 
358 -1 113 359 0 306 345 1 116 255 2 163 427 3 96 157 512 4 15 -3 66 137 -2 41 
80 -1 117 388 0 65 172 1 115 292 3 75 121 512 5 15 -3 67 102 -2 103 234 -1 55 
160 0 35 42 1 52 101 3 73 115 512 6 15 -3 124 174 -2 41 62 -1 111 182 0 29 23 
512 7 15 -2 69 115 -1 34 63 0 139 202 512 8 15 -2 20 19 -1 61 142 0 52 117 512 9
15 -1 24 30 0 32 52 512 
0 16 0 33 36 1 27 23 2 -4 -1 3 49 90 512 1 16 -3 49 77 -2 45 85 -1 163 298 0 58 
96 1 158 341 2 42 87 3 57 95 512 2 16 -3 22 26 -2 70 175 -1 127 403 0 126 234 1 
126 176 2 72 178 3 24 27 512 3 16 -3 48 77 -2 78 203 -1 46 80 0 34 29 1 50 63 2 
76 87 3 45 77 512 4 16 -3 33 39 -2 129 186 -1 8 6 0 157 354 1 17 9 2 133 173 3 
15 8 512 5 16 -3 33 38 -2 50 82 -1 65 242 0 29 21 1 64 107 512 6 16 -2 36 46 -1 
122 302 0 -22 -16 512 7 16 -2 119 149 -1 41 41 0 9 3 512 8 16 0 29 25 512 
0 17 1 -22 -14 2 16 13 3 120 148 512 1 17 -3 44 51 -2 46 105 -1 37 37 0 61 99 1 
50 45 2 37 76 3 52 62 512 2 17 -3 20 15 -2 31 45 -1 39 40 0 96 171 1 38 27 2 20 
10 3 29 23 512 3 17 -3 16 8 -2 73 169 -1 39 51 0 40 33 1 45 48 2 79 110 3 -20 
-11 512 4 17 -1 58 70 0 46 52 1 54 50 2 49 38 512 5 17 -2 50 73 -1 61 97 0 11 4 
1 50 56 2 42 41 512 6 17 -1 111 147 0 41 35 1 104 134 512 7 17 0 66 84 1 69 82 
512 
0 18 1 -28 -21 2 51 86 512 1 18 -1 46 49 0 36 33 1 42 33 2 83 93 512 2 18 -2 79 
151 0 -26 -22 1 116 139 2 78 88 512 3 18 -2 60 110 0 45 50 1 27 18 512 4 18 -2 
-18 -17 -1 71 99 0 62 59 1 67 77 512 5 18 -1 73 85 0 27 19 512 6 18 0 116 115 
512 
0 19 1 -18 -9 512 1 19 -1 43 29 0 81 108 1 43 31 512 2 19 0 146 153 1 -7 -1 512 
3 19 0 -19 -12 1 73 69 512 4 19 0 24 11 -512 
# Punched on 11/03/16 at 11:20:23
#LIST     16                                                                    
NO 
DIST 0.86, 0.02 = 
CONT N ( 3) TO H(31) 
REST 0.037, 0.002 = H(31,U[ISO]) 
ANGLE 0.0, 2.0 = MEAN 
CONT H(31) TO N ( 3) TO C(2) 
CONT H(31) TO N ( 3) TO C(4) 
REM                              3 H ON SP 3 
DIST 0.96, 0.02 = 
CONT C ( 7) TO H(73) 
CONT C ( 7) TO H(72) 
CONT C ( 7) TO H(71) 
REST 0.083, 0.002 = H(73,U[ISO]) 
REST 0.083, 0.002 = H(72,U[ISO]) 
REST 0.083, 0.002 = H(71,U[ISO]) 
ANGLE 109.54, 2.0 = 
CONT O(6) TO C ( 7) TO H(73) 
CONT O(6) TO C ( 7) TO H(72) 
CONT O(6) TO C ( 7) TO H(71) 
ANGLE 0.0, 2.0 = MEAN H(73) TO C ( 7) TO H(72) 
CONT H(73) TO C ( 7) TO H(71) 
CONT H(72) TO C ( 7) TO H(71) 
U(IJ) 0.,.001= O(1) TO C(2) 
VIB 0.,.001= O(1) TO C(2) 
END                                                                             
#
#LIST     12                                                                    
BLOCK 
CONT SCALE 
CONT O    (     1 ,X'S,U'S)  UNTIL C    (    11 ) 
CONT H    (    71 ,X'S,U[ISO])  UNTIL H    (    31 ) 
FIX C(7,X'S) 
FIX O(1,U[22]) C(2,U[22]) 
REM FIX O(1,U'S) C(2,U'S) 
END                                                                             
#
#check
end
#sfls
ref
shift gen=0
end
#
#LIST     12                                                                    
BLOCK 
CONT SCALE 
CONT O    (     1 ,X'S,U'S)  UNTIL C    (    11 ) 
CONT H    (    71 ,X'S,U[ISO])  UNTIL H    (    31 ) 
FIX C(7,X'S) 
rem FIX O(1,U[22]) C(2,U[22]) 
FIX O(1,U'S) C(2,U'S) 
END                                                                             
#
#check
end
#sfls
ref
shift gen=0
end

#
#LIST     16                                                                    
SAME C(7) H(71) H(72) H(73) AND C(11) h(111) h(112) h(113) 
END                                                                             
\
#
#check
end
#sfls
ref
shift gen=0
end
#end
