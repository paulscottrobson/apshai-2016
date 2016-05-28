        ********************************************************************************************************************
        ********************************************************************************************************************

                                                          TEMPLE OF APSHAI
                                                      by Automated Simulations
                                             reverse engineered by Paul Robson May 2016

        ********************************************************************************************************************
        ********************************************************************************************************************
                                                     ---  Dimension arrays  ---
        Dim armourName$(5),armourWeight(5),armourPrice(5),statName$(6),swordWeight(5),swordPrice(5),swordDamage(5),strengthForSword(5),shieldDexterityAdjust(1,1),swordDexterityAdjust(5,1),stats(6)
        monTypeCount = 12
        roomCount = 60
        Dim innResponse$(6),responseProbability(6),initQualities(6),treasureCount%(20),treasureInfo%(20,6),monsterInfo%(monTypeCount,10),monsterName$(monTypeCount),wallLeft%(roomCount),wallTop%(roomCount)
        Dim roomInDir(roomCount,3),exitRoom(roomCount,3),doorLower(roomCount,3),doorUpper(roomCount,3),monsterTypeForRoom%(roomCount),roomMonsterCount%(roomCount),roomTrapID%(roomCount),xTrap%(roomCount),yTrap%(roomCount)
        Dim roomTreasureID%(roomCount),xTreasure%(roomCount),yTreasure%(roomCount),?roomSize%(4),?playerInRoom(4),attackDamageOnAction(3),chanceMonsterHitOnAction(5),swordAnimX%(3,1),swordAnimY%(3,1),fatigueEffectOfAttack(5)
        Dim __h(3),monsterPixelCount%(2),xMonsterPixel%(9,2),yMonsterPixel%(9,2),trapName$(9)
        screenRAM = 32768
        arrowDamageAdjust = 0
        keepCurrentPlayer = 0
        Dim wallRight%(roomCount),wallBottom%(roomCount),shieldName$(2),roomOnScreen%(roomCount),magicalItems%(10),textPrompt$(22),treasureName$(20)
                                                      ---  Read trap names  ---
        Data "flame","dust","mold","pit","","spear","needle","xbow","cavein","ceiling"
        For i = 0 To 9
            Read trapName$(i)
        Next
                                                 ---  Read monster drawing data  ---
        Data 4,1,10,0,-1,-1,0,1,0,0,1,0,0,-1,-1,0,-1,1,-1,-2,0,0,0,2,0,-1,1,1,1,-1,2
        Data 1,2,0,1,-1,1,-2,6,1,1,2,1,12,-1,1,-1,2,18,-1,-1,-2,-1,10,13,2,1,1
        Read monsterPixelCount%(0),monsterPixelCount%(1),monsterPixelCount%(2)
        For j = 0 To 2
            For i = 0 To monsterPixelCount%(j) - 1
                Read xMonsterPixel%(i,j),yMonsterPixel%(i,j)
                                                 ---  Read sword animation data  ---
            Next
        Next
        For i = 0 To 3
            Read __h(i)
            For j = 0 To 1
                Read swordAnimX%(i,j),swordAnimY%(i,j)
            Next
        Next
                                                   ---  Read fatigue effects  ---
        For i = 1 To 5
            Read fatigueEffectOfAttack(i)
        Next
                                                  ---  Read armour information  ---
        Data "None",0,0,"Leather",150,30,"Ringmail",350,100,"Chainmail",500,150
        Data "Partial Plate",750,250,"Full Plate",1000,1000,"Intelligence","Intuition"
        Data "Ego","Strength","Constitution","Dexterity"
        For i = 0 To 5
            Read armourName$(i),armourWeight(i),armourPrice(i)
            armourWeight(i) = Int(armourWeight(i) / 16 + .5)
        Next
                                              ---  Read characteristic information  ---
        armourWeight(0) = 0
        For i = 1 To 6
            Read statName$(i)
        Next i
        Data "None",0,0,0,0,0,18
        Data "Dagger",1,5,5,3,7,12,"Shortsword",2,14,6,8,9,12,"Broadsword",3,18,7,10
        Data 9,13,"Hand-and-a-half Sword",6,35,8,16,9,14,"Great Sword",9,70,10,15,7,1
                                              ---  Set up attack action modifiers  ---
        chanceMonsterHitOnAction(0) = 3
        attackDamageOnAction(1) = 0
        chanceMonsterHitOnAction(1) = 0
        attackDamageOnAction(2) = 3
        chanceMonsterHitOnAction(2) = 3
        attackDamageOnAction(3) = - 6
        chanceMonsterHitOnAction(3) = - 2
        chanceMonsterHitOnAction(4) = 5
        chanceMonsterHitOnAction(5) = 5
        Data "Magic Sword","None","Small","Large"
                                                  ---  Read sword information  ---
        For i = 0 To 5
            Read swordName$(i),swordWeight(i),swordPrice(i),swordDamage(i),strengthForSword(i)
            For j = 0 To 1
                Read swordDexterityAdjust(i,j)
            Next
                                                  ---  Read shield information  ---
        Next
        Read swordName$(6)
        For i = 0 To 2
            Read shieldName$(i)
        Next
        Data 6,3,10,8,15,12,5,15,6,17
        For i = 1 To 2
            Read shieldWeight(i),swordTypeToID(i),shieldPrice(i)
            For j = 0 To 1
                Read shieldDexterityAdjust(i - 1,j)
            Next
        Next
        Data "I'd not part with these fine goods for that pittance! Mayhap for",5
        Data "Not so cheap my friend! But for thee just",10
        Data "Blackheart! Thou takest food from my children's mouths! No less than"
        Data 5,"Well, life is short and thy arse long! What say thee to",2
        Data "hmm...such fine workmanship. I could notpart with this for less than"
        Data 10,"A pox on thee! But I'd take",3
                                            ---  Read innkeeper response information  ---
        possInnAnswers = 6
        totalResponseProbability = 0
        For i = 1 To possInnAnswers
            Read innResponse$(i),responseProbability(i)
            totalResponseProbability = totalResponseProbability + responseProbability(i)
        Next
        Data "room no.:    "," ","wounds:     %","fatigue:    %"," ","wgt:     lbs"
        Data " ","arrows:     ","magic ar:    "," "," "," ","{176}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{174}"," "
        Data "{VBar}             {VBar}","{173}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{189}"," ","{176}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{174}","{VBar}           {VBar}"
        Data "{VBar}           {VBar}","{173}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{HBar}{189}","total slain:","     ","           "
                                                     ---  Read text strings  ---
        For i = 0 To 22
            Read textPrompt$(i)
        Next i
        textPrompt$(13) = textPrompt$(14)
        Read space11$
        space13$ = space11$ + "   "
        space12$ = space11$ + " "
        Goto Innkeeper@607
        ********************************************************************************************************************
                                           Lose one wound point, also reduce constitution
        ********************************************************************************************************************
ReduceConstitution@274
        wounds = wounds - 1
        stats(5) = stats(5) - 1
        initQualities(5) = initQualities(5) - 1
        Return
        ********************************************************************************************************************
                                                   Switch the PET to Graphic Mode.
        ********************************************************************************************************************
SwitchToGraphicMode@277
        Print Chr$(14);
        For i = 1 To 40
        Next
        Print Chr$(142);
        Return
        ********************************************************************************************************************
                                                    Update weight carried display
        ********************************************************************************************************************
UpdateWeight@280
        x = 53
        y = 5
        Gosub MoveToXY@352
        Print weightCarried;
        Return
        ********************************************************************************************************************
                                                 Set Monster position in game space
        ********************************************************************************************************************
PutMonsterInGameSpace@283
        yy = wallTop - wallBottom - 4
        If yMonster > yy Then
            yMonster = yy
        If yMonster < 4 Then
            yMonster = 4
        xx = wallRight - wallLeft - 4
        If xMonster > xx Then
            xMonster = xx
        ********************************************************************************************************************
                                                   Erase the monster message area
        ********************************************************************************************************************
EraseMonsterMessageArea@292
        If xMonster < 4 Then
            xMonster = 4
        x = 50
        y = 18
        Gosub MoveToXY@352
        Print space11$;
        y = 19
        Gosub MoveToXY@352
        Print space11$;
        Return
        ********************************************************************************************************************
                                                       Announce j arrows found
        ********************************************************************************************************************
AnnounceArrowsFound@298
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print j;"arrows";
        Return
        ********************************************************************************************************************
                                                     Announce Monster a$ appears
        ********************************************************************************************************************
AnnounceMonster@301
        x = 50
        y = 13
        Gosub MoveToXY@352
        Print space12$;
        Gosub MoveToXY@352
        Print a$;
        y = 14
        Gosub MoveToXY@352
        Print "appears!";
        Return
        ********************************************************************************************************************
                                                  Update display of killed monsters
        ********************************************************************************************************************
UpdateKillCount@307
        a$ = "   "
        j = 1739
        Gosub PokeA$IntoScreenAtJ@349
        a$ = Str$(killCount)
        Gosub PokeA$IntoScreenAtJ@349
        Return
        ********************************************************************************************************************
                                                   Animated effect for player hit.
        ********************************************************************************************************************
FlashPlayer@310
        j = xPlayer - xRoomBase + screenRAM + 80 * Int((yPlayer - yRoomBase) / 2)
        l = Peek(j)
        Poke j,166
        For i = 1 To 30
        Next i
        Poke j,l
        Return
        ********************************************************************************************************************
                                                        Update Wounds Display
        ********************************************************************************************************************
UpdateWounds@316
        a$ = "    "
        j = 215
        Gosub PokeA$IntoScreenAtJ@349
        i = Int(100 * wounds / stats(5) + .5)
        a$ = Str$(i)
        Gosub PokeA$IntoScreenAtJ@349
        Return
        ********************************************************************************************************************
                                                       Get a number key press.
        ********************************************************************************************************************
GetDigit@322
        Gosub GetKey@490
        If l = 0 Goto GetDigit@322
        j = Asc(c$) - 48
        If j < 0 Or j > 9 Goto GetDigit@322
328
        Return
        ********************************************************************************************************************
                                                       Update displayed arrows
        ********************************************************************************************************************
UpdateArrows@331
        a$ = Str$(arrows)
        j = 616
        Goto 337
        ********************************************************************************************************************
                                                    Update displayed magic arrows
        ********************************************************************************************************************
UpdateMagicArrows@334
        a$ = Str$(magicArrows)
        j = 696
337
        For i = 2 To Len(a$)
            Poke screenRAM + j + i, Asc(Mid$(a$,i,1))
        Next i
        For i = Len(a$) + 1 To 5
            Poke screenRAM + j + i,32
        Next i
        Return
        ********************************************************************************************************************
                                               Clear the 10th line down in status area
        ********************************************************************************************************************
ClearLine10@343
        x = 49
        y = 10
        Gosub MoveToXY@352
        Print space13$;
        Return
        ********************************************************************************************************************
                                                   Reset all room displayed flags
        ********************************************************************************************************************
ClearDisplayedFlags@346
        For i = 1 To 60
            roomOnScreen%(i) = 0
        Next i
        Return
        ********************************************************************************************************************
                                 Poke string a$ into screen RAM at offset J, except first Character
        ********************************************************************************************************************
PokeA$IntoScreenAtJ@349
        For i = 2 To Len(a$)
            Poke i + j + screenRAM, Asc(Mid$(a$,i,1))
        Next i
        Return
        ********************************************************************************************************************
                                                       Move the cursor to x,y
        ********************************************************************************************************************
MoveToXY@352
        Poke 226,x
        Poke 224,y
        Print "{19}";
        Poke 226,0
        Poke 224,0
        Return
        ********************************************************************************************************************
                                                     Clear Game Area, not status
        ********************************************************************************************************************
ClearGameArea@355
        Poke 213,47
        Print "{Clr}";
        Poke 213,79
        Return
        ********************************************************************************************************************
                                                         Draw Vertical Line
        ********************************************************************************************************************
DrawVerticalLine@358
        l1 = yy
        l2 = yy + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
        l3 = Int((l1 + 1) / 2)
        l4 = Int((l2 - 1) / 2)
        xPixel = xx
        If xPixel < 0 Or xPixel > 47 Then
            Return
        If l1 And 1 Then
            yPixel = l1
            Gosub FastDrawPixel@469
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub FastDrawPixel@469
        If Not l2 And 1 Then
            yPixel = l2
            Gosub FastDrawPixel@469
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub FastDrawPixel@469
        If l4 > = l3 Then
            nx = screenRAM + xx + 80 * l3
            For ny = l3 To l4
                Poke nx,160
                Poke nx + 1,160
                nx = nx + 80
            Next
        Return
        ********************************************************************************************************************
                                                         Erase Vertical Line
        ********************************************************************************************************************
EraseVerticalLine@382
        l1 = yy
        l2 = yy + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
        l3 = Int((l1 + 1) / 2)
        l4 = Int((l2 - 1) / 2)
        xPixel = xx
        If xPixel < 0 Or xPixel > 47 Then
            Return
        If i1 = 0 Then
            
            For yPixel = l1 To l2
                Gosub FastErasePixel@475
            Next
            Return
        If l1 And 1 Then
            yPixel = l1
            Gosub FastErasePixel@475
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub FastErasePixel@475
                xPixel = xx
        If Not l2 And 1 Then
            yPixel = l2
            Gosub FastErasePixel@475
            If i1 = 1 Then
                xPixel = xPixel + 1
                Gosub FastErasePixel@475
        If l4 > = l3 Then
            nx = screenRAM + xx + 80 * l3
            For ny = l3 To l4
                Poke nx,32
                Poke nx + 1,32
                nx = nx + 80
            Next
        Return
        ********************************************************************************************************************
                                                        Draw Horizontal Line
        ********************************************************************************************************************
DrawHorizontalLine@409
        l1 = xx
        l2 = l1 + l - 1
        If l1 < 0 Then
            l1 = 0
            If l1 < 0 Then
                Return
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
        yPixel = yy
        If yPixel < 0 Or yPixel > 47 Then
            Return
        If yy And 1 Then
            For yPixel = yy To yy + 1
                For xPixel = l1 To l2
                    Gosub FastDrawPixel@469
                Next
            Next
            Return
        If l2 > = l1 Then
            ny = screenRAM + yy * 40
            For nx = l1 To l2
                Poke ny + nx,160
            Next
        Return
        ********************************************************************************************************************
                                                        Erase Horizontal Line
        ********************************************************************************************************************
EraseHorizontalLine@427
        l1 = xx
        l2 = l1 + l - 1
        If l1 < 0 Then
            l1 = 0
            If l2 < 0 Then
                Return
        If l2 > 47 Then
            l2 = 47
            If l1 > 47 Then
                Return
        yPixel = yy
        If yPixel < 0 Or yPixel > 47 Then
            Return
        If yy And 1 Or i1 = 0 Then
            For yPixel = yy To yy + i1
                For xPixel = l1 To l2
                    Gosub FastErasePixel@475
                Next
            Next
            Return
        If l2 > = l1 Then
            ny = screenRAM + yy * 40
            For nx = l1 To l2
                Poke ny + nx,32
            Next
        Return
        ********************************************************************************************************************
                                                       Draw Player on display
        ********************************************************************************************************************
DrawPlayer@445
        xx = xPlayer - xRoomBase
        yy = yRoomBase - yPlayer
        Poke 86,xx
        Poke 87,yy
        Poke 88,dirPlayer
        Sys 640
        Return
        ********************************************************************************************************************
                                                       Erase Player on display
        ********************************************************************************************************************
ErasePlayer@448
        xx = xPlayer - xRoomBase
        yy = yRoomBase - yPlayer
        Poke 86,xx
        Poke 87,yy
        Poke 88,dirPlayer
        Sys 643
        Return
        ********************************************************************************************************************
                                                            Draw Monster
        ********************************************************************************************************************
DrawMonster@451
        k = 1
454
        j = monsterInfo%(currentMonsterID,6)
        For i = 0 To monsterPixelCount%(j) - 1
            xPixel = xMonster + wallLeft - xRoomBase + xMonsterPixel%(i,j)
            yPixel = yRoomBase - yMonster - wallBottom + yMonsterPixel%(i,j)
            On k Gosub DrawPixel@466,ErasePixel@472
        Next i
        Return
        ********************************************************************************************************************
                                                    Erase Monster if one present
        ********************************************************************************************************************
EraseMonsterIfExists@460
        If isMonsterActive = 0 Then
            Return
        ********************************************************************************************************************
                                                            Erase Monster
        ********************************************************************************************************************
EraseMonster@463
        k = 2
        Goto 454
        ********************************************************************************************************************
                                                            Draw a Pixel
        ********************************************************************************************************************
DrawPixel@466
        If xPixel < 0 Or xPixel > 47 Then
            Return
        ********************************************************************************************************************
                                                    Draw a Pixel without checking
        ********************************************************************************************************************
FastDrawPixel@469
        Poke 86,xPixel
        Poke 87,yPixel
        Sys 634
        Return
        ********************************************************************************************************************
                                                            Erase a Pixel
        ********************************************************************************************************************
ErasePixel@472
        If xPixel < 0 Or xPixel > 47 Or yPixel < 0 Or yPixel > 47 Then
            Return
        ********************************************************************************************************************
                                                   Erase a Pixel without checking
        ********************************************************************************************************************
FastErasePixel@475
        Poke 86,xPixel
        Poke 87,yPixel
        Sys 637
        Return
        ********************************************************************************************************************
                                                  Graphic display when monster hit
        ********************************************************************************************************************
MonsterHitAnimation@478
        xPixel =(xMonster + wallLeft - xRoomBase)
        yPixel = Int((yRoomBase - yMonster - wallBottom) / 2)
        j = screenRAM + xPixel + 80 * yPixel
        l = Peek(j)
        For i = 1 To 100
            Poke j,219
            k = k / 5
            Poke j,l
        Next i
        Return
        ********************************************************************************************************************
                                  Gets key, with timed exit into c$, l is non-zero if key pressed.
        ********************************************************************************************************************
GetKey@490
        keyLoopCount = monsterSpeed /(isMonsterActive + 1)
        For keyTimeCount = 1 To keyLoopCount
            Get c$
            If Len(c$) > 0 Then
                l = 1
                For bufferClear = 1 To 10
                    Get clear$
                Next bufferClear
                Return
        Next keyTimeCount
        l = 0
        Return
        ********************************************************************************************************************
                                                   Draw or erase sword animation.
        ********************************************************************************************************************
DrawEraseSword@499
        ii = xPlayerRoom - xRoomBase + wallLeft
        ij = yRoomBase - yPlayerRoom - wallBottom
        For l = 0 To 1
            xPixel = ii + swordAnimX%(dirPlayer - 1,l)
            yPixel = ij + swordAnimY%(dirPlayer - 1,l)
            On k + 1 Gosub DrawPixel@466,ErasePixel@472
        Next l
        Return
        ********************************************************************************************************************
                                                     Update the Fatigue Display
        ********************************************************************************************************************
UpdateFatigue@508
        fatigue = Int(fatigue -(Abs(m) / energyLossScalar *(100 / stats(5) + 5 - 5 * wounds / stats(5)) *(1 + weightCarried / initialStrength * 3) / 2) + 11)
        a$ = "    "
        j = 295
        Gosub PokeA$IntoScreenAtJ@349
        If fatigue > 100 Then
            fatigue = 100
        a$ = Str$(fatigue)
        If fatigue < 0 Then
            a$ = "-" + a$
        Gosub PokeA$IntoScreenAtJ@349
        Return
        ********************************************************************************************************************
                                                          Do trap animation
        ********************************************************************************************************************
TrapAnimation@520
        yPixel = yRoomBase - yTrap%(currentRoom) - wallBottom
        xPixel = xTrap%(currentRoom) + wallLeft - xRoomBase
        For l = 1 To 10
            Gosub DrawPixel@466
            Gosub ErasePixel@472
        Next l
        Return
        ********************************************************************************************************************
                                          Update the treasure display in the current room.
        ********************************************************************************************************************
UpdateTreasureDisplay@523
        If roomTreasureID%(currentRoom) = 0 Then
            Return
        ********************************************************************************************************************
                                    Update the treasure display in the current room, no checking.
        ********************************************************************************************************************
UpdateTreasureDisplayNoCheck@526
        xPixel = wallLeft + xTreasure%(currentRoom) - xRoomBase
        yy = yRoomBase - wallBottom - yTreasure%(currentRoom)
        For yPixel = yy - 1 To yy
            If roomTreasureID%(currentRoom) = 0 Then
                Gosub ErasePixel@472
            If roomTreasureID%(currentRoom) > 0 Then
                Gosub DrawPixel@466
        Next yPixel
        Return
        ********************************************************************************************************************
                                                        Check for Trap fired
        ********************************************************************************************************************
TrapCheck@538
        id = roomTrapID%(currentRoom)
        l = 0
        If isMonsterActive > 0 Or id = 0 Then
            Return
        If Abs(xPlayerRoom - xTrap%(currentRoom)) > 2 Or Abs(yPlayerRoom - yTrap%(currentRoom)) > 2 Or Rnd(0) * 100 > treasureInfo%(id,2) Then
            Return
        Gosub ClearLine10@343
        x = 49
        y = 10
        Gosub MoveToXY@352
        Print trapName$(treasureInfo%(id,4));" trap";
        Gosub FlashPlayer@310
        i = treasureInfo%(id,3)
        If i > 0 Then
            isMonsterActive = 1
            Gosub 1249
            xMonster = xTrap%(currentRoom)
            yMonster = yTrap%(currentRoom)
            Gosub AnnounceMonster@301
            Goto 556
        If treasureInfo%(id,5) > 0 Then
            monsterLevel = treasureInfo%(id,5)
            l = 1
            monsterDamage = 3 * monsterLevel
556
        roomTrapID%(currentRoom) = 0
        Return
        ********************************************************************************************************************
                                                     Read data for current room
        ********************************************************************************************************************
ReadCurrentRoomData@559
        ll = currentRoom
        Goto 565
        ********************************************************************************************************************
                                                      Read data for given room
        ********************************************************************************************************************
ReadRoomData@562
        ll = wkRoom
565
        loadWallLeft = wallLeft%(ll)
        loadWallRight = wallRight%(ll)
        loadWallTop = wallTop%(ll)
        loadWallBottom = wallBottom%(ll)
        If ll < > currentRoom Then
            Return
        wallLeft = loadWallLeft
        wallRight = loadWallRight
        wallTop = loadWallTop
        wallBottom = loadWallBottom
        Return
        ********************************************************************************************************************
                                                 Get current monster name (unused ?)
        ********************************************************************************************************************
        a$ = monsterName$(currentMonsterID)
        Return
        ********************************************************************************************************************
                                                             Title Page
        ********************************************************************************************************************
TitlePage@574
        j% = 0
        Print "{Clr}"
577
        For i = 0 To 79
            Poke screenRAM + j% + i,160
        Next i
        If j% = 0 Then
            j% = 23 * 80
            Goto 577
        For i = 0 To j% Step 80
            Poke screenRAM + i,160
            Poke screenRAM + i + 79,160
        Next i
        Print "{Down}{Down}{Down}" Tab(32);"dunjonquest (tm)"
        Print "{Down}{Down}{Down}" Tab(30);"the temple of apshai"
        Print "{Down}{Down}{Down}{Down}{Down}{Down}" Tab(33);"copyright 1979"
        Print Tab(29);"{Down}automated  simulations"
        For i = 21 * 80 + 1 To 22 * 80 - 2
            Poke screenRAM + i,230
        Next i
        Print "{Down}{Down}{Down}" Tab(30);"hit any key to begin"
                                              ---  Wait for key while randomising.  ---
601
        Get a$
        combatChance = Rnd(0)
        If Len(a$) = 0 Goto 601
        Return
        ********************************************************************************************************************
        ********************************************************************************************************************
                                                     Innkeeper code starts here
        ********************************************************************************************************************
        ********************************************************************************************************************
Innkeeper@607
        Print Chr$(130); Chr$(142);
        If keepCurrentPlayer < > 123 Then
            Gosub TitlePage@574
        Print Chr$(14)"{Clr}Thus quoth the Innkeeper:"
        If keepCurrentPlayer < > 123 Goto NewCharacter@634
        Gosub 1915
        Gosub 1306
        Print "I trust thy sojourn in the Temple was pleasant."
        Input "Wouldst thou return thereto";a$
        If Left$(a$,1) < > "y" Goto NewCharacter@634
        Gosub 1906
        Input "How many silver pieces hast thou";silver
        originalMoney = silver
        If silver > 0 Then
            Gosub BuySword@970
        Goto 652
                                                  ---  Not re-entering dungeon  ---
NewCharacter@634
        keepCurrentPlayer = 0
        Print "{Down}Hail and well met O noble Adventurer!"
        Print "{Down}Hast thou a character already, or should"
        Print "{Down}I find thee one; say yea if I should";
        Input a$
        If Left$(a$,1) = "y" Then
            Gosub CreateCharacter@766
        If Left$(a$,1) < > "y" Then
            Gosub InputCharacter@793
            Gosub 1306
            For i = 1 To 1500
            Next i
        originalMoney = silver
        Input "Thy character's name";playerName$
        If silver > 0 Then
            Gosub BuySword@970
652
        If silver > 0 Then
            Gosub 1027
        If shieldID = 0 Then
            weaponMagicPowerAdjust = weaponMagicPowerAdjust + shieldPower
            shieldPower = 0
        attSkill = attSkill - weaponMagicPowerAdjust - Int(ll / 2)
        If weaponMagicPowerAdjust > 0 Then
            defSkill = defSkill + weaponMagicPowerAdjust - 1
        If weaponMagicPowerAdjust < 0 Then
            defSkill = defSkill + weaponMagicPowerAdjust + 1
        If silver > 0 Then
            Gosub BuyArmour@733
        If silver > 0 Then
            Gosub BuyBow@1072
        If silver > 0 Then
            Gosub BuySalves@1105
        monsterSpeed = 300
        Input "Monster speed (slow,medium, or fast)";a$
        If Left$(a$,1) = "s" Then
            monsterSpeed = 600
        If Left$(a$,1) = "f" Then
            monsterSpeed = 150
        startWeightCarried = Int(5 + swordWeight(swordID) + armourWeight(armourID) + shieldWeight(Int(shieldID / 2)) + 1 +(arrows + magicArrows) / 10)
        weightCarried = startWeightCarried
        Gosub 1306
        keepCurrentPlayer = 123
        ********************************************************************************************************************
                                                   Load Dungeon in from Disk/Tape
        ********************************************************************************************************************
        Input "What level wouldst thou visit (1-12)";levelDungeon
        filename$ = driveNumber$ + ":level " + Chr$(levelDungeon + 64)
        If currentLoadLevel = levelDungeon Goto 730
        currentLoadLevel = levelDungeon
        k = 0
        Open 2,currentDevice%,2,filename$
        Input# 2,levelDungeon,xStart,yStart,initialDirection,roomRisk,__bg
        xPlayer = xStart
        yPlayer = yStart
        dirPlayer = initialDirection
        For i = 1 To roomCount
            For j = 0 To 3
                Input# 2,roomInDir(i,j),exitRoom(i,j),doorLower(i,j),doorUpper(i,j)
            Next
        Next
        For i = 1 To roomCount
            Input# 2,monsterTypeForRoom%(i),roomMonsterCount%(i),roomTrapID%(i),xTrap%(i),yTrap%(i),roomTreasureID%(i),xTreasure%(i),yTreasure%(i)
            Input# 2,wallLeft%(i),wallTop%(i),wallRight%(i),wallBottom%(i)
        Next
        For i = 1 To 12
            Input# 2,monsterName$(i)
            For j = 0 To 10
                Input# 2,monsterInfo%(i,j)
            Next
        Next
        For i = 1 To 20
            Input# 2,treasureName$(i)
            For j = 0 To 6
                Input# 2,treasureInfo%(i,j)
            Next
        Next
        Close 2
730
        Print Chr$(14)"{Clr}"
        Goto EnterDungeon@1369
        ********************************************************************************************************************
                                                          Armour purchasing
        ********************************************************************************************************************
BuyArmour@733
        Input "Wilt thou buy new armor";a$
        If Left$(a$,1) = "n" Then
            Return
        Print "{Clr}type" Tab(25);"weight" Tab(32);"price"
        For i = 1 To 5
            Print armourName$(i); Tab(25);armourWeight(i); Tab(32);armourPrice(i)
        Next i
742
        Print "What sort of armor wouldst thou wear"
        Input a$
        Gosub CapitaliseFirst@1981
        If Left$(a$,1) = "N" Then
            armourMagic = 0
            armourID = 0
            Return
        For i = 1 To 5
            If Left$(a$,2) = Left$(armourName$(i),2) Then
                id = i
                Goto 754
        Next i
        Print "I have not "a$;" for sale"
        Goto 742
754
        lowestPrice = .3 * armourPrice(id)
        attackDamage = armourPrice(id)
        firstPrice = attackDamage
        Gosub AcceptCheckOffer@1129
        If offer = 0 Goto 742
757
        armourID = id
        armourMagic = 0
        silver = silver - offer
        Print "Thou hast"silver;" silver pieces left in thy purse"
        Return
        ********************************************************************************************************************
                                             Generate one of the player characteristics
        ********************************************************************************************************************
GeneratePlayerValue@763
        j = Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1)
        Return
        ********************************************************************************************************************
                                                     Create a character randomly
        ********************************************************************************************************************
CreateCharacter@766
        hasBow = 0
        charTotal = 0
        For i = 1 To 6
            Gosub GeneratePlayerValue@763
            stats(i) = j
            charTotal = charTotal + j
            initQualities(i) = j
        Next i
        If charTotal < 60 Or stats(4) < 8 Or stats(5) < 7 Goto CreateCharacter@766
        experience = 0
        arrows = 0
        magicArrows = 0
        armourID = 0
        armourMagic = 0
        shieldID = 0
        swordID = 0
        shieldPower = 0
        weaponMagicPowerAdjust = 1
        swordMagic = 0
        healingSalves = 0
        elixirs = 0
        ll = 0
        Print "{Clr}Thy qualities:"
        For i = 1 To 6
            Print statName$(i); Tab(15);stats(i)
        Next i
        Print " "
        Gosub GeneratePlayerValue@763
        silver = j * 10
        Print "Thou hast"silver;" pieces of Silver"
        l = 1
        Gosub 790
784
        defSkill = 11
        attSkill = 11
        Return
790
        For i = 1 To 10
            __si%(i) = 0
        Next i
        Return
        ********************************************************************************************************************
                                                     Input a character manually.
        ********************************************************************************************************************
InputCharacter@793
        ll = 0
        For i = 1 To 6
            Print "enter "statName$(i);
            Input stats(i)
            initQualities(i) = stats(i)
            If stats(i) > 18 Then
                Print stats(i);"be too high. no more than 18 can it be"
                i = i - 1
        Next i
        Input "Thy character's experience is";experience
        If experience > 16000000 Then
            Print "Thy character be too worldwise, find another"
            Goto InputCharacter@793
        ex1000 = experience / 1000
        For l = 1 To 20
            If 2 ^ l > ex1000 Then
                Goto 814
        Next l
814
        Input "How much money hast thou to spend";silver
        Gosub 889
820
        Print "What kind of Sword hast thou"
        Input a$
        Gosub CapitaliseFirst@1981
        For i = 0 To 5
            If Left$(a$,1) = Left$(swordName$(i),1) Then
                id = i
                offer = 0
                Goto 832
        Next i
        Print "Thou canst not take a "a$;" to the Dunjon. Thou must buy another."
        Goto 820
832
        If strengthForSword(id) < = stats(4) Then
            Gosub 1012
            Goto 838
        Print "Thou canst not wield such a great weapon"
        Goto 820
838
        Print "What sort of Armor dost thou wear"
        Input a$
        Gosub CapitaliseFirst@1981
        For i = 0 To 5
            If Left$(a$,2) = Left$(armourName$(i),2) Then
                id = i
                offer = 0
                Gosub 757
                Goto 847
        Next i
        Print "Thou canst not wear "a$;" in the Dunjon"
        Goto 838
847
        Input "Hast thou a shield";a$
        id = 0
        If Left$(a$,1) < > "y" Goto 856
        Input "Be it large or small";a$
        Gosub CapitaliseFirst@1981
        id = 1
        If Left$(a$,1) = "L" Then
            id = 2
        If id > 0 Then
            Gosub 1051
856
        Input "Hast thou a bow";a$
        hasBow = 0
        If Left$(a$,1) = "y" Then
            hasBow = 1
        Input "How many arrows hast thou";arrows
        Input "How many magic arrows hast thou";magicArrows
        Input "How many healing potions hast thou";elixirs
        Input "How many healing salves hast thou";healingSalves
        If healingSalves > 10 Then
            healingSalves = 10
        swordMagic = 0
        If swordID > 0 Then
            Input "Be thy sword magical";a$
        If Left$(a$,1) = "y" Then
            Input "What be the plus";swordMagic
        armourMagic = 0
        If armourID = 0 Goto 886
        Input "Is thy armor Magical";a$
        If Left$(a$,1) = "y" Then
            Input "What be the plus";armourMagic
886
        Gosub 790
        Goto 784
889
        weaponMagicPowerAdjust = l
        shieldPower = 0
        If wallBottom < > 1 Then
            weaponMagicPowerAdjust = Int((l + 1) / 2)
            shieldPower = l - weaponMagicPowerAdjust
        If l = ll Then
            Return
        ll = l
        j = l - 1
898
        If j > 5 Then
            j = j - 5
            Goto 898
        If keepCurrentPlayer = 123 Then
            l = 2
            On j + 1 Goto 889,904,913,922,928,940
904
        l = l - 1
        If l = 0 Goto 949
        If stats(5) < 9 Then
            stats(5) = stats(5) + 1
            Goto 913
        stats(4) = stats(4) + 1
913
        l = l - 1
        If l = 0 Goto 949
        If stats(6) < 9 Then
            stats(6) = stats(6) + 1
            Goto 922
        stats(5) = stats(5) + 1
922
        l = l - 1
        If l = 0 Goto 949
        stats(5) = stats(5) + 1
928
        l = l - 1
        If l = 0 Goto 949
        If stats(6) < 9 Then
            stats(6) = stats(6) + 1
            Goto 940
        If stats(4) < stats(5) Then
            stats(4) = stats(4) + 1
            Goto 940
        stats(5) = stats(5) + 1
940
        l = l - 1
        If l = 0 Goto 949
        If stats(2) < stats(3) Then
            stats(2) = stats(2) + 1
            Goto 904
        stats(3) = stats(3) + 1
        Goto 904
949
        For i = 1 To 6
            m = stats(i) - 18
            If m < = 0 Goto 967
            stats(i) = 18
            For j = 1 To m
                If stats(4) < 18 Then
                    stats(4) = stats(4) + 1
                    Goto 964
                If stats(5) < 18 Then
                    stats(5) = stats(5) + 1
                    Goto 964
                If stats(6) < 18 Then
                    stats(6) = stats(6) + 1
                    Goto 964
                combatChance = Int(3 * Rnd(1) + .999)
                stats(combatChance) = stats(combatChance) + 1
964
            Next j
967
        Next i
        Return
        ********************************************************************************************************************
                                                        Sword purchasing code
        ********************************************************************************************************************
BuySword@970
        Print "Wilt thou buy one of our fine Swords";
        Input a$
        If Left$(a$,1) < > "y" Then
            id = __0
            Gosub 1015
            Return
        wallBottom = 0
        Print "weapon" Tab(24);"weight" Tab(35);"price"
        For i = 1 To 5
            Print swordName$(i); Tab(24);swordWeight(i); Tab(34);swordPrice(i)
        Next i
982
        Print "{Down}What weapon wilt thou purchase"
        Input a$
        Gosub CapitaliseFirst@1981
        For i = 1 To 5
            If Left$(a$,1) = Left$(swordName$(i),1) Then
                id = i
                Goto 994
        Next i
        If Left$(a$,1) = "n" Then
            id = swordID
            Gosub 1015
            Return
        Print "I have not such a weapon as a "a$
        Goto 982
994
        If strengthForSword(id) > stats(4) Then
            Print "Thou cannot wield such a Great Weapon"
            Goto 982
        Print "Feast thy eyes 'pon this fine "swordName$(id)
        j = Int(Rnd(1) + 1)
        If j > 2 Then
            Print "'Tis sure to always drink thy Foe's blood"
        If j < 3 Then
            Print "'Tis well-forged iron"
        lastOffer = 0
        lowestPrice = .3 * swordPrice(id)
        attackDamage = swordPrice(id)
        firstPrice = attackDamage
        Gosub AcceptCheckOffer@1129
        If offer = 0 Goto 982
        silver = silver - offer
        Print "Thou hast"silver;" silver pieces left"
1012
        swordPower = Int(swordDamage(id) * stats(4) / 10 + .5)
        swordMagic = 0
        swordID = id
        If id = 5 Then
            wallBottom = 1
1015
        If swordDexterityAdjust(id,0) > stats(6) Then
            weaponMagicPowerAdjust = weaponMagicPowerAdjust + stats(6) - swordDexterityAdjust(id,0)
        If swordDexterityAdjust(id,1) < stats(6) Then
            weaponMagicPowerAdjust = weaponMagicPowerAdjust + stats(6) - swordDexterityAdjust(id,1)
        If weaponMagicPowerAdjust > 0 Then
            weaponMagicPowerAdjust = Int(1.3 * Log(weaponMagicPowerAdjust) + 1)
        Return
1027
        If wallBottom = 1 Then
            shieldID = 0
            shieldPower = 0
            Return
        ********************************************************************************************************************
                                                       Shield purchasing code
        ********************************************************************************************************************
BuyShield@1030
        Input "Wilt thou buy a shield";a$
        If Left$(a$,1) = "n" Then
            Gosub 1063
            Return
        Print "shield     weight     ask"
        Print "small" Tab(11);shieldWeight(1); Tab(22)shieldPrice(1)
        Print "large" Tab(11);shieldWeight(2); Tab(22);shieldPrice(2)
        Input "What sort";a$
        id = 0
        Gosub CapitaliseFirst@1981
        If Left$(a$,1) = "L" Then
            id = 2
        If Left$(a$,1) = "S" Then
            id = 1
        If id = 0 Then
            Return
        lowestPrice = .3 * shieldPrice(id)
        attackDamage = shieldPrice(id)
        firstPrice = attackDamage
        Gosub AcceptCheckOffer@1129
        If offer = 0 Then
            Goto BuyShield@1030
1051
        If shieldDexterityAdjust(id - 1,0) > stats(6) Then
            shieldPower = shieldPower + stats(6) - shieldDexterityAdjust(id - 1,0)
        If shieldDexterityAdjust(id - 1,1) < stats(6) Then
            shieldPower = shieldPower + stats(6) - shieldDexterityAdjust(id - 1,1)
        silver = silver - offer
        Print "Thou hast"silver;" silver pieces left"
        shieldID = swordTypeToID(id)
        Gosub 1063
        Return
1063
        If shieldID = 5 Then
            shieldPower = Int(shieldPower / 2)
        If shieldPower > 0 Then
            shieldPower = Int(1.3 * Log(shieldPower) + 1)
        shieldPower = 2 * shieldID + shieldPower
        Return
        ********************************************************************************************************************
                                                         Bow purchasing code
        ********************************************************************************************************************
BuyBow@1072
        If hasBow > 0 Then
            Goto 1090
        Input "Wilt thou buy a bow";a$
        If Left$(a$,1) = "n" Then
            Return
        Print "I've a fine bow, Yew and nearly New, for12 silver pieces"
        lowestPrice = 4
        attackDamage = 12
        firstPrice = attackDamage
        Gosub AcceptCheckOffer@1129
        If offer = 0 Then
            Return
        silver = silver - offer
        Print "Thou hast"silver;" remaining"
        If arrows + magicArrows > = 60 Then
            arrows = 60 - magicArrows
            Goto 1102
1090
        id = 0
        Input "How many arrows wilt thou buy (at 5 coppers each)";id
        If Int((id + 1) / 2) > silver Then
            Print "No credit!"
            Goto 1090
        If arrows + magicArrows + id > 60 Then
            Print "Thou can carry but 60 - buy fewer"
            Goto 1090
        arrows = arrows + id
        silver = silver - Int((id + 1) / 2)
        Print "Thou hast"silver;" remaining"
1102
        Return
        ********************************************************************************************************************
                                                       Salves purchasing code
        ********************************************************************************************************************
BuySalves@1105
        Input "How many salves wilt thou buy - they'll cost thee 10 each";id
        If 10 * id > silver Then
            Print "no credit"
            Goto BuySalves@1105
        If id > 10 Then
            Print "More than 10 will do thee no good"
            id = 10 - healingSalves
        silver = silver - 10 * id
        healingSalves = healingSalves + id
        If silver < .35 * originalMoney Then
            Print playerName$;"! Thou spendthrift!"
        If silver > .7 * originalMoney Then
            Print playerName$;", Thou art frugal"
        Print "Thou hast"silver;" silver pieces left"
        Return
        ********************************************************************************************************************
                                         Code inputs offer, and checks if it is acceptable.
        ********************************************************************************************************************
AcceptCheckOffer@1129
        j = Rnd(0)
        If j > .66 Then
            Print "What be thy offer "playerName$;
        If j < = .66 Then
            Print "What offerest thou";
        Input offer
        If offer > silver Then
            Print "Liar -  thou hast but"silver
            Goto AcceptCheckOffer@1129
        If offer = 0 Then
            lastOffer = 0
            Return
        If offer < = lowestPrice Then
            Gosub 1354
            Goto AcceptCheckOffer@1129
        If offer < = lastOffer Then
            Gosub 1342
            Goto AcceptCheckOffer@1129
        If offer > = attackDamage Then
            Print "done"
            lastOffer = 0
            Return
        If offer < attackDamage - .3 * Sqr(Rnd(0)) * attackDamage Goto 1159
        lastOffer = 0
        If offer < .6 * firstPrice Then
            Print "Thou art a hard bargainer "playerName$
            Return
        Print "done"
        Return
1159
        If Rnd(0) < .995 Goto 1165
        Print "I see the gods look with favor on thee- so take it for that!"
        lastOffer = 0
        Return
1165
        attackDamage = offer +(attackDamage - offer) * Sqr(Rnd(0)) *(20 /(stats(1) + stats(3)))
        lastOffer = offer
        Gosub 1360
        Goto AcceptCheckOffer@1129
        ********************************************************************************************************************
        ********************************************************************************************************************
                                                        New Room drawing code
        ********************************************************************************************************************
        ********************************************************************************************************************
NewRoom@1174
        wkRoom = currentRoom
        Gosub ReadCurrentRoomData@559
        If roomOnScreen%(currentRoom) = 1 Goto 1186
        Print Chr$(142);
        Gosub ClearGameArea@355
        Gosub ClearDisplayedFlags@346
        xRoomBase = wallLeft
        yRoomBase = wallTop
        If exitRoom(wkRoom,3) = 1 Then
            xRoomBase = xRoomBase -(48 - wallRight + wallLeft) / 2
            If exitRoom(wkRoom,1) = 1 Then
                xRoomBase = xRoomBase +(wallLeft - xRoomBase) / 2
        If exitRoom(wkRoom,0) = 1 Then
            yRoomBase = yRoomBase + 48 - wallTop + wallBottom
            If exitRoom(wkRoom,2) = 1 Then
                yRoomBase = yRoomBase -(yRoomBase - wallTop) / 2
1186
        xRoomBase = Int(xRoomBase + .9)
        If Not xRoomBase And 1 Then
            xRoomBase = xRoomBase - 1
        yRoomBase = Int(yRoomBase + .9) And 254
1192
        xPlayerRoom = xPlayer - wallLeft
        yPlayerRoom = yPlayer - wallBottom
        If monsterTypeForRoom%(currentRoom) > 0 And roomMonsterCount%(currentRoom) > 0 Then
            Gosub 1225
            isMonsterActive = 1
            Goto 1201
        Gosub 1240
1201
        Poke 226,49
        Print "{19}";
        For y = 0 To 22
            Print textPrompt$(y)
        Next
        Poke 226,0
        x = 58
        y = 0
        Gosub MoveToXY@352
        Print currentRoom;
        Gosub UpdateWeight@280
        Gosub UpdateArrows@331
        Gosub UpdateMagicArrows@334
        Gosub UpdateFatigue@508
        Gosub UpdateWounds@316
        Gosub UpdateKillCount@307
        If isMonsterActive > 0 Then
            Gosub DrawMonster@451
            a$ = monsterName$(currentMonsterID)
            Gosub AnnounceMonster@301
        noWall = 5
        If pMoveResult = 3 Goto 1222
        For iRoom = 0 To 3
            wkRoom = roomInDir(currentRoom,iRoom)
            If exitRoom(currentRoom,iRoom) = 1 And wkRoom > 0 Then
                Gosub 1258
        Next iRoom
1222
        wkRoom = currentRoom
        Gosub 1258
        Gosub DrawPlayer@445
        Gosub UpdateTreasureDisplay@523
        Return
1225
        currentMonsterID = monsterTypeForRoom%(currentRoom)
        i = currentMonsterID
        isMonsterActive = 1
1228
        monsterLevel = monsterInfo%(i,0)
        monsterAttacksPerTurn = monsterInfo%(i,1)
        monsterWounds = monsterInfo%(i,2)
        monsterSize = monsterInfo%(i,9)
        monsterDamage = monsterInfo%(i,4)
        monsterHeal = monsterInfo%(i,5)
        __ih = 0
        a$ = monsterName$(currentMonsterID)
        Gosub AnnounceMonster@301
        xMonster = Int(Rnd(0) *(wallRight - wallLeft - 8)) + 4
        yMonster = Int(Rnd(0) *(wallTop - wallBottom - 8)) + 5
        monsterDir = Int(Rnd(0) * 4) + 1
        Return
1240
        l = Rnd(0)
        If l > roomRisk / 100 Then
            isMonsterActive = 0
            a$ = ""
            Return
1243
        l = Rnd(0)
        lastOffer = 0
        isMonsterActive = 1
        For i = 1 To monTypeCount
            lastOffer = lastOffer + monsterInfo%(i,8)
            If l < = lastOffer / 100 Goto 1249
        Next i
1249
        monsterTypeForRoom%(currentRoom) = i
        roomMonsterCount%(currentRoom) = 1
        currentMonsterID = i
        Goto 1228
1252
        l = Rnd(0)
        If l < roomRisk / 600 Goto 1243
        Return
1258
        If roomOnScreen%(wkRoom) = 1 Then
            Return
        Gosub ReadRoomData@562
        If loadWallLeft - xRoomBase > - 1 And loadWallRight - xRoomBase < 49 And yRoomBase - loadWallTop > - 1 And yRoomBase - loadWallBottom < 49 Then
            roomOnScreen%(wkRoom) = 1
        xx = loadWallRight - xRoomBase - 2
        For k = 1 To 3 Step 2
            yy = yRoomBase - loadWallTop
            If noWall = k Goto 1282
            l = loadWallTop - loadWallBottom
            ll = doorUpper(wkRoom,k) - doorLower(wkRoom,k)
            If ll + 4 = l Goto 1282
            i1 = 1
            If ll = 0 Then
                Gosub DrawVerticalLine@358
                Goto 1282
            If exitRoom(wkRoom,k) > 1 Then
                Gosub DrawVerticalLine@358
                Goto 1279
            l = l - doorUpper(wkRoom,k)
            Gosub DrawVerticalLine@358
            l = doorLower(wkRoom,k)
            yy = yRoomBase - loadWallBottom - l
            Gosub DrawVerticalLine@358
            Goto 1282
1279
            i1 = 2 - exitRoom(wkRoom,k)
            If i1 > = 0 And i1 < 2 Then
                yy = yRoomBase - loadWallBottom - doorUpper(wkRoom,k)
                l = ll
                Gosub EraseVerticalLine@382
1282
            xx = loadWallLeft - xRoomBase
        Next k
        yy = yRoomBase - loadWallTop
        For k = 0 To 2 Step 2
            If noWall = k Goto 1303
            xx = loadWallLeft - xRoomBase
            l = loadWallRight - loadWallLeft
            ll = doorUpper(wkRoom,k) - doorLower(wkRoom,k)
            If ll + 4 = l Goto 1303
            If ll = 0 Then
                Gosub DrawHorizontalLine@409
                Goto 1303
            If exitRoom(wkRoom,k) > 1 Then
                Gosub DrawHorizontalLine@409
                Goto 1300
            l = doorLower(wkRoom,k)
            Gosub DrawHorizontalLine@409
            l = loadWallRight - loadWallLeft - doorUpper(wkRoom,k)
            xx = loadWallRight - xRoomBase - l
            Gosub DrawHorizontalLine@409
            Goto 1303
1300
            i1 = 2 - exitRoom(wkRoom,k)
            If i1 > = 0 And i1 < 2 Then
                xx = loadWallLeft - xRoomBase + doorLower(wkRoom,k)
                l = ll
                Gosub EraseHorizontalLine@427
1303
            yy = yRoomBase - loadWallBottom - 2
        Next k
        Return
1306
        wID = swordID
        If swordMagic < > 0 Then
            wID = 6
        Print "{Clr}Character Summary for "playerName$
        Print " "
        For i = 1 To 6
            Print statName$(i); Tab(15);initQualities(i)
        Next i
        Print "{Down}Weapon:"swordName$(wID);
        If wID = 6 Then
            Print Tab(22);"plus:"swordMagic;
        Print " "
        Print "Armor :"armourName$(armourID);
        If armourMagic > 0 Then
            Print Tab(22);"plus:"armourMagic;
        j = 0
        If shieldID > 0 Then
            j = 1
            If shieldID > 3 Then
                j = 2
        Print " "
        Print "Shield:"shieldName$(j)
        Print "Arrows:"arrows; Tab(20);"Magic Arrows:"magicArrows
        Print "Salves:"healingSalves; Tab(20);"Elixirs:"elixirs
        Print "Experience:"experience; Tab(20);"Weight carried:"weightCarried
        Print "Silver:"silver
        Return
1342
        j = Int(Rnd(0) * 3 + 1)
        On j Goto 1345,1348,1351
1345
        Print "Dost thou take me for a dolt!"
        Return
1348
        Print "Fool or knave "playerName$;"! Make an offer higher than thy last!"
        Return
1351
        Print "Perchance thou wouldst not have this at all!"
        Return
1354
        If Rnd(0) > .5 Then
            Print "Ha! 'Tis less than I paid for it!"
            Return
        Print "I spit on thy paltry offer!"
        Return
1360
        combatChance = Rnd(0)
        responseProbabilityCtr = 0
        For i1 = 1 To possInnAnswers
            responseProbabilityCtr = responseProbabilityCtr + responseProbability(i1) / totalResponseProbability
            If responseProbabilityCtr > combatChance Then
                Print innResponse$(i1); Int(attackDamage + .99)
                Return
        Next i1
        ********************************************************************************************************************
        ********************************************************************************************************************
                                                 Enter the dungeon, loading complete
        ********************************************************************************************************************
        ********************************************************************************************************************
EnterDungeon@1369
        currentRoom = 1
        commandList$ = "rlatpfmgev!hqsydo"
        weightCarried = startWeightCarried
        energyLossScalar = 4
        fatigue = 100
        wounds = stats(5)
        strengthScalar = stats(4) / 10
        killCount = 0
        xPlayer = xStart
        yPlayer = yStart
        dirPlayer = initialDirection
        initialStrength = stats(4) * stats(4)
1375
        Gosub NewRoom@1174
        ?roomSize%(1) = wallTop - wallBottom
        ?roomSize%(2) = wallRight - wallLeft
        ?roomSize%(3) = 0
        ?roomSize%(4) = 0
        ?playerInRoom(1) = xPlayer - wallLeft
        ?playerInRoom(2) = yPlayer - wallBottom
        ?playerInRoom(3) = ?playerInRoom(1)
        ?playerInRoom(4) = ?playerInRoom(2)
        ?playerInRoom(0) = ?playerInRoom(2)
1381
        xPlayerRoomStart = xPlayerRoom
        yPlayerRoomStart = yPlayerRoom
        ia = 0
        Gosub GetKey@490
        m = 0
        Gosub ClearLine10@343
        Gosub EraseMonsterMessageArea@292
        If l = 0 Goto 1771
        If Asc(c$) > 47 And Asc(c$) < 58 Goto 1399
        For i = 1 To 17
            If c$ < > Mid$(commandList$,i,1) Goto 1396
            On i Goto 1507,1513,1525,1525,1525,1525,1525,1645,1633,1519,1726,1732,1750
            On i - 13 Goto 1762,1744,1705,1597
1396
        Next i
        Goto 1381
1399
        If fatigue < 1 Goto 1525
        m = Asc(c$) - 48
        moveDist = m
        pMoveResult = 0
        On dirPlayer Goto 1405,1417,1411,1423
1405
        If yPlayer + m > wallTop - 3 Then
            m = wallTop - 3 - yPlayer
            pMoveResult = 1
        Goto 1438
1411
        m = - m
        moveDist = m
        If yPlayer + m < wallBottom + 4 Then
            m = wallBottom + 4 - yPlayer
            pMoveResult = 1
        Goto 1438
1417
        If xPlayer + m > wallRight - 4 Then
            m = wallRight - 4 - xPlayer
            pMoveResult = 1
        Goto 1438
1423
        m = - m
        moveDist = m
        If xPlayer + m < wallLeft + 3 Then
            m = wallLeft + 3 - xPlayer
            pMoveResult = 1
        Goto 1438
        If isMonsterActive > 0 Goto 1771
        Goto 1792
1438
        If pMoveResult = 0 Goto 1474
        xPlayerRoom = xPlayer - wallLeft
        yPlayerRoom = yPlayer - wallBottom
        If exitRoom(currentRoom,dirPlayer - 1) < > 1 Goto 1474
        If ?playerInRoom(dirPlayer) < = doorLower(currentRoom,dirPlayer - 1) Or ?playerInRoom(dirPlayer) > = doorUpper(currentRoom,dirPlayer - 1) Goto 1453
        Gosub EraseMonsterIfExists@460
        isMonsterActive = 0
        monsterCharmed = 0
        currentRoom = roomInDir(currentRoom,dirPlayer - 1)
        Gosub ReadCurrentRoomData@559
        pMoveResult = 2
        m = Abs(m) + 4
        If currentRoom = 0 Goto 1930
1453
        If pMoveResult = 1 Goto 1474
        If wallLeft - xRoomBase < 0 Or wallRight - xRoomBase > 48 Or yRoomBase - wallTop < 0 Or yRoomBase - wallBottom > 48 Goto 1462
        pMoveResult = 3
        ?roomSize%(1) = wallTop - wallBottom
        ?roomSize%(2) = wallRight - wallLeft
        m = moveDist
        Gosub UpdateFatigue@508
        Goto 1474
1462
        If dirPlayer = 1 Then
            yPlayer = wallBottom + 4
            Goto 1375
        If dirPlayer = 3 Then
            yPlayer = wallTop - 3
            Goto 1375
        If dirPlayer = 2 Then
            xPlayer = wallLeft + 3
            Goto 1375
        xPlayer = wallRight - 4
        Goto 1375
1474
        Gosub ErasePlayer@448
        Gosub UpdateTreasureDisplay@523
        If dirPlayer = 1 Or dirPlayer = 3 Then
            yPlayer = yPlayer + m
            Goto 1480
        xPlayer = xPlayer + m
1480
        If magicalItems%(4) > 0 Then
            m = m / 2
        If xPlayer < wallLeft + 3 Then
            xPlayer = wallLeft + 3
        If xPlayer > wallRight - 4 Then
            xPlayer = wallRight - 4
        If yPlayer < wallBottom + 4 Then
            yPlayer = wallBottom + 4
        If yPlayer > wallTop - 3 Then
            yPlayer = wallTop - 3
        Gosub DrawPlayer@445
        ?playerInRoom(1) = xPlayer - wallLeft
        ?playerInRoom(3) = ?playerInRoom(1)
        ?playerInRoom(2) = yPlayer - wallBottom
        ?playerInRoom(4) = ?playerInRoom(2)
        ?playerInRoom(0) = ?playerInRoom(2)
        If pMoveResult = 3 Then
            wkRoom = currentRoom
            Gosub 1192
            pMoveResult = 0
            Goto 1381
        xPlayerRoom = xPlayer - wallLeft
        yPlayerRoom = yPlayer - wallBottom
        Gosub TrapCheck@538
        If l > 0 Goto 1792
        Goto 1771
1507
        Gosub ErasePlayer@448
        dirPlayer = dirPlayer + 1
        If dirPlayer > 4 Then
            dirPlayer = 1
        Goto 1522
1513
        Gosub ErasePlayer@448
        dirPlayer = dirPlayer - 1
        If dirPlayer < 1 Then
            dirPlayer = 4
        Goto 1522
1519
        Gosub ErasePlayer@448
        dirPlayer = dirPlayer - 2
        If dirPlayer < 1 Then
            dirPlayer = dirPlayer + 4
1522
        Gosub DrawPlayer@445
        Goto 1381
1525
        x = 49
        y = 10
        If fatigue < 1 Then
            Gosub MoveToXY@352
            Print "too tired";
            Goto 1771
        monsterCharmed = 0
        ia = i - 2
        arrowDamageAdjust = 0
        On ia Goto 1531,1531,1531,1558,1552
1531
        attackDisablesMonster = 0
        If Abs(xPlayerRoom - xMonster) > 5 Or Abs(yPlayerRoom - yMonster) > 5 Then
            Gosub MoveToXY@352
            Print "too far to hit";
            Goto 1771
        m = fatigueEffectOfAttack(ia)
        k = 0
        Gosub DrawEraseSword@499
        attackEffect = attSkill -(stats(3) - 9) / 3 * Exp(- 2 * wounds / stats(5)) + monsterLevel / 3 - attackDamageOnAction(ia)
        combatChance = Int(Rnd(0) * 20 + 1)
        x = 50
        y = 18
        If combatChance < attackEffect Then
            Gosub MoveToXY@352
            Print "swish";
            Goto 1768
        attackDamage = strengthScalar *(combatChance - attackEffect + 1)
        Gosub MoveToXY@352
        Print "crunch";
        If attackDamage > swordPower Then
            attackDamage = swordPower
1543
        If attackDamage < monsterHeal Then
            attackDamage = monsterHeal
        If monsterInfo%(currentMonsterID,3) < > 2 Or(swordMagic > 0 And ia < 4) Or ia = 5 Then
            monsterWounds = monsterWounds - attackDamage + monsterHeal
        monsterCharmed = 0
        Goto 1768
1552
        i1 = 5
        arrowDamageAdjust = 5
        If magicArrows = 0 Goto 1771
        magicArrows = magicArrows - 1
        Gosub UpdateMagicArrows@334
        Goto 1564
1558
        i1 = 3
        If arrows = 0 Goto 1771
        arrows = arrows - 1
        Gosub UpdateArrows@331
1564
        On dirPlayer Goto 1567,1579,1570,1582
1567
        ly = yPlayerRoom + 2
        uy = yMonster - 2
        arrowDir = 1
        Goto 1573
1570
        ly = yPlayerRoom - 2
        uy = yMonster + 2
        arrowDir = - 1
1573
        x = xPlayerRoom
        xPixel = x + wallLeft - xRoomBase
        For y = ly To uy Step arrowDir
            yPixel = yRoomBase - y - wallBottom
            Gosub DrawPixel@466
            Gosub ErasePixel@472
        Next y
        Goto 1588
1579
        lx = xPlayerRoom + 2
        ux = xMonster - 2
        arrowDir = 1
        Goto 1585
1582
        lx = xPlayerRoom - 2
        ux = xMonster + 2
        arrowDir = - 1
1585
        yPixel = yRoomBase - yPlayerRoom - wallBottom
        For x = lx To ux Step arrowDir
            xPixel = x + wallLeft - xRoomBase
            Gosub DrawPixel@466
            Gosub ErasePixel@472
        Next x
        y = yPlayerRoom
1588
        c$ = "swissh"
        If Abs(x - xMonster) < i1 And Abs(y - yMonster) < i1 Then
            c$ = "thwunk"
        Gosub EraseMonsterMessageArea@292
        x = 50
        y = 18
        Gosub MoveToXY@352
        Print c$;
        If Left$(c$,1) = "s" Goto 1771
        attackDamage = Int(7 * Rnd(0) + 1) + arrowDamageAdjust
        Goto 1543
1597
        If exitRoom(currentRoom,dirPlayer - 1) < > 2 Goto 1771
        k = dirPlayer - 1
        If ?playerInRoom(dirPlayer) < = doorLower(currentRoom,k) Or ?playerInRoom(dirPlayer) > = doorUpper(currentRoom,k) Or Abs(?playerInRoom(k) - ?roomSize%(dirPlayer)) > 5 Goto 1771
        exitRoom(currentRoom,k) = 1
        ij = 0
        On dirPlayer Gosub 1621,1612,1627,1618
        wkRoom = roomInDir(currentRoom,k)
        noWall =(dirPlayer + 1) And 3
        exitRoom(wkRoom,noWall) = 1
        noWall = 5
        Gosub 1258
        Goto 1771
1612
        xx = wallRight - xRoomBase - 2
1615
        i1 = 1 + ij
        yy = yRoomBase - wallBottom - doorUpper(currentRoom,k)
        l = doorUpper(currentRoom,k) - doorLower(currentRoom,k)
        Gosub EraseVerticalLine@382
        Return
1618
        xx = wallLeft - xRoomBase
        Goto 1615
1621
        yy = yRoomBase - wallTop
1624
        i1 = 1 + ij
        xx = wallLeft - xRoomBase + doorLower(currentRoom,k)
        l = doorUpper(currentRoom,k) - doorLower(currentRoom,k)
        Gosub EraseHorizontalLine@427
        Return
1627
        yy = yRoomBase - wallBottom - 2
        Goto 1624
1630
        Gosub MoveToXY@352
        Print "nothing";
        Return
1633
        Gosub ClearLine10@343
        k = dirPlayer - 1
        If exitRoom(currentRoom,k) < > 3 Or(40 * Rnd(0)) > 18 + stats(2) Then
            Gosub 1630
            Goto 1771
        Gosub MoveToXY@352
        Print "a secret door!";
        ij = - 1
        wkRoom = currentRoom
        exitRoom(currentRoom,k) = 2
        secretDoorFound%(k) = 1
        On dirPlayer Gosub 1621,1612,1627,1618
        Goto 1771
1645
        id = roomTreasureID%(currentRoom)
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Rem get
        If id = 0 Or Abs(xPlayerRoom - xTreasure%(currentRoom)) > 3 Or Abs(yPlayerRoom - yTreasure%(currentRoom)) > 3 Then
            Print "you can't";
            Goto 1771
        roomTreasureID%(currentRoom) = 0
        Print treasureName$(id);
        treasureCount%(id) = treasureCount%(id) + 1
        weightCarried = weightCarried + treasureInfo%(id,0)
        Gosub UpdateWeight@280
        monsterCharmed = 0
        Gosub UpdateTreasureDisplayNoCheck@526
        Gosub DrawPlayer@445
        i = treasureInfo%(id,1)
        If i < 101 Goto 1660
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
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print j;"elixirs";
        elixirs = elixirs + j
        Goto 1771
1669
        shieldID = 4
        shieldPower = shieldPower + 1
        Goto 1771
1672
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "dost use sword";
        Gosub GetKey@490
        If l = 0 Goto 1672
        Gosub ClearLine10@343
        If c$ < > "y" Then
            treasureCount%(id) = treasureCount%(id) - 1
            weightCarried = weightCarried - treasureInfo%(id,0)
            Goto 1771
        attSkill = attSkill + swordMagic
        swordMagic = Int(4 * Rnd(0)) + Int(4 * Rnd(0)) - 2
        i =((levelDungeon - 1) And 3) + 1
        If levelDungeon > 8 Then
            i = i + 1
        If swordMagic > 0 Then
            swordMagic = swordMagic - Int(2 - Int(i / 2))
            If swordMagic > 1 Then
                Gosub MoveToXY@352
                Print "then sword glows";
        attSkill = attSkill - swordMagic
        swordPower = Int(strengthScalar *(7 + swordMagic) + .5)
        Goto 1771
1687
        j = Int(20 * Rnd(0) + 1)
        Gosub AnnounceArrowsFound@298
        arrows = arrows + j
        Gosub 328
        Goto 1771
1690
        j = Int(10 * Rnd(0) + 1)
        Gosub AnnounceArrowsFound@298
        magicArrows = magicArrows + j
        Gosub UpdateMagicArrows@334
        Goto 1771
1693
        magicalItems%(1) = magicalItems%(1) + 1
        defSkill = defSkill + 1
        Goto 1771
1696
        magicalItems%(3) = 1
        Goto 1771
1699
        magicalItems%(4) = 1
        Goto 1771
1702
        roomRisk = 75
        Goto 1771
1705
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "drop some";
        Gosub GetDigit@322
        _intuition = 10 * j
        Gosub GetDigit@322
        _intuition = _intuition + j
        If _intuition > 20 Then
            Gosub ClearLine10@343
            Goto 1771
        If treasureCount%(_intuition) < 1 Then
            Gosub ClearLine10@343
            Goto 1771
        treasureCount%(_intuition) = treasureCount%(_intuition) - 1
        weightCarried = weightCarried - treasureInfo%(_intuition,0)
        Gosub ClearLine10@343
        Gosub UpdateWeight@280
        If treasureInfo%(_intuition,1) > 0 Goto 1771
        If roomTreasureID%(currentRoom) = 0 Then
            roomTreasureID%(currentRoom) = _intuition
            xTreasure%(currentRoom) = xPlayerRoom
            yTreasure%(currentRoom) = yPlayerRoom
            Gosub UpdateTreasureDisplayNoCheck@526
        Goto 1771
1726
        If 100 * Rnd(0) > .3 *(stats(1) + stats(3)) * monsterInfo%(currentMonsterID,7) Goto 1771
        monsterCharmed = 1
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "pass by";
        Goto 1771
1732
        If healingSalves < = 0 Goto 1747
        healingSalves = healingSalves - 1
        j = 0
1738
        wounds = wounds + 1 + j
        If wounds > stats(5) Then
            wounds = stats(5)
        Gosub UpdateWounds@316
        Goto 1771
1744
        If elixirs > 0 Then
            elixirs = elixirs - 1
            j = Int(Rnd(0) * 6) + 2
            Goto 1738
1747
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "none left";
        Goto 1381
1750
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        i = monsterTypeForRoom%(roomInDir(currentRoom,dirPlayer - 1))
        If i = 0 Or roomMonsterCount%(roomInDir(currentRoom,dirPlayer - 1)) = 0 Goto 1759
        If 1000 * Rnd(0) > stats(2) ^ 2 + magicalItems%(2) * 700 Goto 1759
        Print monsterName$(i);
        Goto 1771
1759
        Print "nothing";
        Goto 1771
1762
        If roomTrapID%(currentRoom) > 0 And 1 + 20 * Rnd(0) < stats(2) Then
            Gosub TrapAnimation@520
            Goto 1771
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Goto 1759
1768
        k = 1
        Gosub DrawEraseSword@499
1771
        Gosub UpdateFatigue@508
        If isMonsterActive > 0 Goto 1780
        Gosub 1252
        If isMonsterActive = 0 Goto 1381
        Gosub DrawMonster@451
        Goto 1381
1780
        If monsterCharmed > 0 Or attackDisablesMonster > 0 Goto 1885
        If Abs(xPlayerRoomStart - xMonster) > 5 Or Abs(yPlayerRoomStart - yMonster) > 5 Goto 1846
        monsterAttackCounter = monsterInfo%(currentMonsterID,1)
1789
        monsterAttackCounter = monsterAttackCounter - 1
        If monsterAttackCounter < 0 Goto 1828
1792
        attackEffect = defSkill - chanceMonsterHitOnAction(ia)
        combatChance = Int(20 * Rnd(0) + 1) + monsterLevel
        If combatChance > = attackEffect Goto 1798
        x = 50
        y = 19
        Gosub MoveToXY@352
        Print space11$;
        Gosub MoveToXY@352
        Print "it missed!";
        Goto 1789
1798
        Gosub SwitchToGraphicMode@277
        x = 50
        y = 19
        Gosub MoveToXY@352
        Print space11$;
        Gosub MoveToXY@352
        Gosub FlashPlayer@310
        If Int(Rnd(0) * 20 + 1) > shieldPower Goto 1807
        Print "shield hit";
        k = - shieldID
        Goto 1816
1807
        Print "struck thee";
        k = 0
        If monsterInfo%(currentMonsterID,3) < > 2 Goto 1816
        If Int(Rnd(0) * 20) < stats(5) Or magicalItems%(2) > 0 Goto 1816
        Gosub ReduceConstitution@274
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "a chill...";
1816
        k = k + Int((monsterDamage *(combatChance - attackEffect + 1)) / 10) - armourID - armourMagic
        If k < 0 Then
            k = 0
        wounds = wounds - k
        If wounds < 1 Then
            For i = 1 To 1000
            Next i
            Goto KilledByMonster@1954
        Gosub UpdateWounds@316
        If isMonsterActive > 0 Goto 1789
        Goto 1381
1828
        If isMonsterActive = 0 Goto 1381
        Gosub EraseMonster@463
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
        Gosub EraseMonster@463
        Gosub UpdateTreasureDisplay@523
        xx = xPlayerRoom - xMonster
        yy = yPlayerRoom - yMonster
        If Abs(xx) < Abs(yy) Goto 1855
        monsterDir = 4
        If xx > 0 Then
            monsterDir = 2
        Goto 1858
1855
        monsterDir = 3
        If yy > 0 Then
            monsterDir = 1
1858
        m = monsterSize
        On monsterDir Goto 1861,1867,1873,1879
1861
        yMonster = yMonster + m
        If yMonster > yPlayerRoom - 3 Then
            yMonster = yPlayerRoom - 3
        Goto 1882
1867
        xMonster = xMonster + m
        If xMonster > xPlayerRoom - 3 Then
            xMonster = xPlayerRoom - 3
        Goto 1882
1873
        yMonster = yMonster - m
        If yMonster < yPlayerRoom + 3 Then
            yMonster = yPlayerRoom + 3
        Goto 1882
1879
        xMonster = xMonster - m
        If xMonster < xPlayerRoom + 3 Then
            xMonster = xPlayerRoom + 3
1882
        Gosub PutMonsterInGameSpace@283
        Gosub DrawMonster@451
1885
        If monsterWounds > 0 Or isMonsterActive = 0 Goto 1900
        Gosub MonsterHitAnimation@478
        Gosub EraseMonster@463
        experience = experience + 20 * monsterLevel * monsterLevel + 15
        killCount = killCount + 1
        Gosub UpdateKillCount@307
        Gosub DrawPlayer@445
        Gosub ClearLine10@343
        Gosub MoveToXY@352
        Print "monster slain!";
        m = roomMonsterCount%(currentRoom)
        If m > 0 Then
            roomMonsterCount%(currentRoom) = m - 1
        If m > 1 Then
            Gosub 1225
            Gosub ClearLine10@343
            Gosub MoveToXY@352
            Print "and another";
            Gosub DrawMonster@451
            Goto 1900
        isMonsterActive = 0
        x = 50
        y = 13
        Gosub MoveToXY@352
        Print space12$;
        y = 14
        Gosub MoveToXY@352
        Print space11$;
1900
        Goto 1381
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
        hasBow = 1
        Gosub 889
        Gosub 784
        Goto 1927
1915
        Print "{Clr}treasures for "playerName$
        Print "{Down}treasure" Tab(10);"#" Tab(20);"treasure" Tab(30);"value"
        For i = 1 To 20
            j = treasureInfo%(i,6) * treasureCount%(i)
            If j > 0 Then
                Print treasureName$(i); Tab(20);treasureCount%(i); Tab(30);j
            silver = silver + j
            weightCarried = weightCarried - treasureCount%(i) * treasureInfo%(i,0)
            treasureCount%(i) = 0
        Next
        Input "art thou ready for more";a$
        Return
1927
        For i = 1 To 20
            treasureCount%(i) = 0
        Next i
        Return
1930
        Print "{Clr}thou leavest the dunjon"
        ********************************************************************************************************************
                                                 Option of re-entering the dungeon.
        ********************************************************************************************************************
ReEnterDungeon@1933
        Print "{Down}experience:"experience
        Print "{Down}dost thou wish to re-enter the pit"
        For i = 1 To 10
            Get a$
        Next i
1939
        Gosub GetKey@490
        If l = 0 Goto 1939
        For i = 1 To 60
            roomOnScreen%(i) = 0
        Next i
        For i = 1 To 10
            Get a$
        Next i
        If c$ < > "y" Goto Innkeeper@607
        weightCarried = startWeightCarried
        currentRoom = 1
        wounds = stats(5)
        xPlayer = xStart
        yPlayer = yStart
        dirPlayer = initialDirection
        fatigue = 100
        Gosub ClearDisplayedFlags@346
        Goto 1375
        ********************************************************************************************************************
                                                 Come here when killed by a monster
        ********************************************************************************************************************
KilledByMonster@1954
        Print Chr$(14)"{Clr}{Down}{Down}{Down}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}Thou art slain!{Down}"
        For i = 1 To 2500
        Next i
        For i = 1 To 60
            roomOnScreen%(i) = 0
        Next i
        i = Int(Sqr(Rnd(0) * 16 + 1) + .7)
        On i Goto Eaten@1963,FoundByMage@1972,FoundByDwarf@1975,FoundByCleric@1969
        ********************************************************************************************************************
                                                  Been eaten and cannot be revived
        ********************************************************************************************************************
Eaten@1963
        Print "Thou art eaten"
        keepCurrentPlayer = 0
        For i = 1 To 1500
        Next i
        For i = 1 To 60
            roomOnScreen%(i) = 0
        Next i
        Goto Innkeeper@607
        ********************************************************************************************************************
                                                     Found by Benedic the Cleric
        ********************************************************************************************************************
FoundByCleric@1969
        Print "Benedic the Cleric found thee"
        Goto ReEnterDungeon@1933
        ********************************************************************************************************************
                                                     Found by Lowenthal the Mage
        ********************************************************************************************************************
FoundByMage@1972
        Print "Lowenthal the Mage found thee"
        For i = 1 To 10
            magicalItems%(i) = 0
        Next i
        Goto ReEnterDungeon@1933
        ********************************************************************************************************************
                                                      Found by Olias the Dwarf
        ********************************************************************************************************************
FoundByDwarf@1975
        Print "Olias the Dwarf found thee"
        For i = 1 To 20
            treasureCount%(i) = 0
        Next i
        For i = 1 To 10
            magicalItems%(i) = 0
        Next i
        swordMagic = 0
        armourMagic = 0
        healingSalves = 0
        elixirs = 0
        magicArrows = 0
        Goto ReEnterDungeon@1933
        ********************************************************************************************************************
                                                  Capitalise first letter of string
        ********************************************************************************************************************
CapitaliseFirst@1981
        charAscii = Asc(Left$(a$,1))
        If charAscii > 127 Then
            Return
        b$ = a$
        a$ = Chr$(charAscii + 128)
        If Len(b$) > 1 Then
            a$ = a$ + Right$(b$, Len(b$) - 1)
        Return
