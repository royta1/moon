#!/bin/bash

# Define lower and upper bounds
lower=1
upper=20
error=false

# Function to check if response is even or odd and within range
check_even_odd_within_range() {
    response=$1
    url=$2
    if [ $((response % 2)) -eq 0 ]; then
        even_or_odd="even"
    else
        even_or_odd="odd"
    fi

    if [ "$even_or_odd" != "$url" ]; then
        error=true
    fi

    if [ "$response" -ge "$lower" ] && [ "$response" -le "$upper" ]; then
        within_range="within"
    else
        within_range="outside of"
        error=true
    fi

    echo "$response is $even_or_odd and $within_range the range [$lower, $upper]."
}

# Curl command for even.com
response_even=$(curl -s --header 'Host: even.com' http://192.168.49.2/)
echo "Checking even.com: "
check_even_odd_within_range "$response_even" "even"

# Check if /ready endpoint returns 200 OK for even.com
response_ready_even=$(curl -s -o /dev/null -w "%{http_code}" --header 'Host: even.com' http://192.168.49.2/ready)
if [ "$response_ready_even" -ne 200 ]; then
    echo "Error: even.com /ready endpoint did not return 200 OK"
    error=true
else
    echo "even.com /ready endpoint returned 200 OK"
fi

# Curl command for odd.com
response_odd=$(curl -s --header 'Host: odd.com' http://192.168.49.2/)
echo "Checking odd.com: "
check_even_odd_within_range "$response_odd" "odd"

# Check if /ready endpoint returns 200 OK for odd.com
response_ready_odd=$(curl -s -o /dev/null -w "%{http_code}" --header 'Host: odd.com' http://192.168.49.2/ready)
if [ "$response_ready_odd" -ne 200 ]; then
    echo "Error: odd.com /ready endpoint did not return 200 OK"
    error=true
else
    echo "odd.com /ready endpoint returned 200 OK"
fi

if [ "$error" = "true" ]; then
    echo "One or more tests failed"
    exit 1
fi
