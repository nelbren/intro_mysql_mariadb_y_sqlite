#!/bin/bash

base=devteam504
user=devteam504

echo -n "Destruir usuario de acceso para base de datos $base..."
if mysql mysql -e "SELECT COUNT(*) FROM user WHERE User='$user' and Host='localhost'" | grep -q "1"; then
  mysql -e "DROP USER '$user'@'localhost';"
  echo "Hecho."
else
  echo "Ya."
fi
