#!/bin/bash

# Read the input from the user
read -p "Enter a comma-separated list of numbers: " input

# Split the input string into an array using ',' as the delimiter
IFS=',' read -ra numbers <<< "$input"

# Sort the numbers in ascending order
sorted=($(printf '%s\n' "${numbers[@]}" | sort -n))

# Find the frequency of each number
declare -A frequency
for num in "${sorted[@]}"; do
  ((frequency["$num"]++))
done

# Find the mode(s)
max=0
modes=()
for num in "${!frequency[@]}"; do
  if (( frequency["$num"] > max )); then
    modes=("$num")
    max=${frequency["$num"]}
  elif (( frequency["$num"] == max )); then
    modes+=("$num")
  fi
done

# Print the mode(s)
if (( ${#modes[@]} == 1 )); then
  echo "The mode is: ${modes[0]}"
else
  echo "The modes are: ${modes[*]}"
fi
