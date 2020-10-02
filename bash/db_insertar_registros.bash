#!/bin/bash

source db_config.bash

echo -n "Insertar registros en tabla speakers de base de datos $base..."
count=$($cmd $base $param_exec "SELECT COUNT(*) FROM speakers;" $param_noheader)
r=$(( $RANDOM % $max + 1 ))
if [ $count -lt $max ]; then
  n=0
  while [ $n -lt $max ]; do
    if [ $n -eq $r ]; then
      usuario='nelbren'
      clave='ultrasecret'
      nombre='Martin Cuellar'
      correo="$usuario@gmail.com"
      m='M'
    else
      usuario="USUARIO_$n"
      clave="CLAVE_$n"
      nombre="NOMBRE_$n"
      correo="$(echo $usuario | tr "[A-Z]" "[a-z]")@correo.com"
      m='S'
    fi
    $cmd $base $param_exec "INSERT INTO speakers ( id, usuario, clave, nombre, correo, activo ) VALUES ( null, '$usuario', '$clave', '$nombre', '$correo', 1 );"
    if [ $n -eq $r ]; then
      declare -a TITULOS=('Introducción a la Distribución Debian GNU/Linux 10.4' 'Introducción a MySQL, MariaDB y SQLite')
      speaker_id=$($cmd $base $param_exec "SELECT id FROM speakers WHERE usuario = '$usuario';" $param_noheader)
      for t in "${TITULOS[@]}"; do
        $cmd $base $param_exec "INSERT INTO webminars ( titulo, speaker_id ) VALUES ( '$t', $speaker_id );"
        webminar_id=$($cmd $base $param_exec "SELECT id FROM webminars WHERE speaker_id = '$speaker_id' ORDER by id DESC LIMIT 1;" $param_noheader)
        if [ -n "$webminar_id" ]; then
           echo -n 'w'
        fi
      done
    fi
    echo -n $m
    n=$((n+1))
  done
  echo "Hecho."
else
  echo "Ya."
fi
