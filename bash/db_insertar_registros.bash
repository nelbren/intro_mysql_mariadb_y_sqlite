#!/bin/bash

source db_config.bash

echo -n "Insertar registros en tabla speakers de base de datos $base..."
count=$($cmd $base $param_exec "SELECT COUNT(*) FROM speakers;" $param_noheader)
if [ $count -lt $max ]; then
  n=0
  while [ $n -lt $max ]; do
    usuario="USUARIO_$n"
    clave="CLAVE_$n"
    nombre="NOMBRE_$n"
    $cmd $base $param_exec "INSERT INTO speakers ( id, usuario, clave, nombre ) VALUES ( null, '$usuario', '$clave', '$nombre' );"
    n=$((n+1))
    echo -n "."
  done
  echo "Hecho."
else
  echo "Ya."
fi
