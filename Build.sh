#!/usr/bin/env bash

#Verify in TmuxRecon directory
if [[ "$(pwd | awk -F"/" '{print$NF}')" != "TmuxRecon" ]]; then
	echo "You must be in the TmuxRecon directory to run this script (case sensitive)."
	exit 1
fi

cat <<'END'
TmuxRecon is installing...
END

if [[ ! -d 'dirsearch' ]]; then git clone https://github.com/maurosoria/dirsearch.git; fi
chmod -R 755 dirsearch/

rm /usr/bin/TmuxRecon 2> /dev/null
ln -s "$PWD/TmuxRecon.py" "/usr/bin/TmuxRecon"

apt update
apt-get install gobuster seclists dconf-cli g++ pip libreoffice smtp-user-enum leafpad enum4linux smbmap -y
wait
python3 -m pip install pandasql psutil

if [ -f "/usr/share/wordlists/rockyou.txt.gz" ] || [ ! -f "/usr/share/wordlists/rockyou.txt" ]
then
	gzip -d /usr/share/wordlists/rockyou.txt.gz
fi

wordlists=("/usr/share/wordlists/rockyou.txt" "/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt" "/usr/share/dirbuster/wordlists/directory-list-2.3-small.txt" "/usr/share/seclists/Usernames/Names/names.txt")
for wordlist in "${wordlists[@]}"
do
    if [[ ! -f "$wordlist" ]]
    then
        echo "#"
        echo "#"
        echo "#"
        echo "You are going to want to install $wordlist"
        echo "#"
        echo "#"
        echo "#"
    fi
done
chown 0 -R ./*
chmod +x -R *
