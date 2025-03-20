#!/usr/bin/env bash

read -p "Choose a salt to test: " ENTROPY_SALT
read -p "Choose how much iterations are required: " ENTROPY_ITERATION
read -p "Choose how much parallel work is required: " ENTROPY_PARALLELISM

echo "Starting Entropy Amplification Test:"

weak_passwords=(
  "password321" "pass1234" "letmein1" "drowssap" "123abc" "321cba" "qweasd" "asdzxc" "love123" "myverystrongpassword"
)

total_time=0

for password in "${weak_passwords[@]}"; do
  start_time=$(date +%s.%N) # Start time with nanosecond precision

  hashing=$(echo "$password" | argon2 "$ENTROPY_SALT" -id -t "${ENTROPY_ITERATION:-2}" -m 20 -p "${ENTROPY_PARALLELISM:-2}")
  password_hash=$(echo "$hashing" | awk '/^Hash:/ {print $2}')
  echo "Password: $password -> Hash: $password_hash"

  end_time=$(date +%s.%N)                             # End time with nanosecond precision
  elapsed_time=$(echo "$end_time - $start_time" | bc) # Calculate elapsed time for this password

  echo "Timed Elapsed for $password --> Time: $elapsed_time seconds"

  total_time=$(echo "$total_time + $elapsed_time" | bc)
done

one_hundred_time=$(echo "$total_time * 10" | bc)    # Time for 100 passwords in seconds
one_thousand_time=$(echo "$total_time * 100" | bc)  # Time for 1000 passwords in seconds
one_million_time=$(echo "$total_time * 10000" | bc) # Time for 10000 passwords in seconds

one_hundred_time_minutes=$(echo "$one_hundred_time / 60" | bc -l)   # Minutes
one_thousand_time_minutes=$(echo "$one_thousand_time / 60" | bc -l) # Minutes

one_million_time_hours=$(echo "$one_million_time / 3600" | bc -l) # Hours

one_billion_time=$(echo "$total_time * 1000000000" | bc)

one_billion_time_days=$(echo "$one_billion_time / 86400" | bc -l) # Days

echo
echo "Total Time for 1 password: $total_time seconds"
echo "Time for 100 passwords: $one_hundred_time_minutes minutes"
echo "Time for 1000 passwords: $one_thousand_time_minutes minutes"
echo "Time for 1 million passwords: $one_million_time_hours hours"
echo "Time for 1 billion passwords: $one_billion_time_days days"
