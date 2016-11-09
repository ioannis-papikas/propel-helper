:: Set current directory
set CURRENT_DIR=%~dp0
set ROOT_DIR=%CURRENT_DIR%..\..

:: Create database schema
call %ROOT_DIR%\vendor\bin\propel database:reverse --config-dir=%ROOT_DIR%\ --output-dir=%ROOT_DIR%\config\propel --database-name=default --schema-name=schema_auto

:: Add database namespace for generated classes
php %CURRENT_DIR%replace_in_file.php "<database name=\"default\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\">" "<database name=\"default\" defaultIdMethod=\"native\" defaultPhpNamingMethod=\"underscore\" namespace=\"App\Propel\">" "%ROOT_DIR%\config\propel\schema_auto.xml"

:: Move file with the new name
move %ROOT_DIR%\config\propel\schema_auto.xml %ROOT_DIR%\config\propel\schema.xml

:: Create all model classes
call %ROOT_DIR%\vendor\bin\propel model:build --config-dir=%ROOT_DIR%\ --output-dir=%ROOT_DIR%\ --schema-dir=%ROOT_DIR%\config\propel\
echo Propel model classes generated.

:: Add files to git
git add %ROOT_DIR%\app\Propel\
echo Files added to git.
