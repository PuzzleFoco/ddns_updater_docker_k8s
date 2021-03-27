#!/bin/busybox ash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

PFAD="/ddns_data"

update_IP()
{
  if [ ! -f $PFAD/updip.txt ]; then
    echo "$PFAD/updip.txt does not exist. Creating new file."
  fi
  DATUM=`date +%Y-%m-%d\ %H:%M:%S`
  IP=`wget -q -O - http://www.ddnss.de/meineip.php| grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
  if [ -f $PFAD/updip.txt ]; then
    UPDIP=`cat $PFAD/updip.txt`
  else
    echo "Keine alte IP vorhanden. File wird mit Standard-IP angelegt."
    echo "0.0.0.0" > $PFAD/updip.txt
    UPDIP=`cat $PFAD/updip.txt`
  fi

  if [ "$IP" = "$UPDIP" ]; then
          echo "$DATUM - IP ist gleich - KEIN UPDATE"
  else
          echo "$DATUM -  Neue-IP: $IP / Alte-IP: $UPDIP - UPDATE!"
          echo $IP > $PFAD/updip.txt
  	wget -q -O - 'http://www.ddnss.de/upd.php?key='$KEYAUTH'&host='$HOSTNAME''
    echo "Update ..."
  fi
}

if [ -z "$KEYAUTH" ] || [ -z "$HOSTNAME" ]; then
  echo "KEYAUTH und HOSTNAME müssen als Umgebungsvariable gesetzt werden."
  exit
fi

update_IP
