#!/bin/bash

base=devteam504.db

echo "Esta seguro? (Si=Aceptar): "
read respuesta

[ "$respuesta" != "Si" ] && exit

echo -n "Destruir base de datos $base..."
if [ -r $base ]; then
  rm $base
  echo "Hecho."
else
  echo "Ya."
fi
