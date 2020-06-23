@echo off

:: Supprime tout les fichiers et dossiers de temp

echo Suppression fichiers dans %temp%
for /r "%temp%" %%i in ("*") do del /F /Q "%%i"

echo Suppression dossiers dans %temp%
cd %temp%
for /D %%l in (.\*) do rmdir /Q /S "%%l"

:: Nettoyage du disque

echo Nettoyage de l'ordinateur
cd %windir%\system32
cleanmgr.exe /VERYLOWDISK