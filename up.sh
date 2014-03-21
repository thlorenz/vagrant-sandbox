#! /usr/bin/env bash

vagrant up

# for multiple machines it is impossible to just do `npm start` since that blocks
# and prevents other machines from starting, `npm start &` also is not working since then the server doesn't come up

# doing it manually works better
for i in `seq 0 2`; do
  # clean old logs
  rm -f slave-$i.log
  vagrant ssh slave-$i -c "sudo killall node && cd /vagrant && SLAVE_ID=$i npm start" &> slave-$i.log &
done 

echo slaves are listening at:
echo http://localhost:42222
echo http://localhost:42223 
echo http://localhost:42224 

tail -f slave-0.log -f slave-1.log -f slave-2.log
