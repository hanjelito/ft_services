#!/bin/sh

# Start Telegraf and Influxdb.

influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER root WITH PASSWORD '123456'"
influx -execute "GRANT ALL ON influxdb TO root"

/etc/init.d/telegraf start & influxd
