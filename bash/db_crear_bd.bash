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
    $cmd $base $param_exec "CREATE TABLE speakers ( id INT(11) NOT NULL AUTO_INCREMENT, usuario VARCHAR(20) NOT NULL UNIQUE, clave VARCHAR(80) NOT NULL, nombre VARCHAR(200) NOT NULL, correo VARCHAR(50) DEFAULT NULL, activo TINYINT(1) NOT NULL, CONSTRAINT pk_id PRIMARY KEY (id) );"
    echo "Hecho."
  else
    echo "Ya."
  fi

  echo -n "Crear tabla webminars en base de datos $base..."
  if ! $cmd $base $param_exec "SHOW TABLES;" | grep -q webminars; then
	  $cmd $base $param_exec "CREATE TABLE webminars ( id INT(11) NOT NULL AUTO_INCREMENT, titulo VARCHAR(250) NOT NULL, speaker_id INT(11) NOT NULL, PRIMARY KEY(id), KEY webminar_speaker_id (speaker_id), CONSTRAINT webminars_ibfk_1 FOREIGN KEY (speaker_id) REFERENCES speakers(id) ON DELETE CASCADE );"
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
    $cmd $base "CREATE TABLE speakers ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, usuario VARCHAR(20) NOT NULL UNIQUE, clave VARCHAR(80) NOT NULL, nombre VARCHAR(200) NOT NULL, correo VARCHAR(50) NOT NULL UNIQUE, activo INTEGER NOT NULL);"
    echo "Hecho."
  else
    echo "Ya."
  fi

  echo -n "Crear tabla webminars en base de datos $base..."
  if ! $cmd $base ".tables" | grep -q webminars; then
    $cmd $base "CREATE TABLE webminars ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, titulo VARCHAR(250) NOT NULL, speaker_id INTEGER NOT NULL, FOREIGN KEY (speaker_id) REFERENCES speakers (id) ON DELETE CASCADE);"
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
