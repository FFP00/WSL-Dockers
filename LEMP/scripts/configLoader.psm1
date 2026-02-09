function Get-Config {

    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "El archivo '$Path' no existe."
    }

    $data = @{}

    Get-Content $Path |
        Where-Object { $_ -match '^\s*[^#]' } |   # Ignora comentarios y líneas vacías
        ForEach-Object {
            $line = $_.Trim()
            if ($line -match '(.+?)=(.+)') {
                $key = $Matches[1].Trim()
                $value = $Matches[2].Trim()
                $data[$key] = $value
            }
        }

    return $data
}