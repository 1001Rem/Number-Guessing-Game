#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#random no gen
R_NO=$(($RANDOM%1000))

#get username
echo Enter your username:
read USERNAME

QUERY=$($PSQL "SELECT * FROM gamers WHERE username = '$USERNAME'")

if [[ $NAME != '' ]]
then

echo "$QUERY" | while read USER BAR GAMES_PLAYED BAR BEST_GAME
do

echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

done

else 

echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

echo "Guess the secret number between 1 and 1000:"
read INPUT

while [[ ! $INPUT =~ ^[0-9]+$ ]]
do
echo "That is not an integer, guess again:"
read INPUT
done
