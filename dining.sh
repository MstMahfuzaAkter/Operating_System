#!/bin/bash

echo "DINING PHILOSOPHER PROBLEM"

read -p "Enter the total no. of philosophers: " n
read -p "How many are hungry: " h

declare -a hungry

for ((i=0; i<h; i++))
do
    read -p "Enter philosopher $((i+1)) position: " pos
    hungry[$i]=$pos
done

while true
do
    echo -e "\nOUTPUT"
    echo "1. One can eat at a time"
    echo "2. Two can eat at a time"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    if [ $choice -eq 1 ]; then
        echo -e "\nAllow one philosopher to eat at any time"
        for ((i=0; i<h; i++))
        do
            echo "P ${hungry[$i]} is granted to eat"
            for ((j=0; j<h; j++))
            do
                if [ $i -ne $j ]; then
                    echo "P ${hungry[$j]} is waiting"
                fi
            done
        done

    elif [ $choice -eq 2 ]; then
        echo -e "\nAllow two philosophers to eat at the same time"
        found=0
        for ((i=0; i<h; i++))
        do
            for ((j=i+1; j<h; j++))
            do
                diff=$(( ${hungry[$i]} - ${hungry[$j]} ))
                absdiff=${diff#-}   # absolute value

                if [ $absdiff -ne 1 ] && [ $absdiff -ne $((n-1)) ]; then
                    echo "P ${hungry[$i]} and P ${hungry[$j]} are granted to eat"
                    for ((k=0; k<h; k++))
                    do
                        if [ $k -ne $i ] && [ $k -ne $j ]; then
                            echo "P ${hungry[$k]} is waiting"
                        fi
                    done
                    found=1
                    break
                fi
            done
            if [ $found -eq 1 ]; then
                break
            fi
        done
        if [ $found -eq 0 ]; then
            echo "No two philosophers can eat at the same time (all are neighbors)."
        fi

    elif [ $choice -eq 3 ]; then
        echo "Exiting..."
        break

    else
        echo "Invalid choice! Try again."
    fi
done
