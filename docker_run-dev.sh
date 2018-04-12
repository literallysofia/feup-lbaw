#!/bin/bash

#cd /app

echo "Wait until PostgreSQL is up and ready."
export PGPASSWORD='pg!fcp'
until pg_isready -h postgres -d postgres -U postgres; do
  echo "PostgreSQL is unavailable, sleep 10s."
  sleep 10
done
echo "PostgreSQL is ready."

if [ ! -f /.inited ]; then
    echo "Since it is the first launch, we will install project dependencies and seed the database."

    composer install
    php artisan db:seed

    touch /.inited
fi

echo "Launching php server..."
php artisan serve --host=0.0.0.0
