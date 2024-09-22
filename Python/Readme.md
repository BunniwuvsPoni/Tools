# Useful information (Windows)
Note: Run with administrative privileges for all users, otherwise changes will only be refected for the currently logged in user.

## Generate requirements.txt
pip freeze > requirements.txt

## List all packages
pip list

## List packages with updates
pip list --outdated

## Update all packages
pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}

pip install --upgrade (package)

## Delete all installed packages
pip freeze > requirements.txt

pip uninstall -r requirements.txt -y
