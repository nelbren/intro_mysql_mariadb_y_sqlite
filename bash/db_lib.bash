#!/bin/bash

engine=$(basename $(dirname $(pwd)))
if echo $engine  | egrep -vq "^mariadb$|^sqlite$"; then
  echo "Por favor use dentro de cada motor de base de datos."
  exit 1
fi
