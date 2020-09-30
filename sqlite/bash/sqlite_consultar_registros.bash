#!/bin/bash

base=devteam504.db
tabla=speakers

echo "Consultar registros en tabla $tabla de base de datos $base:"
sqlite3 $base "SELECT * FROM $tabla;" 
