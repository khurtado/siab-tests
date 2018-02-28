#!/bin/bash

printf "Start time: "; /bin/date
printf "Job is running on node: "; /bin/hostname
printf "Job running as user: "; /usr/bin/id
printf "Job is running in directory: "; /bin/pwd

echo -e "\n---Worker node environment---"
env
echo -e "---end of environment---\n"

sleep ${1-5}
echo "Science complete!"
