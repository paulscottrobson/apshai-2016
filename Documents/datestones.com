10:**$Datestones of Ryn
16:Setup pointers to game data elements
50.ReduceConstitution:*Reduce constitution by one.
55.PutMonsterInRoom:*Fit monster into current room.
60:NotUsed
65:HitEffect:*Use the TRS80 display mode to generate a hit effect
72.UpdateArrows:*Update Arrow Display
74.UpdateMagicArrows:*Update Magic Arrow Display
80.ResetRoomRepaint:*Reset room repaint flags
82.SecretDoor:*Undo secret doors:Set door status back to 3 for any found secret doors
85:If the one behind us is found keep it open.
88.UpdateWounds:*Update Wounds Display
100.DrawVerticalWall:*Draw vertical wall
120.EraseVerticalWall:*Erase vertical wall
140.DrawHorizontalWall:*Draw Horizontal Wall
150.EraseHorizontalWall:*Erase Horizontal Wall
200.DrawPlayer:*Draw the Player
250.ErasePlayer:*Erase the Player
300.DrawMonster:*Draw a monster
345.EraseMonsterIfAny:*Erase monster if exists
350.EraseMonster:*Erase a monster
400.SetPixel:*Set a Pixel
410.ErasePixel:*Erase a Pixel
450.ExplosionEffect:*Star Explosion Effect
500.GetTimedKey:*Get a keystroke with time-out
600.DrawEraseSword:*Animate sword attack
650.UpdateFatigueForAction:*Update the fatigue value based on action "m"
670.TrapAnimation:*Do Sprung Trap Animation
679.DrawTreasure:*Update Treasure for this room
680.UpdateTreasure:*Update Treasure display
695.TrapCheck:*Check if trap fires
800.LoadCurrentRoomInfo:*Load Current Room Data
840.LoadLastRoomInfo:*Load Last Room Info
880.GetMonsterName:*Get Name of Current Monster
900.TitleScreen:*Draw Title Screen
1600.LoadData:*Load the Data in
1950.UnpackString:*Unpack a string.
1955:For each data element, get the offset as its ASCII
2250.Repaint10Rooms:*Force repaint of rooms 51-60 ?
2400.ResetPlayerStats:*Reset the Player Statistics
2500.DisplayStatus:*Display the Player status
3000.DrawRoom:*Draw a single room
4000.RedrawDisplay:*Redraw the whole display:If already drawn, skip this, else clear screen and clear all repaint flags.
4002:Figure where on the screen it should start, make sure it all fits on the screen.
4004:Work out player position in room, create monster if required.
4005:Update the status display
4010:Draw any active monster
4020:Some sort of side-forbid flag set to never apply. If new room was on screen (ib = 3) then we don't need to do adjacent ones.
4050:Draw the current room, player and treasure.
4030:Draw all adjacent rooms, if there are any
4500.CreateMonsterInRoom:*Create the monster in the room.
4800.MayCreateRandomMonster:*Create a random monster (perhaps)
4830.CreateMonster:*Create Monster i
4850.CheckRandomMonsterAppear:* Random monster creation on turn when no monster only.
5000.StartGame:*Start the actual game
5030.NewRoom:*New Room if come here
5044.MainLoop:*$Main Game Loop
5100.MovePlayer:*Player Move code
5110:n is trap if any,ib is left area flag, m is move distance
5120.MoveUp.:Move Player up
5164.Move Down:Move Player down
5210.MoveRight:Move Player right
5250.MoveLeft:Move Player left
5281.ExecMovement:*Do Player Movement:Checks to see if door open (1) and if not skip
5282.ChangeRoom:*Left a room:If in door space then change room
5284:If didn't change room (i.e. walked into a wall not door), move there.
5285:If the whole of the room is on the screen ?
5286:We are in a new room redraw situation
5290.AnimatePlayerMove:*Move the player graphic
5300.R-Command:*Turn Left
5350.L-Command:*Turn Right
5370.V-Command:*Turn around
5390.ATPFM-Commands:* Attack, Thrust, Parry, Fire, Magic Arrow
5400.SwordAttack:* Attack Thrust Parry comes here
5427.DamageMonster:*Do Damage to Monster
5437.DamageMonster:* Do actual monster damage
5440:Damage only if non-magic, or magic sword, or magic arrow
5490.FireMagicArrow:* Fire Magic Arrow
5500.FireArrow:* Fire Arrow
5505.ArrowCode:*General Arrow code
5510:Arrow up
5515:Arrow down
5520:Animate vertical arrow
5550:Arrow right
5555:Arrow left
5560:Animate horizontal arrow
5580:Complete Arrow.Check if hit, if so damage monster
5620.OpenRightDoor:Open the right door
5640.OpenLeftDoor:Open the left door
5660.OpenUpDoor:Open the up door
5680.OpenDownDoor:Open the down door
5700.E-Command:*Examine Secret Door
5800.G-Command:*Grab Treasure
5900.!-Command:*Speak to Monster
6100:Not used
6110.RecoverWounds:*Recoved Wounds
6140.Y-Command:*Drink a Healing Potion
6300.S-Command:*Search for Traps
6990.EraseSwordThenMonster:Erase player sword then monster turn
7000.MonsterTurn:*$Monster's Turn.
7002:Monster appears, do nothing till next turn.
7010:Check range
7015:*Monster attacks
7020:Check to see if the monster will hit this time, depends on what the player did (in ia)
7030:If damage absorbed by shield, use -shield# as the wound damage
7040:Do actual damage
7060:Loop round for multiple attacks
7250:If still alive, move monster one square in a random direction.
7300:*Monster moves:Work out how to chase the player
7490:Force monster in room space and draw it.
7500:Kill monster if dead, possibly creating another one.
10000.LeaveDungeon:*Exited the dungeon
11000.PlayerDead:*Player has Died
12000.QuestEnd:*Quest Ended
12020:Calculate and print Score
