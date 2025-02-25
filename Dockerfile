# Use uma imagem oficial do PHP com Apache
FROM php:8.0-apache

# Atualize os repositórios e instale as dependências necessárias
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

# Ativa o módulo rewrite do Apache (se necessário para a aplicação)
RUN a2enmod rewrite

# Cria o diretório para o HRConvert2 e copia os arquivos da aplicação para lá
# (Certifique-se de que o diretório HRConvert2 está na mesma pasta do Dockerfile)
COPY . /var/www/html/HRConvert2

# Ajusta as permissões para que o Apache (usuário www-data) possa acessar os arquivos
RUN chown -R www-data:www-data /var/www/html/HRConvert2 && \
    chmod -R 0755 /var/www/html/HRConvert2

# Exponha a porta 80
EXPOSE 80

# Define o comando padrão para iniciar o Apache
CMD ["apache2-foreground"]
