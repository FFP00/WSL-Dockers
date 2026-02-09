Import-Module "$PSScriptRoot\configLoader.psm1"
$config = Get-Config "$PSScriptRoot\..\.env"

$rutaLinux = $config["RUTA"]
$rutaWindows = "\\wsl$\Debian" + ($rutaLinux -replace "/", "\")
$rutaScript = Join-Path $PSScriptRoot "..\linux"
$rutaEnv = Join-Path $PSScriptRoot "..\.env"


# Corre el script dentro del entorno WSL
Copy-Item "$rutaEnv" "$rutaScript\.env" -Force
robocopy "$rutaScript" "$rutaWindows" /MIR /NFL /NDL /NJH /NJS /NP > $null 2>&1
wsl -d Debian bash -lc "cd '$rutaLinux' && chmod u+x lifter.sh"
wsl -d Debian bash -lc "cd '$rutaLinux' && ./lifter.sh"