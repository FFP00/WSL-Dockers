# Consigue la ruta desde donde se llama a este script
$ruta = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Montamos la ruta completa con containerLifter 
$rutaLifter = Join-Path $ruta "containerLifter.ps1"

# Corre el script en base a la ruta
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$rutaLifter`"" -Wait

# Cuando acaba el script hace un node compose down
docker compose -p node_compose down
