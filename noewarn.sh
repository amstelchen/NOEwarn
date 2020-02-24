#!/bin/bash

version="0.1.1" # wird mit --version auf der console ausgegeben
GUI=yad
filter=0

#Versionsinfo auf der Console ausgeben, dann beenden
if [[ $1 = "--version" || $1 = "-v" ]]; then
    echo "$(basename $0) version $version"
    echo "Copyright 2020 Michael John
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law."
    exit
fi

if [[ $1 = "--help" || $1 = "-h" || $1 = "" ]]; then
    echo "Aufruf: $(basename $0) [OPTIONEN]
      -e, --einsatz          zeige Einsatzüberblick in NÖ (default)
      -f, --feuerwehren      zeige eingesetzte Feuerwehren in NÖ
      -r, --historie         zeige Einsatzrückblick in NÖ
      -h, --help             zeige eine Kurzfassung des Aufrufs
      -v, --version          zeige Programmversion an"
#      --file DATEI           diese Benutzerkonfigurationsdatei verwenden
    echo "Die Ausgabe kann zusätzlich mit \`grep\` gefiltert und/oder mit \`watch\` überwacht werden."
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
		echo "no file given, exiting."
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

