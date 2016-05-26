**********************************************************************
**********************************************************************

                 Temple of Apshai reverse engineering
                        by Paul Robson May 2016

**********************************************************************
**********************************************************************
100
        Rem dunjonquest,copyright1979,automatedsimulations
101
        Rem commodore8032versionbyblacksmurf2013
        // Identify which device and drive was used for loading
102
        currentDevice% = Peek(212)
        driveAddress = Peek(218) + 256 * Peek(219)
        driveUsed = Peek(driveAddress)
103
        driveNumber$ = "0"
        If driveUsed > 48 And driveUsed < 58 Then
            driveNumber$ = Chr$(driveUsed)
        // Load Bit Set/Reset machine code into memory.
105
        Read i
106
        Read j
        If j > = 0 Then
            Poke i,j
            i = i + 1
            Goto 106
109
        Data 634,76,237,2,76,200,2,76,22,3,76,18,3,169,0,133,85
112
        Data 165,87,74,102,89,10,10,10,133,84,10,38,85,10,38,85
115
        Data 10,38,85,101,84,144,3,230,85,24,101,84,133,84,169,128
118
        Data 101,85,133,85,177,84,36,89,96,136,16,12,200,200,16,8
121
        Data 198,87,16,4,230,87,230,87,36,90,48,41,16,2,164,86
124
        Data 32,134,2,48,13,201,160,208,4,169,98,208,19,201,226,240
127
        Data 13,96,201,160,208,4,169,226,208,6,201,98,208,4,169,32
130
        Data 145,84,96,164,86,32,134,2,48,13,201,32,208,4,169,226
133
        Data 208,19,201,98,240,13,96,201,32,208,4,169,98,208,6,201
136
        Data 226,208,4,169,160,145,84,96,169,0,240,2,169,128,133,90
139
        Data 164,86,166,88,202,240,57,202,240,37,202,240,17,32,186,2
142
        Data 32,183,2,32,190,2,32,179,2,198,87,76,179,2,32,179
145
        Data 2,32,186,2,32,182,2,32,192,2,230,87,76,179,2,32
148
        Data 186,2,32,179,2,32,190,2,32,183,2,198,87,76,183,2
151
        Data 32,179,2,32,192,2,32,182,2,32,186,2,198,87,76,179,2,-1
**********************************************************************
                             Set up Arrays
**********************************************************************
154
        Dim armourName$(5),armourWeight(5),armourPrice(5),qualities$(6),swordWeight(5),swordPrice(5),wd(5),strengthForSword(5),shieldDexterityAdjust(1,1),swordDexterityAdjust(5,1),qualities(6)
157
        monTypeCount = 12
160
        roomCount = 60
        Dim innResponse$(6),rr(6),initQualities(6),treasureCount%(20),treasureInfo%(20,6),monsterInfo%(monTypeCount,10),monsterName$(monTypeCount),x1%(roomCount),y1%(roomCount)
163
        Dim no%(roomCount,3),nt%(roomCount,3),d1%(roomCount,3),d2%(roomCount,3),roomMonsterType%(roomCount),roomMonsterCount%(roomCount),roomTrapID%(roomCount),xTrap%(roomCount),yTrap%(roomCount)
166
        Dim roomTreasureID%(roomCount),xTreasure%(roomCount),yTreasure%(roomCount),s%(4),p%(4),za(3),zd(5),tx%(3,1),ty%(3,1),tm(5)
169
        Dim h(3),monsterPixelCount%(2),xMonsterPixel%(9,2),yMonsterPixel%(9,2),trapName$(9)
        screenRAM = 32768
        km = 0
172
        keepCurrentPlayer = 0
        Dim x2%(roomCount),y2%(roomCount),shieldName$(2),roomVisited%?(roomCount),magicalItems%(10),textPrompt$(22),treasureName$(20)
175
        Data "flame","dust","mold","pit","","spear","needle","xbow","cavein","ceiling"
178
        For i = 0 To 9
            Read trapName$(i)
        Next
181
        Data 4,1,10,0,-1,-1,0,1,0,0,1,0,0,-1,-1,0,-1,1,-1,-2,0,0,0,2,0,-1,1,1,1,-1,2
184
        Data 1,2,0,1,-1,1,-2,6,1,1,2,1,12,-1,1,-1,2,18,-1,-1,-2,-1,10,13,2,1,1
187
        Read monsterPixelCount%(0),monsterPixelCount%(1),monsterPixelCount%(2)
        For j = 0 To 2
            For i = 0 To monsterPixelCount%(j) - 1
                Read xMonsterPixel%(i,j),yMonsterPixel%(i,j)
190
            Next
        Next
        For i = 0 To 3
            Read h(i)
            For j = 0 To 1
                Read tx%(i,j),ty%(i,j)
            Next
        Next
193
        For i = 1 To 5
            Read tm(i)
        Next
196
        Data "None",0,0,"Leather",150,30,"Ringmail",350,100,"Chainmail",500,150
199
        Data "Partial Plate",750,250,"Full Plate",1000,1000,"Intelligence","Intuition"
202
        Data "Ego","Strength","Constitution","Dexterity"
205
        For i = 0 To 5
            Read armourName$(i),armourWeight(i),armourPrice(i)
            armourWeight(i) = Int(armourWeight(i) / 16 + .5)
        Next
208
        armourWeight(0) = 0
        For i = 1 To 6
            Read qualities$(i)
        Next i
        Data "None",0,0,0,0,0,18
211
        Data "Dagger",1,5,5,3,7,12,"Shortsword",2,14,6,8,9,12,"Broadsword",3,18,7,10
214
        Data 9,13,"Hand-and-a-half Sword",6,35,8,16,9,14,"Great Sword",9,70,10,15,7,1
217
        zd(0) = 3
        za(1) = 0
        zd(1) = 0
        za(2) = 3
        zd(2) = 3
        za(3) = - 6
        zd(3) = - 2
        zd(4) = 5
        zd(5) = 5
220
        Data "Magic Sword","None","Small","Large"
223
        For i = 0 To 5
            Read swordName$(i),swordWeight(i),swordPrice(i),wd(i),strengthForSword(i)
            For j = 0 To 1
                Read swordDexterityAdjust(i,j)
            Next
226
        Next
        Read swordName$(6)
        For i = 0 To 2
            Read shieldName$(i)
        Next
229
        Data 6,3,10,8,15,12,5,15,6,17
232
        For i = 1 To 2
            Read shieldWeight(i),sd(i),shieldPrice(i)
            For j = 0 To 1
                Read shieldDexterityAdjust(i - 1,j)
            Next
        Next
235
        Data "I'd not part with these fine goods for that pittance! Mayhap for",5
238
        Data "Not so cheap my friend! But for thee just",10
241
        Data "Blackheart! Thou takest food from my children's mouths! No less than"
244
        Data 5,"Well, life is short and thy arse long! What say thee to",2
247
        Data "hmm...such fine workmanship. I could notpart with this for less than"
250
        Data 10,"A pox on thee! But I'd take",3
253
        possInnAnswers = 6
        rt = 0
        For i = 1 To possInnAnswers
            Read innResponse$(i),rr(i)
            rt = rt + rr(i)
        Next
256
        Data "room no.:    "," ","wounds:     %","fatigue:    %"," ","wgt:     lbs"
259
        Data " ","arrows:     ","magic ar:    "," "," "," ","{176}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{174}"," "
262
        Data "{VBar}             {VBar}","{173}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{189}"," ","{176}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{174}","{VBar}           {VBar}"
265
        Data "{VBar}           {VBar}","{173}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{189}","total slain:","     ","           "
268
        For i = 0 To 22
            Read textPrompt$(i)
        Next i
        textPrompt$(13) = textPrompt$(14)
        Read space11$
        space13$ = space11$ + "   "
271
        space12$ = space11$ + " "
        Goto Innkeeper
**********************************************************************
            Lose one wound point, also reduce constitution
**********************************************************************
ReduceConstitution
        wounds = wounds - 1
        qualities(5) = qualities(5) - 1
        initQualities(5) = initQualities(5) - 1
        Return
**********************************************************************
                    Switch the PET to Graphic Mode.
**********************************************************************
SwitchToGraphicMode
        Print Chr$(14);
        For i = 1 To 40
        Next
        Print Chr$(142);
        Return
**********************************************************************
                     Update weight carried display
**********************************************************************
UpdateWeight
        x = 53
        y = 5
        Gosub MoveToXY
        Print weightCarried;
        Return
**********************************************************************
                  Set Monster position in game space
**********************************************************************
PutMonsterInGameSpace
        yy = wallTop - wallBottom - 4
        If yMonster > yy Then
            yMonster = yy
286
        If yMonster < 4 Then
            yMonster = 4
289
        xx = wallRight - wallLeft - 4
        If xMonster > xx Then
            xMonster = xx
292
        If xMonster < 4 Then
            xMonster = 4
295
        x = 50
        y = 18
        Gosub MoveToXY
        Print space11$;
        y = 19
        Gosub MoveToXY
        Print space11$;
        Return
**********************************************************************
                        Announce j arrows found
**********************************************************************
AnnounceArrowsFound
        Gosub ClearLine10
        Gosub MoveToXY
        Print j;"arrows";
        Return
**********************************************************************
                      Announce Monster a$ appears
**********************************************************************
AnnounceMonster
        x = 50
        y = 13
        Gosub MoveToXY
        Print space12$;
        Gosub MoveToXY
        Print a$;
        y = 14
        Gosub MoveToXY
        Print "appears!";
304
        Return
**********************************************************************
                   Update display of killed monsters
**********************************************************************
UpdateKillCount
        a$ = "   "
        j = 1739
        Gosub PokeA$IntoScreenAtJ
        a$ = Str$(killCount)
        Gosub PokeA$IntoScreenAtJ
        Return
**********************************************************************
                    Animated effect for player hit.
**********************************************************************
FlashPlayer
        j = xPlayer - xRoomBase + screenRAM + 80 * Int((yPlayer - yRoomBase) / 2)
        l = Peek(j)
        Poke j,166
313
        For i = 1 To 30
        Next i
        Poke j,l
        Return
**********************************************************************
                         Update Wounds Display
**********************************************************************
UpdateWounds
        a$ = "    "
        j = 215
        Gosub PokeA$IntoScreenAtJ
        i = Int(100 * wounds / qualities(5) + .5)
        a$ = Str$(i)
319
        Gosub PokeA$IntoScreenAtJ
        Return
**********************************************************************
                        Get a number key press.
**********************************************************************
GetDigit
        Gosub GetKey
        If l = 0 Goto GetDigit
325
        j = Asc(c$) - 48
        If j < 0 Or j > 9 Goto GetDigit
328
        Return
**********************************************************************
                        Update displayed arrows
**********************************************************************
UpdateArrows
        a$ = Str$(arrows)
        j = 616
        Goto 337
**********************************************************************
                     Update displayed magic arrows
**********************************************************************
UpdateMagicArrows
        a$ = Str$(magicArrows)
        j = 696
337
        For i = 2 To Len(a$)
            Poke screenRAM + j + i, Asc(Mid$(a$,i,1))
        Next i
340
        For i = Len(a$) + 1 To 5
            Poke screenRAM + j + i,32
        Next i
        Return
**********************************************************************
                Clear the 10th line down in status area
**********************************************************************
ClearLine10
        x = 49
        y = 10
        Gosub MoveToXY
        Print space13$;
        Return
**********************************************************************
                     Reset all room visited flags.
**********************************************************************
ClearVisitedFlags
        For i = 1 To 60
            roomVisited%?(i) = 0
        Next i
        Return
**********************************************************************
  Poke string a$ into screen RAM at offset J, except first Character
**********************************************************************
PokeA$IntoScreenAtJ
        For i = 2 To Len(a$)
            Poke i + j + screenRAM, Asc(Mid$(a$,i,1))
        Next i
        Return
**********************************************************************
                        Move the cursor to x,y
**********************************************************************
MoveToXY
        Poke 226,x
        Poke 224,y
        Print "{19}";
        Poke 226,0
        Poke 224,0
        Return
**********************************************************************
                      Clear Game Area, not status
**********************************************************************
ClearGameArea
        Poke 213,47
        Print "{Clr}";
        Poke 213,79
        Return
**********************************************************************
                          Draw Vertical Line
**********************************************************************
DrawVerticalLine
        l1 = yy
        l2 = yy + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
361
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
364
        l3 = Int((l1 + 1) / 2)
        l4 = Int((l2 - 1) / 2)
367
        xPixel = xx
        If xPixel < 0 Or xPixel > 47 Then
            Return
370
        If l1 And 1 Then
            yPixel = l1
            Gosub 469
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub 469
373
        If Not l2 And 1 Then
            yPixel = l2
            Gosub 469
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub 469
376
        If l4 > = l3 Then
            nx = screenRAM + xx + 80 * l3
            For ny = l3 To l4
                Poke nx,160
                Poke nx + 1,160
                nx = nx + 80
            Next
379
        Return
**********************************************************************
                          Erase Vertical Line
**********************************************************************
EraseVerticalLine
        l1 = yy
        l2 = yy + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
385
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
388
        l3 = Int((l1 + 1) / 2)
        l4 = Int((l2 - 1) / 2)
391
        xPixel = xx
        If xPixel < 0 Or xPixel > 47 Then
            Return
394
        If i1 = 0 Then
            
            For yPixel = l1 To l2
                Gosub 475
            Next
            Return
397
        If l1 And 1 Then
            yPixel = l1
            Gosub 475
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub 475
                xPixel = xx
400
        If Not l2 And 1 Then
            yPixel = l2
            Gosub 475
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub 475
403
        If l4 > = l3 Then
            nx = screenRAM + xx + 80 * l3
            For ny = l3 To l4
                Poke nx,32
                Poke nx + 1,32
                nx = nx + 80
            Next
406
        Return
**********************************************************************
                         Draw Horizontal Line
**********************************************************************
DrawHorizontalLine
        l1 = xx
        l2 = l1 + l - 1
        If l1 < 0 Then
            l1 = 0
            If l1 < 0 Then
                Return
412
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
415
        yPixel = yy
        If yPixel < 0 Or yPixel > 47 Then
            Return
418
        If yy And 1 Then
            For yPixel = yy To yy + 1
                For xPixel = l1 To l2
                    Gosub 469
                Next
            Next
            Return
421
        If l2 > = l1 Then
            ny = screenRAM + yy * 40
            For nx = l1 To l2
                Poke ny + nx,160
            Next
424
        Return
**********************************************************************
                         Erase Horizontal Line
**********************************************************************
EraseHorizontalLine
        l1 = xx
        l2 = l1 + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
430
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
433
        yPixel = yy
        If yPixel < 0 Or yPixel > 47 Then
            Return
436
        If yy And 1 Or i1 = 0 Then
            For yPixel = yy To yy + i1
                For xPixel = l1 To l2
                    Gosub 475
                Next
            Next
            Return
439
        If l2 > = l1 Then
            ny = screenRAM + yy * 40
            For nx = l1 To l2
                Poke ny + nx,32
            Next
442
        Return
**********************************************************************
                        Draw Player on display
**********************************************************************
DrawPlayer
        xx = xPlayer - xRoomBase
        yy = yRoomBase - yPlayer
        Poke 86,xx
        Poke 87,yy
        Poke 88,direction
        Sys 640
        Return
**********************************************************************
                        Erase Player on display
**********************************************************************
ErasePlayer
        xx = xPlayer - xRoomBase
        yy = yRoomBase - yPlayer
        Poke 86,xx
        Poke 87,yy
        Poke 88,direction
        Sys 643
        Return
**********************************************************************
                             Draw Monster
**********************************************************************
DrawMonster
        k = 1
454
        j = monsterInfo%(monsterTypeID,6)
        For i = 0 To monsterPixelCount%(j) - 1
            xPixel = xMonster + wallLeft - xRoomBase + xMonsterPixel%(i,j)
            yPixel = yRoomBase - yMonster - wallBottom + yMonsterPixel%(i,j)
457
            On k Gosub DrawPixel,ErasePixel
        Next i
        Return
**********************************************************************
                     Erase Monster if one present
**********************************************************************
EraseMonsterIfExists
        If monsterActive = 0 Then
            Return
**********************************************************************
                             Erase Monster
**********************************************************************
EraseMonster
        k = 2
        Goto 454
**********************************************************************
                             Draw a Pixel
**********************************************************************
DrawPixel
        If xPixel < 0 Or xPixel > 47 Then
            Return
469
        Poke 86,xPixel
        Poke 87,yPixel
        Sys 634
        Return
**********************************************************************
                             Erase a Pixel
**********************************************************************
ErasePixel
        If xPixel < 0 Or xPixel > 47 Or yPixel < 0 Or yPixel > 47 Then
            Return
475
        Poke 86,xPixel
        Poke 87,yPixel
        Sys 637
        Return
**********************************************************************
                   Graphic display when monster hit
**********************************************************************
MonsterHitAnimation
        xPixel =(xMonster + wallLeft - xRoomBase)
        yPixel = Int((yRoomBase - yMonster - wallBottom) / 2)
481
        j = screenRAM + xPixel + 80 * yPixel
        l = Peek(j)
484
        For i = 1 To 100
            Poke j,219
            k = k / 5
            Poke j,l
        Next i
487
        Return
**********************************************************************
   Gets key, with timed exit into c$, l is non-zero if key pressed.
**********************************************************************
GetKey
        le = monsterSpeed /(monsterActive + 1)
        For ic = 1 To le
493
            Get c$
            If Len(c$) > 0 Then
                l = 1
                For id = 1 To 10
                    Get d$
                Next id
                Return
496
        Next ic
        l = 0
        Return
**********************************************************************
                    Draw and Erase Magic Treasure ?
**********************************************************************
DrawEraseMagicTreasure
        ii = xl - xRoomBase + wallLeft
        ij = yRoomBase - yl - wallBottom
        For l = 0 To 1
            xPixel = ii + tx%(direction - 1,l)
            yPixel = ij + ty%(direction - 1,l)
502
            On k + 1 Gosub DrawPixel,ErasePixel
505
        Next l
        Return
**********************************************************************
                      Update the Fatigue Display
**********************************************************************
UpdateFatigue
        fatigue = Int(fatigue -(Abs(m) / mm *(100 / qualities(5) + 5 - 5 * wounds / qualities(5)) *(1 + weightCarried / wt * 3) / 2) + 11)
511
        a$ = "    "
        j = 295
        Gosub PokeA$IntoScreenAtJ
        If fatigue > 100 Then
            fatigue = 100
514
        a$ = Str$(fatigue)
        If fatigue < 0 Then
            a$ = "-" + a$
517
        Gosub PokeA$IntoScreenAtJ
        Return
**********************************************************************
                           Do trap animation
**********************************************************************
TrapAnimation
        yPixel = yRoomBase - yTrap%(currentRoom) - wallBottom
        xPixel = xTrap%(currentRoom) + wallLeft - xRoomBase
        For l = 1 To 10
            Gosub DrawPixel
            Gosub ErasePixel
        Next l
        Return
**********************************************************************
           Update the treasure display in the current room.
**********************************************************************
UpdateTreasureDisplay
        If roomTreasureID%(currentRoom) = 0 Then
            Return
526
        xPixel = wallLeft + xTreasure%(currentRoom) - xRoomBase
        yy = yRoomBase - wallBottom - yTreasure%(currentRoom)
        For yPixel = yy - 1 To yy
529
            If roomTreasureID%(currentRoom) = 0 Then
                Gosub ErasePixel
532
            If roomTreasureID%(currentRoom) > 0 Then
                Gosub DrawPixel
535
        Next yPixel
        Return
538
        n = roomTrapID%(currentRoom)
        l = 0
541
        If monsterActive > 0 Or n = 0 Then
            Return
544
        If Abs(xl - xTrap%(currentRoom)) > 2 Or Abs(yl - yTrap%(currentRoom)) > 2 Or Rnd(0) * 100 > treasureInfo%(n,2) Then
            Return
547
        Gosub ClearLine10
        x = 49
        y = 10
        Gosub MoveToXY
        Print trapName$(treasureInfo%(n,4));" trap";
        Gosub FlashPlayer
550
        i = treasureInfo%(n,3)
        If i > 0 Then
            monsterActive = 1
            Gosub 1249
            xMonster = xTrap%(currentRoom)
            yMonster = yTrap%(currentRoom)
            Gosub AnnounceMonster
            Goto 556
553
        If treasureInfo%(n,5) > 0 Then
            ml = treasureInfo%(n,5)
            l = 1
            md = 3 * ml
556
        roomTrapID%(currentRoom) = 0
        Return
559
        ll = currentRoom
        Goto 565
562
        ll = lastRoom?
565
        v3 = x1%(ll)
        v4 = x2%(ll)
        w3 = y1%(ll)
        w4 = y2%(ll)
        If ll < > currentRoom Then
            Return
568
        wallLeft = v3
        wallRight = v4
        wallTop = w3
        wallBottom = w4
        Return
571
        a$ = monsterName$(monsterTypeID)
        Return
**********************************************************************
                              Title Page
**********************************************************************
TitlePage
        j% = 0
        Print "{Clr}"
577
        For i = 0 To 79
            Poke screenRAM + j% + i,160
        Next i
580
        If j% = 0 Then
            j% = 23 * 80
            Goto 577
583
        For i = 0 To j% Step 80
            Poke screenRAM + i,160
            Poke screenRAM + i + 79,160
        Next i
586
        Print "{Down}{Down}{Down}" Tab(32);"dunjonquest (tm)"
589
        Print "{Down}{Down}{Down}" Tab(30);"the temple of apshai"
592
        Print "{Down}{Down}{Down}{Down}{Down}{Down}" Tab(33);"copyright 1979"
        Print Tab(29);"{Down}automated  simulations"
595
        For i = 21 * 80 + 1 To 22 * 80 - 2
            Poke screenRAM + i,230
        Next i
598
        Print "{Down}{Down}{Down}" Tab(30);"hit any key to begin"
601
        Get a$
        r = Rnd(0)
        If Len(a$) = 0 Goto 601
604
        Return
**********************************************************************
**********************************************************************
                      Innkeeper code starts here
**********************************************************************
**********************************************************************
Innkeeper
        Print Chr$(130); Chr$(142);
        If keepCurrentPlayer < > 123 Then
            Gosub TitlePage
610
        Print Chr$(14)"{Clr}Thus quoth the Innkeeper:"
613
        If keepCurrentPlayer < > 123 Goto 634
616
        Gosub 1915
619
        Gosub 1306
        Print "I trust thy sojourn in the Temple was pleasant."
622
        Input "Wouldst thou return thereto";a$
        If Left$(a$,1) < > "y" Goto 634
625
        Gosub 1906
        Input "How many silver pieces hast thou";silver
        originalMoney = silver
628
        If silver > 0 Then
            Gosub BuySword
631
        Goto 652
634
        keepCurrentPlayer = 0
        Print "{Down}Hail and well met O noble Adventurer!"
637
        Print "{Down}Hast thou a character already, or should"
640
        Print "{Down}I find thee one; say yea if I should";
        Input a$
643
        If Left$(a$,1) = "y" Then
            Gosub CreateCharacter
646
        If Left$(a$,1) < > "y" Then
            Gosub InputCharacter
            Gosub 1306
            For i = 1 To 1500
            Next i
649
        originalMoney = silver
        Input "Thy character's name";characterName$
        If silver > 0 Then
            Gosub BuySword
652
        If silver > 0 Then
            Gosub 1027
655
        If shieldID = 0 Then
            wp = wp + sp
            sp = 0
658
        pb = pb - wp - Int(ll / 2)
        If wp > 0 Then
            pa = pa + wp - 1
661
        If wp < 0 Then
            pa = pa + wp + 1
664
        If silver > 0 Then
            Gosub BuyArmour
667
        If silver > 0 Then
            Gosub BuyBow
670
        If silver > 0 Then
            Gosub BuySalves
673
        monsterSpeed = 300
676
        Input "Monster speed (slow,medium, or fast)";a$
679
        If Left$(a$,1) = "s" Then
            monsterSpeed = 600
682
        If Left$(a$,1) = "f" Then
            monsterSpeed = 150
685
        wa = Int(5 + swordWeight(swordID) + armourWeight(armourID) + shieldWeight(Int(shieldID / 2)) + 1 +(arrows + magicArrows) / 10)
        weightCarried = wa
688
        Gosub 1306
691
        keepCurrentPlayer = 123
**********************************************************************
                    Load Dungeon in from Disk/Tape
**********************************************************************
LoadDungeon
        Input "What level wouldst thou visit (1-12)";levelDungeon
695
        an$ = driveNumber$ + ":level " + Chr$(levelDungeon + 64)
697
        If currentLoadLevel = levelDungeon Goto 730
700
        currentLoadLevel = levelDungeon
703
        k = 0
        Open 2,currentDevice%,2,an$
706
        Input# 2,levelDungeon,startX,startY,initialDirection,pw,bg
709
        xPlayer = startX
        yPlayer = startY
        direction = initialDirection
712
        For i = 1 To roomCount
            For j = 0 To 3
                Input# 2,no%(i,j),nt%(i,j),d1%(i,j),d2%(i,j)
            Next
        Next
715
        For i = 1 To roomCount
            Input# 2,roomMonsterType%(i),roomMonsterCount%(i),roomTrapID%(i),xTrap%(i),yTrap%(i),roomTreasureID%(i),xTreasure%(i),yTreasure%(i)
718
            Input# 2,x1%(i),y1%(i),x2%(i),y2%(i)
        Next
721
        For i = 1 To 12
            Input# 2,monsterName$(i)
            For j = 0 To 10
                Input# 2,monsterInfo%(i,j)
            Next
        Next
724
        For i = 1 To 20
            Input# 2,treasureName$(i)
            For j = 0 To 6
                Input# 2,treasureInfo%(i,j)
            Next
        Next
727
        Close 2
730
        Print Chr$(14)"{Clr}"
        Goto EnterDungeon
**********************************************************************
                           Armour purchasing
**********************************************************************
BuyArmour
        Input "Wilt thou buy new armor";a$
        If Left$(a$,1) = "n" Then
            Return
736
        Print "{Clr}type" Tab(25);"weight" Tab(32);"price"
739
        For i = 1 To 5
            Print armourName$(i); Tab(25);armourWeight(i); Tab(32);armourPrice(i)
        Next i
742
        Print "What sort of armor wouldst thou wear"
        Input a$
        Gosub 1981
745
        If Left$(a$,1) = "N" Then
            armourMagic = 0
            armourID = 0
            Return
748
        For i = 1 To 5
            If Left$(a$,2) = Left$(armourName$(i),2) Then
                n = i
                Goto 754
751
        Next i
        Print "I have not "a$;" for sale"
        Goto 742
754
        lowestPrice = .3 * armourPrice(n)
        askingPrice = armourPrice(n)
        a1 = askingPrice
        Gosub AcceptCheckOffer
        If oo = 0 Goto 742
757
        armourID = n
        armourMagic = 0
        silver = silver - oo
760
        Print "Thou hast"silver;" silver pieces left in thy purse"
        Return
**********************************************************************
              Generate one of the player characteristics
**********************************************************************
GeneratePlayerValue
        j = Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1)
        Return
**********************************************************************
                      Create a character randomly
**********************************************************************
CreateCharacter
        hasBow = 0
        sc = 0
        For i = 1 To 6
            Gosub GeneratePlayerValue
            qualities(i) = j
            sc = sc + j
            initQualities(i) = j
        Next i
769
        If sc < 60 Or qualities(4) < 8 Or qualities(5) < 7 Goto CreateCharacter
772
        experience = 0
        arrows = 0
        magicArrows = 0
        armourID = 0
        armourMagic = 0
        shieldID = 0
        swordID = 0
        sp = 0
        wp = 1
        swordMagic = 0
        healingSalves = 0
        elixirs = 0
        ll = 0
775
        Print "{Clr}Thy qualities:"
        For i = 1 To 6
            Print qualities$(i); Tab(15);qualities(i)
        Next i
778
        Print " "
        Gosub GeneratePlayerValue
        silver = j * 10
        Print "Thou hast"silver;" pieces of Silver"
781
        l = 1
        Gosub 790
784
        pa = 11
        pb = 11
787
        Return
790
        For i = 1 To 10
            si%(i) = 0
        Next i
        Return
**********************************************************************
                      Input a character manually.
**********************************************************************
InputCharacter
        ll = 0
        For i = 1 To 6
            Print "enter "qualities$(i);
            Input qualities(i)
            initQualities(i) = qualities(i)
796
            If qualities(i) > 18 Then
                Print qualities(i);"be too high. no more than 18 can it be"
                i = i - 1
799
        Next i
802
        Input "Thy character's experience is";experience
805
        If experience > 16000000 Then
            Print "Thy character be too worldwise, find another"
            Goto InputCharacter
808
        e = experience / 1000
        For l = 1 To 20
            If 2 ^ l > e Then
                Goto 814
811
        Next l
814
        Input "How much money hast thou to spend";silver
817
        Gosub 889
820
        Print "What kind of Sword hast thou"
        Input a$
        Gosub 1981
823
        For i = 0 To 5
            If Left$(a$,1) = Left$(swordName$(i),1) Then
                n = i
                oo = 0
                Goto 832
826
        Next i
        Print "Thou canst not take a "a$;" to the Dunjon. Thou must buy another."
829
        Goto 820
832
        If strengthForSword(n) < = qualities(4) Then
            Gosub 1012
            Goto 838
835
        Print "Thou canst not wield such a great weapon"
        Goto 820
838
        Print "What sort of Armor dost thou wear"
        Input a$
        Gosub 1981
841
        For i = 0 To 5
            If Left$(a$,2) = Left$(armourName$(i),2) Then
                n = i
                oo = 0
                Gosub 757
                Goto 847
844
        Next i
        Print "Thou canst not wear "a$;" in the Dunjon"
        Goto 838
847
        Input "Hast thou a shield";a$
        n = 0
        If Left$(a$,1) < > "y" Goto 856
850
        Input "Be it large or small";a$
        Gosub 1981
        n = 1
        If Left$(a$,1) = "L" Then
            n = 2
853
        If n > 0 Then
            Gosub 1051
856
        Input "Hast thou a bow";a$
        hasBow = 0
        If Left$(a$,1) = "y" Then
            hasBow = 1
859
        Input "How many arrows hast thou";arrows
862
        Input "How many magic arrows hast thou";magicArrows
865
        Input "How many healing potions hast thou";elixirs
868
        Input "How many healing salves hast thou";healingSalves
        If healingSalves > 10 Then
            healingSalves = 10
871
        swordMagic = 0
        If swordID > 0 Then
            Input "Be thy sword magical";a$
874
        If Left$(a$,1) = "y" Then
            Input "What be the plus";swordMagic
877
        armourMagic = 0
        If armourID = 0 Goto 886
880
        Input "Is thy armor Magical";a$
883
        If Left$(a$,1) = "y" Then
            Input "What be the plus";armourMagic
886
        Gosub 790
        Goto 784
889
        wp = l
        sp = 0
        If wallBottom < > 1 Then
            wp = Int((l + 1) / 2)
            sp = l - wp
892
        If l = ll Then
            Return
895
        ll = l
        j = l - 1
898
        If j > 5 Then
            j = j - 5
            Goto 898
901
        If keepCurrentPlayer = 123 Then
            l = 2
            On j + 1 Goto 889,904,913,922,928,940
904
        l = l - 1
        If l = 0 Goto 949
907
        If qualities(5) < 9 Then
            qualities(5) = qualities(5) + 1
            Goto 913
910
        qualities(4) = qualities(4) + 1
913
        l = l - 1
        If l = 0 Goto 949
916
        If qualities(6) < 9 Then
            qualities(6) = qualities(6) + 1
            Goto 922
919
        qualities(5) = qualities(5) + 1
922
        l = l - 1
        If l = 0 Goto 949
925
        qualities(5) = qualities(5) + 1
928
        l = l - 1
        If l = 0 Goto 949
931
        If qualities(6) < 9 Then
            qualities(6) = qualities(6) + 1
            Goto 940
934
        If qualities(4) < qualities(5) Then
            qualities(4) = qualities(4) + 1
            Goto 940
937
        qualities(5) = qualities(5) + 1
940
        l = l - 1
        If l = 0 Goto 949
943
        If qualities(2) < qualities(3) Then
            qualities(2) = qualities(2) + 1
            Goto 904
946
        qualities(3) = qualities(3) + 1
        Goto 904
949
        For i = 1 To 6
            m = qualities(i) - 18
            If m < = 0 Goto 967
952
            qualities(i) = 18
            For j = 1 To m
                If qualities(4) < 18 Then
                    qualities(4) = qualities(4) + 1
                    Goto 964
955
                If qualities(5) < 18 Then
                    qualities(5) = qualities(5) + 1
                    Goto 964
958
                If qualities(6) < 18 Then
                    qualities(6) = qualities(6) + 1
                    Goto 964
961
                r = Int(3 * Rnd(1) + .999)
                qualities(r) = qualities(r) + 1
964
            Next j
967
        Next i
        Return
**********************************************************************
                         Sword purchasing code
**********************************************************************
BuySword
        Print "Wilt thou buy one of our fine Swords";
        Input a$
973
        If Left$(a$,1) < > "y" Then
            n = st
            Gosub 1015
            Return
976
        wallBottom = 0
        Print "weapon" Tab(24);"weight" Tab(35);"price"
979
        For i = 1 To 5
            Print swordName$(i); Tab(24);swordWeight(i); Tab(34);swordPrice(i)
        Next i
982
        Print "{Down}What weapon wilt thou purchase"
        Input a$
        Gosub 1981
        For i = 1 To 5
985
            If Left$(a$,1) = Left$(swordName$(i),1) Then
                n = i
                Goto 994
988
        Next i
        If Left$(a$,1) = "n" Then
            n = swordID
            Gosub 1015
            Return
991
        Print "I have not such a weapon as a "a$
        Goto 982
994
        If strengthForSword(n) > qualities(4) Then
            Print "Thou cannot wield such a Great Weapon"
            Goto 982
997
        Print "Feast thy eyes 'pon this fine "swordName$(n)
        j = Int(Rnd(1) + 1)
1000
        If j > 2 Then
            Print "'Tis sure to always drink thy Foe's blood"
1003
        If j < 3 Then
            Print "'Tis well-forged iron"
1006
        ls = 0
        lowestPrice = .3 * swordPrice(n)
        askingPrice = swordPrice(n)
        a1 = askingPrice
        Gosub AcceptCheckOffer
        If oo = 0 Goto 982
1009
        silver = silver - oo
        Print "Thou hast"silver;" silver pieces left"
1012
        wm = Int(wd(n) * qualities(4) / 10 + .5)
        swordMagic = 0
        swordID = n
        If n = 5 Then
            wallBottom = 1
1015
        If swordDexterityAdjust(n,0) > qualities(6) Then
            wp = wp + qualities(6) - swordDexterityAdjust(n,0)
1018
        If swordDexterityAdjust(n,1) < qualities(6) Then
            wp = wp + qualities(6) - swordDexterityAdjust(n,1)
1021
        If wp > 0 Then
            wp = Int(1.3 * Log(wp) + 1)
1024
        Return
1027
        If wallBottom = 1 Then
            shieldID = 0
            sp = 0
            Return
**********************************************************************
                        Shield purchasing code
**********************************************************************
BuyShield
        Input "Wilt thou buy a shield";a$
        If Left$(a$,1) = "n" Then
            Gosub 1063
            Return
1033
        Print "shield     weight     ask"
        Print "small" Tab(11);shieldWeight(1); Tab(22)shieldPrice(1)
1036
        Print "large" Tab(11);shieldWeight(2); Tab(22);shieldPrice(2)
        Input "What sort";a$
        n = 0
1039
        Gosub 1981
        If Left$(a$,1) = "L" Then
            n = 2
1042
        If Left$(a$,1) = "S" Then
            n = 1
1045
        If n = 0 Then
            Return
1048
        lowestPrice = .3 * shieldPrice(n)
        askingPrice = shieldPrice(n)
        a1 = askingPrice
        Gosub AcceptCheckOffer
        If oo = 0 Then
            Goto BuyShield
1051
        If shieldDexterityAdjust(n - 1,0) > qualities(6) Then
            sp = sp + qualities(6) - shieldDexterityAdjust(n - 1,0)
1054
        If shieldDexterityAdjust(n - 1,1) < qualities(6) Then
            sp = sp + qualities(6) - shieldDexterityAdjust(n - 1,1)
1057
        silver = silver - oo
        Print "Thou hast"silver;" silver pieces left"
1060
        shieldID = sd(n)
        Gosub 1063
        Return
1063
        If shieldID = 5 Then
            sp = Int(sp / 2)
1066
        If sp > 0 Then
            sp = Int(1.3 * Log(sp) + 1)
1069
        sp = 2 * shieldID + sp
        Return
**********************************************************************
                          Bow purchasing code
**********************************************************************
BuyBow
        If hasBow > 0 Then
            Goto 1090
1075
        Input "Wilt thou buy a bow";a$
        If Left$(a$,1) = "n" Then
            Return
1078
        Print "I've a fine bow, Yew and nearly New, for12 silver pieces"
        lowestPrice = 4
        askingPrice = 12
1081
        a1 = askingPrice
        Gosub AcceptCheckOffer
        If oo = 0 Then
            Return
1084
        silver = silver - oo
        Print "Thou hast"silver;" remaining"
1087
        If arrows + magicArrows > = 60 Then
            arrows = 60 - magicArrows
            Goto 1102
1090
        n = 0
        Input "How many arrows wilt thou buy (at 5 coppers each)";n
1093
        If Int((n + 1) / 2) > silver Then
            Print "No credit!"
            Goto 1090
1096
        If arrows + magicArrows + n > 60 Then
            Print "Thou can carry but 60 - buy fewer"
            Goto 1090
1099
        arrows = arrows + n
        silver = silver - Int((n + 1) / 2)
        Print "Thou hast"silver;" remaining"
1102
        Return
**********************************************************************
                        Salves purchasing code
**********************************************************************
BuySalves
        Input "How many salves wilt thou buy - they'll cost thee 10 each";n
1108
        If 10 * n > silver Then
            Print "no credit"
            Goto BuySalves
1111
        If n > 10 Then
            Print "More than 10 will do thee no good"
            n = 10 - healingSalves
1114
        silver = silver - 10 * n
        healingSalves = healingSalves + n
1117
        If silver < .35 * originalMoney Then
            Print characterName$;"! Thou spendthrift!"
1120
        If silver > .7 * originalMoney Then
            Print characterName$;", Thou art frugal"
1123
        Print "Thou hast"silver;" silver pieces left"
1126
        Return
**********************************************************************
          Code inputs offer, and checks if it is acceptable.
**********************************************************************
AcceptCheckOffer
        j = Rnd(0)
        If j > .66 Then
            Print "What be thy offer "characterName$;
1132
        If j < = .66 Then
            Print "What offerest thou";
1135
        Input oo
        If oo > silver Then
            Print "Liar -  thou hast but"silver
            Goto AcceptCheckOffer
1138
        If oo = 0 Then
            ls = 0
            Return
1141
        If oo < = lowestPrice Then
            Gosub 1354
            Goto AcceptCheckOffer
1144
        If oo < = ls Then
            Gosub 1342
            Goto AcceptCheckOffer
1147
        If oo > = askingPrice Then
            Print "done"
            ls = 0
            Return
1150
        If oo < askingPrice - .3 * Sqr(Rnd(0)) * askingPrice Goto 1159
1153
        ls = 0
        If oo < .6 * a1 Then
            Print "Thou art a hard bargainer "characterName$
            Return
1156
        Print "done"
        Return
1159
        If Rnd(0) < .995 Goto 1165
1162
        Print "I see the gods look with favor on thee- so take it for that!"
        ls = 0
        Return
1165
        askingPrice = oo +(askingPrice - oo) * Sqr(Rnd(0)) *(20 /(qualities(1) + qualities(3)))
1168
        ls = oo
1171
        Gosub 1360
        Goto AcceptCheckOffer
**********************************************************************
**********************************************************************
                         New Room drawing code
**********************************************************************
**********************************************************************
NewRoom
        lastRoom? = currentRoom
        Gosub 559
        If roomVisited%?(currentRoom) = 1 Goto 1186
1177
        Print Chr$(142);
        Gosub ClearGameArea
        Gosub ClearVisitedFlags
        xRoomBase = wallLeft
        yRoomBase = wallTop
1180
        If nt%(lastRoom?,3) = 1 Then
            xRoomBase = xRoomBase -(48 - wallRight + wallLeft) / 2
            If nt%(lastRoom?,1) = 1 Then
                xRoomBase = xRoomBase +(wallLeft - xRoomBase) / 2
1183
        If nt%(lastRoom?,0) = 1 Then
            yRoomBase = yRoomBase + 48 - wallTop + wallBottom
            If nt%(lastRoom?,2) = 1 Then
                yRoomBase = yRoomBase -(yRoomBase - wallTop) / 2
1186
        xRoomBase = Int(xRoomBase + .9)
        If Not xRoomBase And 1 Then
            xRoomBase = xRoomBase - 1
1189
        yRoomBase = Int(yRoomBase + .9) And 254
1192
        xl = xPlayer - wallLeft
        yl = yPlayer - wallBottom
1195
        If roomMonsterType%(currentRoom) > 0 And roomMonsterCount%(currentRoom) > 0 Then
            Gosub 1225
            monsterActive = 1
            Goto 1201
1198
        Gosub 1240
1201
        Poke 226,49
        Print "{19}";
        For y = 0 To 22
            Print textPrompt$(y)
        Next
        Poke 226,0
1204
        x = 58
        y = 0
        Gosub MoveToXY
        Print currentRoom;
1207
        Gosub UpdateWeight
        Gosub UpdateArrows
        Gosub UpdateMagicArrows
        Gosub UpdateFatigue
        Gosub UpdateWounds
        Gosub UpdateKillCount
1210
        If monsterActive > 0 Then
            Gosub DrawMonster
            a$ = monsterName$(monsterTypeID)
            Gosub AnnounceMonster
1213
        ns = 5
        If ib = 3 Goto 1222
1216
        For ir = 0 To 3
            lastRoom? = no%(currentRoom,ir)
            If nt%(currentRoom,ir) = 1 And lastRoom? > 0 Then
                Gosub 1258
1219
        Next ir
1222
        lastRoom? = currentRoom
        Gosub 1258
        Gosub DrawPlayer
        Gosub UpdateTreasureDisplay
        Return
1225
        monsterTypeID = roomMonsterType%(currentRoom)
        i = monsterTypeID
        monsterActive = 1
1228
        ml = monsterInfo%(i,0)
        ma = monsterInfo%(i,1)
        mp = monsterInfo%(i,2)
        ms = monsterInfo%(i,9)
        md = monsterInfo%(i,4)
        mh = monsterInfo%(i,5)
        ih = 0
1231
        a$ = monsterName$(monsterTypeID)
        Gosub AnnounceMonster
1234
        xMonster = Int(Rnd(0) *(wallRight - wallLeft - 8)) + 4
        yMonster = Int(Rnd(0) *(wallTop - wallBottom - 8)) + 5
1237
        mf = Int(Rnd(0) * 4) + 1
        Return
1240
        l = Rnd(0)
        If l > pw / 100 Then
            monsterActive = 0
            a$ = ""
            Return
1243
        l = Rnd(0)
        ls = 0
        monsterActive = 1
        For i = 1 To monTypeCount
            ls = ls + monsterInfo%(i,8)
            If l < = ls / 100 Goto 1249
1246
        Next i
1249
        roomMonsterType%(currentRoom) = i
        roomMonsterCount%(currentRoom) = 1
        monsterTypeID = i
        Goto 1228
1252
        l = Rnd(0)
        If l < pw / 600 Goto 1243
1255
        Return
1258
        If roomVisited%?(lastRoom?) = 1 Then
            Return
1261
        Gosub 562
        If v3 - xRoomBase > - 1 And v4 - xRoomBase < 49 And yRoomBase - w3 > - 1 And yRoomBase - w4 < 49 Then
            roomVisited%?(lastRoom?) = 1
1264
        xx = v4 - xRoomBase - 2
        For k = 1 To 3 Step 2
            yy = yRoomBase - w3
            If ns = k Goto 1282
1267
            l = w3 - w4
            ll = d2%(lastRoom?,k) - d1%(lastRoom?,k)
            If ll + 4 = l Goto 1282
1270
            i1 = 1
            If ll = 0 Then
                Gosub DrawVerticalLine
                Goto 1282
1273
            If nt%(lastRoom?,k) > 1 Then
                Gosub DrawVerticalLine
                Goto 1279
1276
            l = l - d2%(lastRoom?,k)
            Gosub DrawVerticalLine
            l = d1%(lastRoom?,k)
            yy = yRoomBase - w4 - l
            Gosub DrawVerticalLine
            Goto 1282
1279
            i1 = 2 - nt%(lastRoom?,k)
            If i1 > = 0 And i1 < 2 Then
                yy = yRoomBase - w4 - d2%(lastRoom?,k)
                l = ll
                Gosub EraseVerticalLine
1282
            xx = v3 - xRoomBase
        Next k
1285
        yy = yRoomBase - w3
        For k = 0 To 2 Step 2
            If ns = k Goto 1303
1288
            xx = v3 - xRoomBase
            l = v4 - v3
            ll = d2%(lastRoom?,k) - d1%(lastRoom?,k)
            If ll + 4 = l Goto 1303
1291
            If ll = 0 Then
                Gosub DrawHorizontalLine
                Goto 1303
1294
            If nt%(lastRoom?,k) > 1 Then
                Gosub DrawHorizontalLine
                Goto 1300
1297
            l = d1%(lastRoom?,k)
            Gosub DrawHorizontalLine
            l = v4 - v3 - d2%(lastRoom?,k)
            xx = v4 - xRoomBase - l
            Gosub DrawHorizontalLine
            Goto 1303
1300
            i1 = 2 - nt%(lastRoom?,k)
            If i1 > = 0 And i1 < 2 Then
                xx = v3 - xRoomBase + d1%(lastRoom?,k)
                l = ll
                Gosub EraseHorizontalLine
1303
            yy = yRoomBase - w4 - 2
        Next k
        Return
1306
        wn = swordID
        If swordMagic < > 0 Then
            wn = 6
1309
        Print "{Clr}Character Summary for "characterName$
1312
        Print " "
        For i = 1 To 6
            Print qualities$(i); Tab(15);initQualities(i)
        Next i
1315
        Print "{Down}Weapon:"swordName$(wn);
        If wn = 6 Then
            Print Tab(22);"plus:"swordMagic;
1318
        Print " "
        Print "Armor :"armourName$(armourID);
        If armourMagic > 0 Then
            Print Tab(22);"plus:"armourMagic;
1321
        j = 0
        If shieldID > 0 Then
            j = 1
            If shieldID > 3 Then
                j = 2
1324
        Print " "
        Print "Shield:"shieldName$(j)
1327
        Print "Arrows:"arrows; Tab(20);"Magic Arrows:"magicArrows
1330
        Print "Salves:"healingSalves; Tab(20);"Elixirs:"elixirs
1333
        Print "Experience:"experience; Tab(20);"Weight carried:"weightCarried
1336
        Print "Silver:"silver
1339
        Return
1342
        j = Int(Rnd(0) * 3 + 1)
        On j Goto 1345,1348,1351
1345
        Print "Dost thou take me for a dolt!"
        Return
1348
        Print "Fool or knave "characterName$;"! Make an offer higher than thy last!"
        Return
1351
        Print "Perchance thou wouldst not have this at all!"
        Return
1354
        If Rnd(0) > .5 Then
            Print "Ha! 'Tis less than I paid for it!"
            Return
1357
        Print "I spit on thy paltry offer!"
        Return
1360
        r = Rnd(0)
        rq = 0
1363
        For i1 = 1 To possInnAnswers
            rq = rq + rr(i1) / rt
            If rq > r Then
                Print innResponse$(i1); Int(askingPrice + .99)
                Return
1366
        Next i1
**********************************************************************
**********************************************************************
                  Enter the dungeon, loading complete
**********************************************************************
**********************************************************************
EnterDungeon
        currentRoom = 1
        commandList$ = "rlatpfmgev!hqsydo"
        weightCarried = wa
        mm = 4
        fatigue = 100
        wounds = qualities(5)
        as = qualities(4) / 10
1372
        killCount = 0
        xPlayer = startX
        yPlayer = startY
        direction = initialDirection
        wt = qualities(4) * qualities(4)
1375
        Gosub NewRoom
        s%(1) = wallTop - wallBottom
        s%(2) = wallRight - wallLeft
        s%(3) = 0
        s%(4) = 0
1378
        p%(1) = xPlayer - wallLeft
        p%(2) = yPlayer - wallBottom
        p%(3) = p%(1)
        p%(4) = p%(2)
        p%(0) = p%(2)
1381
        x0 = xl
        y0 = yl
        ia = 0
        Gosub GetKey
        m = 0
        Gosub ClearLine10
        Gosub 292
        If l = 0 Goto 1771
1384
        If Asc(c$) > 47 And Asc(c$) < 58 Goto 1399
1387
        For i = 1 To 17
            If c$ < > Mid$(commandList$,i,1) Goto 1396
1390
            On i Goto 1507,1513,1525,1525,1525,1525,1525,1645,1633,1519,1726,1732,1750
1393
            On i - 13 Goto 1762,1744,1705,1597
1396
        Next i
        Goto 1381
1399
        If fatigue < 1 Goto 1525
1402
        m = Asc(c$) - 48
        movesAllowed = m
        ib = 0
        On direction Goto 1405,1417,1411,1423
1405
        If yPlayer + m > wallTop - 3 Then
            m = wallTop - 3 - yPlayer
            ib = 1
1408
        Goto 1438
1411
        m = - m
        movesAllowed = m
        If yPlayer + m < wallBottom + 4 Then
            m = wallBottom + 4 - yPlayer
            ib = 1
1414
        Goto 1438
1417
        If xPlayer + m > wallRight - 4 Then
            m = wallRight - 4 - xPlayer
            ib = 1
1420
        Goto 1438
1423
        m = - m
        movesAllowed = m
1426
        If xPlayer + m < wallLeft + 3 Then
            m = wallLeft + 3 - xPlayer
            ib = 1
1429
        Goto 1438
1432
        If monsterActive > 0 Goto 1771
1435
        Goto 1792
1438
        If ib = 0 Goto 1474
1441
        xl = xPlayer - wallLeft
        yl = yPlayer - wallBottom
        If nt%(currentRoom,direction - 1) < > 1 Goto 1474
1444
        If p%(direction) < = d1%(currentRoom,direction - 1) Or p%(direction) > = d2%(currentRoom,direction - 1) Goto 1453
1447
        Gosub EraseMonsterIfExists
        monsterActive = 0
        in = 0
        currentRoom = no%(currentRoom,direction - 1)
        Gosub 559
        ib = 2
        m = Abs(m) + 4
1450
        If currentRoom = 0 Goto 1930
1453
        If ib = 1 Goto 1474
1456
        If wallLeft - xRoomBase < 0 Or wallRight - xRoomBase > 48 Or yRoomBase - wallTop < 0 Or yRoomBase - wallBottom > 48 Goto 1462
1459
        ib = 3
        s%(1) = wallTop - wallBottom
        s%(2) = wallRight - wallLeft
        m = movesAllowed
        Gosub UpdateFatigue
        Goto 1474
1462
        If direction = 1 Then
            yPlayer = wallBottom + 4
            Goto 1375
1465
        If direction = 3 Then
            yPlayer = wallTop - 3
            Goto 1375
1468
        If direction = 2 Then
            xPlayer = wallLeft + 3
            Goto 1375
1471
        xPlayer = wallRight - 4
        Goto 1375
1474
        Gosub ErasePlayer
        Gosub UpdateTreasureDisplay
        If direction = 1 Or direction = 3 Then
            yPlayer = yPlayer + m
            Goto 1480
1477
        xPlayer = xPlayer + m
1480
        If magicalItems%(4) > 0 Then
            m = m / 2
1483
        If xPlayer < wallLeft + 3 Then
            xPlayer = wallLeft + 3
1486
        If xPlayer > wallRight - 4 Then
            xPlayer = wallRight - 4
1489
        If yPlayer < wallBottom + 4 Then
            yPlayer = wallBottom + 4
1492
        If yPlayer > wallTop - 3 Then
            yPlayer = wallTop - 3
1495
        Gosub DrawPlayer
        p%(1) = xPlayer - wallLeft
        p%(3) = p%(1)
        p%(2) = yPlayer - wallBottom
        p%(4) = p%(2)
        p%(0) = p%(2)
1498
        If ib = 3 Then
            lastRoom? = currentRoom
            Gosub 1192
            ib = 0
            Goto 1381
1501
        xl = xPlayer - wallLeft
        yl = yPlayer - wallBottom
        Gosub 538
        If l > 0 Goto 1792
1504
        Goto 1771
1507
        Gosub ErasePlayer
        direction = direction + 1
        If direction > 4 Then
            direction = 1
1510
        Goto 1522
1513
        Gosub ErasePlayer
        direction = direction - 1
        If direction < 1 Then
            direction = 4
1516
        Goto 1522
1519
        Gosub ErasePlayer
        direction = direction - 2
        If direction < 1 Then
            direction = direction + 4
1522
        Gosub DrawPlayer
        Goto 1381
1525
        x = 49
        y = 10
        If fatigue < 1 Then
            Gosub MoveToXY
            Print "too tired";
            Goto 1771
1528
        in = 0
        ia = i - 2
        km = 0
        On ia Goto 1531,1531,1531,1558,1552
1531
        hi = 0
        If Abs(xl - xMonster) > 5 Or Abs(yl - yMonster) > 5 Then
            Gosub MoveToXY
            Print "too far to hit";
            Goto 1771
1534
        m = tm(ia)
        k = 0
        Gosub DrawEraseMagicTreasure
        p = pb -(qualities(3) - 9) / 3 * Exp(- 2 * wounds / qualities(5)) + ml / 3 - za(ia)
1537
        r = Int(Rnd(0) * 20 + 1)
        x = 50
        y = 18
        If r < p Then
            Gosub MoveToXY
            Print "swish";
            Goto 1768
1540
        askingPrice = as *(r - p + 1)
        Gosub MoveToXY
        Print "crunch";
        If askingPrice > wm Then
            askingPrice = wm
1543
        If askingPrice < mh Then
            askingPrice = mh
1546
        If monsterInfo%(monsterTypeID,3) < > 2 Or(swordMagic > 0 And ia < 4) Or ia = 5 Then
            mp = mp - askingPrice + mh
1549
        in = 0
        Goto 1768
1552
        i1 = 5
        km = 5
        If magicArrows = 0 Goto 1771
1555
        magicArrows = magicArrows - 1
        Gosub UpdateMagicArrows
        Goto 1564
1558
        i1 = 3
        If arrows = 0 Goto 1771
1561
        arrows = arrows - 1
        Gosub UpdateArrows
1564
        On direction Goto 1567,1579,1570,1582
1567
        ly = yl + 2
        uy = yMonster - 2
        s = 1
        Goto 1573
1570
        ly = yl - 2
        uy = yMonster + 2
        s = - 1
1573
        x = xl
        xPixel = x + wallLeft - xRoomBase
        For y = ly To uy Step s
            yPixel = yRoomBase - y - wallBottom
            Gosub DrawPixel
            Gosub ErasePixel
        Next y
1576
        Goto 1588
1579
        lx = xl + 2
        ux = xMonster - 2
        s = 1
        Goto 1585
1582
        lx = xl - 2
        ux = xMonster + 2
        s = - 1
1585
        yPixel = yRoomBase - yl - wallBottom
        For x = lx To ux Step s
            xPixel = x + wallLeft - xRoomBase
            Gosub DrawPixel
            Gosub ErasePixel
        Next x
        y = yl
1588
        c$ = "swissh"
        If Abs(x - xMonster) < i1 And Abs(y - yMonster) < i1 Then
            c$ = "thwunk"
1591
        Gosub 292
        x = 50
        y = 18
        Gosub MoveToXY
        Print c$;
        If Left$(c$,1) = "s" Goto 1771
1594
        askingPrice = Int(7 * Rnd(0) + 1) + km
        Goto 1543
1597
        If nt%(currentRoom,direction - 1) < > 2 Goto 1771
1600
        k = direction - 1
        If p%(direction) < = d1%(currentRoom,k) Or p%(direction) > = d2%(currentRoom,k) Or Abs(p%(k) - s%(direction)) > 5 Goto 1771
1603
        nt%(currentRoom,k) = 1
        ij = 0
        On direction Gosub 1621,1612,1627,1618
1606
        lastRoom? = no%(currentRoom,k)
        ns =(direction + 1) And 3
1609
        nt%(lastRoom?,ns) = 1
        ns = 5
        Gosub 1258
        Goto 1771
1612
        xx = wallRight - xRoomBase - 2
1615
        i1 = 1 + ij
        yy = yRoomBase - wallBottom - d2%(currentRoom,k)
        l = d2%(currentRoom,k) - d1%(currentRoom,k)
        Gosub EraseVerticalLine
        Return
1618
        xx = wallLeft - xRoomBase
        Goto 1615
1621
        yy = yRoomBase - wallTop
1624
        i1 = 1 + ij
        xx = wallLeft - xRoomBase + d1%(currentRoom,k)
        l = d2%(currentRoom,k) - d1%(currentRoom,k)
        Gosub EraseHorizontalLine
        Return
1627
        yy = yRoomBase - wallBottom - 2
        Goto 1624
1630
        Gosub MoveToXY
        Print "nothing";
        Return
1633
        Gosub ClearLine10
        k = direction - 1
        If nt%(currentRoom,k) < > 3 Or(40 * Rnd(0)) > 18 + qualities(2) Then
            Gosub 1630
            Goto 1771
1636
        Gosub MoveToXY
        Print "a secret door!";
        ij = - 1
        lastRoom? = currentRoom
        nt%(currentRoom,k) = 2
        rf%(k) = 1
1639
        On direction Gosub 1621,1612,1627,1618
1642
        Goto 1771
1645
        n = roomTreasureID%(currentRoom)
        Gosub ClearLine10
        Gosub MoveToXY
        Rem get
1648
        If n = 0 Or Abs(xl - xTreasure%(currentRoom)) > 3 Or Abs(yl - yTreasure%(currentRoom)) > 3 Then
            Print "you can't";
            Goto 1771
1651
        roomTreasureID%(currentRoom) = 0
        Print treasureName$(n);
        treasureCount%(n) = treasureCount%(n) + 1
        weightCarried = weightCarried + treasureInfo%(n,0)
        Gosub UpdateWeight
1654
        in = 0
        Gosub 526
        Gosub DrawPlayer
        i = treasureInfo%(n,1)
        If i < 101 Goto 1660
1657
        j = i - 100
        magicalItems%(j) = magicalItems%(j) + 1
        initQualities(j) = initQualities(j) + 1
        Goto 1771
1660
        On i + 1 Goto 1771,1666,1669,1672,1687,1690,1693,1663,1696,1699,1702
1663
        magicalItems%(2) = 1
        Goto 1771
1666
        j = Int(6 * Rnd(0) + .99)
        Gosub ClearLine10
        Gosub MoveToXY
        Print j;"elixirs";
        elixirs = elixirs + j
        Goto 1771
1669
        shieldID = 4
        sp = sp + 1
        Goto 1771
1672
        Gosub ClearLine10
        Gosub MoveToXY
        Print "dost use sword";
        Gosub GetKey
        If l = 0 Goto 1672
1675
        Gosub ClearLine10
        If c$ < > "y" Then
            treasureCount%(n) = treasureCount%(n) - 1
            weightCarried = weightCarried - treasureInfo%(n,0)
            Goto 1771
1678
        pb = pb + swordMagic
        swordMagic = Int(4 * Rnd(0)) + Int(4 * Rnd(0)) - 2
        i =((levelDungeon - 1) And 3) + 1
        If levelDungeon > 8 Then
            i = i + 1
1681
        If swordMagic > 0 Then
            swordMagic = swordMagic - Int(2 - Int(i / 2))
            If swordMagic > 1 Then
                Gosub MoveToXY
                Print "then sword glows";
1684
        pb = pb - swordMagic
        wm = Int(as *(7 + swordMagic) + .5)
        Goto 1771
1687
        j = Int(20 * Rnd(0) + 1)
        Gosub AnnounceArrowsFound
        arrows = arrows + j
        Gosub 328
        Goto 1771
1690
        j = Int(10 * Rnd(0) + 1)
        Gosub AnnounceArrowsFound
        magicArrows = magicArrows + j
        Gosub UpdateMagicArrows
        Goto 1771
1693
        magicalItems%(1) = magicalItems%(1) + 1
        pa = pa + 1
        Goto 1771
1696
        magicalItems%(3) = 1
        Goto 1771
1699
        magicalItems%(4) = 1
        Goto 1771
1702
        pw = 75
        Goto 1771
1705
        Gosub ClearLine10
        Gosub MoveToXY
        Print "drop some";
1708
        Gosub GetDigit
        jj = 10 * j
        Gosub GetDigit
        jj = jj + j
        If jj > 20 Then
            Gosub ClearLine10
            Goto 1771
1711
        If treasureCount%(jj) < 1 Then
            Gosub ClearLine10
            Goto 1771
1714
        treasureCount%(jj) = treasureCount%(jj) - 1
        weightCarried = weightCarried - treasureInfo%(jj,0)
        Gosub ClearLine10
        Gosub UpdateWeight
1717
        If treasureInfo%(jj,1) > 0 Goto 1771
1720
        If roomTreasureID%(currentRoom) = 0 Then
            roomTreasureID%(currentRoom) = jj
            xTreasure%(currentRoom) = xl
            yTreasure%(currentRoom) = yl
            Gosub 526
1723
        Goto 1771
1726
        If 100 * Rnd(0) > .3 *(qualities(1) + qualities(3)) * monsterInfo%(monsterTypeID,7) Goto 1771
1729
        in = 1
        Gosub ClearLine10
        Gosub MoveToXY
        Print "pass by";
        Goto 1771
1732
        If healingSalves < = 0 Goto 1747
1735
        healingSalves = healingSalves - 1
        j = 0
1738
        wounds = wounds + 1 + j
        If wounds > qualities(5) Then
            wounds = qualities(5)
1741
        Gosub UpdateWounds
        Goto 1771
1744
        If elixirs > 0 Then
            elixirs = elixirs - 1
            j = Int(Rnd(0) * 6) + 2
            Goto 1738
1747
        Gosub ClearLine10
        Gosub MoveToXY
        Print "none left";
        Goto 1381
1750
        Gosub ClearLine10
        Gosub MoveToXY
        i = roomMonsterType%(no%(currentRoom,direction - 1))
        If i = 0 Or roomMonsterCount%(no%(currentRoom,direction - 1)) = 0 Goto 1759
1753
        If 1000 * Rnd(0) > qualities(2) ^ 2 + magicalItems%(2) * 700 Goto 1759
1756
        Print monsterName$(i);
        Goto 1771
1759
        Print "nothing";
        Goto 1771
1762
        If roomTrapID%(currentRoom) > 0 And 1 + 20 * Rnd(0) < qualities(2) Then
            Gosub TrapAnimation
            Goto 1771
1765
        Gosub ClearLine10
        Gosub MoveToXY
        Goto 1759
1768
        k = 1
        Gosub DrawEraseMagicTreasure
1771
        Gosub UpdateFatigue
        If monsterActive > 0 Goto 1780
1774
        Gosub 1252
        If monsterActive = 0 Goto 1381
1777
        Gosub DrawMonster
        Goto 1381
1780
        If in > 0 Or hi > 0 Goto 1885
1783
        If Abs(x0 - xMonster) > 5 Or Abs(y0 - yMonster) > 5 Goto 1846
1786
        im = monsterInfo%(monsterTypeID,1)
1789
        im = im - 1
        If im < 0 Goto 1828
1792
        p = pa - zd(ia)
        r = Int(20 * Rnd(0) + 1) + ml
        If r > = p Goto 1798
1795
        x = 50
        y = 19
        Gosub MoveToXY
        Print space11$;
        Gosub MoveToXY
        Print "it missed!";
        Goto 1789
1798
        Gosub SwitchToGraphicMode
1801
        x = 50
        y = 19
        Gosub MoveToXY
        Print space11$;
        Gosub MoveToXY
        Gosub FlashPlayer
        If Int(Rnd(0) * 20 + 1) > sp Goto 1807
1804
        Print "shield hit";
        k = - shieldID
        Goto 1816
1807
        Print "struck thee";
        k = 0
        If monsterInfo%(monsterTypeID,3) < > 2 Goto 1816
1810
        If Int(Rnd(0) * 20) < qualities(5) Or magicalItems%(2) > 0 Goto 1816
1813
        Gosub ReduceConstitution
        Gosub ClearLine10
        Gosub MoveToXY
        Print "a chill...";
1816
        k = k + Int((md *(r - p + 1)) / 10) - armourID - armourMagic
        If k < 0 Then
            k = 0
1819
        wounds = wounds - k
        If wounds < 1 Then
            For i = 1 To 1000
            Next i
            Goto 1954
1822
        Gosub UpdateWounds
        If monsterActive > 0 Goto 1789
1825
        Goto 1381
1828
        If monsterActive = 0 Goto 1381
1831
        Gosub EraseMonster
        m = 2
        On Int(4 * Rnd(0) + 1) Goto 1834,1837,1840,1843
1834
        xMonster = xMonster + m
        Goto 1882
1837
        xMonster = xMonster - m
        Goto 1882
1840
        yMonster = yMonster + m
        Goto 1882
1843
        yMonster = yMonster - m
        Goto 1882
1846
        Gosub EraseMonster
        Gosub UpdateTreasureDisplay
        xx = xl - xMonster
        yy = yl - yMonster
        If Abs(xx) < Abs(yy) Goto 1855
1849
        mf = 4
        If xx > 0 Then
            mf = 2
1852
        Goto 1858
1855
        mf = 3
        If yy > 0 Then
            mf = 1
1858
        m = ms
        On mf Goto 1861,1867,1873,1879
1861
        yMonster = yMonster + m
        If yMonster > yl - 3 Then
            yMonster = yl - 3
1864
        Goto 1882
1867
        xMonster = xMonster + m
        If xMonster > xl - 3 Then
            xMonster = xl - 3
1870
        Goto 1882
1873
        yMonster = yMonster - m
        If yMonster < yl + 3 Then
            yMonster = yl + 3
1876
        Goto 1882
1879
        xMonster = xMonster - m
        If xMonster < xl + 3 Then
            xMonster = xl + 3
1882
        Gosub PutMonsterInGameSpace
        Gosub DrawMonster
1885
        If mp > 0 Or monsterActive = 0 Goto 1900
1888
        Gosub MonsterHitAnimation
        Gosub EraseMonster
        experience = experience + 20 * ml * ml + 15
        killCount = killCount + 1
        Gosub UpdateKillCount
        Gosub DrawPlayer
1891
        Gosub ClearLine10
        Gosub MoveToXY
        Print "monster slain!";
        m = roomMonsterCount%(currentRoom)
        If m > 0 Then
            roomMonsterCount%(currentRoom) = m - 1
1894
        If m > 1 Then
            Gosub 1225
            Gosub ClearLine10
            Gosub MoveToXY
            Print "and another";
            Gosub DrawMonster
            Goto 1900
1897
        monsterActive = 0
        x = 50
        y = 13
        Gosub MoveToXY
        Print space12$;
        y = 14
        Gosub MoveToXY
        Print space11$;
1900
        Goto 1381
1903
        b$ = ""
        For i = 1 To j
            Get #1,a$
            b$ = b$ + Chr$(Asc(a$) - 45)
        Next i
        Return
1906
        l = 1
        If experience > 1999 Then
            l = Int(Log(experience / 1000) / Log(2) + 1)
1909
        hasBow = 1
        Gosub 889
        Gosub 784
1912
        Goto 1927
1915
        Print "{Clr}treasures for "characterName$
        Print "{Down}treasure" Tab(10);"#" Tab(20);"treasure" Tab(30);"value"
1918
        For i = 1 To 20
            j = treasureInfo%(i,6) * treasureCount%(i)
            If j > 0 Then
                Print treasureName$(i); Tab(20);treasureCount%(i); Tab(30);j
1921
            silver = silver + j
            weightCarried = weightCarried - treasureCount%(i) * treasureInfo%(i,0)
            treasureCount%(i) = 0
        Next
1924
        Input "art thou ready for more";a$
        Return
1927
        For i = 1 To 20
            treasureCount%(i) = 0
        Next i
        Return
1930
        Print "{Clr}thou leavest the dunjon"
1933
        Print "{Down}experience:"experience
        Print "{Down}dost thou wish to re-enter the pit"
1936
        For i = 1 To 10
            Get a$
        Next i
1939
        Gosub GetKey
        If l = 0 Goto 1939
1942
        For i = 1 To 60
            roomVisited%?(i) = 0
        Next i
1945
        For i = 1 To 10
            Get a$
        Next i
1948
        If c$ < > "y" Goto Innkeeper
1951
        weightCarried = wa
        currentRoom = 1
        wounds = qualities(5)
        xPlayer = startX
        yPlayer = startY
        direction = initialDirection
        fatigue = 100
        Gosub ClearVisitedFlags
        Goto 1375
1954
        Print Chr$(14)"{Clr}{Down}{Down}{Down}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}Thou art slain!{Down}"
        For i = 1 To 2500
        Next i
1957
        For i = 1 To 60
            roomVisited%?(i) = 0
        Next i
1960
        i = Int(Sqr(Rnd(0) * 16 + 1) + .7)
        On i Goto 1963,1972,1975,1969
1963
        Print "Thou art eaten"
        keepCurrentPlayer = 0
        For i = 1 To 1500
        Next i
1966
        For i = 1 To 60
            roomVisited%?(i) = 0
        Next i
        Goto Innkeeper
1969
        Print "Benedic the Cleric found thee"
        Goto 1933
1972
        Print "Lowenthal the Mage found thee"
        For i = 1 To 10
            magicalItems%(i) = 0
        Next i
        Goto 1933
1975
        Print "Olias the Dwarf found thee"
        For i = 1 To 20
            treasureCount%(i) = 0
        Next i
1978
        For i = 1 To 10
            magicalItems%(i) = 0
        Next i
        swordMagic = 0
        armourMagic = 0
        healingSalves = 0
        elixirs = 0
        magicArrows = 0
        Goto 1933
1981
        ja = Asc(Left$(a$,1))
        If ja > 127 Then
            Return
1984
        b$ = a$
        a$ = Chr$(ja + 128)
1987
        If Len(b$) > 1 Then
            a$ = a$ + Right$(b$, Len(b$) - 1)
1990
        Return
