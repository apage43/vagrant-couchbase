#!/bin/bash
rm -rf couchbase.deb 2>/dev/null
echo "Downloading Couchbase Server x64, 2.0.1"
wget -qO couchbase.deb http://cbfs-ext.hq.couchbase.com/couchbase-dist/couchbase-server-enterprise_x86_64_2.0.1.deb
apt-get update
apt-get install -y libssl0.9.8
sudo dpkg -i couchbase.deb
killall -9 beam.smp
killall -9 memcached
service couchbase-server stop
cp -f /vagrant/couchbase-server /opt/couchbase/bin/couchbase-server
rm -rf /otp/couchbase/var/lib/couchbase/data/*
rm -rf /otp/couchbase/var/lib/couchbase/mnesia/*
rm -rf /otp/couchbase/var/lib/couchbase/config/config.dat
service couchbase-server start
echo Waiting...
sleep 8
echo Setting up default bucket...
export AUTH=Administrator:asdasd
wget -qO - --post-data "memoryQuota=597" "http://${AUTH}@localhost:8091/pools/default" 
wget -qO - --post-data "bucketType=membase&ramQuotaMB=597&replicaNumber=1&replicaIndex=1" "http://${AUTH}@localhost:8091/controller/setupDefaultBucket"
wget -qO - --post-data "port=SAME&username=Administrator&password=asdasd" "http://${AUTH}@localhost:8091/settings/web"
echo Done: http://localhost:8091/?na
