#!/bin/bash

version="0.1.2" # wird mit --version auf der console ausgegeben
GUI=yad
filter=0

. gettext.sh

TEXTDOMAIN=noewarn
export TEXTDOMAIN
#echo $TEXTDOMAIN
TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAINDIR
#echo $TEXTDOMAINDIR

#Versionsinfo auf der Console ausgeben, dann beenden
if [[ $1 = "--version" || $1 = "-v" ]]; then
    eval_gettext "$(basename $0) version $version"; echo
    echo "Copyright 2020, 2022 Michael John
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law."
    exit
fi

if [[ $1 = "--help" || $1 = "-h" || $1 = "" ]]; then
    eval_gettext "Aufruf: $(basename $0) [OPTIONEN]"; echo
    echo -n "      -e, --einsatz          "; eval_gettext "show an overview of operations in Lower Austria (default)"; echo
    echo -n "      -f, --feuerwehren      "; eval_gettext "show deployed fire brigades in Lower Austria"; echo
    echo -n "      -r, --historie         "; eval_gettext "show deployment history in Lower Austria"; echo
    echo -n "      -h, --help             "; eval_gettext "show a summary of options"; echo
    echo -n "      -v, --version          "; eval_gettext "display program version"; echo
#      --file DATEI           diese Benutzerkonfigurationsdatei verwenden
    eval_gettext "The output can be additionally filtered with \`grep\` and/or monitored with \`watch\`."; echo
    exit
fi

#Überprüfen ob der User root ist
#if (( $EUID != 0 )); then
#    echo "Please run as root"
#    $($GUI --error --width=200 --title "myservers - Fehler" --text "Please run as root" 2> >(grep -v 'GtkDialog' >&2))
#    exit
#fi

#Überprüfen ob yad installiert ist
#Später durch detect_gui() ersetzen
#if ! [ -x "$(command -v yad)" ]; then
#    echo 'Error: yad is not installed.' >&2
#    exit 1
#fi

#echo "$(basename $0) version $version"
#echo

if [[ $1 = "--file" ]]; then
	if [[ $2 = "" ]]; then
		eval_gettext "No file given, exiting."; echo
		exit
	else
		file=$2
	fi
else
	#file="$HOME/einsatzdoku.conf"
	file="./einsatzdoku.conf"
fi

#url="https://www.feuerwehr-krems.at/ShowArtikelSpeed.asp?Artikel=4284"
url="https://www.feuerwehr-krems.at/codepages/wastl/wastlmain/Land_EinsatzAktuell.asp"

#if [[ $1 = "" ]]; then
#	url="https://www.feuerwehr-krems.at/codepages/wastl/wastlmain/Land_EinsatzAktuell.asp"
#fi

if [[ $1 = "-e" || $1 = "--einsatz" ]]; then
	url="https://www.feuerwehr-krems.at/codepages/wastl/wastlmain/Land_EinsatzAktuell.asp"
fi
if [[ $1 = "-f" || $1 = "--feuerwehren" ]]; then
	url="https://www.feuerwehr-krems.at/codepages/wastl/wastlmain/Land_FFimEinsatz.asp"
fi
if [[ $1 = "-r" || $1 = "--historie" ]]; then
	url="https://www.feuerwehr-krems.at/CodePages/Wastl/WastlMain/Land_EinsatzHistorie.asp"
fi

file=$(mktemp)
curl $url -o $file 2> /dev/null

temp=$(mktemp)
cat $file | sed 's/< /\&lt; /g' > $temp

#echo $file

#echo "cat //html/body/table" |  xmllint --html $temp | sed '/^\/ >/d' | \
#    sed 's/<[^>]*.//g' | tr -d '\n' | awk -F"-------" '{print $1,$2}' | \

xmllint --xpath "//html/body/table/tr" --html $temp | sed 's/ BSW/BSW/g' | awk '{gsub(/<[^>]*>/,";"); print }' | sed 's/&lt;/</g' | column -s';' -t \

#        while IFS= read -r value1 value2
#        do
#            # Do whatever with the values extracted
#        done

