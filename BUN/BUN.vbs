' --- Inicialización de objetos ---
Dim fso, shell, rutaVBS, rutaHidden

' --- Crear un objeto capaz de leer y manipular directorios ---
Set fso   = CreateObject("Scripting.FileSystemObject")

' --- Creamos un objeto capaz de correr scripts ---
Set shell = CreateObject("WScript.Shell")

' --- Obtener la ruta del directorio donde está este .vbs ---
rutaVBS = fso.GetParentFolderName(WScript.ScriptFullName)

' --- Construir la ruta completa hacia hiddenStarter.ps1 ---
rutaHidden = fso.BuildPath(rutaVBS, "scripts\hiddenStarter.ps1")

' --- Ejecutar el script PowerShell de forma oculta ---
shell.Run "powershell.exe -ExecutionPolicy Bypass -File """ & rutaHidden & """", 0, True