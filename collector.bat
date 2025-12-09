@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set "output=code.txt"
if exist "%output%" del "%output%"
set first=1

for /r %%f in (*) do (
    set "skipfile=0"
    
    echo "%%f" | findstr /i "\\.git\\" >nul
    if not errorlevel 1 set skipfile=1
    
    if /i "%%~nxf"=="LICENSE" set skipfile=1
    if /i "%%~nxf"=="collect_files.bat" set skipfile=1
    if /i "%%~xf"==".sqlite" set skipfile=1
    
    if !skipfile!==0 (
        if not exist "%%f\" (
            if !first!==1 (
                set first=0
            ) else (
                echo. >> "%output%"
                echo. >> "%output%"
                echo -- >> "%output%"
                echo. >> "%output%"
            )
            
            for /f "delims=" %%p in ('powershell -Command "Resolve-Path -Relative '%%f'"') do (
                set "relpath=%%p"
            )
            
            if "!relpath:~0,2!"==".\" set "relpath=!relpath:~2!"
            
            if "!relpath!"=="%%~nxf" (
                echo !relpath! >> "%output%"
                echo !relpath!
            ) else (
                echo \!relpath! >> "%output%"
                echo \!relpath!
            )
            
            echo. >> "%output%"
            type "%%f" >> "%output%" 2>nul
        )
    )
)

echo File code.txt created successfully!
pause