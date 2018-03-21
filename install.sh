#!/data/data/com.termux/files/usr/bin/bash
# https://github.com/EdSec

echo '''

 [+] INSTALANDO METASPLOIT . . .

'''

sleep 2

apt install autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config postgresql-contrib wget make ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses unzip zip tar postgresql -y
apt update
apt upgrade
cd
curl -LO https://github.com/rapid7/metasploit-framework/archive/4.16.4.tar.gz
tar -xf $HOME/4.16.4.tar.gz
rm $HOME/4.16.4.tar.gz
cd $HOME/metasploit-framework-4.16.4
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock
gem install nokogiri -v 1.8.0 -- --use-system-libraries
sed 's|grpc (.*|grpc (1.4.1)|g' -i $HOME/metasploit-framework-4.16.4/Gemfile.lock
gem unpack grpc -v 1.4.1
cd grpc-1.4.1
curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
curl -L https://raw.githubusercontent.com/Hax4us/Hax4us.github.io/master/extconf.patch
patch -p1 < extconf.patch
gem build grpc.gemspec
gem install grpc-1.4.1.gem
cd ..
rm -r grpc-1.4.1
cd $HOME/metasploit-framework-4.16.4
bundle install -j5
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
ln -s $HOME/metasploit-framework-4.16.4/msfconsole /data/data/com.termux/files/usr/bin/

cd $HOME
mv metasploit-framework-4.16.4 metasploit
cd metasploit

echo '''

 ::::::::::::::::::::::::::::::::::::::::::

 [+] Metasploit instalado!

 [+] Para inciar, digite:  msfconsole

 ::::::::::::::::::::::::::::::::::::::::::


'''
