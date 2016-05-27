154
      Dim na$(5),w(5),p(5),nc$(6),ww(5),wp(5),wd(5),wr(5),ds(1,1),dw(5,1),ch(6)
157
      q1 = 12
160
      q = 60
      Dim r$(6),rr(6),cp%(6),tt%(20),t%(20,6),m%(q1,10),m$(q1),x1%(q),y1%(q)
163
      Dim no%(q,3),nt%(q,3),d1%(q,3),d2%(q,3),mt%(q),mn%(q),tp%(q),xp%(q),yp%(q)
166
      Dim tr%(q),xr%(q),yr%(q),s%(4),p%(4),za(3),zd(5),tx%(3,1),ty%(3,1),tm(5)
169
      Dim h(3),ls%(2),xs%(9,2),ys%(9,2),t$(9)
      cc = 32768
      km = 0
172
      ef% = 0
      Dim x2%(q),y2%(q),ns$(2),rt%(q),rs%(10),sd$(22),tr$(20)
175
      Data "flame","dust","mold","pit","","spear","needle","xbow","cavein","ceiling"
178
      For i = 0 To 9
          Read t$(i)
      Next
181
      Data 4,1,10,0,-1,-1,0,1,0,0,1,0,0,-1,-1,0,-1,1,-1,-2,0,0,0,2,0,-1,1,1,1,-1,2
184
      Data 1,2,0,1,-1,1,-2,6,1,1,2,1,12,-1,1,-1,2,18,-1,-1,-2,-1,10,13,2,1,1
187
      Read ls%(0),ls%(1),ls%(2)
      For j = 0 To 2
          For i = 0 To ls%(j) - 1
              Read xs%(i,j),ys%(i,j)
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
          Read na$(i),w(i),p(i)
          w(i) = Int(w(i) / 16 + .5)
      Next
208
      w(0) = 0
      For i = 1 To 6
          Read nc$(i)
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
          Read nw$(i),ww(i),wp(i),wd(i),wr(i)
          For j = 0 To 1
              Read dw(i,j)
          Next
226
      Next
      Read nw$(6)
      For i = 0 To 2
          Read ns$(i)
      Next
229
      Data 6,3,10,8,15,12,5,15,6,17
232
      For i = 1 To 2
          Read sw(i),sd(i),sp(i)
          For j = 0 To 1
              Read ds(i - 1,j)
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
      rn = 6
      rt = 0
      For i = 1 To rn
          Read r$(i),rr(i)
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
          Read sd$(i)
      Next i
      sd$(13) = sd$(14)
      Read b1$
      bl$ = b1$ + "   "
271
      b2$ = b1$ + " "
      Goto 607
274
      pc = pc - 1
      ch(5) = ch(5) - 1
      cp%(5) = cp%(5) - 1
      Return
277
      Print Chr$(14);
      For i = 1 To 40
      Next
      Print Chr$(142);
      Return
280
      x = 53
      y = 5
      Gosub 352
      Print wc;
      Return
283
      yy = w1 - w2 - 4
      If ym > yy Then
          ym = yy
286
      If ym < 4 Then
          ym = 4
289
      xx = v2 - v1 - 4
      If xm > xx Then
          xm = xx
292
      If xm < 4 Then
          xm = 4
295
      x = 50
      y = 18
      Gosub 352
      Print b1$;
      y = 19
      Gosub 352
      Print b1$;
      Return
298
      Gosub 343
      Gosub 352
      Print j;"arrows";
      Return
301
      x = 50
      y = 13
      Gosub 352
      Print b2$;
      Gosub 352
      Print a$;
      y = 14
      Gosub 352
      Print "appears!";
304
      Return
307
      a$ = "   "
      j = 1739
      Gosub 349
      a$ = Str$(kc)
      Gosub 349
      Return
310
      j = xa - xb + cc + 80 * Int((ya - yb) / 2)
      l = Peek(j)
      Poke j,166
313
      For i = 1 To 30
      Next i
      Poke j,l
      Return
316
      a$ = "    "
      j = 215
      Gosub 349
      i = Int(100 * pc / ch(5) + .5)
      a$ = Str$(i)
319
      Gosub 349
      Return
322
      Gosub 490
      If l = 0 Goto 322
325
      j = Asc(c$) - 48
      If j < 0 Or j > 9 Goto 322
328
      Return
331
      a$ = Str$(rs)
      j = 616
      Goto 337
334
      a$ = Str$(rm)
      j = 696
337
      For i = 2 To Len(a$)
          Poke cc + j + i, Asc(Mid$(a$,i,1))
      Next i
340
      For i = Len(a$) + 1 To 5
          Poke cc + j + i,32
      Next i
      Return
343
      x = 49
      y = 10
      Gosub 352
      Print bl$;
      Return
346
      For i = 1 To 60
          rt%(i) = 0
      Next i
      Return
349
      For i = 2 To Len(a$)
          Poke i + j + cc, Asc(Mid$(a$,i,1))
      Next i
      Return
352
      Poke 226,x
      Poke 224,y
      Print "{19}";
      Poke 226,0
      Poke 224,0
      Return
355
      Poke 213,47
      Print "{Clr}";
      Poke 213,79
      Return
358
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
      jx = xx
      If jx < 0 Or jx > 47 Then
          Return
370
      If l1 And 1 Then
          jy = l1
          Gosub 469
          If i1 = 1 Then
              jx = jx + 1
              Gosub 469
373
      If Not l2 And 1 Then
          jy = l2
          Gosub 469
          If i1 = 1 Then
              jx = jx + 1
              Gosub 469
376
      If l4 > = l3 Then
          nx = cc + xx + 80 * l3
          For ny = l3 To l4
              Poke nx,160
              Poke nx + 1,160
              nx = nx + 80
          Next
379
      Return
382
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
      jx = xx
      If jx < 0 Or jx > 47 Then
          Return
394
      If i1 = 0 Then
          
          For jy = l1 To l2
              Gosub 475
          Next
          Return
397
      If l1 And 1 Then
          jy = l1
          Gosub 475
          If i1 = 1 Then
              jx = jx + 1
              Gosub 475
              jx = xx
400
      If Not l2 And 1 Then
          jy = l2
          Gosub 475
          If i1 = 1 Then
              jx = jx + 1
              Gosub 475
403
      If l4 > = l3 Then
          nx = cc + xx + 80 * l3
          For ny = l3 To l4
              Poke nx,32
              Poke nx + 1,32
              nx = nx + 80
          Next
406
      Return
409
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
      jy = yy
      If jy < 0 Or jy > 47 Then
          Return
418
      If yy And 1 Then
          For jy = yy To yy + 1
              For jx = l1 To l2
                  Gosub 469
              Next
          Next
          Return
421
      If l2 > = l1 Then
          ny = cc + yy * 40
          For nx = l1 To l2
              Poke ny + nx,160
          Next
424
      Return
427
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
      jy = yy
      If jy < 0 Or jy > 47 Then
          Return
436
      If yy And 1 Or i1 = 0 Then
          For jy = yy To yy + i1
              For jx = l1 To l2
                  Gosub 475
              Next
          Next
          Return
439
      If l2 > = l1 Then
          ny = cc + yy * 40
          For nx = l1 To l2
              Poke ny + nx,32
          Next
442
      Return
445
      xx = xa - xb
      yy = yb - ya
      Poke 86,xx
      Poke 87,yy
      Poke 88,kf
      Sys 640
      Return
448
      xx = xa - xb
      yy = yb - ya
      Poke 86,xx
      Poke 87,yy
      Poke 88,kf
      Sys 643
      Return
451
      k = 1
454
      j = m%(mq,6)
      For i = 0 To ls%(j) - 1
          jx = xm + v1 - xb + xs%(i,j)
          jy = yb - ym - w2 + ys%(i,j)
457
          On k Gosub 466,472
      Next i
      Return
460
      If nb = 0 Then
          Return
463
      k = 2
      Goto 454
466
      If jx < 0 Or jx > 47 Then
          Return
469
      Poke 86,jx
      Poke 87,jy
      Sys 634
      Return
472
      If jx < 0 Or jx > 47 Or jy < 0 Or jy > 47 Then
          Return
475
      Poke 86,jx
      Poke 87,jy
      Sys 637
      Return
478
      jx =(xm + v1 - xb)
      jy = Int((yb - ym - w2) / 2)
481
      j = cc + jx + 80 * jy
      l = Peek(j)
484
      For i = 1 To 100
          Poke j,219
          k = k / 5
          Poke j,l
      Next i
487
      Return
490
      le = se /(nb + 1)
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
499
      ii = xl - xb + v1
      ij = yb - yl - w2
      For l = 0 To 1
          jx = ii + tx%(kf - 1,l)
          jy = ij + ty%(kf - 1,l)
502
          On k + 1 Gosub 466,472
505
      Next l
      Return
508
      ta = Int(ta -(Abs(m) / mm *(100 / ch(5) + 5 - 5 * pc / ch(5)) *(1 + wc / wt * 3) / 2) + 11)
511
      a$ = "    "
      j = 295
      Gosub 349
      If ta > 100 Then
          ta = 100
514
      a$ = Str$(ta)
      If ta < 0 Then
          a$ = "-" + a$
517
      Gosub 349
      Return
520
      jy = yb - yp%(kr) - w2
      jx = xp%(kr) + v1 - xb
      For l = 1 To 10
          Gosub 466
          Gosub 472
      Next l
      Return
523
      If tr%(kr) = 0 Then
          Return
526
      jx = v1 + xr%(kr) - xb
      yy = yb - w2 - yr%(kr)
      For jy = yy - 1 To yy
529
          If tr%(kr) = 0 Then
              Gosub 472
532
          If tr%(kr) > 0 Then
              Gosub 466
535
      Next jy
      Return
538
      n = tp%(kr)
      l = 0
541
      If nb > 0 Or n = 0 Then
          Return
544
      If Abs(xl - xp%(kr)) > 2 Or Abs(yl - yp%(kr)) > 2 Or Rnd(0) * 100 > t%(n,2) Then
          Return
547
      Gosub 343
      x = 49
      y = 10
      Gosub 352
      Print t$(t%(n,4));" trap";
      Gosub 310
550
      i = t%(n,3)
      If i > 0 Then
          nb = 1
          Gosub 1249
          xm = xp%(kr)
          ym = yp%(kr)
          Gosub 301
          Goto 556
553
      If t%(n,5) > 0 Then
          ml = t%(n,5)
          l = 1
          md = 3 * ml
556
      tp%(kr) = 0
      Return
559
      ll = kr
      Goto 565
562
      ll = lr
565
      v3 = x1%(ll)
      v4 = x2%(ll)
      w3 = y1%(ll)
      w4 = y2%(ll)
      If ll < > kr Then
          Return
568
      v1 = v3
      v2 = v4
      w1 = w3
      w2 = w4
      Return
571
      a$ = m$(mq)
      Return
574
      j% = 0
      Print "{Clr}"
577
      For i = 0 To 79
          Poke cc + j% + i,160
      Next i
580
      If j% = 0 Then
          j% = 23 * 80
          Goto 577
583
      For i = 0 To j% Step 80
          Poke cc + i,160
          Poke cc + i + 79,160
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
          Poke cc + i,230
      Next i
598
      Print "{Down}{Down}{Down}" Tab(30);"hit any key to begin"
601
      Get a$
      r = Rnd(0)
      If Len(a$) = 0 Goto 601
604
      Return
607
      Print Chr$(130); Chr$(142);
      If ef% < > 123 Then
          Gosub 574
610
      Print Chr$(14)"{Clr}Thus quoth the Innkeeper:"
613
      If ef% < > 123 Goto 634
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
      Input "How many silver pieces hast thou";mo
      om = mo
628
      If mo > 0 Then
          Gosub 970
631
      Goto 652
634
      ef% = 0
      Print "{Down}Hail and well met O noble Adventurer!"
637
      Print "{Down}Hast thou a character already, or should"
640
      Print "{Down}I find thee one; say yea if I should";
      Input a$
643
      If Left$(a$,1) = "y" Then
          Gosub 766
646
      If Left$(a$,1) < > "y" Then
          Gosub 793
          Gosub 1306
          For i = 1 To 1500
          Next i
649
      om = mo
      Input "Thy character's name";nm$
      If mo > 0 Then
          Gosub 970
652
      If mo > 0 Then
          Gosub 1027
655
      If ps = 0 Then
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
      If mo > 0 Then
          Gosub 733
667
      If mo > 0 Then
          Gosub 1072
670
      If mo > 0 Then
          Gosub 1105
673
      se = 300
676
      Input "Monster speed (slow,medium, or fast)";a$
679
      If Left$(a$,1) = "s" Then
          se = 600
682
      If Left$(a$,1) = "f" Then
          se = 150
685
      wa = Int(5 + ww(sk) + w(aa) + sw(Int(ps / 2)) + 1 +(rs + rm) / 10)
      wc = wa
688
      Gosub 1306
691
      ef% = 123
694
      Input "What level wouldst thou visit (1-12)";lv
695
      an$ = dr$ + ":level " + Chr$(lv + 64)
697
      If lw = lv Goto 730
700
      lw = lv
703
      k = 0
      Open 2,un%,2,an$
706
      Input# 2,lv,xp,yp,kp,pw,bg
709
      xa = xp
      ya = yp
      kf = kp
712
      For i = 1 To q
          For j = 0 To 3
              Input# 2,no%(i,j),nt%(i,j),d1%(i,j),d2%(i,j)
          Next
      Next
715
      For i = 1 To q
          Input# 2,mt%(i),mn%(i),tp%(i),xp%(i),yp%(i),tr%(i),xr%(i),yr%(i)
718
          Input# 2,x1%(i),y1%(i),x2%(i),y2%(i)
      Next
721
      For i = 1 To 12
          Input# 2,m$(i)
          For j = 0 To 10
              Input# 2,m%(i,j)
          Next
      Next
724
      For i = 1 To 20
          Input# 2,tr$(i)
          For j = 0 To 6
              Input# 2,t%(i,j)
          Next
      Next
727
      Close 2
730
      Print Chr$(14)"{Clr}"
      Goto 1369
733
      Input "Wilt thou buy new armor";a$
      If Left$(a$,1) = "n" Then
          Return
736
      Print "{Clr}type" Tab(25);"weight" Tab(32);"price"
739
      For i = 1 To 5
          Print na$(i); Tab(25);w(i); Tab(32);p(i)
      Next i
742
      Print "What sort of armor wouldst thou wear"
      Input a$
      Gosub 1981
745
      If Left$(a$,1) = "N" Then
          am = 0
          aa = 0
          Return
748
      For i = 1 To 5
          If Left$(a$,2) = Left$(na$(i),2) Then
              n = i
              Goto 754
751
      Next i
      Print "I have not "a$;" for sale"
      Goto 742
754
      lo = .3 * p(n)
      ak = p(n)
      a1 = ak
      Gosub 1129
      If oo = 0 Goto 742
757
      aa = n
      am = 0
      mo = mo - oo
760
      Print "Thou hast"mo;" silver pieces left in thy purse"
      Return
763
      j = Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1) + Int(6 * Rnd(1) + 1)
      Return
766
      hb = 0
      sc = 0
      For i = 1 To 6
          Gosub 763
          ch(i) = j
          sc = sc + j
          cp%(i) = j
      Next i
769
      If sc < 60 Or ch(4) < 8 Or ch(5) < 7 Goto 766
772
      ex = 0
      rs = 0
      rm = 0
      aa = 0
      am = 0
      ps = 0
      sk = 0
      sp = 0
      wp = 1
      sm = 0
      hs = 0
      hn = 0
      ll = 0
775
      Print "{Clr}Thy qualities:"
      For i = 1 To 6
          Print nc$(i); Tab(15);ch(i)
      Next i
778
      Print " "
      Gosub 763
      mo = j * 10
      Print "Thou hast"mo;" pieces of Silver"
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
793
      ll = 0
      For i = 1 To 6
          Print "enter "nc$(i);
          Input ch(i)
          cp%(i) = ch(i)
796
          If ch(i) > 18 Then
              Print ch(i);"be too high. no more than 18 can it be"
              i = i - 1
799
      Next i
802
      Input "Thy character's experience is";ex
805
      If ex > 16000000 Then
          Print "Thy character be too worldwise, find another"
          Goto 793
808
      e = ex / 1000
      For l = 1 To 20
          If 2 ^ l > e Then
              Goto 814
811
      Next l
814
      Input "How much money hast thou to spend";mo
817
      Gosub 889
820
      Print "What kind of Sword hast thou"
      Input a$
      Gosub 1981
823
      For i = 0 To 5
          If Left$(a$,1) = Left$(nw$(i),1) Then
              n = i
              oo = 0
              Goto 832
826
      Next i
      Print "Thou canst not take a "a$;" to the Dunjon. Thou must buy another."
829
      Goto 820
832
      If wr(n) < = ch(4) Then
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
          If Left$(a$,2) = Left$(na$(i),2) Then
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
      hb = 0
      If Left$(a$,1) = "y" Then
          hb = 1
859
      Input "How many arrows hast thou";rs
862
      Input "How many magic arrows hast thou";rm
865
      Input "How many healing potions hast thou";hn
868
      Input "How many healing salves hast thou";hs
      If hs > 10 Then
          hs = 10
871
      sm = 0
      If sk > 0 Then
          Input "Be thy sword magical";a$
874
      If Left$(a$,1) = "y" Then
          Input "What be the plus";sm
877
      am = 0
      If aa = 0 Goto 886
880
      Input "Is thy armor Magical";a$
883
      If Left$(a$,1) = "y" Then
          Input "What be the plus";am
886
      Gosub 790
      Goto 784
889
      wp = l
      sp = 0
      If w2 < > 1 Then
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
      If ef% = 123 Then
          l = 2
          On j + 1 Goto 889,904,913,922,928,940
904
      l = l - 1
      If l = 0 Goto 949
907
      If ch(5) < 9 Then
          ch(5) = ch(5) + 1
          Goto 913
910
      ch(4) = ch(4) + 1
913
      l = l - 1
      If l = 0 Goto 949
916
      If ch(6) < 9 Then
          ch(6) = ch(6) + 1
          Goto 922
919
      ch(5) = ch(5) + 1
922
      l = l - 1
      If l = 0 Goto 949
925
      ch(5) = ch(5) + 1
928
      l = l - 1
      If l = 0 Goto 949
931
      If ch(6) < 9 Then
          ch(6) = ch(6) + 1
          Goto 940
934
      If ch(4) < ch(5) Then
          ch(4) = ch(4) + 1
          Goto 940
937
      ch(5) = ch(5) + 1
940
      l = l - 1
      If l = 0 Goto 949
943
      If ch(2) < ch(3) Then
          ch(2) = ch(2) + 1
          Goto 904
946
      ch(3) = ch(3) + 1
      Goto 904
949
      For i = 1 To 6
          m = ch(i) - 18
          If m < = 0 Goto 967
952
          ch(i) = 18
          For j = 1 To m
              If ch(4) < 18 Then
                  ch(4) = ch(4) + 1
                  Goto 964
955
              If ch(5) < 18 Then
                  ch(5) = ch(5) + 1
                  Goto 964
958
              If ch(6) < 18 Then
                  ch(6) = ch(6) + 1
                  Goto 964
961
              r = Int(3 * Rnd(1) + .999)
              ch(r) = ch(r) + 1
964
          Next j
967
      Next i
      Return
970
      Print "Wilt thou buy one of our fine Swords";
      Input a$
973
      If Left$(a$,1) < > "y" Then
          n = st
          Gosub 1015
          Return
976
      w2 = 0
      Print "weapon" Tab(24);"weight" Tab(35);"price"
979
      For i = 1 To 5
          Print nw$(i); Tab(24);ww(i); Tab(34);wp(i)
      Next i
982
      Print "{Down}What weapon wilt thou purchase"
      Input a$
      Gosub 1981
      For i = 1 To 5
985
          If Left$(a$,1) = Left$(nw$(i),1) Then
              n = i
              Goto 994
988
      Next i
      If Left$(a$,1) = "n" Then
          n = sk
          Gosub 1015
          Return
991
      Print "I have not such a weapon as a "a$
      Goto 982
994
      If wr(n) > ch(4) Then
          Print "Thou cannot wield such a Great Weapon"
          Goto 982
997
      Print "Feast thy eyes 'pon this fine "nw$(n)
      j = Int(Rnd(1) + 1)
1000
      If j > 2 Then
          Print "'Tis sure to always drink thy Foe's blood"
1003
      If j < 3 Then
          Print "'Tis well-forged iron"
1006
      ls = 0
      lo = .3 * wp(n)
      ak = wp(n)
      a1 = ak
      Gosub 1129
      If oo = 0 Goto 982
1009
      mo = mo - oo
      Print "Thou hast"mo;" silver pieces left"
1012
      wm = Int(wd(n) * ch(4) / 10 + .5)
      sm = 0
      sk = n
      If n = 5 Then
          w2 = 1
1015
      If dw(n,0) > ch(6) Then
          wp = wp + ch(6) - dw(n,0)
1018
      If dw(n,1) < ch(6) Then
          wp = wp + ch(6) - dw(n,1)
1021
      If wp > 0 Then
          wp = Int(1.3 * Log(wp) + 1)
1024
      Return
1027
      If w2 = 1 Then
          ps = 0
          sp = 0
          Return
1030
      Input "Wilt thou buy a shield";a$
      If Left$(a$,1) = "n" Then
          Gosub 1063
          Return
1033
      Print "shield     weight     ask"
      Print "small" Tab(11);sw(1); Tab(22)sp(1)
1036
      Print "large" Tab(11);sw(2); Tab(22);sp(2)
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
      lo = .3 * sp(n)
      ak = sp(n)
      a1 = ak
      Gosub 1129
      If oo = 0 Then
          Goto 1030
1051
      If ds(n - 1,0) > ch(6) Then
          sp = sp + ch(6) - ds(n - 1,0)
1054
      If ds(n - 1,1) < ch(6) Then
          sp = sp + ch(6) - ds(n - 1,1)
1057
      mo = mo - oo
      Print "Thou hast"mo;" silver pieces left"
1060
      ps = sd(n)
      Gosub 1063
      Return
1063
      If ps = 5 Then
          sp = Int(sp / 2)
1066
      If sp > 0 Then
          sp = Int(1.3 * Log(sp) + 1)
1069
      sp = 2 * ps + sp
      Return
1072
      If hb > 0 Then
          Goto 1090
1075
      Input "Wilt thou buy a bow";a$
      If Left$(a$,1) = "n" Then
          Return
1078
      Print "I've a fine bow, Yew and nearly New, for12 silver pieces"
      lo = 4
      ak = 12
1081
      a1 = ak
      Gosub 1129
      If oo = 0 Then
          Return
1084
      mo = mo - oo
      Print "Thou hast"mo;" remaining"
1087
      If rs + rm > = 60 Then
          rs = 60 - rm
          Goto 1102
1090
      n = 0
      Input "How many arrows wilt thou buy (at 5 coppers each)";n
1093
      If Int((n + 1) / 2) > mo Then
          Print "No credit!"
          Goto 1090
1096
      If rs + rm + n > 60 Then
          Print "Thou can carry but 60 - buy fewer"
          Goto 1090
1099
      rs = rs + n
      mo = mo - Int((n + 1) / 2)
      Print "Thou hast"mo;" remaining"
1102
      Return
1105
      Input "How many salves wilt thou buy - they'll cost thee 10 each";n
1108
      If 10 * n > mo Then
          Print "no credit"
          Goto 1105
1111
      If n > 10 Then
          Print "More than 10 will do thee no good"
          n = 10 - hs
1114
      mo = mo - 10 * n
      hs = hs + n
1117
      If mo < .35 * om Then
          Print nm$;"! Thou spendthrift!"
1120
      If mo > .7 * om Then
          Print nm$;", Thou art frugal"
1123
      Print "Thou hast"mo;" silver pieces left"
1126
      Return
1129
      j = Rnd(0)
      If j > .66 Then
          Print "What be thy offer "nm$;
1132
      If j < = .66 Then
          Print "What offerest thou";
1135
      Input oo
      If oo > mo Then
          Print "Liar -  thou hast but"mo
          Goto 1129
1138
      If oo = 0 Then
          ls = 0
          Return
1141
      If oo < = lo Then
          Gosub 1354
          Goto 1129
1144
      If oo < = ls Then
          Gosub 1342
          Goto 1129
1147
      If oo > = ak Then
          Print "done"
          ls = 0
          Return
1150
      If oo < ak - .3 * Sqr(Rnd(0)) * ak Goto 1159
1153
      ls = 0
      If oo < .6 * a1 Then
          Print "Thou art a hard bargainer "nm$
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
      ak = oo +(ak - oo) * Sqr(Rnd(0)) *(20 /(ch(1) + ch(3)))
1168
      ls = oo
1171
      Gosub 1360
      Goto 1129
1174
      lr = kr
      Gosub 559
      If rt%(kr) = 1 Goto 1186
1177
      Print Chr$(142);
      Gosub 355
      Gosub 346
      xb = v1
      yb = w1
1180
      If nt%(lr,3) = 1 Then
          xb = xb -(48 - v2 + v1) / 2
          If nt%(lr,1) = 1 Then
              xb = xb +(v1 - xb) / 2
1183
      If nt%(lr,0) = 1 Then
          yb = yb + 48 - w1 + w2
          If nt%(lr,2) = 1 Then
              yb = yb -(yb - w1) / 2
1186
      xb = Int(xb + .9)
      If Not xb And 1 Then
          xb = xb - 1
1189
      yb = Int(yb + .9) And 254
1192
      xl = xa - v1
      yl = ya - w2
1195
      If mt%(kr) > 0 And mn%(kr) > 0 Then
          Gosub 1225
          nb = 1
          Goto 1201
1198
      Gosub 1240
1201
      Poke 226,49
      Print "{19}";
      For y = 0 To 22
          Print sd$(y)
      Next
      Poke 226,0
1204
      x = 58
      y = 0
      Gosub 352
      Print kr;
1207
      Gosub 280
      Gosub 331
      Gosub 334
      Gosub 508
      Gosub 316
      Gosub 307
1210
      If nb > 0 Then
          Gosub 451
          a$ = m$(mq)
          Gosub 301
1213
      ns = 5
      If ib = 3 Goto 1222
1216
      For ir = 0 To 3
          lr = no%(kr,ir)
          If nt%(kr,ir) = 1 And lr > 0 Then
              Gosub 1258
1219
      Next ir
1222
      lr = kr
      Gosub 1258
      Gosub 445
      Gosub 523
      Return
1225
      mq = mt%(kr)
      i = mq
      nb = 1
1228
      ml = m%(i,0)
      ma = m%(i,1)
      mp = m%(i,2)
      ms = m%(i,9)
      md = m%(i,4)
      mh = m%(i,5)
      ih = 0
1231
      a$ = m$(mq)
      Gosub 301
1234
      xm = Int(Rnd(0) *(v2 - v1 - 8)) + 4
      ym = Int(Rnd(0) *(w1 - w2 - 8)) + 5
1237
      mf = Int(Rnd(0) * 4) + 1
      Return
1240
      l = Rnd(0)
      If l > pw / 100 Then
          nb = 0
          a$ = ""
          Return
1243
      l = Rnd(0)
      ls = 0
      nb = 1
      For i = 1 To q1
          ls = ls + m%(i,8)
          If l < = ls / 100 Goto 1249
1246
      Next i
1249
      mt%(kr) = i
      mn%(kr) = 1
      mq = i
      Goto 1228
1252
      l = Rnd(0)
      If l < pw / 600 Goto 1243
1255
      Return
1258
      If rt%(lr) = 1 Then
          Return
1261
      Gosub 562
      If v3 - xb > - 1 And v4 - xb < 49 And yb - w3 > - 1 And yb - w4 < 49 Then
          rt%(lr) = 1
1264
      xx = v4 - xb - 2
      For k = 1 To 3 Step 2
          yy = yb - w3
          If ns = k Goto 1282
1267
          l = w3 - w4
          ll = d2%(lr,k) - d1%(lr,k)
          If ll + 4 = l Goto 1282
1270
          i1 = 1
          If ll = 0 Then
              Gosub 358
              Goto 1282
1273
          If nt%(lr,k) > 1 Then
              Gosub 358
              Goto 1279
1276
          l = l - d2%(lr,k)
          Gosub 358
          l = d1%(lr,k)
          yy = yb - w4 - l
          Gosub 358
          Goto 1282
1279
          i1 = 2 - nt%(lr,k)
          If i1 > = 0 And i1 < 2 Then
              yy = yb - w4 - d2%(lr,k)
              l = ll
              Gosub 382
1282
          xx = v3 - xb
      Next k
1285
      yy = yb - w3
      For k = 0 To 2 Step 2
          If ns = k Goto 1303
1288
          xx = v3 - xb
          l = v4 - v3
          ll = d2%(lr,k) - d1%(lr,k)
          If ll + 4 = l Goto 1303
1291
          If ll = 0 Then
              Gosub 409
              Goto 1303
1294
          If nt%(lr,k) > 1 Then
              Gosub 409
              Goto 1300
1297
          l = d1%(lr,k)
          Gosub 409
          l = v4 - v3 - d2%(lr,k)
          xx = v4 - xb - l
          Gosub 409
          Goto 1303
1300
          i1 = 2 - nt%(lr,k)
          If i1 > = 0 And i1 < 2 Then
              xx = v3 - xb + d1%(lr,k)
              l = ll
              Gosub 427
1303
          yy = yb - w4 - 2
      Next k
      Return
1306
      wn = sk
      If sm < > 0 Then
          wn = 6
1309
      Print "{Clr}Character Summary for "nm$
1312
      Print " "
      For i = 1 To 6
          Print nc$(i); Tab(15);cp%(i)
      Next i
1315
      Print "{Down}Weapon:"nw$(wn);
      If wn = 6 Then
          Print Tab(22);"plus:"sm;
1318
      Print " "
      Print "Armor :"na$(aa);
      If am > 0 Then
          Print Tab(22);"plus:"am;
1321
      j = 0
      If ps > 0 Then
          j = 1
          If ps > 3 Then
              j = 2
1324
      Print " "
      Print "Shield:"ns$(j)
1327
      Print "Arrows:"rs; Tab(20);"Magic Arrows:"rm
1330
      Print "Salves:"hs; Tab(20);"Elixirs:"hn
1333
      Print "Experience:"ex; Tab(20);"Weight carried:"wc
1336
      Print "Silver:"mo
1339
      Return
1342
      j = Int(Rnd(0) * 3 + 1)
      On j Goto 1345,1348,1351
1345
      Print "Dost thou take me for a dolt!"
      Return
1348
      Print "Fool or knave "nm$;"! Make an offer higher than thy last!"
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
      For i1 = 1 To rn
          rq = rq + rr(i1) / rt
          If rq > r Then
              Print r$(i1); Int(ak + .99)
              Return
1366
      Next i1
1369
      kr = 1
      o$ = "rlatpfmgev!hqsydo"
      wc = wa
      mm = 4
      ta = 100
      pc = ch(5)
      as = ch(4) / 10
1372
      kc = 0
      xa = xp
      ya = yp
      kf = kp
      wt = ch(4) * ch(4)
1375
      Gosub 1174
      s%(1) = w1 - w2
      s%(2) = v2 - v1
      s%(3) = 0
      s%(4) = 0
1378
      p%(1) = xa - v1
      p%(2) = ya - w2
      p%(3) = p%(1)
      p%(4) = p%(2)
      p%(0) = p%(2)
1381
      x0 = xl
      y0 = yl
      ia = 0
      Gosub 490
      m = 0
      Gosub 343
      Gosub 292
      If l = 0 Goto 1771
1384
      If Asc(c$) > 47 And Asc(c$) < 58 Goto 1399
1387
      For i = 1 To 17
          If c$ < > Mid$(o$,i,1) Goto 1396
1390
          On i Goto 1507,1513,1525,1525,1525,1525,1525,1645,1633,1519,1726,1732,1750
1393
          On i - 13 Goto 1762,1744,1705,1597
1396
      Next i
      Goto 1381
1399
      If ta < 1 Goto 1525
1402
      m = Asc(c$) - 48
      m1 = m
      ib = 0
      On kf Goto 1405,1417,1411,1423
1405
      If ya + m > w1 - 3 Then
          m = w1 - 3 - ya
          ib = 1
1408
      Goto 1438
1411
      m = - m
      m1 = m
      If ya + m < w2 + 4 Then
          m = w2 + 4 - ya
          ib = 1
1414
      Goto 1438
1417
      If xa + m > v2 - 4 Then
          m = v2 - 4 - xa
          ib = 1
1420
      Goto 1438
1423
      m = - m
      m1 = m
1426
      If xa + m < v1 + 3 Then
          m = v1 + 3 - xa
          ib = 1
1429
      Goto 1438
1432
      If nb > 0 Goto 1771
1435
      Goto 1792
1438
      If ib = 0 Goto 1474
1441
      xl = xa - v1
      yl = ya - w2
      If nt%(kr,kf - 1) < > 1 Goto 1474
1444
      If p%(kf) < = d1%(kr,kf - 1) Or p%(kf) > = d2%(kr,kf - 1) Goto 1453
1447
      Gosub 460
      nb = 0
      in = 0
      kr = no%(kr,kf - 1)
      Gosub 559
      ib = 2
      m = Abs(m) + 4
1450
      If kr = 0 Goto 1930
1453
      If ib = 1 Goto 1474
1456
      If v1 - xb < 0 Or v2 - xb > 48 Or yb - w1 < 0 Or yb - w2 > 48 Goto 1462
1459
      ib = 3
      s%(1) = w1 - w2
      s%(2) = v2 - v1
      m = m1
      Gosub 508
      Goto 1474
1462
      If kf = 1 Then
          ya = w2 + 4
          Goto 1375
1465
      If kf = 3 Then
          ya = w1 - 3
          Goto 1375
1468
      If kf = 2 Then
          xa = v1 + 3
          Goto 1375
1471
      xa = v2 - 4
      Goto 1375
1474
      Gosub 448
      Gosub 523
      If kf = 1 Or kf = 3 Then
          ya = ya + m
          Goto 1480
1477
      xa = xa + m
1480
      If rs%(4) > 0 Then
          m = m / 2
1483
      If xa < v1 + 3 Then
          xa = v1 + 3
1486
      If xa > v2 - 4 Then
          xa = v2 - 4
1489
      If ya < w2 + 4 Then
          ya = w2 + 4
1492
      If ya > w1 - 3 Then
          ya = w1 - 3
1495
      Gosub 445
      p%(1) = xa - v1
      p%(3) = p%(1)
      p%(2) = ya - w2
      p%(4) = p%(2)
      p%(0) = p%(2)
1498
      If ib = 3 Then
          lr = kr
          Gosub 1192
          ib = 0
          Goto 1381
1501
      xl = xa - v1
      yl = ya - w2
      Gosub 538
      If l > 0 Goto 1792
1504
      Goto 1771
1507
      Gosub 448
      kf = kf + 1
      If kf > 4 Then
          kf = 1
1510
      Goto 1522
1513
      Gosub 448
      kf = kf - 1
      If kf < 1 Then
          kf = 4
1516
      Goto 1522
1519
      Gosub 448
      kf = kf - 2
      If kf < 1 Then
          kf = kf + 4
1522
      Gosub 445
      Goto 1381
1525
      x = 49
      y = 10
      If ta < 1 Then
          Gosub 352
          Print "too tired";
          Goto 1771
1528
      in = 0
      ia = i - 2
      km = 0
      On ia Goto 1531,1531,1531,1558,1552
1531
      hi = 0
      If Abs(xl - xm) > 5 Or Abs(yl - ym) > 5 Then
          Gosub 352
          Print "too far to hit";
          Goto 1771
1534
      m = tm(ia)
      k = 0
      Gosub 499
      p = pb -(ch(3) - 9) / 3 * Exp(- 2 * pc / ch(5)) + ml / 3 - za(ia)
1537
      r = Int(Rnd(0) * 20 + 1)
      x = 50
      y = 18
      If r < p Then
          Gosub 352
          Print "swish";
          Goto 1768
1540
      ak = as *(r - p + 1)
      Gosub 352
      Print "crunch";
      If ak > wm Then
          ak = wm
1543
      If ak < mh Then
          ak = mh
1546
      If m%(mq,3) < > 2 Or(sm > 0 And ia < 4) Or ia = 5 Then
          mp = mp - ak + mh
1549
      in = 0
      Goto 1768
1552
      i1 = 5
      km = 5
      If rm = 0 Goto 1771
1555
      rm = rm - 1
      Gosub 334
      Goto 1564
1558
      i1 = 3
      If rs = 0 Goto 1771
1561
      rs = rs - 1
      Gosub 331
1564
      On kf Goto 1567,1579,1570,1582
1567
      ly = yl + 2
      uy = ym - 2
      s = 1
      Goto 1573
1570
      ly = yl - 2
      uy = ym + 2
      s = - 1
1573
      x = xl
      jx = x + v1 - xb
      For y = ly To uy Step s
          jy = yb - y - w2
          Gosub 466
          Gosub 472
      Next y
1576
      Goto 1588
1579
      lx = xl + 2
      ux = xm - 2
      s = 1
      Goto 1585
1582
      lx = xl - 2
      ux = xm + 2
      s = - 1
1585
      jy = yb - yl - w2
      For x = lx To ux Step s
          jx = x + v1 - xb
          Gosub 466
          Gosub 472
      Next x
      y = yl
1588
      c$ = "swissh"
      If Abs(x - xm) < i1 And Abs(y - ym) < i1 Then
          c$ = "thwunk"
1591
      Gosub 292
      x = 50
      y = 18
      Gosub 352
      Print c$;
      If Left$(c$,1) = "s" Goto 1771
1594
      ak = Int(7 * Rnd(0) + 1) + km
      Goto 1543
1597
      If nt%(kr,kf - 1) < > 2 Goto 1771
1600
      k = kf - 1
      If p%(kf) < = d1%(kr,k) Or p%(kf) > = d2%(kr,k) Or Abs(p%(k) - s%(kf)) > 5 Goto 1771
1603
      nt%(kr,k) = 1
      ij = 0
      On kf Gosub 1621,1612,1627,1618
1606
      lr = no%(kr,k)
      ns =(kf + 1) And 3
1609
      nt%(lr,ns) = 1
      ns = 5
      Gosub 1258
      Goto 1771
1612
      xx = v2 - xb - 2
1615
      i1 = 1 + ij
      yy = yb - w2 - d2%(kr,k)
      l = d2%(kr,k) - d1%(kr,k)
      Gosub 382
      Return
1618
      xx = v1 - xb
      Goto 1615
1621
      yy = yb - w1
1624
      i1 = 1 + ij
      xx = v1 - xb + d1%(kr,k)
      l = d2%(kr,k) - d1%(kr,k)
      Gosub 427
      Return
1627
      yy = yb - w2 - 2
      Goto 1624
1630
      Gosub 352
      Print "nothing";
      Return
1633
      Gosub 343
      k = kf - 1
      If nt%(kr,k) < > 3 Or(40 * Rnd(0)) > 18 + ch(2) Then
          Gosub 1630
          Goto 1771
1636
      Gosub 352
      Print "a secret door!";
      ij = - 1
      lr = kr
      nt%(kr,k) = 2
      rf%(k) = 1
1639
      On kf Gosub 1621,1612,1627,1618
1642
      Goto 1771
1645
      n = tr%(kr)
      Gosub 343
      Gosub 352
      Rem get
1648
      If n = 0 Or Abs(xl - xr%(kr)) > 3 Or Abs(yl - yr%(kr)) > 3 Then
          Print "you can't";
          Goto 1771
1651
      tr%(kr) = 0
      Print tr$(n);
      tt%(n) = tt%(n) + 1
      wc = wc + t%(n,0)
      Gosub 280
1654
      in = 0
      Gosub 526
      Gosub 445
      i = t%(n,1)
      If i < 101 Goto 1660
1657
      j = i - 100
      rs%(j) = rs%(j) + 1
      cp%(j) = cp%(j) + 1
      Goto 1771
1660
      On i + 1 Goto 1771,1666,1669,1672,1687,1690,1693,1663,1696,1699,1702
1663
      rs%(2) = 1
      Goto 1771
1666
      j = Int(6 * Rnd(0) + .99)
      Gosub 343
      Gosub 352
      Print j;"elixirs";
      hn = hn + j
      Goto 1771
1669
      ps = 4
      sp = sp + 1
      Goto 1771
1672
      Gosub 343
      Gosub 352
      Print "dost use sword";
      Gosub 490
      If l = 0 Goto 1672
1675
      Gosub 343
      If c$ < > "y" Then
          tt%(n) = tt%(n) - 1
          wc = wc - t%(n,0)
          Goto 1771
1678
      pb = pb + sm
      sm = Int(4 * Rnd(0)) + Int(4 * Rnd(0)) - 2
      i =((lv - 1) And 3) + 1
      If lv > 8 Then
          i = i + 1
1681
      If sm > 0 Then
          sm = sm - Int(2 - Int(i / 2))
          If sm > 1 Then
              Gosub 352
              Print "then sword glows";
1684
      pb = pb - sm
      wm = Int(as *(7 + sm) + .5)
      Goto 1771
1687
      j = Int(20 * Rnd(0) + 1)
      Gosub 298
      rs = rs + j
      Gosub 328
      Goto 1771
1690
      j = Int(10 * Rnd(0) + 1)
      Gosub 298
      rm = rm + j
      Gosub 334
      Goto 1771
1693
      rs%(1) = rs%(1) + 1
      pa = pa + 1
      Goto 1771
1696
      rs%(3) = 1
      Goto 1771
1699
      rs%(4) = 1
      Goto 1771
1702
      pw = 75
      Goto 1771
1705
      Gosub 343
      Gosub 352
      Print "drop some";
1708
      Gosub 322
      jj = 10 * j
      Gosub 322
      jj = jj + j
      If jj > 20 Then
          Gosub 343
          Goto 1771
1711
      If tt%(jj) < 1 Then
          Gosub 343
          Goto 1771
1714
      tt%(jj) = tt%(jj) - 1
      wc = wc - t%(jj,0)
      Gosub 343
      Gosub 280
1717
      If t%(jj,1) > 0 Goto 1771
1720
      If tr%(kr) = 0 Then
          tr%(kr) = jj
          xr%(kr) = xl
          yr%(kr) = yl
          Gosub 526
1723
      Goto 1771
1726
      If 100 * Rnd(0) > .3 *(ch(1) + ch(3)) * m%(mq,7) Goto 1771
1729
      in = 1
      Gosub 343
      Gosub 352
      Print "pass by";
      Goto 1771
1732
      If hs < = 0 Goto 1747
1735
      hs = hs - 1
      j = 0
1738
      pc = pc + 1 + j
      If pc > ch(5) Then
          pc = ch(5)
1741
      Gosub 316
      Goto 1771
1744
      If hn > 0 Then
          hn = hn - 1
          j = Int(Rnd(0) * 6) + 2
          Goto 1738
1747
      Gosub 343
      Gosub 352
      Print "none left";
      Goto 1381
1750
      Gosub 343
      Gosub 352
      i = mt%(no%(kr,kf - 1))
      If i = 0 Or mn%(no%(kr,kf - 1)) = 0 Goto 1759
1753
      If 1000 * Rnd(0) > ch(2) ^ 2 + rs%(2) * 700 Goto 1759
1756
      Print m$(i);
      Goto 1771
1759
      Print "nothing";
      Goto 1771
1762
      If tp%(kr) > 0 And 1 + 20 * Rnd(0) < ch(2) Then
          Gosub 520
          Goto 1771
1765
      Gosub 343
      Gosub 352
      Goto 1759
1768
      k = 1
      Gosub 499
1771
      Gosub 508
      If nb > 0 Goto 1780
1774
      Gosub 1252
      If nb = 0 Goto 1381
1777
      Gosub 451
      Goto 1381
1780
      If in > 0 Or hi > 0 Goto 1885
1783
      If Abs(x0 - xm) > 5 Or Abs(y0 - ym) > 5 Goto 1846
1786
      im = m%(mq,1)
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
      Gosub 352
      Print b1$;
      Gosub 352
      Print "it missed!";
      Goto 1789
1798
      Gosub 277
1801
      x = 50
      y = 19
      Gosub 352
      Print b1$;
      Gosub 352
      Gosub 310
      If Int(Rnd(0) * 20 + 1) > sp Goto 1807
1804
      Print "shield hit";
      k = - ps
      Goto 1816
1807
      Print "struck thee";
      k = 0
      If m%(mq,3) < > 2 Goto 1816
1810
      If Int(Rnd(0) * 20) < ch(5) Or rs%(2) > 0 Goto 1816
1813
      Gosub 274
      Gosub 343
      Gosub 352
      Print "a chill...";
1816
      k = k + Int((md *(r - p + 1)) / 10) - aa - am
      If k < 0 Then
          k = 0
1819
      pc = pc - k
      If pc < 1 Then
          For i = 1 To 1000
          Next i
          Goto 1954
1822
      Gosub 316
      If nb > 0 Goto 1789
1825
      Goto 1381
1828
      If nb = 0 Goto 1381
1831
      Gosub 463
      m = 2
      On Int(4 * Rnd(0) + 1) Goto 1834,1837,1840,1843
1834
      xm = xm + m
      Goto 1882
1837
      xm = xm - m
      Goto 1882
1840
      ym = ym + m
      Goto 1882
1843
      ym = ym - m
      Goto 1882
1846
      Gosub 463
      Gosub 523
      xx = xl - xm
      yy = yl - ym
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
      ym = ym + m
      If ym > yl - 3 Then
          ym = yl - 3
1864
      Goto 1882
1867
      xm = xm + m
      If xm > xl - 3 Then
          xm = xl - 3
1870
      Goto 1882
1873
      ym = ym - m
      If ym < yl + 3 Then
          ym = yl + 3
1876
      Goto 1882
1879
      xm = xm - m
      If xm < xl + 3 Then
          xm = xl + 3
1882
      Gosub 283
      Gosub 451
1885
      If mp > 0 Or nb = 0 Goto 1900
1888
      Gosub 478
      Gosub 463
      ex = ex + 20 * ml * ml + 15
      kc = kc + 1
      Gosub 307
      Gosub 445
1891
      Gosub 343
      Gosub 352
      Print "monster slain!";
      m = mn%(kr)
      If m > 0 Then
          mn%(kr) = m - 1
1894
      If m > 1 Then
          Gosub 1225
          Gosub 343
          Gosub 352
          Print "and another";
          Gosub 451
          Goto 1900
1897
      nb = 0
      x = 50
      y = 13
      Gosub 352
      Print b2$;
      y = 14
      Gosub 352
      Print b1$;
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
      If ex > 1999 Then
          l = Int(Log(ex / 1000) / Log(2) + 1)
1909
      hb = 1
      Gosub 889
      Gosub 784
1912
      Goto 1927
1915
      Print "{Clr}treasures for "nm$
      Print "{Down}treasure" Tab(10);"#" Tab(20);"treasure" Tab(30);"value"
1918
      For i = 1 To 20
          j = t%(i,6) * tt%(i)
          If j > 0 Then
              Print tr$(i); Tab(20);tt%(i); Tab(30);j
1921
          mo = mo + j
          wc = wc - tt%(i) * t%(i,0)
          tt%(i) = 0
      Next
1924
      Input "art thou ready for more";a$
      Return
1927
      For i = 1 To 20
          tt%(i) = 0
      Next i
      Return
1930
      Print "{Clr}thou leavest the dunjon"
1933
      Print "{Down}experience:"ex
      Print "{Down}dost thou wish to re-enter the pit"
1936
      For i = 1 To 10
          Get a$
      Next i
1939
      Gosub 490
      If l = 0 Goto 1939
1942
      For i = 1 To 60
          rt%(i) = 0
      Next i
1945
      For i = 1 To 10
          Get a$
      Next i
1948
      If c$ < > "y" Goto 607
1951
      wc = wa
      kr = 1
      pc = ch(5)
      xa = xp
      ya = yp
      kf = kp
      ta = 100
      Gosub 346
      Goto 1375
1954
      Print Chr$(14)"{Clr}{Down}{Down}{Down}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}{Right}Thou art slain!{Down}"
      For i = 1 To 2500
      Next i
1957
      For i = 1 To 60
          rt%(i) = 0
      Next i
1960
      i = Int(Sqr(Rnd(0) * 16 + 1) + .7)
      On i Goto 1963,1972,1975,1969
1963
      Print "Thou art eaten"
      ef% = 0
      For i = 1 To 1500
      Next i
1966
      For i = 1 To 60
          rt%(i) = 0
      Next i
      Goto 607
1969
      Print "Benedic the Cleric found thee"
      Goto 1933
1972
      Print "Lowenthal the Mage found thee"
      For i = 1 To 10
          rs%(i) = 0
      Next i
      Goto 1933
1975
      Print "Olias the Dwarf found thee"
      For i = 1 To 20
          tt%(i) = 0
      Next i
1978
      For i = 1 To 10
          rs%(i) = 0
      Next i
      sm = 0
      am = 0
      hs = 0
      hn = 0
      rm = 0
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
