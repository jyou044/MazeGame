% January 13, 2015
% By: Jason You
% Ms.Krasteva
% The JasonYou16 Program
% This is a game program. This game is called the Mouse Maze and it tests the user's
% concentration. The user is awarded points based on how quickly he/she finished the maze.
% When the user finishes one level, he/she will have to choice to continue onto the next level
% or to go back to the main menu.
% Import GUI
import GUI
%======================================================================================
%   forward procs
%======================================================================================
forward proc mainMenu
forward proc playGame01
forward proc playGame02
forward proc playGame03
forward proc help
forward proc goodBye
forward proc levels

%======================================================================================
%   Declaration Section
%======================================================================================
var menuButton, helpButton, backButton, playButton, exitButton, continueButton, proceedButton,
    proceedButton01, level01Button, level02Button, level03Button, playToMenuButton : int := 0
% The menuButton variable is responsible for holding the button that allows the user to go to the main menu.
% The helpButton variable is responsible for holding the button that allows the user to go to the instructions/help window.
% The backButton variable is responsible for holding the button that allows the user to go from the instructions/help window back to the
% main menu.
% The playButton is responsible for holding the button that allows the user to go from the main menu to the first level
% of the game.
% The exitButton variable is responsible for holding the button that allows the user to exit the game.
% The continueButton variable is responsible for containing the button that
% allows the user to go from the end game message back to the main menu if he/she hits the wall in the game.
% The proceedButton is responsible for holding the button that allows the user to go from level one to the
% next when he/she has successfully completed one level.
% The proceedButton01 variable is responsible for holding the button that
% allows the user to go from level two to level three if he/she successfully
% completes level two
% The level01Button variable holds the button that allows the user to go to level 1.
% The level02Button variable holds the button that allows the user to go to level 2.
% The level03Button variable holds the button that allows the user to go to level 3.
% The playToMenuButton variable holds the button that allows the user to go from
%the levels screen back to the main menu.
var x, y, speed : int
% The x variable holds the initial x position of the mouse
% The y variable holds the initial y position of the mouse
% The speed variable holds the speed at which the mouse moves
var levelstartTime : int % This variable is responsible for holding the start time of the game.
% Open the window
var winID : int

var levelFinder : int := 0 % This variable is responsible for holding the variable that
% determines the level that the user is at.
var chars : array char of boolean % This variable is responsible for allowing
%the user to successfully use the arrow keys.
var animationOnOffSwitch : int := 0 % This variable controls the displaying of the animation in the
% game.
var sansSerif := Font.New ("sans serif:18:bold") % This variable holds the letter type sans serif, 18 font.
var serif := Font.New ("serif:10") % This variable holds the letter type serif.
var winFont := Font.New ("Palatino:20:bold") % This variable holds the letter type Palatino.
var loseFont := Font.New ("Times New Roman:14:bold") % This variable holds the letter type  Times New Roman, 14 font, bold.
var byeFont := Font.New ("Times New Roman:13") % This variable holds the letter type Goudy Stout, 15 font, bold
var levelfinishTime : int % This variable is responsible for calculating the amount of time it took the user to finish the maze.
var gameResult : int := 0 % 0 : onGame, 1 : success, 2 : fail
% This variable is responsible for determining whether to user won, lost, or is going to play a level.
var elapsedTime : int := 0 % This variable is responsible for determining how much time has passed in
% each level.
var pictureArrow : int % This variable is responsible for holding the arrow keys picture.
var pictureCheese : int % This variable is responsible for holding the cheese picture.
var pictureMouse : int % This variable is responsible for holding the mouse picture.
var pictureMousetrap : int % This variable is responsible for holding the cheese picture.
var pictureVictory : int % This variable is responsible for holding the victory picture.
var pictureGoodbye : int % This variable is responsible for holding the good bye picture.
%======================================================================================

% Set window
%======================================================================================
winID := Window.Open ("position:300;300,graphics:640;480")
%======================================================================================

%======================================================================================
%   Procedure : title
%
%   Description :
%       This procedure is  responsible for displaying the title of the program.
%
%   Input Argument :
%       None
%
%======================================================================================
proc title
    cls
    Font.Draw ("Mouse Maze", 255, 460, sansSerif, brightred)
    Font.Draw ("Copyright. Game Designed and Produced by Jason You.", 170, 440, serif, black)
end title

%======================================================================================
%   Procedure : initPosition
%
%   Description :
%       This procedure is  responsible for holding the initial position of the ball.
%       Also, it holds the restrictions for the ball.
%
%   Input Argument :
%       posX - This is the input position x for the center of the mouse (grey ball).
%       posY - This is the input position y for the center of the mouse (grey ball).
%       mSpeed - This is the speed of the mouse for each level.
%
%======================================================================================
proc initPosition (posX : int, posY : int, mSpeed : int)
    x := posX
    y := posY
    speed := mSpeed
end initPosition

%======================================================================================
%   Procedure : printString
%
%   Description :
%       This Procedureoutputs a string value in the located position on the screen.
%
%   Input Argument :
%       posRow - This is the row position of the text.
%       posColumn - This is the column position of the text.
%       str - This is the input string that will be received and printed.
%
%======================================================================================
proc printString (posRow : int, posColumn : int, str : string)
    locate (posRow, posColumn)
    put str
end printString

%======================================================================================
%   Procedure : displayTimer
%
%   Description :
%       This procedure is  responsible for displaying the timer in each level.
%
%   Input Argument :
%       posX - This is the initial position x of the bottom left corner of the timer text.
%       posY - This is the initial position y of the bottom left corner of the tiimer text.
%       num - This is the number that will be displayed on the timer.
%
%======================================================================================
proc displayTimer (posX : int, posY : int, num : int)
    var digitOnes, digitTens : int

    digitOnes := num mod 10                         % Ones digit of timer.
    digitTens := ((num - digitOnes) mod 100) div 10 % Tens digit of timer.

    for i : 0 .. 50
	drawbox (posX + i, posY, posX + 55 - i, posY + 40, white) % This helps to erase the marks left by the timer.
    end for

    Font.Draw ("Timer", 295, 400, sansSerif, black)

    case (digitTens) of
	label 0 :
	    Font.Draw ("0", posX + 20, posY, winFont, black)          % Displays the ones digit of the timer.
	label 1 :
	    Font.Draw ("1", posX + 20, posY, winFont, black)
	label 2 :
	    Font.Draw ("2", posX + 20, posY, winFont, black)
	label 3 :
	    Font.Draw ("3", posX + 20, posY, winFont, black)
	label 4 :
	    Font.Draw ("4", posX + 20, posY, winFont, black)
	label 5 :
	    Font.Draw ("5", posX + 20, posY, winFont, black)
	label 6 :
	    Font.Draw ("6", posX + 20, posY, winFont, black)
	label 7 :
	    Font.Draw ("7", posX + 20, posY, winFont, black)
	label 8 :
	    Font.Draw ("8", posX + 20, posY, winFont, black)
	label 9 :
	    Font.Draw ("9", posX + 20, posY, winFont, black)
    end case

    case (digitOnes) of
	label 0 :
	    Font.Draw ("0", posX + 40, posY, winFont, black)          % Displays the tens digit of the timer.
	label 1 :
	    Font.Draw ("1", posX + 40, posY, winFont, black)
	label 2 :
	    Font.Draw ("2", posX + 40, posY, winFont, black)
	label 3 :
	    Font.Draw ("3", posX + 40, posY, winFont, black)
	label 4 :
	    Font.Draw ("4", posX + 40, posY, winFont, black)
	label 5 :
	    Font.Draw ("5", posX + 40, posY, winFont, black)
	label 6 :
	    Font.Draw ("6", posX + 40, posY, winFont, black)
	label 7 :
	    Font.Draw ("7", posX + 40, posY, winFont, black)
	label 8 :
	    Font.Draw ("8", posX + 40, posY, winFont, black)
	label 9 :
	    Font.Draw ("9", posX + 40, posY, winFont, black)
    end case
end displayTimer

%======================================================================================
%   Procedure : displayScore
%
%   Description :
%       This procedure is  responsible for displaying the score for each level
%       based on the amount of time that had been elapsed.
%
%   Input Argument
%       posRow - This is responsible for locating the row position of the level score.
%       posColumn - This is responsible for locating the column position of the level score.
%
%======================================================================================
proc displayScore (posRow : int, posColumn : int, gameLevel : int, num : int)
    var score : int
    locate (posRow, posColumn)
    if (gameLevel = 1) then    % Level 1 score
	if num < 5 then
	    score := 100
	else
	    score := 100 - (10 * (num - 5))
	end if    
    elsif (gameLevel = 2) then % Level 2 score
	if num < 10 then
	    score := 100
	else
	    score := 100 - (10 * (num - 10))
	end if   
    elsif (gameLevel = 3) then % Level 3 score
	if num < 40 then
	    score := 100
	else
	    score := 100 - (5 * (num - 40))
	end if    
    end if

    if score <= 0 then
	score := 0
    end if
    locate (posRow, posColumn)
    put "You took ", num, " seconds to finish. Your score is: ", score % Displays how long it took the user to finish along with the score.

    if score >= 80 and score <= 100 then
	put "Your score is excellent."            % Decision 1 (User was very good.)
    elsif score >= 50 and score <= 79 then
	put "Your score is good."                 % Decision 2 (User was good.)
    elsif score >= 1 and score <= 49 then
	put "You could have done a bit better."   % Decision 3 (User could have done better.)
    end if
end displayScore

%======================================================================================
%   Procedure : stopMusic
%
%   Description :
%       This procedure is  responsible for stopping music when called.
%
%   Input Argument :
%       None
%
%======================================================================================
proc stopMusic
    Music.PlayFileStop
end stopMusic

%======================================================================================
%   Procedure : playMusic
%
%   Description :
%       This procedure is  responsible for playing music when called.
%
%   Input Argument :
%       songName - This is responsible for holding the song name that will be played
%       at a specific part of the game.
%
%======================================================================================
proc playMusic (songName : string)
    stopMusic
    Music.PlayFileLoop (songName)
end playMusic

%======================================================================================
%   Procedure : loadScreen
%
%   Description :
%       This procedure is responsible the load screen after a level button has been pressed
%
%   Input Argument :
%       None.
%======================================================================================
proc loadScreen
    title
    for x : 0 .. 480
	drawline (0, 0 + x, 640, 0 + x, grey)
    end for

    Font.Draw ("Loading", 255, 260, sansSerif, black)
    for x : 0 .. 5
	delay (50)
	drawoval (370, 260, 5 - x, 5, black)     % Left black circle.
	delay (50)
	drawoval (390, 260, 5 - x, 5, black)     % Center black circle.
	delay (50)
	drawoval (410, 260, 5 - x, 5, black)     % Right black circle.
    end for
end loadScreen

%======================================================================================
%   Procedure : buttonsCreation
%
%   Description :
%       This procedure is  responsible for storing all the buttonsCreation that will be used in the program.
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
proc buttonsCreation
    level01Button := GUI.CreateButton (190, 350, 70, "Level 1", playGame01)
    GUI.SetColor (level01Button, brightred)
    GUI.Hide (level01Button)
    level02Button := GUI.CreateButton (290, 350, 70, "Level 2", playGame02)
    GUI.SetColor (level02Button, brightblue)
    GUI.Hide (level02Button)
    level03Button := GUI.CreateButton (390, 350, 70, "Level 3", playGame03)
    GUI.SetColor (level03Button, brightgreen)
    GUI.Hide (level03Button)
    menuButton := GUI.CreateButton (300, 295, 70, "Menu", mainMenu)
    GUI.SetColor (menuButton, purple)
    GUI.Hide (menuButton)
    playButton := GUI.CreateButton (250, 300, 70, "Play", levels)
    GUI.SetColor (playButton, brightred)
    GUI.Hide (playButton)
    helpButton := GUI.CreateButton (300, 350, 70, "Help", help)
    GUI.SetColor (helpButton, yellow)
    GUI.Hide (helpButton)
    exitButton := GUI.CreateButton (350, 400, 70, "Exit", goodBye)
    GUI.SetColor (exitButton, green)
    GUI.Hide (exitButton)
    backButton := GUI.CreateButton (300, 20, 0, "Back", mainMenu)
    GUI.SetColor (backButton, brightblue)
    GUI.Hide (backButton)
    proceedButton := GUI.CreateButtonFull (295, 100, 0, "Proceed", playGame02, 0, 'p', false)
    GUI.SetColor (proceedButton, white)
    GUI.Hide (proceedButton)
    continueButton := GUI.CreateButtonFull (287, 300, 0, "Main Menu", mainMenu, 0, 'm', false)
    GUI.SetColor (continueButton, brightblue)
    GUI.Hide (continueButton)
    proceedButton01 := GUI.CreateButtonFull (295, 100, 0, "Proceed", playGame03, 0, 'p', false)
    GUI.SetColor (proceedButton01, white)
    GUI.Hide (proceedButton01)
    playToMenuButton := GUI.CreateButton (300, 20, 0, "Back", mainMenu)
    GUI.SetColor (playToMenuButton, brightblue)
    GUI.Hide (playToMenuButton)
end buttonsCreation

%======================================================================================
%   Procedure : buttonsHide
%
%   Description :
%       This Procedurehides all the button in the program when called.
%
%   Input Argument :
%       None
%
%======================================================================================
proc buttonsHide
    GUI.Hide (level01Button)
    GUI.Hide (level02Button)
    GUI.Hide (level03Button)
    GUI.Hide (menuButton)
    GUI.Hide (playButton)
    GUI.Hide (helpButton)
    GUI.Hide (exitButton)
    GUI.Hide (backButton)
    GUI.Hide (proceedButton01)
    GUI.Hide (continueButton)
    GUI.Hide (proceedButton)
    GUI.Hide (playToMenuButton)
end buttonsHide

%======================================================================================
%   Procedure : winnerFont
%
%   Description :
%       This procedure is  responsible for displaying the window that tells the user that
%       he/she has won.
%
%   Input Argument :
%       None
%
%======================================================================================
proc winnerFont
    for i : 0 .. 400
	drawline (0, 0 + i, 640, 0 + i, yellow)
    end for
    Font.Draw ("Congratulations! You have won!", 125, 215, winFont, black)
    pictureVictory := Pic.FileNew ("victory.jpg")
    Pic.Draw (pictureVictory, 250, -220, picMerge)
end winnerFont

%======================================================================================
%   Procedure : loserFont
%
%   Description :
%       This procedure is  responsible for displaying the window that tells the user
%       that he/she has lost the game.
%
%   Input Argument :
%       None
%
%======================================================================================
proc loserFont
    for i : 0 .. 480
	drawline (0, 0 + i, 640, 0 + i, brightred)
    end for
    Font.Draw ("Sorry! You have failed to complete the level.", 130, 250, loseFont, black)
    pictureMousetrap := Pic.FileNew ("mousetrap.jpg")
    Pic.Draw (pictureMousetrap, 455, -480, picMerge)
end loserFont

%======================================================================================
%   Procedure : gameAnimation
%
%   Description :
%       This procedure is  responsible for displaying the animation portion of the game
%       when required to.
%
%   Input Arguments :
%       None
%
%======================================================================================
proc gameAnimation
    var direction : int % Define direction variable to define direction

    direction := 0      % Initialize forward movement direction

    loop
	if animationOnOffSwitch = 0 then   % Animation disabled (exits loop)
	    exit when GUI.ProcessEvent
	else
	    for i : 0 .. 100
		if animationOnOffSwitch = 0 then % Animation disabled (doesn't execute)

		else
		    if direction = 0 then % Forward movement
			drawfillbox (49 + i, 78, 460 + i, 250, white) % Erase
			drawfilloval (300 + i, 150, 150, 50, grey)  % body
			drawfilloval (150 + i, 150, 50, 3, grey)    % tail
			drawoval (350 + i, 200, 21, 21, black)      % top ear
			drawfilloval (350 + i, 200, 20, 20, grey)   % top ear inside
			drawoval (350 + i, 100, 21, 21, black)      % bottom ear
			drawfilloval (350 + i, 100, 20, 20, grey)   % bottom ear inside
			drawfilloval (450 + i, 150, 5, 5, black)    % nose
			if i mod 10 = 0 then
			    drawfilloval (410 + i, 130, 10, 10, black) % bottom eye
			    drawfilloval (410 + i, 170, 10, 10, black) % top eye
			else
			    drawfilloval (410 + i, 130, 10, 10, black) % bottom eye
			    drawfilloval (410 + i, 170, 10, 10, black) % top eye
			end if
			drawline (410 + i, 180, 410 + i, 210, black) % top left whisker
			drawline (420 + i, 180, 420 + i, 210, black) % top middle whisker
			drawline (430 + i, 170, 430 + i, 210, black) % top right whisker
			drawline (410 + i, 125, 410 + i, 100, black) % bottom left whisker
			drawline (420 + i, 125, 420 + i, 100, black) % bottom middle whisker
			drawline (430 + i, 130, 430 + i, 100, black) % bottom right whisker
			if (i = 100) then
			    direction := 1
			end if
		    else                  % Backward Movement
			drawfillbox (149 - i, 78, 560 - i, 250, white)                  % Erase
			drawfilloval (400 - i, 150, 150, 50, grey)  % body
			drawfilloval (250 - i, 150, 50, 3, grey)    % tail
			drawoval (450 - i, 200, 21, 21, black)      % top ear
			drawfilloval (450 - i, 200, 20, 20, grey)   % top ear inside
			drawoval (450 - i, 100, 21, 21, black)      % bottom ear
			drawfilloval (450 - i, 100, 20, 20, grey)   % bottom ear inside
			drawfilloval (550 - i, 150, 5, 5, black)    % nose
			if i mod 10 = 0 then
			    drawfilloval (510 - i, 130, 10, 10, black) % bottom eye
			    drawfilloval (510 - i, 170, 10, 10, black) % top eye
			else
			    drawfilloval (510 - i, 130, 10, 10, black) % bottom eye
			    drawfilloval (510 - i, 170, 10, 10, black) % top eye
			end if
			drawline (510 - i, 180, 510 - i, 210, black) % top left whisker
			drawline (520 - i, 180, 520 - i, 210, black) % top middle whisker
			drawline (530 - i, 170, 530 - i, 210, black) % top right whisker
			drawline (510 - i, 125, 510 - i, 100, black) % bottom left whisker
			drawline (520 - i, 125, 520 - i, 100, black) % bottom middle whisker
			drawline (530 - i, 130, 530 - i, 100, black) % bottom right whisker
			if (i = 100) then
			    direction := 0
			end if
		    end if
		    delay (40)
		    exit when GUI.ProcessEvent % Exits when the button is pressed.
		end if
	    end for
	end if
    end loop
end gameAnimation

%======================================================================================
%   Procedure : byeMessage
%
%   Description :
%       This procedure is  responsible for displaying the good bye message at the end
%       of the program.
%
%   Input Arugment :
%       None
%
%======================================================================================
proc byeMessage
    Font.Draw ("Thanks for playing! This program was written by Jason You (9M).", 100, 300, byeFont, black)
end byeMessage

%======================================================================================
%   Procedure : decorationmainmenuIntro
%
%   Description :
%       This procedure is  responsible for displaying the decoration for both the main
%       menu and the introduction.
%
%   Input Argument :
%       None
%
%======================================================================================
proc decorationmainmenuIntro
    for i : 0 .. 50
	drawoval (0, 0, 50 - i, 50, yellow) % Yellow circle on the bottom left corner.
	drawoval (640, 0, 50 - i, 50, yellow) % Yellow circle on the bottom right corner.
	drawoval (0, 480, 50 - i, 50, yellow) % Yellow circle on the top left corner.
	drawoval (640, 480, 50 - i, 50, yellow) % Yellow circle on the top right corner.
    end for
end decorationmainmenuIntro

%======================================================================================
%   Procedure : decorationHelp
%
%   Description :
%       This procedure is  responsible for displaying the decoration that will be in the
%       help window.
%
%   Input Argument :
%       None
%
%======================================================================================
proc decorationHelp
    for i : 0 .. 50
	if (i <= 15) then
	    drawline (5, 5 + i, 95, 5 + i, black)
	    drawline (545, 5 + i, 635, 5 + i, black)
	end if
	drawoval (50, 0, 50 - i, 50, black) % The bottom left black semi-circle.
	drawoval (590, 0, 50 - i, 50, black) % The bottom right black semi-circle.
    end for
end decorationHelp

%======================================================================================
%   Procedure : introduction
%
%   Description :
%       This procedure is  responsible for displaying the introduction of the game.
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
proc introduction
    title
    playMusic ("gameMusic.mp3")
    buttonsCreation
    decorationmainmenuIntro
    GUI.Show (menuButton)
    printString (5, 20, "This game will test your concentration.")
    printString (6, 7, "Your goal is to make it through a maze without touching the walls.")
    printString (7, 13, "There are three levels, each increasing in difficulty.")
    printString (8, 20, "Will you be able to survive all the levels?")
    animationOnOffSwitch := 1          % Animation activated.
    gameAnimation
end introduction

%======================================================================================
%   Procedure : mainMenu
%
%   Description :
%       This procedure is  responsible for displaying the main menu of the program.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc mainMenu
    title
    pictureCheese := Pic.FileNew ("cheese.jpg") % Cheese
    Pic.Draw (pictureCheese, 480, -125, picMerge)
    pictureMouse := Pic.FileNew ("mouse.jpg") % Mouse
    Pic.Draw (pictureMouse, 0, -80, picMerge)
    decorationmainmenuIntro
    animationOnOffSwitch := 1          % Animation activated.
    buttonsHide
    GUI.Show (playButton)
    GUI.Show (helpButton)
    GUI.Show (exitButton)
    gameAnimation
end mainMenu

%======================================================================================
%   Procedure : levels
%
%   Description :
%       This procedure is  responsible for showing the buttonsCreation that will lead the user to levels
%       one, two or three.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc levels
    title
    decorationmainmenuIntro
    GUI.Show (level01Button)
    GUI.Show (level02Button)
    GUI.Show (level03Button)
    GUI.Show (playToMenuButton)
end levels

%======================================================================================
%   Procedure: help
%
%   Description :
%      This procedure is  responsible for showing the instructions on how to play the game.
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc help
    title
    animationOnOffSwitch := 0                       % Animation turned off.
    decorationHelp
    buttonsHide
    printString (5, 12, "The Mouse Maze game is a game of speed and concentration.")
    printString (6, 2, "You have to get from the start of the maze to the cheese as fast as you can.")
    printString (7, 12, "Points will be allocated based on how fast you finished.")
    printString (8, 14, "There are three levels, and each gets more difficult.")
    printString (9, 14, "You will be awarded points at the end of each level.")
    printString (10, 12, "You cannot touch the walls, or you will lose.  Good luck.")
    printString (11, 16, "***P.S. There are time limits for each level.***")
    printString (12, 1, "At the end of a level, you can press 'p' to go to the next level, or 'm' to exit")
    pictureArrow := Pic.FileNew ("Arrows.jpg") % loads pic in RAM once!
    Pic.Draw (pictureArrow, 120, -350, picMerge)
    for i : 0 .. 20
	if (i <= 10) then
	    drawoval (30, 140, 5 - i, 5, grey)      % Mouse
	end if
	drawline (40, 162, 20, 162 + i, yellow)     % Cheese
    end for
    Font.Draw ("CONTROLS", 250, 260, sansSerif, black) % Controls title
    Font.Draw ("ARROW UP (MOVES MOUSE UP)", 260, 160, serif, brightred) % Arrow up
    Font.Draw ("ARROW RIGHT (MOVES MOUSE RIGHT)", 400, 100, serif, brightred) % Arrow right
    Font.Draw ("ARROW LEFT (MOVES MOUSE LEFT)", 40, 100, serif, brightred) % Arrow left
    Font.Draw ("ARROW DOWN (MOVES MOUSE DOWN)", 200, 50, serif, brightred) % Arrow down
    Font.Draw ("Game", 15, 220, sansSerif, brightblue) % Game Icon labels ( Cheese and Mouse)
    Font.Draw ("Icons", 15, 200, sansSerif, brightblue)
    Font.Draw ("Cheese", 15, 150, serif, black) % Cheese label
    Font.Draw ("Mouse", 15, 120, serif, black)  % Mouse label
    if GUI.ProcessEvent then
    end if


    GUI.Show (backButton)

end help

%======================================================================================
%   Procedure: level01MazeMap
%
%   Description :
%       This procedure is  responsible for holding the arrow key functions.
%       It detects whether or not the user presses the arrow keys or not. If the user
%       presses the arrow keys, the mouse will move according to the arrow key pressed.
%
%   Input Argument :
%       None
%
%======================================================================================
proc keyProcessing
    Input.KeyDown (chars)

    if chars (KEY_UP_ARROW) then         % Arrow key up
	y += speed
    end if
    if chars (KEY_DOWN_ARROW) then       % Arrow key down
	y -= speed
    end if
    if chars (KEY_LEFT_ARROW) then       % Arrow key left
	x -= speed
    end if
    if chars (KEY_RIGHT_ARROW) then      % Arrow key right
	x += speed
    end if

    if y < 5 then
	y := 5
    end if

    drawfilloval (x, y, 5, 5, grey)     % Mouse
    View.Update
    delay (50)
    drawfilloval (x, y, 5, 5, white)    % Erase
end keyProcessing

%======================================================================================
%   Procedure: level01MazeMap
%
%   Description :
%       This procedure is  responsible for holding
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
proc level01MazeMap
    % Walls of the maze.
    drawline (20, 0, 20, 50, black)               % 01
    drawline (20, 50, 200, 50, black)             % 02
    drawline (40, 0, 40, 30, black)               % 03
    drawline (40, 30, 200, 30, black)             % 04

    for i : 0 .. 100
	if (i <= 50) then
	    drawline (200, 60, 200 + i, 30, yellow) % Bottom Cheese8
	    drawoval (60, 440, 50 - i, 50, yellow) % Top Cheese
	end if
	drawline (0, 200 + i, 640, 200 + i, grey) % Grey Strip
    end for

    Font.Draw ("LEVEL 1", 285, 240, sansSerif, blue) % Level 1
    Font.Draw ("Time Limit: 15 seconds", 10, 300, sansSerif, red) % Time limit
end level01MazeMap

%======================================================================================
%   Procedure: level02MazeMap
%
%   Description :
%       This procedure is  responsible for holding the maze of the second level.
%
%   Input Argument :
%       None
%
%======================================================================================
proc level02MazeMap
    % Walls of the maze.
    drawline (20, 0, 20, 50, black)              % 01
    drawline (20, 50, 200, 50, black)            % 02
    drawline (40, 0, 40, 30, black)              % 03
    drawline (40, 30, 220, 30, black)            % 04
    drawline (220, 30, 220, 80, black)           % 05
    drawline (200, 50, 200, 100, black)          % 06
    drawline (200, 100, 400, 100, black)         % 07
    drawline (220, 80, 380, 80, black)           % 08
    drawline (380, 80, 380, 30, black)           % 09
    drawline (400, 100, 400, 50, black)          % 10
    drawline (400, 50, 550, 50, black)           % 11
    drawline (380, 30, 550, 30, black)           % 12

    for i : 0 .. 100
	if (i <= 50) then
	    drawline (550, 60, 550 + i, 30, yellow) % Bottom Cheese
	    drawoval (560, 440, 50 - i, 50, yellow) % Top Cheese
	end if
	drawline (0, 200 + i, 640, 200 + i, grey) % Grey Strip
    end for

    Font.Draw ("LEVEL 2", 285, 240, sansSerif, blue) % Level 2
    Font.Draw ("Time Limit: 20 seconds", 10, 300, sansSerif, red) % Time limit
end level02MazeMap

%======================================================================================
%   Procedure: level03MazeMap
%
%   Description :
%       This procedure is  responsible for holding the maze of the third level.
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
proc level03MazeMap
    % Walls of the Maze.
    drawline (15, 0, 20, 90, black)             % 1
    drawline (30, 0, 35, 75, black)             % 2
    drawline (35, 75, 90, 75, black)            % 3
    drawline (20, 90, 75, 90, black)            % 4
    drawline (75, 90, 75, 150, black)           % 5
    drawline (90, 75, 90, 150, black)           % 6
    drawline (75, 150, 20, 150, black)          % 7
    drawline (20, 120, 20, 150, black)          % 8
    drawline (5, 120, 20, 120, black)           % 9
    drawline (5, 120, 5, 250, black)            % 10
    drawline (5, 250, 20, 250, black)           % 11
    drawline (20, 250, 20, 165, black)          % 12
    drawline (20, 165, 494, 165, black)         % 13
    drawline (90, 150, 200, 150, black)         % 14
    drawline (200, 50, 200, 150, black)         % 15
    drawline (215, 150, 215, 65, black)         % 16
    drawline (200, 50, 540, 50, black)          % 17
    drawline (215, 65, 540, 65, black)          % 18
    drawline (540, 65, 540, 90, black)          % 19
    drawline (540, 90, 555, 90, black)          % 20
    drawline (555, 90, 555, 30, black)          % 21
    drawline (555, 30, 540, 30, black)          % 22
    drawline (540, 30, 540, 50, black)          % 23
    drawline (215, 150, 506, 150, black)        % 24
    drawline (521, 190, 506, 150, black)        % 25
    drawline (521, 190, 600, 190, black)        % 26
    drawline (509, 205, 494, 165, black)        % 27
    drawline (509, 205, 600, 205, black)        % 28

    for i : 0 .. 80
	if (i <= 35) then
	    drawline (600, 190 + i, 620, 190, yellow)   % Cheese (Big one)
	end if

	if (i <= 50) then
	    drawoval (60, 470, 50 - i, 50, yellow)     % Cheese
	end if

	if (i <= 80) then
	    drawline (0, 260 + i, 640, 260 + i, grey) % Grey strip
	end if
    end for

    Font.Draw ("LEVEL 3", 285, 310, sansSerif, blue) % Level 3
    Font.Draw ("Time Limit: 60 seconds", 10, 350, sansSerif, red) % Time limit
end level03MazeMap

%======================================================================================
%   Procedure: playGame01
%
%   Description :
%       This procedure is  responsible for displaying the first level of the maze.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc playGame01
    loadScreen
    title
    elapsedTime := 0 % elapsedTime reset
    gameResult := 0  % gameResult reset
    initPosition (30, 5, 3)
    animationOnOffSwitch := 0   % Animation turned off.
    levelstartTime := Time.Sec  % Records the start time of the level.
    buttonsHide
    level01MazeMap
    loop
	keyProcessing
	levelfinishTime := Time.Sec
	elapsedTime := levelfinishTime - levelstartTime % Finds out how long it took the user to finish the game.
	displayTimer (290, 350, elapsedTime)            % Displays the timer.
	if ((25 < x) and (x < 35)) and ((0 < y) and (y < 45)) then         % Determines if the user is located within the maze walls.

	elsif ((35 < x) and (x < 195)) and ((35 < y) and (y < 45)) then

	elsif ((x >= 195)) and ((35 < y) and (y < 45)) then                % Determines if the user reaches the cheese.
	    gameResult := 1
	else                 % The variable "gameResult" equals 2 if the user touches a maze wall.
	    gameResult := 2
	end if

	if gameResult = 1 then % Win conditions
	    title
	    winnerFont
	    displayScore (4, 1, 1, elapsedTime)

	    GUI.Show (proceedButton)
	    exit
	elsif gameResult = 2 or elapsedTime >= 15 then % Fail conditions (Hit the wall or time over.)
	    title
	    loserFont
	    exit
	else

	end if
    end loop
    GUI.Show (continueButton)
end playGame01

%======================================================================================
%   Procedure: playGame02
%
%   Description :
%       This procedure is  responsible for displaying the maze of the second level.
%       the maze of the first level.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc playGame02
    loadScreen
    title
    elapsedTime := 0            % Elapsed time reset.
    initPosition (30, 5, 3)
    animationOnOffSwitch := 0   % Animation turned off.
    levelstartTime := Time.Sec  % Records the start time of the level.
    buttonsHide
    level02MazeMap
    gameResult := 0             % gameResult reset.
    loop
	keyProcessing
	levelfinishTime := Time.Sec         % Determines the time when the user finishes the level.
	elapsedTime := levelfinishTime - levelstartTime % Finds out how long it took the user to finish the game.
	displayTimer (290, 350, elapsedTime) % Displays the timer.
	if ((25 < x) and (35 > x)) and ((0 < y) and (y < 45)) then         % Determines if the user is located within the maze walls.

	elsif ((35 < x) and (215 > x)) and ((35 < y) and (45 > y)) then

	elsif ((205 < x) and (215 > x)) and ((35 < y) and (95 > y)) then

	elsif ((215 < x) and (395 > x)) and ((85 < y) and (95 > y)) then

	elsif ((385 < x) and (395 > x)) and ((35 < y) and (85 > y)) then

	elsif ((395 < x) and (545 > x)) and ((35 < y) and (45 > y)) then

	elsif ((x >= 545)) and ((35 < y) and (45 > y)) then                % Determines if the user touches the cheesee or not
	    gameResult := 1
	else                 % The variable "gameResult" equals 2 if the user touches a maze wall.
	    gameResult := 2

	end if

	if gameResult = 1 then  % Win conditions
	    title
	    winnerFont
	    displayScore (4, 1, 2, elapsedTime)
	    GUI.Show (proceedButton01)
	    exit
	elsif gameResult = 2 or elapsedTime >= 20 then % Lose conditions (Hit the wall or time up.)
	    title
	    loserFont
	    exit
	else

	end if
    end loop

    GUI.Show (continueButton)
end playGame02

%======================================================================================
%   Procedure: playGame03
%
%   Description :
%       This procedure is  responsible for displaying the maze of the third level of the
%       game.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc playGame03
    loadScreen
    title
    elapsedTime := 0            % Elapsed time reset.
    initPosition (23, 5, 3)
    animationOnOffSwitch := 0   % Animation turned off.
    levelstartTime := Time.Sec
    buttonsHide
    level03MazeMap
    gameResult := 0             % gameResult reset.
    loop
	keyProcessing
	levelfinishTime := Time.Sec         % Determines the time when the user finished the level.
	elapsedTime := levelfinishTime - levelstartTime  % Finds out how long it took the user to finish the game.
	displayTimer (290, 350, elapsedTime) % Displays the timer of the game
	if ((x > 15) and (x <= 27)) and ((y > 0) and (y <= 80)) then
	    if ((((y + 270) / 18) + 6) < x) and (x < (((y + 450) / 15) - 6)) then % Determines whether or not the user is within the maze walls.

	    else
		gameResult := 2
	    end if
	elsif ((x > 25) and (x < 85)) and ((y > 80) and (y < 85)) then

	elsif ((x > 80) and (x < 85)) and ((y > 80) and (y < 160)) then

	elsif ((x > 10) and (x < 500)) and ((y > 155) and (y < 160)) then

	elsif ((x > 10) and (x < 15)) and ((y > 125) and (y < 245)) then

	elsif ((x >= 518) and (x < 595)) and ((y > 195) and (y < 200)) then

	elsif ((x > 205) and (x < 210)) and ((y > 55) and (y < 160)) then

	elsif ((x > 205) and (x < 545)) and ((y > 55) and (y < 60)) then

	elsif ((x > 540) and (x < 550)) and ((y > 35) and (y < 85)) then

	elsif ((x >= 500) and (x < 518)) and ((y > 155) and (y < 200)) then
	    if (((((y + 1155) / (8 / 3)) + 5) <= x)) and (((((y + 1196) / (8 / 3)) - 5) >= x)) then

	    else
		gameResult := 2
	    end if
	elsif ((x >= 595)) and ((y > 195) and (y < 200)) then         % Win condition
	    gameResult := 1
	else                % The variable "gameResult" equals 2 if the user touches a maze wall.
	    gameResult := 2
	end if

	if gameResult = 1 then        % Win condition
	    title
	    displayScore (4, 1, 3, elapsedTime)
	    winnerFont
	    exit
	elsif gameResult = 2 or elapsedTime >= 60 then % Lose Conditions (Hit the wall or time up.)
	    title
	    loserFont
	    exit
	else

	end if
    end loop
    GUI.Show (continueButton)
end playGame03

%======================================================================================
%   Procedure: goodBye
%
%   Description :
%      This procedure is  responsible for displaying the good bye message
%      when the user presses the exit button.
%
%   Input Argument :
%       None
%
%======================================================================================
body proc goodBye
    animationOnOffSwitch := 0   % Animation turned off.
    title
    playMusic ("goodBye.wav")
    for i : 1 .. 480
	drawline (0, 0 + i, 640, 0 + i, brightgreen)  % Background
    end for
    byeMessage
    pictureGoodbye := Pic.FileNew ("goodbye.jpg")
    Pic.Draw (pictureGoodbye, 200, -340, picMerge)
    delay (2000)
    Window.Close (winID)        % Closes the game after 2 seconds.
end goodBye

% Main program
introduction
% End program
