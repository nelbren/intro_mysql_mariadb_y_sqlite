#!/bin/bash

base=devteam504

echo "Esta seguro? (Si=Aceptar): "
read respuesta

[ "$respuesta" != "Si" ] && exit

echo -n "Destruir base de datos $base..."
if mysql -e "SHOW DATABASES;" | grep -q $base; then
  mysql -e "DROP DATABASE $base;"
  echo "Hecho."
else
  echo "Ya."
fi
