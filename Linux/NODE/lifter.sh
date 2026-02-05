#!/bin/bash
COMPOSE_NAME="node_compose"
CONTAINER_SHELL="server_node"


    #Crea workdir por si no existe
    mkdir -p workdir

    # Abrimos Visual Studio Code
    code .

    # Hacer un docker compose up
    docker compose -p "$COMPOSE_NAME" up --build -d

    # Entrar al contenedor principal
    docker exec -it "$CONTAINER_SHELL" sh -l

    # Salir
    exit

