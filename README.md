sudo apt-get update; sudo apt-get upgrade -y --force-yes; sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson* libpython-dev make unzip git redis-server g++ -y --force-yes && git clone https://github.com/x79zeus79y/zeus.git && cd zeus && chmod +x launch.sh && ./launch.sh install && ./launch.sh





cd
cd zeus
cd .luarocks
cd bin 
./luarocks-5.2 install luafilesystem
./luarocks-5.2 install lub
./luarocks-5.2 install luaexpat
cd ..
cd ..
./launch.sh install
