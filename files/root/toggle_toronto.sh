#!/bin/sh
# Toggle MTL - Toronto pour tous les devices assignés à proton_vpn

# Parcours toutes les policies
POLICIES=$(uci show pbr | grep "=policy" | cut -d '[' -f2 | cut -d ']' -f1)

for i in $POLICIES; do
    IFACE=$(uci get pbr.@policy[$i].interface)
    SRC=$(uci get pbr.@policy[$i].src_addr 2>/dev/null)

    # On ne touche que les policies qui ont une src_addr (devices assignés)
    if [ ! -z "$SRC" ]; then
        if [ "$IFACE" = "proton_vpn" ]; then
            uci set pbr.@policy[$i].interface='toronto'
            echo "Policy $i ($SRC) basculée → Toronto"
        elif [ "$IFACE" = "toronto" ]; then
            uci set pbr.@policy[$i].interface='proton_vpn'
            echo "Policy $i ($SRC) basculée → MTL"
        fi
    fi
done

# Appliquer les changements
uci commit pbr
/etc/init.d/pbr reload

echo "Toggle terminé."

