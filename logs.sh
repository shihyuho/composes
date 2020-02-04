#!/bin/bash

set -e
set -o pipefail

cd $1 && docker-compose logs -f