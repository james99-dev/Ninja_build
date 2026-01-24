#!/bin/sh
git pull --rebase --autostash
./scripts/feeds update -a 
./scripts/feeds install -a
make defconfig
#make -j$(($(nproc)+1)) V=sc download
./scripts/getver.sh
make -i -j$(($(nproc)+1)) V=sc ; echo -e '\a'
#echo "Prêt ! Lance la compilation avec la commande suivante :"
#echo "make download -j$(nproc) && make -j$(nproc) V=s && (notify-send 'OpenWrt' 'RÉUSSIE !' -i face-cool; echo '--- SUCCÈS ---') || (notify-send 'OpenWrt' 'ERREUR !' -u critical; echo '--- ÉCHEC ---')"
