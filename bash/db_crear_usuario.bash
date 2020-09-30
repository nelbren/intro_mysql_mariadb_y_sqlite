#!/bin/bash

source db_config.bash

echo -n "Crear usuario de acceso para base de datos $base..."
if ! $cmd mysql $param_exec "SELECT COUNT(*) FROM user WHERE User='$user' and Host='localhost'" | grep -q "1"; then
  $cmd $param_exec "CREATE USER '$user'@'localhost' IDENTIFIED BY '$pass';"
  $cmd $param_exec "GRANT ALL PRIVILEGES ON $base.* TO '$user'@'localhost';"
  $cmd $param_exec "FLUSH PRIVILEGES;"
  echo "Hecho."
else
  echo "Ya."
fi
