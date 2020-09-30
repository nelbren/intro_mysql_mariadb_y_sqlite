#!/bin/bash

base=devteam504
tabla=speakers

echo -n "Eliminar registros en tabla $tabla de base de datos $base..."
max=$(mysql $base -e "SELECT COUNT(*) FROM $tabla;" -N)
if [ $max -gt 0 ]; then
  n=0
  while [ $n -lt $max ]; do
    id=$(mysql $base -e "SELECT id FROM $tabla LIMIT 1;" -N)
    mysql $base -e "DELETE FROM $tabla WHERE id = '$id';"
    n=$((n+1))
    echo -n "."
  done
  echo "Hecho."
else
  echo "Ya."
fi
