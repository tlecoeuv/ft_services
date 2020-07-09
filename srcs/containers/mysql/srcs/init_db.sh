#! /bin/bash

until mysql
do
	echo "..."
done

mysql < db.sql
