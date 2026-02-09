Import-Module "$PSScriptRoot\readDotEnv.psm1"
$env = Read-DotEnv -Path "$PSScriptRoot\..\.env"

$rutaLinux = $env["RUTA"]
$rutaWindows = "\\wsl$\Debian" + ($rutaLinux -replace "/", "\")
$rutaScript = Join-Path $PSScriptRoot "..\linux"
$rutaCompose = Join-Path $PSScriptRoot "..\compose-config.yml"
$rutaNuevoCompose = Join-Path $PSScriptRoot "..\linux\docker-compose.yml"
$rutaEnv = Join-Path $PSScriptRoot "..\.env"

$composeName = $env["COMPOSE_NAME"]

(Get-Content $rutaCompose) -replace '\$\{CHANGE\}', $composeName | Set-Content $rutaNuevoCompose


# Corre el script dentro del entorno WSL
Copy-Item "$rutaEnv" "$rutaScript\.env" -Force
robocopy "$rutaScript" "$rutaWindows" /MIR /NFL /NDL /NJH /NJS /NP > $null 2>&1
wsl -d Debian bash -lc "cd '$rutaLinux' && chmod u+x lifter.sh"
wsl -d Debian bash -lc "cd '$rutaLinux' && ./lifter.sh"
pause