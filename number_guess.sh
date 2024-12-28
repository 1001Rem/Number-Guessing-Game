#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#random no gen
R_NO=$(($RANDOM%1000))

#get username
echo Enter your username:
read USERNAME

