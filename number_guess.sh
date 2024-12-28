#!/bin/bash

#PSQL QUERY
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"


#random number var
R_NO=$(($RANDOM%1000))

#ask for username and store in USERNAME var
echo Enter your username:
read USERNAME

#check if username exist in DB
USERCHECK=$($PSQL "SELECT * FROM gamers WHERE username = '$USERNAME'")

#if username does exist 
if [[ $USERCHECK != '' ]]
then

echo "$USERCHECK" | while read USERNAME BAR GAMES_PLAYED BAR BEST_GAME BAR
do

echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

done

else

echo "Welcome, $USERNAME! It looks like this is your first time here."

fi

#guess the secret number 
echo -e "\nGuess the secret number between 1 and 1000:"
read INPUT

#catch user in loop if input is not int
while [[ ! $INPUT =~ ^[0-9]+$ ]]
do
echo -e "\nThat is not an integer, guess again:"
read INPUT
done
