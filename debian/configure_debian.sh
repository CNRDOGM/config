#!/bin/bash
root_uid="0"
#Checking if you have super cow powers
if [ "$UID" -ne "$root_uid" ] ; then
    echo "You must be root to run this script!"
    echo "su -c './post_install'"
exit 1
fi

echo "# -------------------------------------------------------"
echo "#"
echo "#  Debian 9 netinstall post-installation script"
echo "#"
echo "# -------------------------------------------------------"
echo
echo "This thing may take several minutes"
echo
echo "Do you want to continue (y/n)?"
echo
read yes

if [ "$yes" = "y" ]
    then
    # --------------- Full System Update ----------------
    apt-get -y update
    apt-get -y upgrade
    # ---------------------------------------------------
    #git
    apt-get -y install git git-core bash-completion
    git clone http://github.com/z0rbax/config

    #replace /etc/apt/source.list
    cp config/apt/sources.list /etc/apt/sources.list
    apt-get update && apt-get upgrade
    apt-get install deb-multimedia-keyring

    #CRAN.itam.mx
    apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480
    apt-get update
    apt-get install r-base r-base-dev

    #Repository spotify
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    apt-get update
    apt-get install spotify-client

    #Repos.fds-team.de

    #Compilación
    apt-get install linux-headers-$(uname -r) build-essential checkinstall make automake cmake autoconf
    apt-get install mate-desktop-environment-core mate-desktop-environment-extras
    apt-get install shiki-brave-theme
    apt-get install lightdm
    #Edit nano /etc/lightdm/lightdm.conf, uncomment greeter-hide-users=false


    service lightdm start

    apt-get install synaptic
    apt-get install firmware-linux
    apt-get install terminator htop mc moc moc-ffmpeg-plugin vim
    apt-get install libdvdcss2
    apt-get install gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-fluendo-mp3 gstreamer0.10-pulseaudio
    apt-get install libgstreamer-perl libgstreamer-interfaces-perl
    apt-get install w64codecs
    aptitude install openjdk-7-jre
    apt-get install rar unrar zip unzip unace bzip2 lzop p7zip-full p7zip-rar
    apt-get install ttf-freefont ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu ttf-liberation fdupes
    fc-cache -fv
    apt-get install inkscape gimp kolourpaint4 iceweasel iceweasel-l10n-es-mx smplayer clementine brasero
    apt-get install blueman python-pip krename gparted pdftk tree parallel rubygems samtools python-h5py binfmt-support
    apt-get install python-dev libncurses5-dev libssl-dev libzmq-dev libgsl0-dev openjdk-7-jdk libxml2 libxslt1.1 libxslt1-dev ant git subversion build-essential zlib1g-dev libpng12-dev libfreetype6-dev mpich2 libreadline-dev gfortran unzip libmysqlclient18 libmysqlclient-dev ghc sqlite3 libsqlite3-dev libc6-i386 libbz2-dev tcl-dev tk-dev r-base r-base-dev libatlas-dev libatlas-base-dev liblapack-dev swig libhdf5-serial-dev
    apt-get install python-biopython r-cran-abind r-cran-colorspace r-cran-dichromat r-cran-digest r-cran-domc r-cran-foreach r-cran-ggplot2 r-cran-gtable r-cran-iterators r-cran-labeling r-cran-mapproj r-cran-maps r-cran-multicore r-cran-munsell r-cran-pkgkitten r-cran-plyr r-cran-proto r-cran-rcolorbrewer r-cran-rcpp r-cran-reshape2 r-cran-scales r-cran-sp r-cran-stringr
    pip install numpy
    pip install qiime
    apt-get install emboss jemboss bedtools pymol firmware-linux-nonfree firmware-realtek openssh-server network-manager network-manager-gnome
    apt-get install nodejs npm libappindicator1 python-dev python3-dev libcurl4-openssl-dev libv8-3.14-dev  libssl-dev libxml2-dev
     npm insall -g vtop

#Config mysql to biosql
    apt-get install php5-mysql phpmyadmin mysql-server
#    cp /etc/mysql/my.cnf /etc/my.cnf

#mysqladmin -u root create bioseqdb
#cat biosqldb-mysql.sql | sed 's/TYPE=INNODB/ENGINE=INNODB/g' > tmp.sql
#mv tmp.sql  biosqldb-mysql2.sql
#mysql -u root -p bioseqdb < biosqldb-mysql2.sql


    #Edit /etc/NetworkManager/NetworkManager.conf
    [ifupdown]
    managed=false #change to 'true'

    #kanjis
    aptitude install ttf-kochi-mincho ttf-baekmuk

    #instapp ppa Ubuntus
    apt-get install software-properties-common python-software-properties
    add-apt-repository ppa:varlesh-l/papirus-pack
    apt-get update
    apt-get install libreoffice-style-papirus smplayer-skin-papirus papirus-gtk-icon-theme

    #edit /etc/apt/sources.list.d/varlesh-l-papirus-pack-jessie.list
    # ubuntu trusty main

    #Delete old ssh-keys when hostkey has changed
    #ssh-keygen -f "/home/zorbax/.ssh/known_hosts" -R 148.247.152.169

    echo
    echo
    echo "########"
    echo "  DONE  "
    echo "########"
    echo
    echo
else
    exit
fi;
