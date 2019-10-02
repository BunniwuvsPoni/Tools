# Note this is a two part script, you will need this script in addition to Initial_Script.ps1

#region requiredVariables
param(
    [Parameter(Mandatory=$true)][string]$importFileName,
    [Parameter(Mandatory=$true)][string]$directory
)

# Setup environmental variables to reduce clutter when using postgres cli commands (i.e. psql)
$env:PGUSER = "postgres"
$env:PGPASSWORD='<postgres password>'
$env:PGHOST = "localhost"
$db = "<database name>"
#endregion requiredVariables

#region importPostgres
# Navigate to posgresql cli directory
cd 'C:\Program Files\PostgreSQL\<postgres version>\bin'

# Drop the existing db
.\dropdb.exe $db

# Re-create new db
.\createdb.exe $db

# Import command
$importCommand = "\i C:/" + $directory + "/" + $importFileName

# Import from pgdump file
.\psql.exe -d $db -c $importCommand
#endregion importPostgres

#region exportPostgres
# Export tables
# Select all tables in the database
$tables = .\psql.exe -d $db -c "SELECT table_name
                FROM information_schema.tables
                WHERE table_type='BASE TABLE'
                AND table_schema='public';"

# Export tables happens here
foreach ($table in $tables)
{
    $exportCommand = "\COPY (SELECT * FROM " + $table + ")
                TO 'C:/" + $directory + "/" + $table.Trim() + ".csv'
                WITH DELIMITER ',' CSV HEADER ENCODING 'UTF8'"
    .\psql.exe -d $db -c $exportCommand
}
#endregion exportPostgres
