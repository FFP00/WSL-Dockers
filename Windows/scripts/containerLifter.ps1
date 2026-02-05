# Especificamod la ruta de donde estará el script .sh para iniciar los contenedores
$RUTA = "/home/netti/dockers/X"



    # Corre el script dentro del entorno WSL
    wsl -d Debian bash -lc "cd '$RUTA' && ./lifter.sh"
