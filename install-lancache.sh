#!/bin/bash
## Set variables
lc_base_folder=/usr/local/lancache
lc_git=/usr/local/temp
lc_nginx_loc=/etc/nginx
lc_srv_loc=/srv/lancache
lc_unbound_loc=/etc/unbound
lc_date=$( date +"%m-%d-%y %T" )
lc_hn=$( hostname )
lc_int_log=interface_used.log
lc_list_int=$( ls /sys/class/net )
lc_ip_googledns1=8.8.8.8
lc_ip_googledns2=8.8.4.4
lc_ip_logfile=ip.log
lc_ip_gw=$( /sbin/ip route | awk '/default/ { print $3 }' )
apt-get install net-tools -y
#rm old lancache files
rm /usr/local/lancache -Rvf
rm /usr/local/lancache -Rvf


#Get Lancache Files from github keep track of the location where you download the files to
git clone -b master http://github.com/nexusofdoom/lancache-installer "$lc_git"
mv "$lc_git" "$lc_base_folder"
## Create the necessary folders
mkdir -p $lc_base_folder/config/
mkdir -p $lc_base_folder/data/
mkdir -p $lc_base_folder/logs/
#Get Lancache Files
chown -R $USER:$USER $lc_base_folder
#--------tested so far april 2nd 2018


## Divide the ip in variables
lc_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
lc_eth_int=$( ip route get 8.8.8.8 | awk '{print $5}' )
lc_eth_netmask=$( ifconfig enp0s3 | grep inet | grep netmask | cut -f13 -d ' ' )
lc_eth_net=$(ip -4 addr show enp0s3 | grep -oP "(?<=inet ).*(?=br)" )
lc_ip_p1=$(echo ${lc_ip} | tr "." " " | awk '{ print $1 }')
lc_ip_p2=$(echo ${lc_ip} | tr "." " " | awk '{ print $2 }')
lc_ip_p3=$(echo ${lc_ip} | tr "." " " | awk '{ print $3 }')
lc_ip_p4=$(echo ${lc_ip} | tr "." " " | awk '{ print $4 }')

## Increment the last IP digit for every Game
lc_incr_steam=$((lc_ip_p4+1))
lc_ip_steam=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_steam

lc_incr_riot=$((lc_ip_p4+2))
lc_ip_riot=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_riot

lc_incr_blizzard=$((lc_ip_p4+3))
lc_ip_blizzard=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_blizzard

lc_incr_hirez=$((lc_ip_p4+4))
lc_ip_hirez=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_hirez

lc_incr_origin=$((lc_ip_p4+5))
lc_ip_origin=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_origin

lc_incr_sony=$((lc_ip_p4+6))
lc_ip_sony=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_sony

lc_incr_microsoft=$((lc_ip_p4+7))
lc_ip_microsoft=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_microsoft

lc_incr_enmasse=$((lc_ip_p4+8))
lc_ip_enmasse=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_enmasse

lc_incr_gog=$((lc_ip_p4+9))
lc_ip_gog=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_gog

lc_incr_arena=$((lc_ip_p4+10))
lc_ip_arena=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_arena

lc_incr_wargaming=$((lc_ip_p4+11))
lc_ip_wargaming=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_wargaming

lc_incr_uplay=$((lc_ip_p4+12))
lc_ip_uplay=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_uplay

lc_incr_apple=$((lc_ip_p4+13))
lc_ip_apple=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_apple

lc_incr_glyph=$((lc_ip_p4+14))
lc_ip_glyph=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_glyph

lc_incr_zenimax=$((lc_ip_p4+15))
lc_ip_zenimax=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_zenimax

lc_incr_digitalextremes=$((lc_ip_p4+16))
lc_ip_digitalextremes=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_digitalextremes

lc_incr_pearlabyss=$((lc_ip_p4+17))
lc_ip_pearlabyss=$lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_incr_pearlabyss

## Put IP's in the log file
echo [ lc_date ] Information !!! >>$lc_base_folder/logs/$lc_ip_logfile
echo IP addresses being used: >>$lc_base_folder/logs/$lc_ip_logfile
echo >>$lc_base_folder/logs/$lc_ip_logfile
echo IP for $lc_eth_int is $lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4 >>$lc_base_folder/logs/$lc_ip_logfile
echo Netmask for $lc_eth_int is $lc_eth_netmask >>$lc_base_folder/logs/$lc_ip_logfile
echo >>$lc_base_folder/logs/$lc_ip_logfile
echo Arena: $lc_ip_arena >>$lc_base_folder/logs/$lc_ip_logfile
echo Apple: $lc_ip_apple >>$lc_base_folder/logs/$lc_ip_logfile
echo Blizzard: $lc_ip_blizzard >>$lc_base_folder/logs/$lc_ip_logfile
echo GOG: $lc_ip_glyph >>$lc_base_folder/logs/$lc_ip_logfile
echo GOG: $lc_ip_gog >>$lc_base_folder/logs/$lc_ip_logfile
echo Hirez: $lc_ip_hirez >>$lc_base_folder/logs/$lc_ip_logfile
echo Microsoft: $lc_ip_microsoft >>$lc_base_folder/logs/$lc_ip_logfile
echo Origin: $lc_ip_origin >>$lc_base_folder/logs/$lc_ip_logfile
echo Riot: $lc_ip_riot >>$lc_base_folder/logs/$lc_ip_logfile
echo Steam: $lc_ip_steam >>$lc_base_folder/logs/$lc_ip_logfile
echo Sony: $lc_ip_sony >>$lc_base_folder/logs/$lc_ip_logfile
echo Enmasse: $lc_ip_enmasse >>$lc_base_folder/logs/$lc_ip_logfile
echo Uplay: $lc_ip_uplay >>$lc_base_folder/logs/$lc_ip_logfile
echo Wargaming: $lc_ip_wargaming >>$lc_base_folder/logs/$lc_ip_logfile
echo Zenimax: $lc_ip_zenimax >>$lc_base_folder/logs/$lc_ip_logfile
echo Digitalextremes: $lc_ip_digitalextremes >>$lc_base_folder/logs/$lc_ip_logfile
echo Pearlabyss: $lc_ip_pearlabyss >>$lc_base_folder/logs/$lc_ip_logfile

#unbound setup
## Preparing configuration for unbound
#mkdir -p /$lc_base_folder/unbound/
sed -i 's|lc-host-ip|'$lc_ip'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-gw|'$lc_ip_gw'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/etc/unbound/unbound.conf
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/etc/unbound/unbound.conf

#copy config for unbound into folder
cp $lc_base_folder/etc/unbound/unbound.conf /etc/unbound/unbound.conf

#Replace the interfaces: section with the normal ip (not the virtual ones)
#Replace all "A records" with the appropriate IPs (the virtual IPs for the appropriate caching service like in hosts file)

## Make the Necessary Changes For The New Host File
sed -i 's|lc-hostname|'$lc_hn'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/etc/hosts
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/etc/hosts

## Make the Necessary Changes For The New Interfaces File
sed -i 's|lc-host-ip|'$lc_ip'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i "s^lc-host-network^$lc_eth_net^g" $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-gateway|'$lc_ip_gw'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-arena|'$lc_ip_arena'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-apple|'$lc_ip_apple'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-blizzard|'$lc_ip_blizzard'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-hirez|'$lc_ip_hirez'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-gog|'$lc_ip_gog'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-glyph|'$lc_ip_glyph'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-microsoft|'$lc_ip_microsoft'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-origin|'$lc_ip_origin'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-riot|'$lc_ip_riot'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-steam|'$lc_ip_steam'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-sony|'$lc_ip_sony'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-enmasse|'$lc_ip_enmasse'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-uplay|'$lc_ip_uplay'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-wargaming|'$lc_ip_wargaming'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-zenimax|'$lc_ip_zenimax'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-digitalextremes|'$lc_ip_digitalextremes'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-pearlabyss|'$lc_ip_pearlabyss'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-netmask|'$lc_eth_netmask'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml
sed -i 's|lc-host-vint|'$lc_eth_int'|g' $lc_base_folder/etc/netplan/01-netcfg.yaml


#Making Directorys for Data and Logs
echo making srv directorys
mkdir -p /srv/lancache/data/blizzard/
mkdir -p /srv/lancache/data/microsoft/
mkdir -p /srv/lancache/data/installs/
mkdir -p /srv/lancache/data/other/
mkdir -p /srv/lancache/data/tmp/
mkdir -p /srv/lancache/data/hirez/
mkdir -p /srv/lancache/data/origin/
mkdir -p /srv/lancache/data/riot/
mkdir -p /srv/lancache/data/gog/
mkdir -p /srv/lancache/data/sony/
mkdir -p /srv/lancache/data/steam/
mkdir -p /srv/lancache/data/wargaming
mkdir -p /srv/lancache/data/arenanetworks
mkdir -p /srv/lancache/data/uplay
mkdir -p /srv/lancache/data/glyph
mkdir -p /srv/lancache/data/zenimax
mkdir -p /srv/lancache/data/digitalextremes
mkdir -p /srv/lancache/data/pearlabyss
mkdir -p /srv/lancache/logs/Errors
mkdir -p /srv/lancache/logs/Keys
mkdir -p /srv/lancache/logs/Access

#Change Ownership of folders
chown -R www-data:www-data /srv/lancache
#chmod -R 777 /srv/lancache

#######
#Copy the conf folder and contents (where you originally git cloned it to in step 3) to /usr/local/nginx/conf/
#cp -R $lc_base_folder/etc/nginx /etc/

#######
## Change the Proxy Bind in Lancache Configs
#sed -i 's|lc-host-proxybind|'$lc_ip'|g' $lc_nginx_loc/sites-available/*.conf

## Moving Base Files to The Correct Locations
if [ -f "$lc_base_folder/etc/hosts" ]; then
	mv /etc/hosts /etc/hosts.bak
	cp $lc_base_folder/etc/hosts /etc/hosts
fi

if [ -f "$lc_base_folder/etc/netplan/01-netcfg.yaml" ]; then
	mv /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak
	cp $lc_base_folder/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
fi


# Updating local DNS resolvers
echo "nameserver $lc_ip_googledns1" > /etc/resolv.conf
echo "nameserver $lc_ip_googledns2" >> /etc/resolv.conf

#IP address for services
## Put IP's in the log file
echo "##########################################################################"
echo Main network interface information
echo IP $lc_ip_p1.$lc_ip_p2.$lc_ip_p3.$lc_ip_p4 
echo Netmask$lc_eth_netmask 
echo "##########################################################################"
echo IP address used for services.
echo Arena: $lc_ip_arena 
echo Apple: $lc_ip_apple 
echo Blizzard: $lc_ip_blizzard 
echo GOG: $lc_ip_glyph 
echo GOG: $lc_ip_gog 
echo Hirez: $lc_ip_hirez 
echo Microsoft: $lc_ip_microsoft 
echo Origin: $lc_ip_origin 
echo Riot: $lc_ip_riot 
echo Steam: $lc_ip_steam 
echo Sony: $lc_ip_sony 
echo Enmasse: $lc_ip_enmasse 
echo Uplay: $lc_ip_uplay 
echo Wargaming: $lc_ip_wargaming 
echo Zenimax: $lc_ip_zenimax 
echo Digitalextremes: $lc_ip_digitalextremes 
echo Pearlabyss: $lc_ip_pearlabyss 
echo "##########################################################################"


echo "##########################################################################"
echo Lancache Installed pleae reboot and check services ,nginx,unbound,sniproxy
echo "##########################################################################"
