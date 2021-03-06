#!/usr/bin/env bash
set -eux

if [ "${PGVERSION-}" != "" ]
then
  # The tricky test user, below, has to actually exist so that it can be used in a test
  # of aclitem formatting. It turns out aclitems cannot contain non-existing users/roles.
  psql -U postgres -c 'create database pgx_test'
  psql -U postgres pgx_test -c 'create extension hstore'
  psql -U postgres pgx_test -c 'create domain uint64 as numeric(20,0)'
  psql -U postgres -c "create user pgx_ssl SUPERUSER PASSWORD 'secret'"
  psql -U postgres -c "create user pgx_md5 SUPERUSER PASSWORD 'secret'"
  psql -U postgres -c "create user pgx_pw  SUPERUSER PASSWORD 'secret'"
  psql -U postgres -c "create user travis"
  psql -U postgres -c "create user pgx_replication with replication password 'secret'"
  psql -U postgres -c "create user \" tricky, ' } \"\" \\ test user \" superuser password 'secret'"
fi
