#!/bin/bash

lib_path="/opt/ros/jazzy/lib/librclcpp.so"

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 [hz|latency] <topic_name> <usdt_lib> <usdt_function>"
    exit 1
fi

if [ $UID != 0 ];then
    echo "Please run with sudo as root"
    exit 1
fi

sub_cmd=$1
topic_name=$2
usdt_lib=$3
usdt_function=$4

container_id=`docker ps -q --filter name=agent`
if [ -z "$container_id" ]; then
    echo "Container not found"
    exit 1
fi

merged_dir=`docker inspect --format='{{.GraphDriver.Data.MergedDir}}' $container_id`
if [ -z "$merged_dir" ]; then
    echo "Merged directory not found"
    exit 1
fi

usdt_library_path="$merged_dir$lib_path"
if [ ! -f "$usdt_library_path" ]; then
    echo "USDT library $usdt_library_path not found"
    exit 1
fi

echo "USDT library found at: $usdt_library_path"

if [ "$sub_cmd" == "hz" ]; then
    bpftrace ./hz.bt $topic_name $usdt_library_path $usdt_function
elif [ "$sub_cmd" == "latency" ]; then
    bpftrace ./latency.bt $topic_name $usdt_library_path $usdt_function
else
    echo "Invalid sub-command: $sub_cmd"
    exit 1
fi