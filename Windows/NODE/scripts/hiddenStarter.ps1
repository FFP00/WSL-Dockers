# Nombre del compose entre comillas
$COMPOSE_NAME = "node_compose"



    # Obtiene la ruta desde donde se está llama actualmente a este script
    $ruta = Split-Path -Parent $MyInvocation.MyCommand.Definition

    # Montamos la ruta completa añadiendo el script containerLifter al final 
    $rutaLifter = Join-Path $ruta "containerLifter.ps1"

    # Corre el script en base a la ruta que hemos creado antes
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$rutaLifter`"" -Wait

    # Cuando acaba el script hace un node compose down
    docker compose -p $COMPOSE_NAME down