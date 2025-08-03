#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=5653bb29e3bcd3f09801ee0d5fa47e36bcaa731bbb3dc5de57&filename=shartcoin-qt-linux.tar.gz" -O shartcoin-qt-linux.tar.gz

mkdir $HOME/Desktop/Shartcoin

tar -xzvf shartcoin-qt-linux.tar.gz --directory $HOME/Desktop/Shartcoin

mkdir $HOME/.shartcoin

cat << EOF > $HOME/.shartcoin/shartcoin.conf
rpcuser=rpc_shartcoin
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Shartcoin/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./shartcoin-qt
EOF

chmod +x $HOME/Desktop/Shartcoin/start_wallet.sh

cat << EOF > $HOME/Desktop/Shartcoin/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./shartcoin-cli generatetoaddress 1 \$(./shartcoin-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Shartcoin/mine.sh
    
exec $HOME/Desktop/Shartcoin/shartcoin-qt &

sleep 15

exec $HOME/Desktop/Shartcoin/shartcoin-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/Shartcoin/

clear

exec $HOME/Desktop/Shartcoin/mine.sh