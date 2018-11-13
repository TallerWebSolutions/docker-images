#!/bin/bash

set -e

# Source NVM scripts
source /taller/.nvm/nvm.sh

# Start services and loggers.
# ---------------------------

sudo service apache2 restart > /tmp/apache2.log

echo ""
echo "--------------------------------------"
echo "--- Virtual Machine ready to work! ---"
echo "--------------------------------------"
echo ""
echo "Access your site at http://$(hostname -i)"
echo ""

exec "$@"
