#!/bin/bash

mariadb() {
  if $cmd $param_exec "SHOW DATABASES;" | grep -q $base; then
    $cmd $param_exec"DROP DATABASE $base;"
    echo "Hecho."
  else
    echo "Ya."
  fi
}

sqlite() {
  if [ -r $base ]; then
    rm $base
    echo "Hecho."
  else
    echo "Ya."
  fi
}

source db_config.bash

echo "Esta seguro? (Si=Aceptar): "
read respuesta

[ "$respuesta" != "Si" ] && exit

echo -n "Destruir base de datos $base..."

case $cmd in
  mysql) mariadb;;
  sqlite3) sqlite;;
  *) echo "$cmd desconocido";;
esac
