#!/bin/bash -x

AMOUNT_PER_DAY=100
BET_PER_GAME=1

WIN_STATE=1
LOSE_STATE=0

gambResult=$AMOUNT_PER_DAY
betResult=$((RANDOM%2))
if [ $betResult -eq $WIN_STATE ]
then
	echo "Won Bet !"
	gambResult=$(($gambResult + 1))
else
	echo "Bet Lost !"
	gambResult=$(($gambResult - 1))
fi
echo "Amount: "$gambResult

