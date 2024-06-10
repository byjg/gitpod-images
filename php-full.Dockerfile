FROM gitpod/workspace-full:latest

RUN sudo update-alternatives --set php /usr/bin/php8.2

RUN sudo install-packages \
    unixodbc-dev libaio1 \
    php8.2-dev \
    php8.2-cli \
    php8.2-curl \
    php8.2-dba \
    php8.2-dev \
    php8.2-gd \
    php8.2-igbinary \
    php8.2-imagick \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-memcached \
    php8.2-mongodb \
    php8.2-msgpack \
    php8.2-mysql \
    php8.2-opcache \
    php8.2-pgsql \
    php8.2-phpdbg \
    php8.2-readline \
    php8.2-redis \
    php8.2-soap \
    php8.2-sqlite3 \
    php8.2-xdebug \
    php8.2-xml


RUN sudo pecl channel-update pecl.php.net && \
    sudo pecl -d php_suffix=8.2 install sqlsrv && \
    sudo pecl -d php_suffix=8.2 install pdo_sqlsrv && \
    printf "; priority=20\nextension=sqlsrv.so\n" | sudo tee /etc/php/8.2/mods-available/sqlsrv.ini && \
    printf "; priority=30\nextension=pdo_sqlsrv.so\n" | sudo tee /etc/php/8.2/mods-available/pdo_sqlsrv.ini && \
    sudo phpenmod -v php8.2 sqlsrv && \
    sudo phpenmod -v php8.2 pdo_sqlsrv

RUN wget https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-basic-linux.x64-23.4.0.24.05.zip && \
    wget wget https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-sdk-linux.x64-23.4.0.24.05.zip && \
    unzip -o instantclient-basic-linux.x64-23.4.0.24.05.zip && \
    unzip -o instantclient-sdk-linux.x64-23.4.0.24.05.zip && \
    sudo mv instantclient_23_4 /usr/local/instantclient && \
    sudo sh -c "echo /usr/local/instantclient >  /etc/ld.so.conf.d/oracle-instantclient.conf" && \
    sudo ldconfig && \
    printf "instantclient,/usr/local/instantclient\n" | sudo pecl -d php_suffix=8.2 install oci8 && \
    printf "; priority=20\nextension=oci8.so\n" | sudo tee /etc/php/8.2/mods-available/oci8.ini && \
    sudo phpenmod -v php8.2 oci8 && \
    rm -f instantclient-*

