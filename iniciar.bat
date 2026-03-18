@echo off
echo === Script de inicio de n8n ===
echo Deteniendo y eliminando contenedor anterior...
docker stop n8n 2>nul
docker rm n8n 2>nul

echo Creando carpetas necesarias...
if not exist "C:\Users\Jordan\n8n-data" mkdir "C:\Users\Jordan\n8n-data"
if not exist "C:\python-scripts" mkdir "C:\python-scripts"

echo Creando nuevo contenedor n8n con Python...
docker run -d --name n8n -p 5678:5678 -v "C:\Users\Jordan\n8n-data":/home/node/.n8n -v "C:\python-scripts":/scripts -e NODES_EXCLUDE=[] -e N8N_PYTHON_ENABLED=true --restart unless-stopped n8n-python:latest

if errorlevel 1 (
    echo ERROR: No se pudo crear el contenedor.
    echo Posibles causas:
    echo   - Docker no está instalado o no está corriendo.
    echo   - La imagen n8n-python:latest no existe.
    pause
    exit /b 1
)

echo Contenedor creado exitosamente.
echo Esperando 5 segundos...
timeout /t 5
start http://localhost:5678
echo Proceso completado.
pause