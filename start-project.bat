@echo off

:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Administrator privileges are required.
    echo Please right-click and select "Run as administrator."
    pause
    exit /b
)

:: Stop any existing NGINX process
echo Stopping any existing NGINX processes...
taskkill /F /IM nginx.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo No running NGINX processes found.
) else (
    echo NGINX process stopped successfully.
)

:: Start NGINX
echo Starting NGINX server...
cd "C:\Users\Sione\Documents\OneDrive\Desktop\GitHub\streaming-website\nginx-rtmp-httpflv-1.17.1-windows-prebuilt\release"
start /b nginx.exe
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start NGINX.
    pause
    exit /b
)
echo NGINX server started successfully.

:: Start Node.js server as a background process
echo Starting Node.js server...
cd "C:\Users\Sione\Documents\OneDrive\Desktop\GitHub\streaming-website"
start /b cmd /c "node server.js >node_server.log 2>&1"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to start Node.js server.
    pause
    exit /b
)
echo Node.js server started successfully.

:: Wait loop for user input
echo ===============================================
echo Servers are running. Type "stop" to terminate.
echo ===============================================

:waitForStop
set /p userInput=Enter "stop" to terminate: 
if /i "%userInput%"=="stop" (
    goto stopServers
) else (
    echo Invalid input. Try again.
    goto waitForStop
)

:stopServers
echo Stopping servers...

:: Stop NGINX gracefully
echo Stopping NGINX server...
taskkill /F /IM nginx.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Failed to stop NGINX gracefully.
) else (
    echo NGINX server stopped successfully.
)

:: Stop Node.js server
echo Stopping Node.js server...
taskkill /F /IM node.exe >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Failed to stop Node.js server gracefully.
) else (
    echo Node.js server stopped successfully.
)

:: Clean up HLS directory
echo Cleaning up HLS files...
del /Q "C:\Users\Sione\Documents\OneDrive\Desktop\GitHub\streaming-website\hls\*"
if %errorlevel% neq 0 (
    echo [ERROR] Failed to clean up HLS files.
) else (
    echo HLS files cleaned successfully.
)

:: End script gracefully
echo ===============================================
echo All tasks completed successfully. Exiting...
echo ===============================================
exit