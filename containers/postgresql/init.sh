#!/bin/bash
set -e

# initdbでdockerというユーザとデータベースを作成する
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "dev" <<-EOSQL
    GRANT ALL PRIVILEGES ON DATABASE dev TO devuser;
    CREATE DATABASE test;
    GRANT ALL PRIVILEGES ON DATABASE test TO devuser;
EOSQL
