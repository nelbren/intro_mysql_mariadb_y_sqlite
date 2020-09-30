#!/bin/bash

./mariadb_crear_bd.bash
./mariadb_crear_usuario.bash
./mariadb_insertar_registros.bash
./mariadb_consultar_registros.bash
./mariadb_eliminar_registros.bash
#./mariadb_destruir_usuario.bash
./mariadb_destruir_bd.bash  
