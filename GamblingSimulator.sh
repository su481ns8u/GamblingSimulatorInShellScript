##!/bin/bash -x

#DICTNORY DECLARATIONS
declare -A dayOfMonth
declare -A dictForLuck

#CONSTANT DECLARATIONS
AMOUNT_PER_DAY=100
BET_PER_GAME=1
WIN_STATE=1
LOSE_STATE=0
GOAL=$((AMOUNT_PER_DAY * 50/100))
WIN_CASH=$(($AMOUNT_PER_DAY + $GOAL))
LOSE_CASH=$(($AMOUNT_PER_DAY - $GOAL))
TOTAL_DAYS=30

function betting(){
	#VARIABLES
	monthResult=0
	wins=0
	loss=0

	#GAMBLING AND STORING RESULTS IN A DICTIONARY
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
			dictForLuck["Day_$day"]=$monthResult
		else
			dayOfMonth["Day_$day"]=-$GOAL
			monthResult=$(($monthResult - 1))
			dictForLuck["Day_$day"]=$monthResult
		fi
	done

	#SORTING ELEMENTS OF DICT FOR LUCK
	min=${dictForLuck["Day_1"]}
	max=${dictForLuck["Day_1"]}
	for key in ${!dictForLuck[@]};
	do
		if [ ${dictForLuck[$key]} -gt $max ]
		then
			max=${dictForLuck[$key]}
		elif [ ${dictForLuck[$key]} -lt $min ]
		then
			min=${dictForLuck[$key]}
		fi
	done

	#STORING LUCKY AND UNLUCKY DAYS IN SEPARATE ARRAYS
	lucky=0;
	unLucky=0;
	declare -a luckyDays
	declare -a unLuckyDays
	for key in "${!dictForLuck[@]}"
	do
		if [ ${dictForLuck[$key]} -eq $max ]
		then
			luckyDays[$lucky]=$key
			lucky=$(($lucky + 1))
		elif [ ${dictForLuck[$key]} -eq $min ]
		then
			unLuckyDays[$unLucky]=$key
			unLucky=$(($unLucky + 1))
		fi
	done

	#CALCULATING TOTAL WINS AND LOOSES
	for key in ${!dayOfMonth[@]};
	do
		if [ ${dayOfMonth[$key]} -ge $GOAL ]
		then
			wins=$(($wins + 50))
		else
			loss=$(($loss - 50))
		fi
	done

	#PRINTING ALL DATA
	totalResult=$(($monthResult * $GOAL))
	echo " "
	echo "Total won or lost amount for month: "$totalResult
	echo "Total won: "$(($wins))
	echo "Total loss: "$(($loss))
	echo "Lucky Days: "${luckyDays[@]}
	echo "Un-Lucky Days: "${unLuckyDays[@]}
}

function main(){
	betting
	if [ $totalResult -lt 0 ]
	then
		echo "You are broke and can't play anymore. Thankyou for playing !!!"
	else
		read -p 'Enter 1 if wants to play or any other to exit: ' choice
		if [ $choice -eq 1 ]
		then
			main
		else
			echo "Thankyou for playing !!!"
		fi
	fi
}

main
