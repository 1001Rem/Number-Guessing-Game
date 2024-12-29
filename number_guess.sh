#!/bin/bash

#query DB
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate random number 1 - 1000
R_NO=$(( $RANDOM % 1000 ))

#tries count var
TRIES=0

#is new player?
ISNEW=true

#get username input
echo -e "\nEnter your username:"
read NAME

#see if username already exist 
QUERY=$($PSQL "SELECT * FROM users WHERE username ='$NAME'")

#check if username exist
case $QUERY in

'') echo -e "\nWelcome, $NAME! It looks like this is your first time here.";;


*) IFS='|' read -r USERNAME GAMES_PLAYED BEST_GAME <<< "$QUERY"

echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

#set new user flag to false
ISNEW=false;;
esac

#prompt for int input and read 
echo -e "\nGuess the secret number between 1 and 1000:"
read INPUT

#catch user in a loop if int is not provided
while [[ ! $INPUT =~ ^[0-9]+$ ]]
do
echo -e "\nThat is not an integer, guess again:"
read INPUT
done

#count first try after provided int 
((TRIES++))

#check if input is less than or more than the random number
while (( $INPUT != $R_NO ))
do

if [[ $INPUT -gt $R_NO ]]
then
((TRIES++))
echo -e "\nIt's lower than that, guess again:"
read INPUT

else

((TRIES++))
echo -e "\nIt's higher than that, guess again:"
read INPUT

fi

done

#print win message when loop is broken 
echo -e "\nYou guessed it in $TRIES tries. The secret number was $R_NO. Nice job!"


# #if player is new
if [[ $ISNEW = 'true' ]]
then

#insert current first game stats
($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$NAME', 1, $TRIES)") > /dev/null

fi

#if player is not new 
if [[ $ISNEW = 'false' ]]
then

#increase game count by + 1
($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username = '$NAME'") > /dev/null

#get best game score and compare it against current tries
BEST_GAMES=$($PSQL "SELECT best_game FROM users WHERE username = '$NAME'")

#if tries is less than the saved score, upate with the current score
if [[ $TRIES -lt $BEST_GAMES ]]
then

($PSQL "UPDATE users SET best_game = $TRIES WHERE username = '$NAME' ") > /dev/null

fi

fi

