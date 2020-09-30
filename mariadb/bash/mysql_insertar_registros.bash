#!/bin/bash

base=devteam504
tabla=speakers
max=100

echo -n "Insertar registros en tabla $tabla de base de datos $base..."
count=$(mysql $base -e "SELECT COUNT(*) FROM $tabla;" -N)
if [ $count -lt $max ]; then
  n=0
  while [ $n -lt $max ]; do
    usuario="USUARIO_$n"
    clave="CLAVE_$n"
    nombre="NOMBRE_$n"
    mysql $base -e "INSERT INTO $tabla ( id, usuario, clave, nombre ) VALUES ( null, '$usuario', '$clave', '$nombre' );"
    n=$((n+1))
    echo -n "."
  done
  echo "Hecho."
else
  echo "Ya."
fi
