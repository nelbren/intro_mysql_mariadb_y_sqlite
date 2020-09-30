#!/bin/bash

base=devteam504.db
tabla=speakers

echo -n "Eliminar registros en tabla $tabla de base de datos $base..."
max=$(sqlite3 $base "SELECT COUNT(*) FROM $tabla;")
if [ $max -gt 0 ]; then
  n=0
  while [ $n -lt $max ]; do
    id=$(sqlite3 $base "SELECT id FROM $tabla LIMIT 1;")
    sqlite3 $base "DELETE FROM $tabla WHERE id = '$id';"
    n=$((n+1))
    echo -n "."
  done
  echo "Hecho."
else
  echo "Ya."
fi
