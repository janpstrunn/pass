#!/usr/bin/env bash

read -p "Choose a salt to test: " ENTROPY_SALT
read -p "Choose how much iterations are required: " ENTROPY_ITERATION

echo "Starting Entropy Amplification Test:"

weak_passwords=(
  "password321" "pass1234" "letmein1" "drowssap" "123abc" "321cba" "qweasd" "asdzxc" "love123" "myverystrongpassword"
)

mypassword=$(echo "myverystrongpassword" | argon2 "$ENTROPY_SALT" -id -t "${ENTROPY_ITERATION:-2}" -m 20 -p 2 | awk '/^Hash:/ {print $2}')

start_time=$(date +%s.%N) # Start time with nanosecond precision

for password in "${weak_passwords[@]}"; do
  hashing=$(echo "$password" | argon2 "$ENTROPY_SALT" -id -t "${ENTROPY_ITERATION:-2}" -m 20 -p 2)
  password_hash=$(echo "$hashing" | awk '/^Hash:/ {print $2}')
  time_hash=$(echo "$hashing" | grep "seconds")
  if [ "$password_hash" == "$mypassword" ]; then
    echo "Password: $password -> Hash: $password_hash"
    echo "Timed Elapsed for $password_hash --> Time: $time_hash"
    echo
    echo -e "Given Password: $password"
    echo -e "Your Password: myverystrongpassword"
    echo "Passwords matched!"
  else
    echo "Password: $password -> Hash: $password_hash"
    echo "Timed Elapsed for $password --> Time: $time_hash"
  fi
done

end_time=$(date +%s.%N) # End time with nanosecond precision

elapsed_time=$(echo "$end_time - $start_time" | bc)

doubled_time=$(echo "$elapsed_time * 10" | bc)

echo "Ten Passwords have been hashed in $elapsed_time seconds"
echo "Hypothetically hashing 100 passwords would take $doubled_time seconds"
