#!/bin/bash

echo "Enter number of processes:"
read n

# Arrays for burst time, waiting time, and turnaround time
declare -a bt
declare -a wt
declare -a tat

# Input burst time for each process
for (( i=0; i<n; i++ ))
do
  echo -n "Enter burst time for Process $((i+1)): "
  read bt[i]
done

# First process waiting time is 0
wt[0]=0

# Calculate waiting time
for (( i=1; i<n; i++ ))
do
  wt[i]=$(( wt[i-1] + bt[i-1] ))
done

# Calculate turnaround time
for (( i=0; i<n; i++ ))
do
  tat[i]=$(( wt[i] + bt[i] ))
done

# Display result
echo ""
echo "Process  Burst Time  Waiting Time  Turnaround Time"
total_wt=0
total_tat=0
for (( i=0; i<n; i++ ))
do
  echo "P$((i+1))        ${bt[i]}           ${wt[i]}             ${tat[i]}"
  total_wt=$(( total_wt + wt[i] ))
  total_tat=$(( total_tat + tat[i] ))
done

# Calculate averages
avg_wt=$(echo "scale=2; $total_wt / $n" | bc)
avg_tat=$(echo "scale=2; $total_tat / $n" | bc)

echo ""
echo "Average Waiting Time = $avg_wt"
echo "Average Turnaround Time = $avg_tat"


