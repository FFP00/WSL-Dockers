#!/bin/bash

set -a          # exporta automáticamente todas las variables que se carguen
source .env     # carga el archivo .env
set +a          # desactiva la exportación automática

#Crea workdir por si no existe
mkdir -p workdir

# Abrimos Visual Studio Code
code ./workdir

# Hacer un docker compose up
docker compose -p "$COMPOSE_NAME" up --build -d

# Entrar al contenedor principal
docker exec -it "$CONTAINER_SHELL" sh

# Salir
exit

