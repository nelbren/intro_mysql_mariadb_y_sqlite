#!/bin/bash

base=devteam504
tabla=speakers

echo "Consultar registros en tabla $tabla de base de datos $base:"
mysql $base -e "SELECT * FROM $tabla;" 
