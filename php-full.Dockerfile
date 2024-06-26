FROM gitpod/workspace-full:latest

ARG PHP_VERSION=8.2

ENV PHP_VERSION=${PHP_VERSION}

RUN sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}

RUN sudo install-packages \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dba \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-igbinary \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-memcached \
    php${PHP_VERSION}-mongodb \
    php${PHP_VERSION}-msgpack \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-phpdbg \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-xdebug \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-sybase \
    unixodbc-dev libaio1

RUN sudo pecl channel-update pecl.php.net && \
    sudo pecl -d php_suffix=${PHP_VERSION} install sqlsrv && \
    sudo pecl -d php_suffix=${PHP_VERSION} install pdo_sqlsrv && \
    printf "; priority=20\nextension=sqlsrv.so\n" | sudo tee /etc/php/${PHP_VERSION}/mods-available/sqlsrv.ini && \
    printf "; priority=30\nextension=pdo_sqlsrv.so\n" | sudo tee /etc/php/${PHP_VERSION}/mods-available/pdo_sqlsrv.ini && \
    sudo phpenmod -v php${PHP_VERSION} sqlsrv && \
    sudo phpenmod -v php${PHP_VERSION} pdo_sqlsrv && \
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
    sudo ACCEPT_EULA=Y install-packages -y unixodbc msodbcsql18 mssql-tools18 && \
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc

RUN wget https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-basic-linux.x64-23.4.0.24.05.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/2340000/instantclient-sdk-linux.x64-23.4.0.24.05.zip && \
    unzip -o instantclient-basic-linux.x64-23.4.0.24.05.zip && \
    unzip -o instantclient-sdk-linux.x64-23.4.0.24.05.zip && \
    sudo mv instantclient_23_4 /usr/local/instantclient && \
    sudo sh -c "echo /usr/local/instantclient >  /etc/ld.so.conf.d/oracle-instantclient.conf" && \
    sudo ldconfig && \
    printf "instantclient,/usr/local/instantclient\n" | sudo pecl -d php_suffix=${PHP_VERSION} install oci8 && \
    printf "; priority=20\nextension=oci8.so\n" | sudo tee /etc/php/${PHP_VERSION}/mods-available/oci8.ini && \
    sudo phpenmod -v php${PHP_VERSION} oci8 && \
    rm -f instantclient-* && \
    rm -rf META-INF

