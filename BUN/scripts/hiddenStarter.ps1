# --- Cargar módulo para leer .env ---
Import-Module "$PSScriptRoot\readDotEnv.psm1"

# --- Cargar variables del archivo .env ---
$envVars = Read-DotEnv "$PSScriptRoot\..\.env"

# --- Ruta completa hacia containerLifter.ps1 ---
$rutaLifter = "$PSScriptRoot\containerLifter.ps1"

# --- Ejecutar containerLifter.ps1 ---
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$rutaLifter`"" -Wait

# --- Apagar contenedores ---
docker compose -p $envVars["COMPOSE_NAME"] down