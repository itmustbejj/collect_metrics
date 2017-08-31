include_recipe 'collect_metrics::default'

cookbook_file '/home/ec2-user/es_heap.sh' do
 source 'es_heap.sh'
 user 'ec2-user'
 mode '755' 
 action :create
end

cron 'es_heap' do
  minute '*'
  hour '*'
  weekday '*'
  month '*'
  user 'ec2-user'
  home '/home/ec2-user'
  command '/home/ec2-user/es_heap.sh' 
end

cookbook_file '/home/ec2-user/disk_queue_size.sh' do
 source 'disk_queue_size.sh'
 user 'ec2-user'
 mode '755'
 action :create
end

cron 'disk_queue_size' do
  minute '*'
  hour '*'
  weekday '*'
  month '*'
  user 'ec2-user'
  home '/home/ec2-user'
  command '/home/ec2-user/disk_queue_size.sh'
end

cookbook_file '/home/ec2-user/index_records.sh' do
 source 'index_records.sh'
 user 'ec2-user'
 mode '755'
 action :create
end

cookbook_file '/home/ec2-user/index_records.py' do
 source 'index_records.py'
 user 'ec2-user'
 mode '755'
 action :create
end

cron 'index_records' do
  minute '*/5'
  hour '*'
  weekday '*'
  month '*'
  user 'ec2-user'
  home '/home/ec2-user'
  command '/home/ec2-user/index_records.sh'
end

cookbook_file '/home/ec2-user/cluster_health.sh' do
 source 'cluster_health.sh'
 user 'ec2-user'
 mode '755'
 action :create
end

cron 'cluster_health' do
  minute '*/5'
  hour '*'
  weekday '*'
  month '*'
  user 'ec2-user'
  home '/home/ec2-user'
  command '/home/ec2-user/cluster_health.sh'
end
