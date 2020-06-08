##!/bin/bash -x

declare -A dayOfMonth

AMOUNT_PER_DAY=100
BET_PER_GAME=1
WIN_STATE=1
LOSE_STATE=0
GOAL=$((AMOUNT_PER_DAY * 50/100))
WIN_CASH=$(($AMOUNT_PER_DAY + $GOAL))
LOSE_CASH=$(($AMOUNT_PER_DAY - $GOAL))
TOTAL_DAYS=30

monthResult=0
wins=0
loss=0

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
		dayOfMonth["Day_$day"]=$GOAL
		monthResult=$(($monthResult + 1))
	else
		dayOfMonth["Day_$day"]=-$GOAL
		monthResult=$(($monthResult - 1))
	fi
done

echo "Total won or lost amount for month: "$(($monthResult * $GOAL))
for key in ${!dayOfMonth[@]};
do
	if [ ${dayOfMonth[$key]} -ge $GOAL ]
	then
		echo $key": Won"
		wins=$(($wins + 50))
	else
		echo $key": Lost"
		loss=$(($loss - 50))
	fi
done
echo "Total won: "$(($wins))
echo "Total loss: "$(($loss))
