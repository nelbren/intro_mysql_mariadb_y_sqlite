#!/bin/bash

source db_config.bash

mariadb() {
  echo -n "Crear base de datos $base..."
  if ! $cmd $param_exec "SHOW DATABASES;" | grep -q $base; then
    $cmd $param_exec "CREATE DATABASE $base;"
    echo "Hecho."
  else
    echo "Ya."
  fi

  echo -n "Crear tabla speakers en base de datos $base..."
  if ! $cmd $base $param_exec "SHOW TABLES;" | grep -q speakers; then
    $cmd $base $param_exec "CREATE TABLE speakers ( id smallint unsigned not null auto_increment, usuario varchar(20) not null unique, clave varchar(80) not null, nombre varchar(200) not null, constraint pk_id primary key (id) );"
    echo "Hecho."
  else
    echo "Ya."
  fi
}

sqlite() {
  echo -n "Crear base de datos $base..."
  if [ ! -r $base ]; then
    $cmd $base ".databases" ".exit" >/dev/null
    echo "Hecho."
  else
    echo "Ya."
  fi

  echo -n "Crear tabla speakers en base de datos $base..."
  if ! $cmd $base ".tables" | grep -q speakers; then
    $cmd $base "CREATE TABLE speakers ( id integer primary key autoincrement, usuario varchar(20) not null unique, clave  varchar(80) not null, nombre  varchar(200) not null );"
    echo "Hecho."
  else
    echo "Ya."
  fi
}

case $cmd in
  mysql) mariadb;;
  sqlite3) sqlite;;
  *) echo "$cmd desconocido";;
esac
