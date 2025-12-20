' Crear un objeto capaz de leer y manipular directorios '
Set fileSystemObject = CreateObject("Scripting.FileSystemObject") 

' Consigue la ruta desde donde se llama a este script '
ruta = fileSystemObject.GetParentFolderName(WScript.ScriptFullName)

' Montamos la ruta completa con hiddenStarter '
rutaHidden = fileSystemObject.BuildPath(ruta, "scripts\hiddenStarter.ps1") 

' Creamos un objeto capaz de correr scripts '
Set shellObject = CreateObject("Wscript.Shell") 

' Corre el script en base a la ruta '
shellObject.Run "powershell.exe -ExecutionPolicy Bypass -File """ & rutaHidden & """", 0, True 
