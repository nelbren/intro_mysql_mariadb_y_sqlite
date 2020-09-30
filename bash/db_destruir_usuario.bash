#!/bin/bash

source db_config.bash

echo -n "Destruir usuario de acceso para base de datos $base..."
if $cmd mysql $param_exec "SELECT COUNT(*) FROM user WHERE User='$user' and Host='localhost'" | grep -q "1"; then
  $cmd $param_exec "DROP USER '$user'@'localhost';"
  echo "Hecho."
else
  echo "Ya."
fi
