cd /tmp || exit

echo "Téléchargement de sonar-scanner."
if [ -d "/tmp/sonar-scanner-cli-4.8.0.2856-linux.zip" ];then
    sudo rm /tmp/sonar-scanner-cli-4.8.0.2856-linux.zip
fi

wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip
echo "Download completed."

echo "Décompression du fichier téléchargé."
unzip sonar-scanner-cli-4.8.0.2856-linux.zip
echo "Unzip completed."
rm sonar-scanner-cli-4.8.0.2856-linux.zip

echo "Installation en direction d'opt."
if [ -d "/var/opt/sonar-scanner-4.8.0.2856-linux" ];then
    sudo rm -rf /var/opt/sonar-scanner-4.8.0.2856-linux
fi

sudo mv sonar-scanner-4.8.0.2856-linux /var/opt

# wsl -d docker-desktop/sudo sysctl -w vm.max_map_count=262144
# chmod 755 script/install-sonar-scanner.sh
# ./script/install-sonar-scanner.sh
# cd vgel
# /var/opt/sonar-scanner-4.8.0.2856-linux/
# cd ..
# make sonar-scan
#http://127.0.0.1:9000/dashboard?id=vgel