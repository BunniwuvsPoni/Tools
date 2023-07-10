# Useful information (Windows)

## List all packages
pip list

## List packages with updates
pip list --outdated

## Update all packages
pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}

pip install --upgrade (package)

## Delete all installed packages (must be ran with administrative privileges)
pip freeze > requirements.txt
pip uninstall -r requirements.txt -y
