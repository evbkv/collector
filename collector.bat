@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set "output=code.txt"
if exist "%output%" del "%output%"
set first=1

for /r %%f in (*) do (
    set "skipfile=0"
    set "skipcontent=0"
    
    echo "%%f" | findstr /i "\\.git\\" >nul
    if not errorlevel 1 set skipfile=1
    
    if /i "%%~nxf"=="LICENSE" set skipfile=1
    if /i "%%~nxf"=="collector.bat" set skipfile=1
    
    if !skipfile!==0 (
        if /i "%%~xf"==".sqlite" set skipcontent=1
        if /i "%%~xf"==".db" set skipcontent=1
        if /i "%%~xf"==".db3" set skipcontent=1
        if /i "%%~xf"==".sqlite3" set skipcontent=1
        
        if /i "%%~xf"==".ico" set skipcontent=1
        
        if /i "%%~xf"==".jpg" set skipcontent=1
        if /i "%%~xf"==".jpeg" set skipcontent=1
        if /i "%%~xf"==".png" set skipcontent=1
        if /i "%%~xf"==".gif" set skipcontent=1
        if /i "%%~xf"==".bmp" set skipcontent=1
        if /i "%%~xf"==".tiff" set skipcontent=1
        if /i "%%~xf"==".tif" set skipcontent=1
        if /i "%%~xf"==".webp" set skipcontent=1
        if /i "%%~xf"==".psd" set skipcontent=1
        
        if /i "%%~xf"==".svg" set skipcontent=1
        if /i "%%~xf"==".ai" set skipcontent=1
        if /i "%%~xf"==".eps" set skipcontent=1
        if /i "%%~xf"==".pdf" set skipcontent=1
        
        if /i "%%~xf"==".ttf" set skipcontent=1
        if /i "%%~xf"==".otf" set skipcontent=1
        if /i "%%~xf"==".woff" set skipcontent=1
        if /i "%%~xf"==".woff2" set skipcontent=1
        if /i "%%~xf"==".eot" set skipcontent=1
        if /i "%%~xf"==".fon" set skipcontent=1
    )
    
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
            
            if !skipcontent!==0 (
                type "%%f" >> "%output%" 2>nul
            )
        )
    )
)

echo File code.txt created successfully!
pause
