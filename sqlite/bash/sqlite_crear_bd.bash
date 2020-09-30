#!/bin/bash

base=devteam504.db
tabla=speakers

echo -n "Crear base de datos $base..."
if [ ! -r $base ]; then
  sqlite3 $base ".databases" ".exit" >/dev/null
  echo "Hecho."
else
  echo "Ya."
fi

echo -n "Crear tabla $tabla en base de datos $base..."
if ! sqlite3 $base ".tables" | grep -q $tabla; then
  sqlite3 $base "CREATE TABLE $tabla ( id integer primary key autoincrement, usuario varchar(20) not null unique, clave  varchar(80) not null, nombre  varchar(200) not null );"
  echo "Hecho."
else
  echo "Ya."
fi
