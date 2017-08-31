include_recipe 'collect_metrics::default'

cookbook_file '/home/ec2-user/data_collector_queue_length.sh' do
 source 'data_collector_queue_length.sh'
 user 'ec2-user'
 mode '755' 
 action :create
end

cron 'data_collector_queue_length' do
  minute '*'
  hour '*'
  weekday '*'
  month '*'
  user 'root'
  command '/home/ec2-user/data_collector_queue_length.sh' 
end

cookbook_file '/home/ec2-user/es_post_times.sh' do
 source 'es_post_times.sh'
 user 'ec2-user'
 mode '755'
 action :create
end

cron 'es_post_times' do
  minute '*/5'
  hour '*'
  weekday '*'
  month '*'
  user 'root'
  command '/home/ec2-user/es_post_times.sh'
end

cookbook_file '/home/ec2-user/logstash_worker_heap_stats.sh' do
 source 'logstash_worker_heap_stats.sh'
 user 'ec2-user'
 mode '755'
 action :create
end

cron 'logstash_worker_heap_stats' do
  minute '*/5'
  hour '*'
  weekday '*'
  month '*'
  user 'root'
  command '/home/ec2-user/logstash_worker_heap_stats.sh'
end
