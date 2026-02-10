# _**WSL-Dockers**_

_**DISCLAIMER**_

- Este proyecto consta de un conjunto de scripts en varios lenguajes de scripting que consiguen un reemplazo consistente y cómodo para Laragon y Node.js.

- También soluciona varios problemas comunes de detección de cambios y lentitud de mounting points entre Docker Desktop (Windows) y contenedores Linux.

_**BENEFITS**_

- Facilidad de uso.

- Más **dev-style** que Laragon.

- Más personalizable.

_**PREREQUISITES**_

- _**Windows 10/11**_

- _**Docker Desktop**_

- _**Visual Studio Code**_

## _**¿CÓMO FUNCIONA?**_

1. El archivo `.vbs` inicia en oculto/segundo plano el script `hiddenStarter.ps1`.

2. `hiddenStarter.ps1` ejecuta `containerLifter.ps1` y permanece abierto hasta que este último se cierre.

3. `containerLifter.ps1` importa `readDotEnv.psm1` y carga las variables definidas en `.env`.

4. Para evitar problemas de permisos, `containerLifter.ps1` obtiene los UID y GID del usuario por defecto de WSL.

5. Ya con las variables importadas `containerLifter.ps1` monta las plantillas de `.\templates` y las deja en `.\linux`.

6. `containerLifter.ps1` copia toda la carpeta `.\linux` a la home de tu usuario de `WSL`.

7. `containerLifter.ps1` entra en el shell de `WSL` y corre el script `lifter.sh`.

8. `lifter.sh` monta el docker-compose y entra en sesión interactiva del contenedor deseado.

9. Una vez finalizada la sesión, `hiddenStarter.ps1` vuelve a tomar las riendas y hace un `docker compose down`. 

# _**STEP 1**_

**R**ealizamos el clonado del repositorio.

```powershell
git clone https://github.com/FFP00/WSL-Dockers
```

Instalamos `WSL` y configuramos `Debian` como distribución base.

```powershell
wsl --install --no-distribution
wsl --update
wsl --install -d Debian
```

# _**STEP 2**_

**A**ctualizamos los repositorios, preparamos certificados e instalamos Git.

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install ca-certificates
sudo update-ca-certificates
sudo apt install git
```

# _**STEP 3**_
**O**ptimizamos la integración entre Docker Desktop y WSL.

1. Dentro de `Docker Desktop` abrimos ajustes ( _Arriba a la derecha_ ).

    ![1](/public/img/1.png)

2. Entramos en `Resources`.

    ![2](/public/img/2.png)

3. Vamos hacia la pestaña de `WSL integration`. 

    ![3](/public/img/3.png)

4. Activamos la integración con `Debian`.

    ![4](/public/img/4.png)

# _**STEP 4**_
**U**tilizamos la extensión oficial de Microsoft para trabajar con `WSL` desde `VS Code`.


[**Microsoft WSL**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

Desde la nueva pestaña nos conectamos a `Debian` mediante la flecha.

![5](/public/img/5.png)

# _**STEP 5**_
**I**dentificamos y asignamos los atributos a los `.env`.

    Además cerramos las ventanas de los siguientes programas:  

    - PowerShell
    - Visual Studio Code

# _**STEP 6**_

**A**brimos la aplicación deseada ejecutando su archivo `.vbs`.

## _**FAQ**_

*¿Por qué Debian?* 

    - Estabilidad
    - Compatibilidad
    - Espacio

*¿Por qué no funciona npm run dev ni npm run preview?* 

    A causa de limitaciones en las redes internas de Docker (Windows), se han creado alias para estos comandos:

    - npm run dev → bun-run-dev   
    - npm run preview → bun-run-preview 

    Es importante decir que todos los comandos que empezaban por npm ahora empiezan por bun.
    
    Además, ahora cuando se cree un proyecto ( bun create vite@latest ) y se inicie automáticamente, habrá que cerrarlo ( q + Enter ), e introducir alguno de los alias antes mencionados.

*¿Cómo funciona específicamente esto?* 

    Todos los scripts están comentados para que se entienda su funcionamiento, así que si tienes ganas puedes mirar exactamente qué hace.