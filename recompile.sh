#!/bin/sh
#make -i -j$(($(nproc)+1)) V=sc ; echo -e '\a'

make -j$(($(nproc)-1)) V=s

# Vérification du succès et notification sur Linux Mint
if [ $? -eq 0 ]; then
    notify-send 'OpenWrt Build' 'COMPILATION RÉUSSIE ! Le fichier est prêt.' -i face-cool
    echo "--- SUCCÈS : Ton firmware est dans bin/targets/mediatek/filogic/ ---"
else
    notify-send 'OpenWrt Build' 'ERREUR lors de la compilation.' -u critical -i face-sad
    echo "--- ÉCHEC de la compilation ---"
    exit 1
fi
