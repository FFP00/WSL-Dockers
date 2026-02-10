# --- Cargar módulo para leer .env ---
Import-Module "$PSScriptRoot\readDotEnv.psm1"

# --- Cargar variables del archivo .env ---
$envVars = Read-DotEnv "$PSScriptRoot\..\.env"

# --- Asignar variables de entorno para comandos ---
$composeName    = $envVars["COMPOSE_NAME"]
$containerShell = $envVars["CONTAINER_SHELL"]
$rutaPWD        = $envVars["LINUX_ROUTE"]

# --- Detectar automáticamente el usuario default de WSL ---
$userWSL    = wsl -d Debian bash -lc 'echo $USER'
$uID        = wsl -d Debian bash -lc "id -u"
$gID        = wsl -d Debian bash -lc "id -g"

# --- Asignar rutas varias ---
$rutaWSL                = "\\wsl$\Debian\home\$userWSL" + ($rutaPWD -replace "/", "\")
$rutaLinux              = "$PSScriptRoot\..\linux"

$rutaConfigCompose      = "$PSScriptRoot\..\templates\config-compose.yml"
$rutaDockerCompose      = "$PSScriptRoot\..\linux\docker-compose.yml"

$rutaENV                = "$PSScriptRoot\..\.env"

# --- Generar docker-compose.yml desde plantilla ---
(Get-Content $rutaConfigCompose -Raw) `
    -replace '\$\{COMPOSE_NAME\}', $composeName `
    -replace '\$\{CONTAINER_SHELL\}', $containerShell `
    -replace '\$\{UID\}', $uID `
    -replace '\$\{GID\}', $gID |
    Set-Content $rutaDockerCompose

# --- Copiar .env a la carpeta linux ---
Copy-Item "$rutaENV" "$rutaLinux\.env" -Force

# --- Sincronizar carpeta linux → WSL ---
robocopy "$rutaLinux" "$rutaWSL" /E /NJH /NJS /NDL /NFL /NP /NS /NC

# --- Ejecutar script dentro del entorno WSL ---
wsl -d Debian bash -lc "cd '/home/$userWSL/$rutaPWD' && chmod u+x lifter.sh && ./lifter.sh"