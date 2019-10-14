import GUI
forward proc animation
forward proc goodBye
forward proc mainMenu
var animationButton, exitButton, backButton: int := 0 
var winID := Window.Open("Graphics:640;400")
proc title
    cls
    locate (1, 36)
    put "Animation"
end title

body proc mainMenu
  title
    exitButton := GUI.CreateButton (200, 100, 0, "Exit", goodBye)
    animationButton  := GUI.CreateButton (200, 150, 0, "Animation", animation)
end mainMenu

body proc animation
    title
    
    for x : 1 .. 390 % Down
	drawfilloval (5, 395 - x, 6, 6, white) % Erase
	drawfilloval (5, 395 - x, 5, 5, green) % Draw
	delay (5)                      % Delay
    end for

    for x : 1 .. 630
	drawfilloval (5 + x, 5, 6, 6, white) % Erase
	drawfilloval (5 + x, 5, 5, 5, green) % Draw
	delay (5)                  % Delay
    end for
    backButton := GUI.CreateButton (200, 50, 0, "Back", mainMenu)
end animation

body proc goodBye
    title
    put "Bye"
    delay(1000)
    Window.Close(winID)
end goodBye
mainMenu
loop
    exit when GUI.ProcessEvent
end loop 


