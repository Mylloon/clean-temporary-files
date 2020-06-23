@echo off

:: Lance en tant qu'administrateur
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Demander des droits d'administrateur...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  

:: Supprime tout les fichiers de temp, %temp% et %windir%\Prefetch

echo Suppression fichiers dans %temp%
for /r "%temp%" %%i in ("*") do del /F /Q "%%i"

echo Suppression fichiers dans %windir%\Temp
for /r "%windir%\Temp" %%j in ("*") do del /F /Q "%%j"

echo Suppression fichiers dans %windir%\Prefetch
for /r "%windir%\Prefetch" %%k in ("*") do del /F /Q "%%k"

:: Supprime tout les dossiers de temp, %temp% et %windir%\Prefetch

echo Suppression dossiers dans %temp%
cd %temp%
for /D %%l in (.\*) do rmdir /Q /S "%%l"

echo Suppression dossiers dans %windir%\Temp
cd %windir%\Temp
for /D %%m in (.\*) do rmdir /Q /S "%%m"

echo Suppression dossiers dans %windir%\Prefetch
cd %windir%\Prefetch
for /D %%n in (.\*) do rmdir /Q /S "%%n"