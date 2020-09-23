FROM python:3.8.3

# Get the ODBC driver for Microsoft SQL Server
RUN apt-get update \
&& apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
&& curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
&& curl https://packages.microsoft.com/config/debian/10/prod.list  > /etc/apt/sources.list.d/mssql-release.list \
&& apt-get update \
&& ACCEPT_EULA=Y apt-get -y install --no-install-recommends msodbcsql17 \
&& ACCEPT_EULA=Y apt-get -y install mssql-tools \
    unixodbc-dev \
    libgssapi-krb5-2 \
&& apt-get clean \
&& echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
&& echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
&& pip install pyodbc
WORKDIR /src

CMD [ "/bin/bash" ]
