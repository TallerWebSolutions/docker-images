#!/bin/bash

set -e

# Source NVM scripts
source /taller/.nvm/nvm.sh

# Await database.
# ---------------.
while ! nc -q 1 database-host 3306 </dev/null; do sleep 3; done

echo ""
echo "--------------------------------------"
echo "--------- Database connected ---------"
echo "--------------------------------------"
echo ""

echo ""
echo "--------------------------------------"
echo "--- Virtual Machine ready to work! ---"
echo "--------------------------------------"
echo ""
echo "Access your site at http://$(hostname -i)"
echo ""

exec "$@"
