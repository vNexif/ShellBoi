#! /bin/bash


clear


function getIPs {
	{
	ips=$(ip a | grep "inet" | awk '{print "\n", $2} "\n"')
        echo 50
	sleep 1
        result="Interface ips: $ips"
	echo $result > result
	} | whiptail --gauge "Getting data ..." 6 60 0
}

function IntIPs {
	{
	echo "Interface IPs" > title
	ints=$((cat /proc/net/fib_trie | grep "|--" | egrep -v "0.0.0.0| 127.") | awk '{print $2}')
	echo 100
	echo $ints > result
	} | whiptail --gauge "Getting data ..." 6 60 50
}

while [ 1 ]
do
CHOICE=$(
whiptail --title "Operative Systems" --menu "Make your choice" 16 100 9 \
	"1)" "The name of this script."   \
	"2)" "Time since last boot."  \
	"9)" "End script"  3>&2 2>&1 1>&3	
)

case $CHOICE in
	"1)")   

		IntIPs

		read -r title < title
		read -r result < result
        ;;

	"9)") exit
        ;;
esac
whiptail --msgbox "$result" --title "$title" 20 78
done
exit