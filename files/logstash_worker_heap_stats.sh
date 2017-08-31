#!/bin/bash

source /home/ec2-user/instance_info

per_host_options="--namespace AWS/EC2 --region us-west-2 --dimensions TestId=$test_id,Instance=$instance"
total=0
pids=`ps -ef | grep 'runsv logstash' | grep -v grep`
while read -r line; do
  worker=`printf "$line" | awk '{print $9}'`
  parent_pid=`printf "$line" | awk '{print $2}'`
  pid=`ps -Af | grep $parent_pid | grep delivery | grep -v root | awk '{print $2}'` 
  worker_heap=`su delivery -c "/opt/delivery/embedded/jre/bin/jcmd $pid GC.class_histogram" | grep Total | awk '{print $3}'`
  worker_heap_bytes=$worker_heap
  total=$(($total+$worker_heap))
  aws cloudwatch put-metric-data $per_host_options --metric-name LogstashHeap_${worker} --unit Bytes --value ${worker_heap_bytes}
done <<< "$pids"

total_heap_bytes=$total

aws cloudwatch put-metric-data $per_host_options --metric-name TotalLogstashHeap --unit Bytes --value ${total_heap_bytes}
