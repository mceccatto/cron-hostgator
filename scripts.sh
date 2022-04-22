#!/bin/bash

# REMOVER ARQUIVOS DE BACKUP COM MAIS DE 6 DIAS
find /home/dominio/backups/files -name "*.zip" -type f -mtime +6 -exec rm - f {} \;

# EFETUA BACKUP DE UM SITE INCLUINDO SEU BANCO DE DADOS
mysqldump -uusuario -psenha banco_de_dados | gzip > /home/dominio/public_html/banco_de_dados.sql.gz
find /home/dominio/public_html/banco_de_dados.sql.gz -type f -print0|xargs -0 chmod 700
zip -r /home/dominio/backups/files/`date +%d-%m-%Y`_public_html.zip /home/dominio/public_html
rm -f /home/dominio/public_html/banco_de_dados.sql.gz

# EFETUA ALTERAÇÃO NO ACESSO DA PASTA COMPACTADOS
find /home/dominio/backups/files -type f -print0|xargs -0 chmod 700

# EFETUA DESCOMPACTAÇÃO DE UM BACKUP PARA UMA PASTA DESTINO
unzip -o /home/dominio/backups/restore/00-00-0000_public_html.zip -d /home/dominio/public_html/