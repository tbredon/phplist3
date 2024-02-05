
## Vagrant allows running the Behat tests locally, with different versions of PHP
## to use, run "vagrant init" once and "vagrant plugin install vagrant-docker-compose"
## and after that "vagrant up" to run the tests
## to start from scratch run "vagrant destroy" and then "vagrant up"
## to change the version of PHP being used change the line 
#      PHPVERSION=7.0
## below

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "public_network"

  config.vm.provider "virtualbox" do |v|
      v.memory = 10640
      v.cpus = 2
  end

  config.vm.provision :shell,
    keep_color: true,
    privileged: true,
    run: "always",
    inline: <<-SCRIPT
      cd /vagrant
      PHPVERSION=7.4
      apt install software-properties-common
      add-apt-repository ppa:ondrej/php
      DEBIAN_FRONTEND=noninteractive apt update
      DEBIAN_FRONTEND=noninteractive apt install -y make mariadb-client mariadb-server postfix chromium-chromedriver firefox openjdk-8-jre-headless fonts-liberation xdg-utils 
      DEBIAN_FRONTEND=noninteractive apt install -y php${PHPVERSION} php${PHPVERSION}-mbstring php${PHPVERSION}-curl php${PHPVERSION}-mysql php${PHPVERSION}-xml php${PHPVERSION}-zip 

      [[ ! -f /usr/bin/geckodriver ]] && {
        wget https://github.com/mozilla/geckodriver/releases/download/v0.29.0/geckodriver-v0.29.0-linux64.tar.gz
        tar zxf geckodriver-v0.29.0-linux64.tar.gz
        mv geckodriver /usr/bin/
      }
      update-alternatives --set php /usr/bin/php$PHPVERSION
      update-alternatives --set phar /usr/bin/phar$PHPVERSION
      update-alternatives --set phar.phar /usr/bin/phar.phar$PHPVERSION
      [[ ! -z $(which google-chrome) ]] || {
        [[ ! -f google-chrome-stable_current_amd64.deb ]] && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        dpkg -i google-chrome-stable_current_amd64.deb
      }
      google-chrome --version
      rm -rf vendor
      bin/update-composer.sh
      sudo -u vagrant php composer.phar update
      ln -s /vagrant/vendor/bin/chromedriver /usr/local/bin/chromedriver
      ln -s /vagrant/vendor/bin/geckodriver /usr/local/bin/geckodriver
      service postfix stop
      service apache2 stop
      service mysqld start
      cp -fv tests/ci/config.php public_html/lists/config/config.php
      cp -fv tests/ci/behat.yml tests/behat.yml
      [[ ! -d public_html/lists/admin/ui/phplist-ui-bootlist ]] && { 
        cd public_html/lists/admin/ui/ 
        wget https://github.com/phpList/phplist-ui-bootlist/archive/master.tar.gz
        tar -xzf master.tar.gz 
        mv phplist-ui-bootlist-master phplist-ui-bootlist
        rm master.tar.gz 
        cd /vagrant
      }
      (echo >/dev/tcp/localhost/80) &>/dev/null || {
        php -S 0.0.0.0:80 -t public_html > phpserver.log 2>&1 &
      }
      (echo >/dev/tcp/localhost/4444) &>/dev/null || {
        vendor/bin/selenium-server-standalone -p 4444 -Dwebdriver.chrome.driver="/usr/bin/chromedriver" -Dwebdriver.gecko.driver="/usr/bin/geckodriver" &
      }
      mkdir -p tests/build/mails
      cd tests/build/mails
      (echo >/dev/tcp/localhost/2500) &>/dev/null || {
        smtp-sink -u vagrant -d "%d.%H.%M.%S" localhost:2500 1000 &
      }
      cd ../../
      make test
    SCRIPT
end
