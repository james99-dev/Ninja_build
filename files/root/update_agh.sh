#!/bin/sh

# Fichier de log
LOG_FILE="/var/log/agh_update.log"

# Couleurs pour le terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Fonction pour écrire dans le log avec la date
log_msg() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

echo -e "${GREEN}--- Début de la mise à jour AdGuard Home Edge ---${NC}"
log_msg "Début de la tentative de mise à jour vers la version Edge."

# 1. Préparation dans /tmp
cd /tmp
log_msg "Téléchargement du binaire..."
wget -q https://static.adguard.com/adguardhome/edge/AdGuardHome_linux_arm64.tar.gz

if [ $? -ne 0 ]; then
    log_msg "ERREUR: Échec du téléchargement."
    echo -e "${RED}Échec du téléchargement.${NC}"
    exit 1
fi

# 2. Extraction du binaire
tar -xzf AdGuardHome_linux_arm64.tar.gz ./AdGuardHome/AdGuardHome 2>> "$LOG_FILE"

# 3. Vérification de la version
chmod +x /tmp/AdGuardHome/AdGuardHome
VERSION=$(/tmp/AdGuardHome/AdGuardHome --version 2>/dev/null)

if [ $? -eq 0 ]; then
    log_msg "Version valide détectée : $VERSION"
    echo -e "${GREEN}Version détectée : $VERSION${NC}"
else
    log_msg "ERREUR: Le binaire extrait est invalide ou corrompu."
    echo -e "${RED}Erreur binaire. Consultez $LOG_FILE${NC}"
    exit 1
fi

# 4. Sauvegardes et installation
log_msg "Arrêt du service et remplacement du binaire."
cp /opt/AdGuardHome/AdGuardHome.yaml /opt/AdGuardHome/AdGuardHome.yaml.backup
/etc/init.d/adguardhome stop

mv /opt/AdGuardHome/AdGuardHome /opt/AdGuardHome/AdGuardHome.stable.backup
mv /tmp/AdGuardHome/AdGuardHome /opt/AdGuardHome/AdGuardHome

# 5. Redémarrage et nettoyage
/etc/init.d/adguardhome start
rm -rf /tmp/AdGuardHome /tmp/AdGuardHome_linux_arm64.tar.gz

log_msg "Mise à jour réussie."
echo -e "${GREEN}--- Mise à jour terminée avec succès ! ---${NC}"
