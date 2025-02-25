# Use uma imagem base do PHP com Apache
FROM php:8.0-apache

# Adiciona repositórios non-free ao sources.list
RUN echo "deb http://deb.debian.org/debian bullseye main non-free" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian-security bullseye-security main non-free" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bullseye-updates main non-free" >> /etc/apt/sources.list

# Atualiza e instala as dependências necessárias
RUN apt-get update && apt-get install -y \
    libreoffice-core \
    libreoffice-java-common \
    unoconv \
    default-jre \
    clamav \
    rar \
    unrar \
    p7zip-full \
    imagemagick \
    tesseract-ocr \
    ffmpeg \
    poppler-utils \
    meshlab \
    dia \
    pandoc \
    mkisofs \
    nodejs \
    gnuplot \
 && rm -rf /var/lib/apt/lists/*

# Ativa o módulo rewrite do Apache (se necessário)
RUN a2enmod rewrite

# Copia os arquivos da aplicação para o diretório do Apache
COPY . /var/www/html/HRConvert2

# Ajusta as permissões para o usuário do Apache
RUN chown -R www-data:www-data /var/www/html/HRConvert2 && \
    chmod -R 0755 /var/www/html/HRConvert2

# Exponha a porta 80
EXPOSE 80

# Comando padrão para iniciar o Apache
CMD ["apache2-foreground"]
