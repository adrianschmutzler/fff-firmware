FFF Firmware
============

# Besonderheiten meiner Firmware

## Zweige
Die aktuelle stabile Version wird im Zweig **mainline** entwickelt.

Der Branch **nextgen** enthält zusätzliche Änderungen, sodass basierend auf dem OpenWrt master gebaut werden kann. Dieser Zweig wird regelmäßig auf den aktuellen Stand von mainline rebased. Der Unterschied besteht üblicherweise nur in einzelnen Patches, die on-top applied werden.

Der Branch **devtree** enthält Änderungen, die noch nicht ausreichend getestet sind. Dieser Zweig wird nur gelegentlich genutzt.

## Versionen
Die Firmware ist so gestaltet, dass mit demselben Branch alle Varianten der Firmware gebaut werden können. Entsprechend der Auswahl werden die relevanten Pakete selektiert.

Die Variante **adsc** entspricht der klassischen node-Firmware (auch V2-Firmware).

Die Variante **jubtl** umfasst die node-Firmware sowie weitere spezifische Features. Für normale User ist diese Variante nicht relevant.

Die Variante **gw** wählt die Gateway- oder Layer3-Firmware aus.

Die Identifier können jeweils um eine Zahl ergänzt werden, die die jeweilige Version näher spezifizieren:

**adsc9** - Basierend auf openwrt-18.06 (wegen Kernel 4.9)

**adsc10** - Basierend auf openwrt-18.06 - development version

**adsc14** - Basierend auf openwrt master (wegen Kernel 4.14)

**adsc15** - Basierend auf openwrt master - ath79 target

**adsc19** - Basierend auf openwrt master nach branch-off (wegen Kernel 4.19)

***Ein Verwenden von adsc ohne Ziffer sollte vermieden werden, da dies für die veraltete V1-Firmware verwendet wurde!***

Umgeschaltet wird mittels des buildscript-Parameters ***selectvariant***:

`./buildscript selectvariant adsc9`

Aus der Variante und dem letzten Tag im ausgewählten Tree wird dann die Firmware-Version zusammengesetzt.

# Was ist Freifunk?
Freifunk ist eine nicht-kommerzielle Initiative für freie Funknetzwerke. Jeder Nutzer im Freifunk-Netz stellt einen günstigen WLAN-Router für sich selbst und den Datentransfer der anderen Teilnehmer zur Verfügung. Dieses Netzwerk kann von jedem genutzt werden.

Weitere Informationen gibt es auf <https://freifunk.net/> und auf <https://wiki.freifunk-franken.de/w/Hauptseite>.

# Firmware selbst kompilieren
## Voraussetzungen
* `apt-get install zlib1g-dev lua5.2 build-essential unzip libncurses-dev gawk git subversion realpath libssl-dev` (Sicherlich müssen noch mehr Abhängigkeiten installiert werden, diese Liste wird sich hoffentlich nach und nach füllen. Ein erster Ansatzpunkt sind die Abhängigkeiten von OpenWrt selbst)
* `git clone https://github.com/adrianschmutzler/fff-firmware.git`
* `cd firmware`

## Erste Schritte
Je nachdem, für welche Hardware die Firmware gebaut werden soll, muss das BSP gewählt werden:

* `./buildscript selectvariant adsc9`
* `./buildscript selectbsp bsp/board_ar71xx.bsp`
* Um die vorhandenen BSPs zu sehen, kann `./buildscript selectbsp help` ausgeführt werden.

## Was ist ein BSP?
Ein BSP (Board-Support-Package) beschreibt, was zu tun ist, damit ein Firmware Image für eine spezielle Hardware gebaut werden kann.
Typischerweise ist eine Ordner-Struktur wie folgt vorhanden:
* .config
* root_file_system/
  * etc/
    * rc.local.board
    * config/
      * board
      * network
      * system
    * crontabs/
      * root

Die Daten des BSP werden nie alleine verwendet. Zuerst werden immer die Daten aus dem "default"-BSP zum Ziel kopiert, erst danach werden die Daten des eigentlichen BSPs dazu kopiert. Durch diesen Effekt kann ein BSP die "default" Daten überschreiben.

## Die Verwendung des Buildscripts
Die BSP-Datei wird durch das Buildscript automatisch als dot-Script geladen, somit stehen dort alle Funktionen zur Verfügung.
Das Buildscript generiert ein dynamisches sed-Script. Dies geschieht, damit die Templates mit den richtigen Werten gefüllt werden können.

### `./buildscript prepare`
* Sourcen werden in einen separaten src-Folder geladen, sofern diese nicht schon da sind. Zu den Sourcen zählen folgende Komponenten:
  * OpenWrt
  * Sämtliche Packages (ggf. werden Patches angewandt)

* Ein ggf. altes Target wird gelöscht
* OpenWrt wird ins Target exportiert (kopiert)
* Eine OpenWrt Feed-Config wird mit dem lokalen Source Verzeichnis als Quelle angelegt
* Die Feeds werden geladen
* Spezielle Auswahl an Paketen wird geladen
* Patches werden angewandt
* board_prepare() aus dem BSP wird aufgerufen (wird z.B. für Patches für eine bestimmte Hardware verwendet)

### `./buildscript config openwrt`
Um das Arbeiten mit den .config-Dateien von OpenWrt zu vereinfachen, bietet das Buildscript die Möglichkeit das `menuconfig` von OpenWrt aufzurufen. Nachdem man die gewünschten Einstellungen vorgenommen hat, hat man die Möglichkeit, die frisch editierte Konfiguration in das BSP zu übernehmen.
Dieses Kommando arbeitet folgendermaßen:
* prebuild
* OpenWrt: `make menuconfig`
* Speichern, y/n?
* Config-Format vereinfachen
* Config ins BSP zurück speichern

### `./buildscript build`
* prebuild
  * $target/files aufräumen
    * (In $target/files liegen Dateien, die später direkt im Ziel-Image landen)
  * Files aus default-bsp und bsp kopieren
  * OpenWrt- und Kernel-Config kopieren
  * board_prebuild() aus dem BSP wird aufgerufen
* Templates transformieren
* GIT Versionen speichern: $target/files/etc/firmware_release
* OpenWrt: make
* postbuild
  * board_postbuild() wird aufgerufen

## Erweiterung eines BSPs
Beispielhaftes Vorgehen um den WR1043V2 zu unterstützen.

### Repository auschecken
```
git clone https://github.com/adrianschmutzler/fff-firmware.git
cd firmware
```

### Erste Images erzeugen
Du fügst die Dateinamen der Images, die zusätzlich kopiert werden sollen, in das `images`-Array ein:

```
vim bsp/board_ar71xx.bsp
images=(
    // ...
    openwrt-${chipset}-${subtarget}-tl-wr1043nd-v2-squashfs-sysupgrade.bin"
    openwrt-${chipset}-${subtarget}-tl-wr1043nd-v2-squashfs-factory.bin"
    // ...
)
```

Dann muss auf jeden Fall noch das Netzwerk richtig konfiguriert werden. Dazu muss man den Router sehr gut kennen, i.d.R. lernt man den erst beim Verwenden kennen, daher ist ein guter Startpunkt die Config vom v1 zu kopieren und erstmal zu gucken was passiert.
Dazu in `src/packages/fff/fff-network/files/etc/uci-defaults/22a-config-ports` die richtige Zeile suchen und dann entsprechend ergänzen.

Anschließend kann ein erstes Image erzeugt werden:
```
./buildscript selectbsp bsp/board_wr1043nd.bsp

./buildscript prepare
./buildscript build
```
Jetzt gehst du n Kaffee trinken.

### Netzwerkeinstellungen korrekt setzen
Am Ende sollte im bin/ Verzeichnis das Image für v1 und v2 liegen. Das v2 Image wird auf den Router geflasht. Achtung: Eventuell ist das Netzwerk jetzt so falsch eingestellt, dass man nicht mehr über Netzwerk auf den Router zugreifen kann. Am einfachsten ist es den Router dann über eine serielle Konsole zu verwenden. Theoretisch kann man an den unterschiedlichen LAN-Ports mit der IPv6 Link-Local aus der MAC Adresse des Geräts versuchen drauf zu kommen. Es kann auch sein, dass die IPv6 +/- 1 am Ende hat. Letztlich kann das funktionieren, ist aber aufwändig und da am LAN Einstellungen verändert werden sollen, ist die serielle Konsole das Mittel der Wahl!

### BSP commiten und Patch erzeugen
Ist das Netzwerk korrekt konfiguriert, kann man die Änderungen im git Repository in die relevanten uci-default Dateien eintragen. Nun kann man mit `git status` die Änderungen sehen. Mit `git add` staged man diese und mit `git commit` checkt man sie ein. `git format-patch origin/HEAD` erzeugt dann aus deinen Commits ein (oder mehr) Patches. Diese schickst du dann mit `git send-email --to franken-dev@freifunk.net *.patch` an unsere Liste. Dort nimmt sich jemand die Zeit und schaut kurz drüber und wenn alles passt finden deine Änderungen in den Hauptentwicklungszweig und sind ab dann Teil der Freifunk-Franken-Firmware.

### Patch schicken
Auf der Mailingliste franken-dev@freifunk.net kannst du natürlich jederzeit Fragen stellen, falls etwas nicht klar sein sollte.

## Hinzufügen von Paketen zum Image
Das Hinzufügen von Paketen sollte mit Bedacht erfolgen, da dies (bei unvorsichtiger Konfiguration) den Betrieb des Routers und eventuell des Freifunk-Netzes beeinträchtigen könnte.
Mit dem Firmware-Verzeichnis als Arbeitsverzeichnis kann mittels des Befehls `./build/<target>/scripts/feeds install <paket>` ein Paket zur menuconfig hinzugefügt werden.
Mittels des schon bekannten `./buildscript config openwrt` kann das Paket dann ausgewählt werden. Es wird beim anschließenden Build zum Image hinzugefügt.
