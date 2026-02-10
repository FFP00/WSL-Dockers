function Read-DotEnv {

    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "El archivo '$Path' no existe."
    }

    $envTable = @{}

    foreach ($line in Get-Content $Path) {

        if ([string]::IsNullOrWhiteSpace($line) -or $line.Trim().StartsWith("#")) {
            continue
        }

        if ($line -match "^\s*[^=\s]+\=[^=\s].*$") {

            $parts = $line.Split("=", 2)
            $key   = $parts[0]
            $value = $parts[1]

            $envTable[$key] = $value
        }
        else {
            Write-Warning "Línea inválida (espacios no permitidos): '$line'"
        }
    }

    return $envTable
}