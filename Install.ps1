# Variables
$installPath = "C:\zabbix"
$configPath = "$installPath\conf\zabbix_agent2.win.conf"
$pskIdentity = "<PSK Identity>"
$pskKey = "<PSK Key>" # Remplacez cette clé par une clé PSK générée
$hostname = (hostname)


# Extraction de l'archive
Expand-Archive -Path $downloadPath -DestinationPath $installPath

# Création du fichier de configuration
@"
LogFile=C:\zabbix\zabbix_agent2.log
Server=<Server IP or Name>
ServerActive=<Server IP or Name>
Hostname=$hostname
TLSConnect=psk
TLSAccept=psk
TLSPSKIdentity=$pskIdentity
TLSPSKFile=$installPath\conf\zabbix_agent2.psk
"@ | Out-File -FilePath $configPath -Encoding ascii

# Écriture de la clé PSK dans le fichier
Set-Content -Path "$installPath\conf\zabbix_agent2.psk" -Value $pskKey

# Installation et démarrage du service
& "$installPath\bin\zabbix_agent2.exe" --config "$configPath" --install

Start-Service -Name "Zabbix Agent 2"
