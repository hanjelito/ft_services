#!/bin/sh
/etc/init.d/telegraf start & influxd

influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER root WITH PASSWORD '123456'"
influx -execute "GRANT ALL ON telegraf TO root"