      **********************************************************************
      **********************************************************************

                                 Datestones of Ryn

      **********************************************************************
      **********************************************************************
10
      Clear 300
      Defint d,h-z
12
      Poke 16553,255
      roomCount=30
      Dim playerInRoom?(4),roomSize?(4),attackDamageOnAction(3),chanceMonsterHitOnAction(5),xSwordAnim(3,1),ySwordAnim(3,1),fatigueEffectOfAttack(5),__h(3),trapName$(9),secretDoorFound(3),secretDoorRepaired(3),statName$(6),stats(6)
13
      monTypeCount=12
      Dim monsterName$(monTypeCount)
      screenAddress=15360
      arrowDamageAdjust=0
      space6$="      "
15
      __q2=20
      Cls
      Data 0,2,-1,2,-2,6,2,1,4,1,12,-2,1,-2,2,18,-2,-1,-4,-1,10,13,2,1,1
      For i=0 To 3
          Read __h(i)
          For j=0 To 1
              Read xSwordAnim(i,j),ySwordAnim(i,j)
          Next j
      Next i
      For i=1 To 5
          Read fatigueEffectOfAttack(i)
      Next i
                   --- Setup pointers to game data elements ----
16
      roomDataOrigin=31485
      roomInDir=roomDataOrigin
      exitRoom=4*roomCount+roomDataOrigin
      doorLower=8*roomCount+roomDataOrigin
      doorUpper=12*roomCount+roomDataOrigin
      roomMonsterType=16*roomCount+roomDataOrigin
      monsterInRoomCount=roomMonsterType+roomCount
      trapID=monsterInRoomCount+roomCount
      xTrap=trapID+roomCount
      yTrap=xTrap+roomCount
      stonesInRoom=yTrap+roomCount
      xTreasure=stonesInRoom+roomCount
      yTreasure=xTreasure+roomCount
      __kb=roomDataOrigin+1246
17
      wallLeftData=yTreasure+roomCount
      wallRightData=wallLeftData+2*roomCount
      wallTopData=wallRightData+2*roomCount
      wallBottomData=wallTopData+2*roomCount
      trapMonster=wallBottomData+2*roomCount
      trapDamage=trapMonster+5
      trapChance=trapDamage+5
      trapIDToNameMap=trapChance+5
      treasureWeight=trapIDToNameMap+5
      specialTreasureID=treasureWeight+12
      monsterLevelData=specialTreasureID+12
      attacksPerTurnData=monsterLevelData+monTypeCount
      monsterWoundsData=attacksPerTurnData+monTypeCount
      monsterResistance=monsterWoundsData+monTypeCount
      monsterDamageData=monsterResistance+monTypeCount
      monsterHealData=monsterDamageData+monTypeCount
      _monsterUnused=monsterHealData+monTypeCount
      monsterCharm=_monsterUnused+monTypeCount
      randomMonsterChance=monsterCharm+monTypeCount
      monsterSize=randomMonsterChance+monTypeCount
20
      screenAddress=15360
      space15$= String$(15," ")
      chanceMonsterHitOnAction(0)=3
      attackDamageOnAction(1)=0
      chanceMonsterHitOnAction(1)=0
      attackDamageOnAction(2)=3
      chanceMonsterHitOnAction(2)=3
      attackDamageOnAction(3)=-6
      chanceMonsterHitOnAction(3)=-2
      chanceMonsterHitOnAction(4)=5
      chanceMonsterHitOnAction(5)=5
      monsterSpeed=100
      energyLossScalar=4
      dataElements=248
      asciiOffset=59
      dataElementStep=249
      c1=1
25
      Data "flame","dust","mold","pit","","spear","needle","xbow","cavein","ceiling","intelligence","intuition","ego","strength","constitution","dexterity"
45
      For i=0 To 9
          Read trapName$(i)
      Next i
      For i=1 To 6
          Read statName$(i)
      Next i
      cSolid=191
      c64=64
      Goto 1000
      **********************************************************************
                            Reduce constitution by one.
      **********************************************************************
ReduceConstitution@50
      wounds=wounds-1
      stats(5)=stats(5)-1
      Return
      **********************************************************************
                          Fit monster into current room.
      **********************************************************************
PutMonsterInRoom@55
      yy=wallTop-wallBottom-4
      If yMonster>yy Then
          yMonster=yy
      Else
          If yMonster<4 Then
              yMonster=4
56
      xx=wallRight-wallLeft-4
      If xMonster>xx Then
          xMonster=xx
      Else
          If xMonster<4 Then
              xMonster=4
57
      Return
                                 --- NotUsed ----
60
      Print @945,j;"arrows";
      Return
                                --- HitEffect ----
      **********************************************************************
                Use the TRS80 display mode to generate a hit effect
      **********************************************************************
65
      Print Chr$(23);
      For i=1 To 30
      Next i
      Print Chr$(28);
      Return
70
      Gosub GetTimedKey@500
      If l=0 Then
          70
      Else
          j= Asc(key$)-48
          If j<0 Or j>9 Then
              70
          Else
              Return
      **********************************************************************
                               Update Arrow Display
      **********************************************************************
UpdateArrows@72
      Print @503,space6$;
      Print @503,arrows;
      Return
      **********************************************************************
                            Update Magic Arrow Display
      **********************************************************************
UpdateMagicArrows@74
      Print @569,space6$;
      Print @569,magicArrows;
      Return
      **********************************************************************
                             Reset room repaint flags
      **********************************************************************
ResetRoomRepaint@80
      For i=1 To roomCount
          Poke roomDataOrigin-i,0
      Next i
      Return
      **********************************************************************
                                 Undo secret doors
      **********************************************************************
           --- Set door status back to 3 for any found secret doors ----
SecretDoor@82
      For i=0 To 3
          secretDoorRepaired(i)=0
          If secretDoorFound(i)>0 Then
              Poke exitRoom+currentRoom+i*roomCount,3
              Poke roomDataOrigin-roomCount-1+currentRoom,0
              secretDoorRepaired(i)=1
              secretDoorFound(i)=0
84
      Next i
      i=dirPlayer+1
      If i>3 Then
      i=i-4
               --- If the one behind us is found keep it open. ----
85
      If secretDoorRepaired(dirPlayer-1)>0 Then
          secretDoorFound(i)=1
86
      Return
      **********************************************************************
                               Update Wounds Display
      **********************************************************************
UpdateWounds@88
      Print @119,space6$;
      Print @119,Int(100*wounds/stats(5)+.5);"%";
      Return
90
      Poke contentID,Peek(ia+nn)
      nn=nn+1
      Return
      **********************************************************************
                                Draw vertical wall
      **********************************************************************
DrawVerticalWall@100
      l1=yy
      l2=yy+l-1
      If l1<0 Then
          l1=0
          If l2<0 Then
              Return
101
      If l2>47 Then
          l2=47
          If l1>47 Then
              Return
102
      l3= Int((l1+3)/3)
      l4= Int((l2-3)/3)
      _lm=3*l4+3
      lx=3*l3-1
      If _lm<l1 Then
          _lm=l1
103
      If lx>l2 Then
          lx=l2
104
      For ii=xx To xx+1
          If ii<0 Or ii>47 Then
              Return
105
      i=2*ii
      For ik=l1 To lx
          Gosub SetPixel@400
      Next ik
      For ik=_lm To l2
          Gosub SetPixel@400
      Next ik
110
      If l4>=l3 Then
          For ny=l3 To l4
              Poke screenAddress+ii+64*ny,cSolid
          Next ny
115
      Next ii
      Return
      **********************************************************************
                                Erase vertical wall
      **********************************************************************
EraseVerticalWall@120
      l1=yy
      l2=yy+l-1
      If l1<0 Then
          l1=0
          If l2<0 Then
              Return
121
      If l2>47 Then
          l2=47
          If l1>47 Then
              Return
122
      For i=0 To i1
          nx=2*xx+i
          If nx<0 Or nx>96 Then
              Return
125
      For j=l1 To l2
          Reset(nx,j)
      Next j
      Next i
      Return
      **********************************************************************
                               Draw Horizontal Wall
      **********************************************************************
DrawHorizontalWall@140
      l1=2*xx
      l2=l1+l-1
      If l1<0 Then
          l1=0
          If l2<0 Then
              Return
141
      If l2>95 Then
          l2=95
          If l1>95 Then
              Return
142
      For i=0 To i1
          ny=yy+i
          If ny<0 Or ny>47 Then
              Return
145
      For j=l1 To l2
          Set(j,ny)
      Next j
      Next i
      Return
      **********************************************************************
                               Erase Horizontal Wall
      **********************************************************************
EraseHorizontalWall@150
      l1=2*xx
      l2=l1+l-1
      If l1<0 Then
          l1=0
          If l2<0 Then
              Return
151
      If l2>95 Then
          l2=95
          If l1>95 Then
              Return
152
      For i=0 To i1
          ny=yy+i
          If ny<0 Or ny>47 Then
              Return
155
      For j=l1 To l2
          Reset(j,ny)
      Next j
      Next i
      Return
      **********************************************************************
                                  Draw the Player
      **********************************************************************
DrawPlayer@200
      i1=1
205
      xx=2*(xPlayer-xRoomBase)-1
      yy=yRoomBase-yPlayer
      If dirPlayer=2 Or dirPlayer=4 Then
          230
210
      For i=xx-3 To xx+1 Step 4
          ik=yy-(dirPlayer-1)/2
          On i1 Gosub SetPixel@400,ErasePixel@410
          ik=ik+1
          On i1 Gosub SetPixel@400,ErasePixel@410
      Next i
      i=xx-1
      ik=yy-2+dirPlayer
      On i1 Gosub SetPixel@400,ErasePixel@410
      Return
230
      For ik=yy-1 To yy+1 Step 2
          i=xx-5+dirPlayer
          On i1 Gosub SetPixel@400,ErasePixel@410
          i=i+2
          On i1 Gosub SetPixel@400,ErasePixel@410
      Next ik
      ik=yy
      i=xx+5-2*dirPlayer
      On i1 Gosub SetPixel@400,ErasePixel@410
      Return
      **********************************************************************
                                 Erase the Player
      **********************************************************************
ErasePlayer@250
      i1=2
      Goto 205
      **********************************************************************
                                  Draw a monster
      **********************************************************************
DrawMonster@300
      i1=1
305
      xx=2*(xMonster-xRoomBase+wallLeft)-1
      yy=yRoomBase-yMonster-wallBottom
      i=xx
      ik=yy-1
      On i1 Gosub SetPixel@400,ErasePixel@410
      ik=yy+1
      On i1 Gosub SetPixel@400,ErasePixel@410
      ik=yy
      For i=xx-2 To xx+2 Step 4
          On i1 Gosub SetPixel@400,ErasePixel@410
      Next i
      Return
      **********************************************************************
                              Erase monster if exists
      **********************************************************************
EraseMonsterIfAny@345
      If isMonsterActive=0 Then
          Return
      **********************************************************************
                                  Erase a monster
      **********************************************************************
EraseMonster@350
      i1=2
      Goto 305
      **********************************************************************
                                    Set a Pixel
      **********************************************************************
SetPixel@400
      If i<0 Or i>94 Or ik<0 Or ik>47 Then
          Return
      Else
          For j=0 To 1
              Set(i+j,ik)
          Next j
          Return
      **********************************************************************
                                   Erase a Pixel
      **********************************************************************
ErasePixel@410
      If i<0 Or i>94 Or ik<0 Or ik>47 Then
          Return
      Else
          For j=0 To 1
              Reset(i+j,ik)
          Next j
          Return
440
      If k=0 Then
          Set(i,yy-j)
          Set(i,yy+j)
      Else
          Reset(i,yy-j)
          Reset(i,yy+j)
445
      Return
      **********************************************************************
                               Star Explosion Effect
      **********************************************************************
ExplosionEffect@450
      For l=0 To 2
          For k=0 To 1
              i=xx+1
              j=1
              Gosub 440
              i=xx-1
              Gosub 440
              i=xx+2
              j=0
              Gosub 440
              i=xx-2
              Gosub 440
460
      i=xx+2
      j=2
      Gosub 440
      i=xx-2
      Gosub 440
      i=xx+4
      j=0
      Gosub 440
      i=xx-4
      Gosub 440
      Next k
      Next l
      Return
      **********************************************************************
                           Get a keystroke with time-out
      **********************************************************************
GetTimedKey@500
      _le=monsterSpeed/(isMonsterActive+1)
      For _ic=1 To _le
510
      key$= Inkey$
      If Len(key$)>0 Then
          l=1
          Return
520
      Next _ic
      l=0
      Return
      **********************************************************************
                               Animate sword attack
      **********************************************************************
DrawEraseSword@600
      ii=2*(xPlayerRoom-xRoomBase+wallLeft-1)
      ij=yRoomBase-yPlayerRoom-wallBottom
      For l=0 To 1
          i=ii+xSwordAnim(dirPlayer-1,l)
          ik=ij+ySwordAnim(dirPlayer-1,l)
          If k=0 Then
              Gosub SetPixel@400
          Else
              Gosub ErasePixel@410
610
      Next l
      Return
      **********************************************************************
                   Update the fatigue value based on action "m"
      **********************************************************************
UpdateFatigueForAction@650
      fatigue=fatigue-( Abs(m)/energyLossScalar*(100/stats(5)+5-5*wounds/stats(5))*(1+weightCarried/initialStrength*3)/2)+11
      If fatigue>100 Then
          fatigue=100
660
      Print @184,space6$;
      Print @184,fatigue;"%";
      Return
      **********************************************************************
                             Do Sprung Trap Animation
      **********************************************************************
TrapAnimation@670
      y=yRoomBase- Peek(yTrap+currentRoom)-wallBottom
      x= Peek(xTrap+currentRoom)+wallLeft-xRoomBase
      For l=1 To 15
          i=2*x
          ik=y
          Gosub SetPixel@400
          Gosub ErasePixel@410
      Next l
      Return
      **********************************************************************
                           Update Treasure for this room
      **********************************************************************
DrawTreasure@679
      If Peek(stonesInRoom+currentRoom)=0 Then
          Return
      **********************************************************************
                              Update Treasure display
      **********************************************************************
UpdateTreasure@680
      i=2*(wallLeft+ Peek(xTreasure+currentRoom)-xRoomBase)
      yy=yRoomBase-wallBottom- Peek(yTreasure+currentRoom)
      For ik=yy-1 To yy
          If Peek(stonesInRoom+currentRoom)>0 Then
              Gosub SetPixel@400
          Else
              Gosub ErasePixel@410
690
      Next ik
      Return
      **********************************************************************
                                Check if trap fires
      **********************************************************************
TrapCheck@695
      contentID= Peek(trapID+currentRoom)
      l=0
      If isMonsterActive>0 Or contentID=0 Or Abs(xPlayerRoom- Peek(xTrap+currentRoom))>3 Or Abs(yPlayerRoom- Peek(yTrap+currentRoom))>3 Or Rnd(100)> Peek(trapChance+contentID) Then
          Return
700
      Print @624,space15$;
      Print @624,trapName$( Peek(trapIDToNameMap+contentID));" trap";
      Gosub 65
      Gosub 65
      If Peek(trapMonster+contentID)>0 Then
          i= Peek(trapMonster+contentID)
          isMonsterActive=1
          Gosub CreateMonster@4830
          xMonster= Peek(xTrap+currentRoom)
          yMonster= Peek(yTrap+currentRoom)
          Print @624,aTemp$;
          Goto 720
710
      If Peek(trapDamage+contentID)>0 Then
          monsterLevel= Peek(trapDamage+contentID)
          l=1
          monsterDamage=2*monsterLevel
720
      Poke trapID+currentRoom,0
      Return
      **********************************************************************
                              Load Current Room Data
      **********************************************************************
LoadCurrentRoomInfo@800
      ll=currentRoom
      Goto 850
      **********************************************************************
                                Load Last Room Info
      **********************************************************************
LoadLastRoomInfo@840
      ll=wkRoom
850
      loadWallLeft= Peek(wallLeftData+ll)+128* Peek(wallLeftData+roomCount+ll)
      loadWallRight= Peek(wallRightData+ll)+128* Peek(wallRightData+roomCount+ll)
      loadWallTop= Peek(wallTopData+ll)+128* Peek(wallTopData+roomCount+ll)
      loadWallBottom= Peek(wallBottomData+ll)+128* Peek(wallBottomData+roomCount+ll)
      If ll<>currentRoom Then
          Return
860
      wallLeft=loadWallLeft
      wallRight=loadWallRight
      wallTop=loadWallTop
      wallBottom=loadWallBottom
      Return
      **********************************************************************
                            Get Name of Current Monster
      **********************************************************************
GetMonsterName@880
      k=0
      monsterNameData=roomDataOrigin+1125
      For ll=1 To currentMonsterID
          l= Peek(k+monsterNameData)
          k=k+l+1
      Next ll
      k=k-l-1
      aTemp$=""
      For ll=1 To l
          aTemp$=aTemp$+ Chr$( Peek(k+monsterNameData+ll))
      Next ll
      Return
      **********************************************************************
                                 Draw Title Screen
      **********************************************************************
TitleScreen@900
      Random
      Cls
      Print Chr$(23)
      Print @148,"dunjonquest"
      Print @266,"the datestones of ryn"
910
      Print @594,"copyright 1979"
      Print @714,"automated  simulations"
915
      j=191
      For i=0 To 63 Step 2
          Poke screenAddress+i,j
      Next i
      For i=960 To 1023 Step 2
          Poke screenAddress+i,j
      Next i
      For i=64 To 896 Step 64
          Poke screenAddress+i,j
      Next i
      For i=126 To 958 Step 64
          Poke screenAddress+i,j
      Next i
917
      k=140
      For i=834 To 892 Step 2
          Poke screenAddress+i,k
      Next i
920
      Print @908,"hit any key to begin";
930
      i= Rnd(5)
      aTemp$= Inkey$
      If Len(aTemp$)=0 Then
          930
940
      For i=1 To 60
          Poke roomDataOrigin-i,0
      Next i
990
      Return
1000
      Gosub TitleScreen@900
      Cls
      Gosub ResetPlayerStats@2400
1200
      playerName$="brian hammerhand"
1210
      defSkill=12
      attSkill=7
      weightCarried=54
      elixirs=1
1400
      Gosub DisplayStatus@2500
      **********************************************************************
                                 Load the Data in
      **********************************************************************
LoadData@1600
      Input "insert data tape, press play and enter";aTemp$
1620
      Input #-1,aTemp$
1621
      Print "loading dunjon"
1625
      k=0
1630
      Gosub UnpackString@1950
1640
      For i=2 To 5
1642
      If Len(aTemp$)=249 Then
          1650
1644
      Print "*** data read error - block length =" Len(aTemp$);" ***"
1650
      aTemp$=""
      Input #-1,aTemp$
      Gosub UnpackString@1950
1665
      Next i
1900
      Goto StartGame@5000
      **********************************************************************
                                 Unpack a string.
      **********************************************************************
UnpackString@1950
      ia= Varptr(aTemp$)
      ia= Peek(ia+1)+256* Peek(ia+2)
            --- For each data element, get the offset as its ASCII ----
1955
      For j=0 To dataElements
          l= Peek(ia+j)
1965
      Poke roomDataOrigin+k+j,l-asciiOffset
      Next j
      k=k+dataElementStep
      Return
      **********************************************************************
                          Force repaint of rooms 51-60 ?
      **********************************************************************
Repaint10Rooms@2250
      For i=roomDataOrigin-60 To roomDataOrigin-51
          Poke i,0
      Next i
      Return
      **********************************************************************
                            Reset the Player Statistics
      **********************************************************************
ResetPlayerStats@2400
      stats(1)=10
      stats(2)=14
      stats(3)=13
      stats(4)=14
      stats(5)=15
      stats(6)=12
2427
      swordPower=10
      swordMagic=0
      Poke __kb+10,0
      Poke __kb+17,contentID
      armourID=3
      armourMagic=0
      shieldID=5
      Poke __kb,shieldID
2440
      arrows=20
      magicArrows=2
2450
      healingSalves=0
      elixirs=1
2480
      swordMagic=0
2485
      Poke __kb+16,0
2490
      Gosub Repaint10Rooms@2250
      Return
      **********************************************************************
                             Display the Player status
      **********************************************************************
DisplayStatus@2500
      Cls
      Print "character summary for "playerName$
2520
      Print " "
      For i=1 To 6
          Print statName$(i); Tab( 20);stats(i)
      Next i
2530
      Print "weapon: broadsword" Tab( 22);"armor: chainmail"
2535
      Print "arrows:"arrows; Tab( 22);"magic arrows:"magicArrows; Tab( 45);"shield: large"
2537
      Print "elixirs:"elixirs
2540
      Print "weight carried:"weightCarried;" lbs"
2550
      Return
      **********************************************************************
                                Draw a single room
      **********************************************************************
DrawRoom@3000
      If Peek(roomDataOrigin+wkRoom-31)=1 Then
          Return
      Else
          Gosub LoadLastRoomInfo@840
          xx=loadWallRight-xRoomBase-2
          If loadWallLeft-xRoomBase>-1 And loadWallRight-xRoomBase<49 And yRoomBase-loadWallTop>-1 And yRoomBase-loadWallBottom<49 And secretDoorFound(_ir)=0 Then
              Poke roomDataOrigin+wkRoom-31,1
3011
      For k=1 To 3 Step 2
          nn=wkRoom+k*roomCount
          yy=yRoomBase-loadWallTop
          If noWall=k Then
              3014
          Else
              i1=3
              l=loadWallTop-loadWallBottom
              If Peek(doorUpper+nn)- Peek(doorLower+nn)+4=l Then
                  3014
              Else
                  Gosub DrawVerticalWall@100
3012
      i1=5-2* Peek(exitRoom+nn)
      If i1>=0 And i1<5 Then
          yy=yRoomBase-loadWallBottom- Peek(doorUpper+nn)
          l= Peek(doorUpper+nn)- Peek(doorLower+nn)
          Gosub EraseVerticalWall@120
3014
      xx=loadWallLeft-xRoomBase
      Next k
3032
      yy=yRoomBase-loadWallTop
      For k=0 To 2 Step 2
          nn=wkRoom+k*roomCount
          If noWall=k Then
              3034
          Else
              i1=1
              xx=loadWallLeft-xRoomBase
              l=2*(loadWallRight-loadWallLeft)
              If Peek(doorUpper+nn)- Peek(doorLower+nn)+4=l/2 Then
                  3034
              Else
                  Gosub DrawHorizontalWall@140
                  i1=2- Peek(exitRoom+nn)
                  If i1>=0 And i1<2 Then
                      xx=loadWallLeft-xRoomBase+ Peek(doorLower+nn)
                      l=2*( Peek(doorUpper+nn)- Peek(doorLower+nn))
                      Gosub EraseHorizontalWall@150
3034
      yy=yRoomBase-loadWallBottom-2
      Next k
      Return
      **********************************************************************
                             Redraw the whole display
      **********************************************************************
      --- If already drawn, skip this, else clear screen and clear all repaint flags. ----
RedrawDisplay@4000
      wkRoom=currentRoom
      Gosub LoadCurrentRoomInfo@800
      If Peek(roomDataOrigin+currentRoom-31)=1 Then
          4005
      Else
          Cls
          Gosub ResetRoomRepaint@80
      --- Figure where on the screen it should start, make sure it all fits on the screen. ----
4002
      xRoomBase=wallLeft
      yRoomBase=wallTop
      If Peek(exitRoom+wkRoom+3*roomCount)=1 Then
          xRoomBase=xRoomBase-(48-wallRight+wallLeft)/2
          If Peek(exitRoom+wkRoom+roomCount)=1 Then
              xRoomBase=xRoomBase+(wallLeft-xRoomBase)/2
4003
      If Peek(exitRoom+wkRoom)=1 Then
          yRoomBase=yRoomBase+48-wallTop+wallBottom
          If Peek(exitRoom+wkRoom+2*roomCount)=1 Then
              yRoomBase=yRoomBase-(yRoomBase-wallTop)/2
      --- Work out player position in room, create monster if required. ----
4004
      Print @624,space15$;
      xPlayerRoom=xPlayer-wallLeft
      yPlayerRoom=yPlayer-wallBottom
      If Peek(roomMonsterType+currentRoom)>0 And Peek(monsterInRoomCount+currentRoom)>0 Then
          Gosub CreateMonsterInRoom@4500
          isMonsterActive=1
      Else
          Gosub MayCreateRandomMonster@4800
                        --- Update the status display ----
4005
      Print @112,"wounds:";
      Gosub UpdateWounds@88
      Print @176,"fatigue:"fatigue;"%";
      Print @240,"wgt:"weightCarried;" lbs";
      Print @624,aTemp$;
      Print @496,"arrows:"arrows;
      Print @560,"magic ar:"magicArrows;
                         --- Draw any active monster ----
4010
      If isMonsterActive>0 Then
          Gosub DrawMonster@300
      --- Some sort of side-forbid flag set to never apply. If new room was on screen (ib = 3) then we don't need to do adjacent ones. ----
4020
      noWall=5
      If pMoveResult=3 Then
          4050
                --- Draw all adjacent rooms, if there are any ----
4030
      For _ir=0 To 3
          i=currentRoom+_ir*roomCount
          If Peek(exitRoom+i)=1 And Peek(roomInDir+i)>0 Then
              wkRoom= Peek(roomInDir+i)
              Gosub DrawRoom@3000
4040
      Next _ir
      _ir=0
               --- Draw the current room, player and treasure. ----
4050
      wkRoom=currentRoom
      Gosub DrawRoom@3000
      Gosub DrawPlayer@200
      Gosub DrawTreasure@679
      Return
      **********************************************************************
                          Create the monster in the room.
      **********************************************************************
CreateMonsterInRoom@4500
      currentMonsterID= Peek(roomMonsterType+currentRoom)
      __mw=0
      monsterLevel= Peek(monsterLevelData+currentMonsterID)
      monsterAttacksPerTurn= Peek(attacksPerTurnData+currentMonsterID)
      monsterWounds= Peek(monsterWoundsData+currentMonsterID)
      monsterSize= Peek(monsterSize+currentMonsterID)
      monsterDamage= Peek(monsterDamageData+currentMonsterID)
      monsterHeal= Peek(monsterHealData+currentMonsterID)
      __mr=0
      Gosub ResetRoomRepaint@80
      _ih=0
4520
      xMonster= Rnd(wallRight-wallLeft-8)+4
      yMonster= Rnd(wallTop-wallBottom-8)+4
4550
      monsterDir= Rnd(4)
      Return
      **********************************************************************
                         Create a random monster (perhaps)
      **********************************************************************
MayCreateRandomMonster@4800
      l= Rnd(100)
      If l>roomRisk Then
          isMonsterActive=0
          aTemp$=""
          Return
4810
      l= Rnd(100)
      chanceTotal=0
      isMonsterActive=1
      For i=1 To monTypeCount
          chanceTotal=chanceTotal+ Peek(randomMonsterChance+i)
          If l<=chanceTotal Then
              CreateMonster@4830
4820
      Next i
      **********************************************************************
                                 Create Monster i
      **********************************************************************
CreateMonster@4830
      Poke roomMonsterType+currentRoom,i
      Poke monsterInRoomCount+currentRoom,1
      currentMonsterID=i
      monsterLevel= Peek(monsterLevelData+i)
      monsterAttacksPerTurn= Peek(attacksPerTurnData+i)
      monsterWounds= Peek(monsterWoundsData+i)
      monsterSize= Peek(monsterSize+i)
      monsterDamage= Peek(monsterDamageData+i)
      monsterHeal= Peek(monsterHealData+i)
      Gosub GetMonsterName@880
      _ih=0
      Gosub 4520
      Return
      **********************************************************************
               Random monster creation on turn when no monster only.
      **********************************************************************
CheckRandomMonsterAppear@4850
      l= Rnd(100)
      If l<roomRisk/6 Then
          4810
      Else
          Return
      **********************************************************************
                               Start the actual game
      **********************************************************************
StartGame@5000
      dirPlayer= Peek(roomDataOrigin+1243)
      fatigue=100
      initialStrength=stats(4)[2
      roomRisk= Peek(roomDataOrigin+1240)
      stonesCarried=0
      datestoneCount=0
      isAlive=1
      startClock=0
      currentRoom=1
      commandList$="rlatpfmgev!sy"
      xPlayer= Peek(roomDataOrigin+1241)
      yPlayer= Peek(roomDataOrigin+1242)
      wounds=stats(5)
      **********************************************************************
                               New Room if come here
      **********************************************************************
NewRoom@5030
      Gosub RedrawDisplay@4000
      roomSize?(1)=wallTop-wallBottom
      roomSize?(2)=wallRight-wallLeft
      roomSize?(3)=0
      roomSize?(4)=0'buildmonsterCharmeditialroom
5040
      playerInRoom?(1)=xPlayer-wallLeft
      playerInRoom?(2)=yPlayer-wallBottom
      playerInRoom?(3)=playerInRoom?(1)
      playerInRoom?(4)=playerInRoom?(2)
      playerInRoom?(0)=playerInRoom?(2)
      **********************************************************************

                                  Main Game Loop

      **********************************************************************
MainLoop@5044
      clock=clock+.13
      If clock-startClock>20 Then
          QuestEnd@12000
      Else
          Print @752,"time:" Int(clock-startClock);
          Print @816,"stones:"stonesCarried;
          xPlayerRoomStart=xPlayerRoom
          yPlayerRoomStart=yPlayerRoom
          ia=0
          Gosub GetTimedKey@500
          m=0
          Print @304,space15$;
          Print @368,space15$;
          Print @432,space15$;
          If l=0 Then
              MonsterTurn@7000
5045
      ia=0
      If Asc(key$)>47 And Asc(key$)<58 Then
          MovePlayer@5100
      Else
          For i=1 To 13
              If key$= Mid$(commandList$,i,1) Then
                  On i Then
                      R-Command@5300,L-Command@5350,ATPFM-Commands@5390,ATPFM-Commands@5390,ATPFM-Commands@5390,ATPFM-Commands@5390,ATPFM-Commands@5390,G-Command@5800,E-Command@5700,V-Command@5370,!-Command@5900,S-Command@6300,Y-Command@6140
5050
      Next i
      Goto MainLoop@5044
      **********************************************************************
                                 Player Move code
      **********************************************************************
MovePlayer@5100
      If fatigue<1 Then
          ATPFM-Commands@5390
      Else
          m= Asc(key$)-48
        --- n is trap if any,ib is left area flag, m is move distance ----
5110
      m1=m
      contentID= Peek(trapID+currentRoom)
      pMoveResult=0
      On dirPlayer Then
          MoveUp.@5120,MoveRight@5210,Move Down@5164,MoveLeft@5250
                              --- Move Player up ----
MoveUp.@5120
      If yPlayer+m>wallTop-3 Then
          m=wallTop-3-yPlayer
          pMoveResult=1
5150
      Goto ExecMovement@5281
                             --- Move Player down ----
Move Down@5164
      m=-m
      m1=m
      If yPlayer+m<wallBottom+4 Then
          m=wallBottom+4-yPlayer
          pMoveResult=1
5180
      Goto ExecMovement@5281
                            --- Move Player right ----
MoveRight@5210
      If xPlayer+m>wallRight-3 Then
          m=wallRight-3-xPlayer
          pMoveResult=1
5240
      Goto ExecMovement@5281
                             --- Move Player left ----
MoveLeft@5250
      m=-m
      m1=m
      If xPlayer+m<wallLeft+4 Then
          m=wallLeft+4-xPlayer
          pMoveResult=1
5270
      Goto ExecMovement@5281
5280
      If isMonsterActive>0 Then
          MonsterTurn@7000
      Else
          Goto 7020
      **********************************************************************
                                Do Player Movement
      **********************************************************************
              --- Checks to see if door open (1) and if not skip ----
ExecMovement@5281
      If pMoveResult=0 Then
          AnimatePlayerMove@5290
      Else
          xPlayerRoom=xPlayer-wallLeft
          yPlayerRoom=yPlayer-wallBottom
          If Peek(exitRoom+currentRoom+dirPlayer*roomCount-roomCount)<>1 Then
              AnimatePlayerMove@5290
      **********************************************************************
                                    Left a room
      **********************************************************************
                    --- If in door space then change room ----
ChangeRoom@5282
      l=currentRoom+dirPlayer*roomCount-roomCount
      If playerInRoom?(dirPlayer)> Peek(doorLower+l) And playerInRoom?(dirPlayer)< Peek(doorUpper+l) Then
          Gosub EraseMonsterIfAny@345
          Gosub SecretDoor@82
          isMonsterActive=0
          monsterCharmed=0
          currentRoom= Peek(roomInDir+l)
          Gosub LoadCurrentRoomInfo@800
          pMoveResult=2
          m= Abs(m)+4
          If currentRoom=0 Then
              LeaveDungeon@10000
      --- If didn't change room (i.e. walked into a wall not door), move there. ----
5284
      If pMoveResult=1 Then
          AnimatePlayerMove@5290
               --- If the whole of the room is on the screen ? ----
5285
      If wallLeft-xRoomBase>-1 And wallRight-xRoomBase<49 And yRoomBase-wallTop>-1 And yRoomBase-wallBottom<49 Then
          pMoveResult=3
          roomSize?(1)=wallTop-wallBottom
          roomSize?(2)=wallRight-wallLeft
          m=m1
          Goto AnimatePlayerMove@5290
                  --- We are in a new room redraw situation ----
5286
      If dirPlayer=1 Then
          yPlayer=wallBottom+4
          Goto NewRoom@5030
5287
      If dirPlayer=3 Then
          yPlayer=wallTop-3
          Goto NewRoom@5030
5288
      If dirPlayer=2 Then
          xPlayer=wallLeft+3
      Else
          xPlayer=wallRight-4
5289
      Goto NewRoom@5030
      **********************************************************************
                              Move the player graphic
      **********************************************************************
AnimatePlayerMove@5290
      Gosub ErasePlayer@250
      Gosub DrawTreasure@679
      If dirPlayer=1 Or dirPlayer=3 Then
          yPlayer=yPlayer+m
      Else
          xPlayer=xPlayer+m
5292
      If xPlayer>wallRight-3 Then
          xPlayer=wallRight-3
      Else
          If xPlayer<wallLeft+2 Then
              xPlayer=wallLeft+2
5293
      If yPlayer>wallTop-3 Then
          yPlayer=wallTop-3
      Else
          If yPlayer<wallBottom+4 Then
              yPlayer=wallBottom+4
5294
      Gosub DrawPlayer@200
      playerInRoom?(1)=xPlayer-wallLeft
      playerInRoom?(3)=playerInRoom?(1)
      playerInRoom?(2)=yPlayer-wallBottom
      playerInRoom?(4)=playerInRoom?(2)
      playerInRoom?(0)=playerInRoom?(2)
      If pMoveResult=3 Then
          wkRoom=currentRoom
          Gosub 4004
          pMoveResult=0
          Goto MainLoop@5044
5295
      xPlayerRoom=xPlayer-wallLeft
      yPlayerRoom=yPlayer-wallBottom
      Gosub TrapCheck@695
      If l>0 Then
          Gosub UpdateFatigueForAction@650
          Goto 7020
      Else
          Goto MonsterTurn@7000
      **********************************************************************
                                     Turn Left
      **********************************************************************
R-Command@5300
      Gosub ErasePlayer@250
      dirPlayer=dirPlayer+1
      If dirPlayer>4 Then
          dirPlayer=1
5310
      Gosub DrawPlayer@200
      Goto MainLoop@5044
      **********************************************************************
                                    Turn Right
      **********************************************************************
L-Command@5350
      Gosub ErasePlayer@250
      dirPlayer=dirPlayer-1
      If dirPlayer<1 Then
          dirPlayer=4
5360
      Gosub DrawPlayer@200
      Goto MainLoop@5044
      **********************************************************************
                                    Turn around
      **********************************************************************
V-Command@5370
      Gosub ErasePlayer@250
      dirPlayer=dirPlayer-2
      If dirPlayer<1 Then
          dirPlayer=dirPlayer+4
5380
      Gosub DrawPlayer@200
      Goto MainLoop@5044
      **********************************************************************
                     Attack, Thrust, Parry, Fire, Magic Arrow
      **********************************************************************
ATPFM-Commands@5390
      If fatigue<1 Then
          Print @368,space15$;
          Print @368,"too tired";
          Goto MonsterTurn@7000
      Else
          ia=i-2
          monsterCharmed=0
          arrowDamageAdjust=0
          On ia Then
              SwordAttack@5400,SwordAttack@5400,SwordAttack@5400,FireArrow@5500,FireMagicArrow@5490
      **********************************************************************
                          Attack Thrust Parry comes here
      **********************************************************************
SwordAttack@5400
      attackDisablesMonster=0
      If Abs(xPlayerRoom-xMonster)>5 Or Abs(yPlayerRoom-yMonster)>5 Then
          Print @368,"too far to hit";
          Goto MonsterTurn@7000
5430
      m=fatigueEffectOfAttack(ia)
      k=0
      Gosub DrawEraseSword@600
      attackEffect=attSkill-(stats(3)-9)/3* Exp(-2*wounds/stats(5))+monsterLevel/3-attackDamageOnAction(«09ht»ia)
      combatChance= Rnd(20)
      If combatChance<attackEffect Then
          Print @368,"swish!";
          Goto EraseSwordThenMonster@6990
5435
      attackDamage=stats(4)*(combatChance-attackEffect+1)
      Print @368,"crunch!";
      If attackDamage>swordPower Then
          attackDamage=swordPower
      **********************************************************************
                             Do actual monster damage
      **********************************************************************
DamageMonster@5437
      If attackDamage<monsterHeal Then
          attackDamage=monsterHeal
         --- Damage only if non-magic, or magic sword, or magic arrow ----
5440
      If Peek(monsterResistance+currentMonsterID)<>2 Or(swordMagic>0 And ia<3) Or ia=5 Then
          monsterWounds=monsterWounds-attackDamage+monsterHeal
          monsterCharmed=0
5450
      Goto EraseSwordThenMonster@6990
      **********************************************************************
                                 Fire Magic Arrow
      **********************************************************************
FireMagicArrow@5490
      i1=5
      arrowDamageAdjust=5
      If magicArrows<=0 Then
          MonsterTurn@7000
      Else
          magicArrows=magicArrows-1
          Gosub UpdateMagicArrows@74
          Goto ArrowCode@5505
      **********************************************************************
                                    Fire Arrow
      **********************************************************************
FireArrow@5500
      i1=3
      If arrows<=0 Then
          MonsterTurn@7000
      Else
          arrows=arrows-1
          Gosub UpdateArrows@72
      **********************************************************************
                                General Arrow code
      **********************************************************************
ArrowCode@5505
      On dirPlayer Then
          5510,5550,5515,5555
                                 --- Arrow up ----
5510
      ly=yPlayerRoom+2
      uy=yMonster-3
      arrowDir=1
      Goto 5520
                                --- Arrow down ----
5515
      ly=yPlayerRoom-2
      uy=yMonster+3
      arrowDir=-1
                          --- Animate vertical arrow ----
5520
      x=xPlayerRoom-1
      For y=ly To uy Step arrowDir
          i=2*(x+wallLeft-xRoomBase)
          j=yRoomBase-y-wallBottom
          Set(i,j)
          Reset(i,j)
          x=x*1
      Next y
      Goto 5580
                               --- Arrow right ----
5550
      lx=xPlayerRoom+1
      ux=xMonster-3
      arrowDir=1
      Goto 5560
                                --- Arrow left ----
5555
      lx=xPlayerRoom-3
      ux=xMonster+3
      arrowDir=-1
                         --- Animate horizontal arrow ----
5560
      y=yPlayerRoom
      For x=lx To ux Step arrowDir
          i=2*(x+wallLeft-xRoomBase)
          j=yRoomBase-y-wallBottom
          Set(i,j)
          Reset(i,j)
          y=y*1
      Next x
            --- Complete Arrow.Check if hit, if so damage monster ----
5580
      If Abs(x-xMonster)<i1 And Abs(y-yMonster)<i1 Then
          Print @368,"thwunk!";
          attackDamage= Rnd(7)+arrowDamageAdjust
          Goto DamageMonster@5437
      Else
          Print @368,"sswht!";
          Goto MonsterTurn@7000
                           --- Open the right door ----
OpenRightDoor@5620
      xx=wallRight-xRoomBase-2
5630
      i1=3+ij
      yy=yRoomBase-wallBottom- Peek(doorUpper+k)
      l= Peek(doorUpper+k)- Peek(doorLower+k)
      Gosub EraseVerticalWall@120
      Return
                            --- Open the left door ----
OpenLeftDoor@5640
      xx=wallLeft-xRoomBase
      Goto 5630
                             --- Open the up door ----
OpenUpDoor@5660
      yy=yRoomBase-wallTop
5670
      i1=1+ij/2
      xx=wallLeft-xRoomBase+ Peek(doorLower+k)
      l=2*( Peek(doorUpper+k)- Peek(doorLower+k))
      Gosub EraseHorizontalWall@150
      Return
                            --- Open the down door ----
OpenDownDoor@5680
      yy=yRoomBase-wallBottom-2
      Goto 5670
      **********************************************************************
                                Examine Secret Door
      **********************************************************************
E-Command@5700
      k=currentRoom+(dirPlayer-1)*roomCount
      If Peek(k+exitRoom)=3 And Rnd(40)<20+stats(2) Then
          Poke k+exitRoom,1
          secretDoorFound(dirPlayer-1)=1
          Print @304,space15$;
          Print @304,"a secret door!";
          ij=0
          wkRoom=currentRoom
          On dirPlayer Gosub OpenUpDoor@5660,OpenRightDoor@5620,OpenDownDoor@5680,OpenLeftDoor@5640
      Else
          Print @304,"nothing";
5710
      Goto MonsterTurn@7000
      **********************************************************************
                                   Grab Treasure
      **********************************************************************
G-Command@5800
      contentID= Peek(stonesInRoom+currentRoom)
      Print @304,space15$;
      If contentID=0 Or xPlayerRoom- Peek(xTreasure+currentRoom)>3 Or yPlayerRoom- Peek(yTreasure+currentRoom)>3 Then
          Print @304,"you can't";
          Goto MonsterTurn@7000
      Else
          Poke stonesInRoom+currentRoom,0
          Print @304,contentID;"stones";
          Poke roomDataOrigin+contentID-51,Peek(roomDataOrigin+contentID-51)+1
          weightCarried=weightCarried+ Peek(treasureWeight+contentID)
          Print @240,"wgt:"weightCarried;
          monsterCharmed=0
5801
      stonesCarried=stonesCarried+contentID
      Print @816,"stones:"stonesCarried;
5803
      Gosub UpdateTreasure@680
      i= Peek(specialTreasureID+contentID)
      On i+1 Then
          MonsterTurn@7000,1,1,5820
5820
      Print @944,"a magic sword!";
      attSkill=attSkill+swordMagic
      swordMagic=2
      attSkill=attSkill-swordMagic
      swordPower=stats(4)*(7+swordMagic)+.5
      For i=1 To 1000
      Next i
      Print @944,"the sword glows";
5822
      Goto MonsterTurn@7000
      **********************************************************************
                                 Speak to Monster
      **********************************************************************
!-Command@5900
      If Rnd(100)<.3*(stats(1)+stats(3))* Peek(monsterCharm+currentMonsterID) Then
          monsterCharmed=1
      Else
          Goto MonsterTurn@7000
5910
      Print @304,space15$;
      Print @304,"pass by";
      Goto MonsterTurn@7000
                                 --- Not used ----
6100
      If Peek(__kb+11)>0 Then
          Poke __kb+11,Peek(__kb+11)-1
          j=0
      Else
          Goto 6150
      **********************************************************************
                                  Recoved Wounds
      **********************************************************************
RecoverWounds@6110
      wounds=wounds+1+j
      If wounds>stats(5) Then
          wounds=stats(5)
6130
      Gosub UpdateWounds@88
      Goto MonsterTurn@7000
      **********************************************************************
                              Drink a Healing Potion
      **********************************************************************
Y-Command@6140
      If elixirs>0 Then
          elixirs=elixirs-1
          j= Rnd(6)+1
          Goto RecoverWounds@6110
6150
      Print @945,"none left";
      Goto MainLoop@5044
6200
      _intuition=stats(2)
      Print @304,space15$;
      i= Peek(roomInDir+currentRoom+roomCount*dirPlayer-roomCount)
      currentMonsterID= Peek(roomMonsterType+i)
      If i=0 Or Peek(monsterInRoomCount+i)=0 Or Rnd(1000)>_intuition*_intuition+ Peek(roomDataOrigin-59)*700 Then
          Print @304,"nothing";
          Goto MonsterTurn@7000
6210
      Gosub GetMonsterName@880
      Print @304,aTemp$;
      Goto MonsterTurn@7000
      **********************************************************************
                                 Search for Traps
      **********************************************************************
S-Command@6300
      If Peek(trapID+currentRoom)>0 And Rnd(20)<stats(2) Then
          Gosub TrapAnimation@670
      Else
          Print @304,space15$;
          Print @304,"nothing";
6310
      Goto MonsterTurn@7000
                   --- Erase player sword then monster turn ----
EraseSwordThenMonster@6990
      k=1
      Gosub DrawEraseSword@600
      **********************************************************************

                                  Monster's Turn.

      **********************************************************************
MonsterTurn@7000
      Gosub UpdateFatigueForAction@650
      If isMonsterActive>0 Then
          7005
      Else
          Gosub CheckRandomMonsterAppear@4850
          If isMonsterActive=0 Then
              MainLoop@5044
               --- Monster appears, do nothing till next turn. ----
7002
      Print @688,"appears";
      Print @624,space15$;
      Print @624,aTemp$;
      Gosub DrawMonster@300
      Goto MainLoop@5044
7005
      Print @432,space15$;
      If monsterCharmed>0 Or attackDisablesMonster>0 Then
          7500
                               --- Check range ----
7010
      If Abs(xPlayerRoomStart-xMonster)>5 Or Abs(yPlayerRoomStart-yMonster)>5 Then
          7300
      **********************************************************************
                                  Monster attacks
      **********************************************************************
7015
      monsterAttackCounter=monsterAttacksPerTurn
7017
      monsterAttackCounter=monsterAttackCounter-1
      If monsterAttackCounter<0 Then
          7250
      --- Check to see if the monster will hit this time, depends on what the player did (in ia) ----
7020
      attackEffect=defSkill-chanceMonsterHitOnAction(ia)
      combatChance= Rnd(20)+monsterLevel
      If combatChance<attackEffect Then
          Print @432,space15$;
          monsterAttackCounter=monsterAttackCounter*1
          Print @432,"it missed!";
          Goto 7017
      --- If damage absorbed by shield, use -shield# as the wound damage ----
7030
      Gosub 65
      If Rnd(20)-1<shieldPower Then
          Print @432,space15$;
          Print @432,"shield hit!";
          k=-shieldID
      Else
          Print @432,space15$;
          Print @432,"struck thee!";
          k=0
          If Peek(monsterResistance+currentMonsterID)=2 And Rnd(20)>stats(5)/2+ Peek(roomDataOrigin-81) And Peek(roomDataOrigin-88)=0 Then
              Gosub ReduceConstitution@50
              Print @432,space15$;
              Print @432,"a chill";
                             --- Do actual damage ----
7040
      k=k+(monsterDamage*(combatChance-attackEffect))/10-armourID
      If k<0 Then
          k=0
7050
      wounds=wounds-k
      If wounds<1 Then
          For i=1 To 1000
          Next i
          Goto PlayerDead@11000
                     --- Loop round for multiple attacks ----
7060
      Gosub UpdateWounds@88
      If isMonsterActive>0 Then
          7017
      Else
          Goto MainLoop@5044
      --- If still alive, move monster one square in a random direction. ----
7250
      If isMonsterActive=0 Then
          MainLoop@5044
      Else
          Gosub EraseMonster@350
          l=2
          On Rnd(4) Then
              7260,7270,7280,7290
7260
      yMonster=yMonster+l
      Goto 7490
7270
      xMonster=xMonster+l
      Goto 7490
7280
      yMonster=yMonster-l
      Goto 7490
7290
      xMonster=xMonster-l
      Goto 7490
      **********************************************************************
                                   Monster moves
      **********************************************************************
                     --- Work out how to chase the player ----
7300
      Gosub EraseMonster@350
      Gosub DrawTreasure@679
      xx=xPlayerRoom-xMonster
      yy=yPlayerRoom-yMonster
      If Abs(xx)< Abs(yy) Then
          7306
      Else
          If xx>0 Then
              monsterDir=2
          Else
              monsterDir=4
7304
      Goto 7310
7306
      If yy>0 Then
          monsterDir=1
      Else
          monsterDir=3
7310
      l=monsterSize
      On monsterDir Then
          7320,7360,7400,7440
7320
      If yMonster+l>yPlayerRoom-3 Then
          yMonster=yPlayerRoom-3
      Else
          yMonster=yMonster+l
7330
      Goto 7490
7360
      If xMonster+l>xPlayerRoom-3 Then
          xMonster=xPlayerRoom-3
      Else
          xMonster=xMonster+l
7370
      Goto 7490
7400
      If yMonster-l<yPlayerRoom+3 Then
          yMonster=yPlayerRoom+3
      Else
          yMonster=yMonster-l
7410
      Goto 7490
7440
      If xMonster-l<xPlayerRoom+3 Then
          xMonster=xPlayerRoom+3
      Else
          xMonster=xMonster-l
                 --- Force monster in room space and draw it. ----
7490
      Gosub PutMonsterInRoom@55
      Gosub DrawMonster@300
           --- Kill monster if dead, possibly creating another one. ----
7500
      If monsterWounds<1 And isMonsterActive>0 Then
          Gosub EraseMonster@350
          Gosub ExplosionEffect@450
          experience#=experience#+20*monsterLevel*monsterLevel+15
          killCount=killCount+1
          Print @304,space15$;
          Print @304,"monster slain!";
          m= Peek(monsterInRoomCount+currentRoom)
          If m>0 Then
              Poke monsterInRoomCount+currentRoom,m-1
              If m>1 Then
                  Gosub CreateMonsterInRoom@4500
                  Print @304,"another appears";
                  Gosub DrawMonster@300
7510
      If monsterWounds<1 Then
          isMonsterActive=0
          Print @368,space15$;
          Print @432,space15$;
          Print @624,space15$;
          Print @688,space15$;
7520
      Goto MainLoop@5044
      **********************************************************************
                                Exited the dungeon
      **********************************************************************
LeaveDungeon@10000
      Cls
      Print Chr$(23)
      Print "thou leavest the dunjon"
10010
      datestoneCount=stonesCarried
      Print "current score:" Int(100*datestoneCount+100+10*(clock-startClock)+experience#)
10015
      Print "current time:" Int(clock-startClock)
      Print "dost wish to re-enter the pit?"
10020
      Gosub GetTimedKey@500
      If l=0 Then
          10020
      Else
          If key$<>"y" Then
              10050
10025
      xPlayer= Peek(xPlayer+1241)
      yPlayer= Peek(roomDataOrigin+1242)
      dirPlayer= Peek(roomDataOrigin+1243)
      fatigue=100
      Gosub ResetRoomRepaint@80
      xPlayer=162
      yPlayer=45
      Goto NewRoom@5030
10050
      timeScoreMultiplier=100
      currentRoom=0
      Goto QuestEnd@12000
      **********************************************************************
                                  Player has Died
      **********************************************************************
PlayerDead@11000
      stonesCarried=datestoneCount
      Cls
      Print @401,Chr$(23);"thou art slain!"
      For i=1 To 2500
      Next i
      isAlive=0
      Goto QuestEnd@12000
      **********************************************************************
                                    Quest Ended
      **********************************************************************
QuestEnd@12000
      Cls
      Print Chr$(23);"end of quest"
      Print " "
      Print "experience gained:"experience#
      Print " "
12015
      Print "datestones recovered:"datestoneCount
                        --- Calculate and print Score ----
12020
      Print " "
      Print "thy score:" Int(100*datestoneCount+timeScoreMultiplier+10*(clock-startClock)+isAlive*experience#)
12030
      End
