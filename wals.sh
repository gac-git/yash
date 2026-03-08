#! /usr/bin/env bash

# version: 4.0.0 2026-03-08

WALLPAPER_FOLDERS=( ""
		    ""
		    ""                    )

case $1 in

    # show paths and show if have or not setting

    ~/* | $HOME/*)
    wal -i "$1" -q
    ;;

    d | dir)
	for i in {0..2}; do
	    if [[ "${WALLPAPER_FOLDERS[i]}" == "" ]];
	       
	    then echo "none";
	    else echo "${WALLPAPER_FOLDERS[i]}";
	    fi
	done
	;;

    # show colorscheme / palette only it, pywal for some reason add text and a \n

    p | preview)
	wal --preview | sed '1,2d' | sed '$d';
	;;

    # if uses wal's export colors.sh, we can show what

    # know bug: output a empty location and show root premission
    wp | wallpaper)
	echo $wallpaper;
	;;

    # change wallpaper then color scheme
    
    t | theme)
	wal -i "${WALLPAPER_FOLDERS[0]}" -q --recursive;
	wal --preview | sed '1,2d' | sed '$d';
	echo $wallpaper;
	;;

    [1-3])
	wal -i "${WALLPAPER_FOLDERS[$1 -1]}" -q --recursive;
	;;

    # show images in terminal using sinx graphics

    ls | list)
	lsix "${WALLPAPER_FOLDERS[$2 -1]}"
	;;

    # count how many wallpaper which path have
    
    c | count)
	ls -R -C "${WALLPAPER_FOLDERS[$2 -1]}" | wc -l
	;;

    # set random wallpaper in WALLPAPER_FOLDER[n]

    set | get)
	# fix index be used for use 1..3 and not 0..2
	wal -i "${WALLPAPER_FOLDERS[(($2) - 1)]}" -q --recursive
	;;

    # use the WALLPAPER_FOLDERS[0] for setting wallpaper just by running without xarg
    
    "")
	wal -i "${WALLPAPER_FOLDERS[0]}" -q --recursive
	;;

    #  use the of machine's default editor, don't force someone uses vi/nano in default
    
    c | config)
	$(EDITOR) "$(pwd)/wals.sh";
	;;
    
    help | h)
	echo "
	For settings folders, edit the script array: 'WALLPAPER_FOLDERS' running: 'c' or 'config'

	Commands:
	- help, h		show this help in less
	- c, config		open/edit this script in the $EDITOR

	- t, theme		change wallpaper then show color scheme and wallpaper location
	- wp, wallpaper		show current wallpaper

	- d, dir		show paths of WALLPAPER_FOLDERS
	- p, preview 	        show actual color sheme

	- ""/NO XARG		set/get random wallpaper of WALLPAPER_FOLDER[0]
	- set, get   		set/get random wallpaper by [n]
	- [n]	    		set/get random wallpaper from path[n]

	- ls, list  [n]	 	show images in terminal using lsix
	- c, count  [n]		count wallpapers in path[n]

	" | less -c #make show in full start line
	;;

esac
