#!/bin/sh
set -e

cd $(dirname "$0")
ICON_DIR=tf/custom/better-kill-icons
HUD_DIR=tf/custom/FlawHUD
mkdir -p "$ICON_DIR" "$HUD_DIR" tf dld

rsync -a mastercomfig-tf/ tf/

# FlawHUD
if ! [ -f 'dld/flawhud.zip' ]; then
	wget https://tf2huds.dev/hud/FlawHUD/static/FlawHUD-02f4c51.zip -O dld/flawhud.zip
	7z x dld/flawhud.zip -o"$HUD_DIR"
fi
# Better Kill Icons https://gamebanana.com/mods/406361
if ! [ -f 'dld/icons.rar' ]; then
	wget https://gamebanana.com/dl/760014 -O dld/icons.rar
	unrar e dld/icons.rar -y -op "$ICON_DIR"
fi

slot () {
	sed "s/THIS/$1/; s/NEXT/$2/; s/PREV/$3/; s/RED/$4/; s/GREEN/$5/; s/BLUE/$6/" \
		templates/slot.cfg > "tf/cfg/slot-$1.cfg"
}
slot 1 3 2 255 0 255
slot 2 1 3 0 255 0
slot 3 2 1 255 255 0

sed 's/TEAM/-2/; s/OTHERSCRIPT/alt/' templates/spy.cfg > tf/cfg/spy-same.cfg
sed 's/TEAM/-1/; s/OTHERSCRIPT/same/' templates/spy.cfg > tf/cfg/spy-alt.cfg

cp cfg/* tf/cfg
