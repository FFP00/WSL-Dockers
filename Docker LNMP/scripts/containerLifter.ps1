# Consigue la ruta desde donde se llama a este script
$ruta = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Asigna la ruta desde donde se llama a este script
Set-Location $ruta

# Hace un docker compose up
docker compose -p node_compose up --build -d

# Entra interactivamente al contenedor
docker exec -it app_php sh

# Cierra la ventana obligatoriamente al salir del shell 
exit
