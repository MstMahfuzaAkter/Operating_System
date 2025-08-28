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

MFT algorithm 
#!/bin/bash

# Step 1: Take inputs
read -p "Enter the total memory available (in Bytes) -- " total_mem
read -p "Enter the block size (in Bytes) -- " block_size
read -p "Enter the number of processes -- " num_proc

# Step 2: Read processes
declare -a processes
for ((i=1; i<=num_proc; i++))
do
    read -p "Enter memory required for process $i (in Bytes) -- " p
    processes[$i]=$p
done

# Step 3: Calculate number of blocks
num_blocks=$((total_mem / block_size))
echo -e "\nNo. of Blocks available in memory -- $num_blocks\n"

# Step 4: Allocation logic
allocated=0
internal_frag=0
external_frag=0

echo -e "OUTPUT"
echo -e "PROCESS\tMEMORY REQUIRED\tALLOCATED\tINTERNAL FRAGMENTATION"

for ((i=1; i<=num_proc; i++))
do
    p=${processes[$i]}
    if [ $allocated -lt $num_blocks ]; then
        if [ $p -le $block_size ]; then
            allocated=$((allocated + 1))
            frag=$((block_size - p))
            internal_frag=$((internal_frag + frag))
            echo -e "$i\t$p\t\tYES\t\t$frag"
        else
            echo -e "$i\t$p\t\tNO\t\t-----"
        fi
    else
        echo -e "$i\t$p\t\tNO\t\t-----"
        external_frag=$((external_frag + p))
    fi
done

# Step 5: Print summary
echo -e "\nMemory is Full, Remaining Processes cannot be accommodated"
echo "Total Internal Fragmentation is $internal_frag"
echo "Total External Fragmentation is $external_frag"
