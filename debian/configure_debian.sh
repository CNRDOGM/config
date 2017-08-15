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
    apt-get update
    apt-get -y upgrade
    # ---------------------------------------------------
    #git
	if [ ! `which git` ]; then
	  sudo apt-get install -y git
	fi

	mkdir -p $HOME/bin
	mkdir -p $HOME/bin/R

	cat <<EOF >> $HOME/.bashrc

	
	if [ -d "\$HOME/bin" ] ; then
	    export PATH="\$HOME/bin:\$PATH"
	fi


	EOF

	source $HOME/.bashrc
	cd $HOME/bin

	git clone https://github.com/CNRDOGM/config.git

    #replace /etc/apt/source.list
    cp config/apt/sources.list /etc/apt/sources.list
    apt-get update && apt-get upgrade
    apt-get -y install deb-multimedia-keyring

    #CRAN.itam.mx
    apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480
    apt-get update
    apt-get -y install r-base r-base-dev

    #Compilación
    apt-get -y install linux-headers-$(uname -r) build-essential checkinstall make automake cmake autoconf g++
    apt-get -y install task-gnome-desktop gdm3
:<<'END'
    apt-get -y install synaptic firmware-linux terminator htop mc vim libdvdcss2 bash-completion
    apt-get -y install gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-fluendo-mp3 gstreamer0.10-pulseaudio
    apt-get -y install libgstreamer-perl libgstreamer-interfaces-perl w64codecs
    apt-get -y install openjdk-8-jre openjdk-8-jdk 
    apt-get -y install rar unrar zip unzip unace bzip2 lzop p7zip-full p7zip-rar
    apt-get -y install ttf-freefont ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu ttf-liberation fdupes
    fc-cache -fv
    apt-get -y install inkscape gimp kolourpaint4 firefox-esr firefox-esr-l10n-es-mx smplayer clementine
    apt-get -y install blueman python-pip krename gparted pdftk tree parallel rubygems samtools python-h5py binfmt-support
    apt-get -y install python-dev libncurses5-dev libssl-dev libzmq-dev libgsl0-dev libxml2 libxslt1.1 libxslt1-dev ant zlib1g-dev libpng12-dev libfreetype6-dev mpich2 libreadline-dev gfortran unzip libmysqlclient18 libmysqlclient-dev ghc sqlite3 libsqlite3-dev libc6-i386 libbz2-dev tcl-dev tk-dev libatlas-dev libatlas-base-dev liblapack-dev swig libhdf5-serial-dev
    apt-get -y install python-biopython r-cran-abind r-cran-colorspace r-cran-dichromat r-cran-digest r-cran-domc r-cran-foreach r-cran-ggplot2 r-cran-gtable r-cran-iterators r-cran-labeling r-cran-mapproj r-cran-maps r-cran-multicore r-cran-munsell r-cran-pkgkitten r-cran-plyr r-cran-proto r-cran-rcolorbrewer r-cran-rcpp r-cran-reshape2 r-cran-scales r-cran-sp r-cran-stringr
    apt-get -y install emboss jemboss bedtools pymol firmware-linux-nonfree firmware-realtek openssh-server network-manager network-manager-gnome
    apt-get -y install nodejs npm libappindicator1 python-dev python3-dev libcurl4-openssl-dev libv8-3.14-dev  libssl-dev libxml2-dev


    #Edit /etc/NetworkManager/NetworkManager.conf
    [ifupdown]
    managed=false #change to 'true'
END
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
