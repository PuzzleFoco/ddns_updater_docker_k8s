# ddns_updater_docker_k8s
This repo should contain the code for a docker image to update the ddns host
Based on https://ddnss.de/info.php
# Bedienung
Der Updater für DDNS kann auf drei unterschiedliche Varianten genutzt werden. Ein schneller Einstieg ist hier beschrieben.
## Skript
Im ausführenden Terminal müss der Hostname als Variable 'HOMENAME' und der Authentifizierungskey als 'KEYAUTH' gesetzt werden.
Außerdem sollte im root-Verzeichnis ein Ordner 'ddns_data' angelegt werden.
Das Skript kann anschließend als cron-Job ausgeführt werden. 
## Docker Compose
Im [Docker-Compose-File](docker-compose.yaml) die Domain und den Auth-Key an der entsprechenden Stelle eintragen. 
```docker
docker-compose up -d
```
Dieses Kommando mit Verweis auf dieses Projekt als Cron-Job anlegen um die Domain regelmäßig upzudaten.
## Kubernetes
Im [Kubernetes-Manifest](kubenetes.yaml) die entsprechenden Values bei den Umgebungsvariablen des Cron-Jobs setzten. Das Manifest auf den Kubernetes-Server anwenden mit:
```yaml
kubectl apply -f kubernetes.yaml
```
Der Cron-Job in Kubernetes sollte alle 5 Minuten laufen.

# Disclaimer
Dieses Repository steht in keinen Zusammenhang mit https://ddnss.de. Das Skript ist auf Basis des angegebenen Cron-Job Skripts hier entstanden: https://ddnss.de/info.php.