var userOne : int := 100
var userTwo : int := 100 
var diceNumOne : int 
var diceNumTwo : int 
var diceRollNumber : int 
var stream : int 
open : stream, "diceRoll.txt",put 
loop
    locate(1,1)
    get diceRollNumber 
    if diceRollNumber > 15 and diceRollNumber < 1 then 
    
    elsif diceRollNumber >= 1 and diceRollNumber <= 15 then 
	exit 
    end if 
end loop 

for i: 1 .. diceRollNumber 
    locate(i+1,1)
    randint(diceNumOne,1,6)
    put diceNumOne
    locate(i+1,3)
    randint(diceNumTwo,1,6)
    put diceNumTwo
    if diceNumOne > diceNumTwo then 
	userTwo := userTwo - diceNumOne
    elsif diceNumOne < diceNumTwo then 
	userOne := userOne - diceNumTwo 
    else 
    
    end if 
end for 
put : stream, userOne 
put : stream, userTwo 

close : stream

