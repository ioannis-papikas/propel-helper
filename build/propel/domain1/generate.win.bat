:: Set current and root directory
set CURRENT_DIR=%~dp0
set ROOT_DIR=%CURRENT_DIR%..\..\..

:: Set configuration for running propel on a specific domain
:: This configuration allows propel to connect to different databases if needed
:: and generate separate models in different namespaces
set CONFIG_DIR=%CURRENT_DIR%..\..\..\config\propel\domain1
set DB_NAME=domain1
set NAMESPACE=App\Propel\Domain1\

:: Create database schema
call %ROOT_DIR%\vendor\bin\propel database:reverse --config-dir=%CONFIG_DIR%\ --output-dir=%CONFIG_DIR% --database-name=%DB_NAME% --schema-name=schema_auto

:: Add database namespace for generated classes
php %CURRENT_DIR%replace_in_file.php "<database name=\"%DB_NAME%\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\">" "<database name=\"%DB_NAME%\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\" namespace=\"%NAMESPACE%">" "%CONFIG_DIR%\schema_auto.xml"

:: Move file with the new name
move %CONFIG_DIR%\schema_auto.xml %CONFIG_DIR%\schema.xml

:: Create all model classes
call %ROOT_DIR%\vendor\bin\propel model:build --config-dir=%CONFIG_DIR%\ --output-dir=%ROOT_DIR%\ --schema-dir=%CONFIG_DIR%\
echo Propel model classes generated.

:: Add files to git
git add %ROOT_DIR%\app\Propel\
echo Files added to git.
