statuscheck="$(fail2ban-client status)" # get the status list of jails
cutword="Jail list:" # set a cut point in the string for future use
dirtystring="${statuscheck#*$cutword}" # get rid of all text and formatting before the cut point
dirtyishstring=$(echo "$dirtystring" | tr -d ' ') # remove spaces in the string
cleanstring=$(echo "$dirtyishstring" | xargs) # remove spaces in a different way just in case
IFS=',' read -r -a cleanlist <<< "$cleanstring" # create an array from the comma seperated stings

for item in "${cleanlist[@]}"; do
	fail2ban-client set "$item" unbanip "$bannedIp"
done
#script written by Joel Eagles