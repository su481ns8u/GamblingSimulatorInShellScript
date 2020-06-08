##!/bin/bash -x

AMOUNT_PER_DAY=100
BET_PER_GAME=1
WIN_STATE=1
LOSE_STATE=0
GOAL=$((AMOUNT_PER_DAY * 50/100))
WIN_CASH=$(($AMOUNT_PER_DAY + $GOAL))
LOSE_CASH=$(($AMOUNT_PER_DAY - $GOAL))
TOTAL_DAYS=20

twentyDayResult=0

for ((day = 1; $day <= $TOTAL_DAYS; day++))
do
	gambResult=$AMOUNT_PER_DAY
	while [ $gambResult -lt $WIN_CASH -a $gambResult -gt $LOSE_CASH ]
	do
		betResult=$((RANDOM%2))
		if [ $betResult -eq $WIN_STATE ]
		then
			gambResult=$(($gambResult + $BET_PER_GAME))
		else
			gambResult=$(($gambResult - $BET_PER_GAME))
		fi
	done
	if [ $gambResult -gt $AMOUNT_PER_DAY ]
	then
		echo "Won for the day $day"
		twentyDayResult=$(($twentyDayResult + 1))
	else
		echo "Lost for the day $day"
		twentyDayResult=$(($twentyDayResult - 1))
	fi
done

echo "Total won or lost amount for 20 days: "$(($twentyDayResult * 50))
