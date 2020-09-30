#!/bin/bash

source db_config.bash

echo "Consultar registros en tabla speakers de base de datos $base:"
$cmd $base $param_exec "SELECT * FROM speakers;" 
