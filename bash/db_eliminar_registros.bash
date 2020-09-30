#!/bin/bash

source db_config.bash

echo -n "Eliminar registros en tabla speakers de base de datos $base..."
max=$($cmd $base $param_exec "SELECT COUNT(*) FROM speakers;" $param_noheader)
if [ $max -gt 0 ]; then
  n=0
  while [ $n -lt $max ]; do
    id=$($cmd $base $param_exec "SELECT id FROM speakers LIMIT 1;" $param_noheader)
    $cmd $base $param_exec "DELETE FROM speakers WHERE id = '$id';"
    n=$((n+1))
    echo -n "."
  done
  echo "Hecho."
else
  echo "Ya."
fi
