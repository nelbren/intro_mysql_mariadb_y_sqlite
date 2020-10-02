#!/bin/bash

source db_config.bash

echo "Consultar registros en tabla speakers de base de datos $base:"
$cmd $base $param_exec "SELECT * FROM speakers;" | \
while IFS='|' read -r id usuario clave nombre correo activo; do
  echo $id $usuario $clave $nombre $correo $activo
  $cmd $base $param_exec "SELECT titulo FROM webminars WHERE speaker_id = '$id'" $param_noheader | \
  while read titulo; do
    echo "  - $titulo"
  done
done
