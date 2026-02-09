function Read-DotEnv {

    param(
        # El parámetro Path es obligatorio y debe ser una cadena con la ruta del archivo .env
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    # Comprobar si el archivo existe; si no, lanzar un error
    if (-not (Test-Path $Path)) {
        throw "El archivo '$Path' no existe."
    }

    # Crear un hashtable donde guardaremos las variables del .env
    $envTable = @{}

    # Leer el archivo línea por línea
    foreach ($line in Get-Content $Path) {

        # Ignorar líneas vacías o que empiecen por '#'
        if ([string]::IsNullOrWhiteSpace($line) -or $line.Trim().StartsWith("#")) {
            continue
        }

        # Validar que la línea tenga formato VARIABLE=VALOR sin espacios alrededor del '='
        if ($line -match "^\s*[^=\s]+\=[^=\s].*$") {

            # Separar la línea en clave y valor (solo en el primer '=')
            $parts = $line.Split("=", 2)
            $key   = $parts[0]
            $value = $parts[1]

            # Guardar la variable en el hashtable
            $envTable[$key] = $value
        }
        else {
            # Avisar si la línea no cumple el formato permitido
            Write-Warning "Línea inválida (espacios no permitidos): '$line'"
        }
    }

    # Devolver el hashtable con todas las variables válidas
    return $envTable
}
