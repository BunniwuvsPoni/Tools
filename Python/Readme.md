# Useful information (Windows)

## List all packages
pip list

## List packages with updates
pip list --outdated

## Update all packages
pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
