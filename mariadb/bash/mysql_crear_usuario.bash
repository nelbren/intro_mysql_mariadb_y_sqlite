#!/bin/bash

base=devteam504
user=devteam504
pass=Sup3rP4ssw0rd

echo -n "Crear usuario de acceso para base de datos $base..."
if ! mysql mysql -e "SELECT COUNT(*) FROM user WHERE User='$user' and Host='localhost'" | grep -q "1"; then
  mysql -e "CREATE USER '$user'@'localhost' IDENTIFIED BY '$pass';"
  mysql -e "GRANT ALL PRIVILEGES ON $base.* TO '$user'@'localhost';"
  mysql -e "FLUSH PRIVILEGES;"
  echo "Hecho."
else
  echo "Ya."
fi
