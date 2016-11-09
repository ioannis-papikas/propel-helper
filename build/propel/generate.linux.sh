#!/usr/bin/env bash

# Set base path
BASE_PATH=../../..
# Change directory to current one
cd "$(dirname "$0")"

# Create database schema
$BASE_PATH/vendor/bin/propel reverse --config-dir=$BASE_PATH/ --output-dir=$BASE_PATH/generated-reversed-database --database-name=everfind --schema-name=everfind-schema everfind

# Add database namespace for generated classes
php replace-in-file.php "<database name=\"default\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\">" "<database name=\"default\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\" namespace=\"App\Propel\">" "$BASE_PATH..\..\config\propel\schema_auto.xml"

# Move file with the new name
mv $BASE_PATH/config/propel/schema_auto.xml $BASE_PATH/config/propel/schema.xml

# Create all model classes
$BASE_PATH/vendor/bin/propel model:build --config-dir=$BASE_PATH/ --output-dir=$BASE_PATH/ --schema-dir=$BASE_PATH/config/propel

# Add files to git
git add $BASE_PATH/app/Propel/
