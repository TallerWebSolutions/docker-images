#!/bin/bash

set -e

# Source NVM scripts
source /taller/.nvm/nvm.sh

echo ""
echo "--------------------------------------"
echo "--- Virtual Machine ready to work! ---"
echo "--------------------------------------"
echo ""
echo "Access your site at http://$(hostname -i)"
echo ""

exec "$@"
