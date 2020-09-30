#!/bin/bash

base=devteam504
tabla=speakers

echo -n "Crear base de datos $base..."
if ! mysql -e "SHOW DATABASES;" | grep -q $base; then
  mysql -e "CREATE DATABASE $base;"
  echo "Hecho."
else
  echo "Ya."
fi

echo -n "Crear tabla $tabla en base de datos $base..."
if ! mysql $base -e "SHOW TABLES;" | grep -q $tabla; then
  mysql $base -e "CREATE TABLE $tabla ( id smallint unsigned not null auto_increment, usuario varchar(20) not null unique, clave varchar(80) not null, nombre varchar(200) not null, constraint pk_id primary key (id) );"
  echo "Hecho."
else
  echo "Ya."
fi
