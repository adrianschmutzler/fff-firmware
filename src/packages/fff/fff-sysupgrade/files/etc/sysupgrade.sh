#!/bin/sh
cd /tmp/

. /lib/functions/fff/keyxchange
. /etc/firmware_release

UPGRADE_PATH="$(getUpgradePath)"

if [ -z "$UPGRADE_PATH" ]; then
  echo "Upgrade path not set! Aborting."
  echo ""
  exit 1
fi

BOARD=$(uci get board.model.name)

#decide SOC
case $BOARD in
    tl-wdr4900-v1 )
        SOC="mpc85xx-g" ;;
    tl-mr3020-v1 |\
    tl-wa850re-v1 |\
    tl-wa860re-v1 |\
    tl-wa901nd-v2 |\
    tl-wr740n-v4 |\
    tl-wr741nd-v2 |\
    tl-wr741nd-v4 |\
    tl-wr841-v7 |\
    tl-wr841-v8 |\
    tl-wr841-v9 |\
    tl-wr841-v10 |\
    tl-wr841-v11 |\
    tl-wr841-v12 )
        SOC="ar71xx-tiny" ;;
    * )
        SOC="ar71xx-g" ;;
esac
echo ""
echo "Hardware: $BOARD"

#rewrite BOARD
case $BOARD in
    cpe210 )
        BOARD="cpe210-220-v1" ;;
    cpe510 )
        BOARD="cpe510-520-v1" ;;
esac

wget "${UPGRADE_PATH}/release.nfo"
if [ ! -f release.nfo ]; then
  echo "Latest release information not found. Please try to update manually."
  echo ""
  exit 1
fi
VERSION=$(awk -F: '/VERSION:/ { print $2 }' release.nfo)
rm -f release.nfo
echo "Firmware found on server: $VERSION"

if [ "$VERSION" -eq "$FIRMWARE_VERSION" ]; then
  echo "The installed firmware version is already the current version."
  echo ""

  if [ "$1" = "--script" ]; then
    exit 1
  fi

  while true; do
    echo "Do you want to reinstall the current version? [y/N]"
    read DO_UPDATE
    case $DO_UPDATE in
      [yY]*|[Jj]*)
        break
        ;;
      [nN]*|"")
        exit 1
        ;;
      *)
        echo "Invalid input"
        ;;
    esac
  done
fi

FILE="fff-${VERSION}-${SOC}-${BOARD}-squashfs-sysupgrade.bin"
echo "Downloading $FILE"
echo ""
wget "${UPGRADE_PATH}/${FILE}"
wget "${UPGRADE_PATH}/${FILE}.sha256"

sum=$(sha256sum -c "${FILE}.sha256")
ret=$?
echo ""
echo "done. Comparing sha256 sums: $sum"
echo
if [ $ret -ne 0 ]; then
  echo "sha256 sums do not match. Try restarting this script to redownload the firmware."
  echo ""
  rm -f "${FILE}" "${FILE}.sha256"
  exit 1
else
  if [ "$1" = "--script" ]; then
    echo ""
    echo "Starting firmware upgrade. Don't touch me until I reboot."
    echo ""
    echo ""
    sysupgrade "${FILE}"
  fi
  while true; do
    read -p "sha256 sums correct. Should I start upgrading the firmware (y/N)? " yn
    case $yn in
        [Yy]*|[Jj]*)
            echo ""
            echo "Starting firmware upgrade. Don't touch me until I reboot."
            echo ""
            echo ""
            sysupgrade "${FILE}"
            break;;
        *)
            echo ""
            echo "Aborting firmware upgrade."
            echo ""
            rm -f "${FILE}" "${FILE}.sha256"
            exit 0;;
    esac
  done
fi
