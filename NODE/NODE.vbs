' Crear un objeto capaz de leer y manipular directorios '
Set fileSystemObject = CreateObject("Scripting.FileSystemObject") 

' Obtiene la ruta desde donde se está llama actualmente a este script '
ruta = fileSystemObject.GetParentFolderName(WScript.ScriptFullName)

' Montamos la ruta completa añadiendo el script hiddenStarter al final '
rutaHidden = fileSystemObject.BuildPath(ruta, "scripts\hiddenStarter.ps1") 

' Creamos un objeto capaz de correr scripts '
Set shellObject = CreateObject("Wscript.Shell") 

' Corre el script en oculto en base a la ruta que hemos creado antes '
shellObject.Run "powershell.exe -ExecutionPolicy Bypass -File """ & rutaHidden & """", 0, True 