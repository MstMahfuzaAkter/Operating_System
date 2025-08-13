#!/bin/bash

echo -n "Enter number of processes: "
read n

# Arrays for burst time, waiting time, turnaround time, process IDs
declare -a bt wt tat p

# Input burst times
for ((i = 0; i < n; i++)); do
    echo -n "Enter Burst Time for Process $((i+1)): "
    read bt[i]
    p[i]=$((i+1))
done

# Sort processes by burst time (Selection sort)
for ((i = 0; i < n-1; i++)); do
    for ((j = i+1; j < n; j++)); do
        if (( bt[i] > bt[j] )); then
            temp=${bt[i]}
            bt[i]=${bt[j]}
            bt[j]=$temp

            temp=${p[i]}
            p[i]=${p[j]}
            p[j]=$temp
        fi
    done
done

# Calculate waiting time
wt[0]=0
for ((i = 1; i < n; i++)); do
    wt[i]=$((wt[i-1] + bt[i-1]))
done

# Calculate turnaround time
for ((i = 0; i < n; i++)); do
    tat[i]=$((wt[i] + bt[i]))
done

# Display results
echo
echo "Process    Burst Time    Waiting Time    Turnaround Time"
total_wt=0
total_tat=0

for ((i = 0; i < n; i++)); do
    echo "P[${p[i]}]         ${bt[i]}             ${wt[i]}              ${tat[i]}"
    total_wt=$((total_wt + wt[i]))
    total_tat=$((total_tat + tat[i]))
done

# Calculate averages with decimal values
avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

echo
echo "Average Waiting Time = $avg_wt"
echo "Average Turnaround Time = $avg_tat"
