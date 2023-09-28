@echo off
title BSPSourceContext

REM Проверка на запуск от имени администратора
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
  title BSPSourceContext - Error
  echo Run this file as an administrator!
  pause>nul
  exit /b
)

REM Существует ли bspsrc.jar
if not exist "%~dp0\bspsrc.jar" (
  title BSPSourceContext - Error
  echo Could not find bspsrc.jar!
  pause>nul
  exit /b
)

title BSPSourceContext - Installing...

REM Записываем значения в реестр HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile" /f /v MUIVerb /d "Decompile"
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile" /f /v Icon /d "\"%~dp0icon.ico\""

REM Записываем значение в реестр HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile\command
reg add "HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile\command" /f /ve /d "\"%~dp0runtime\bin\java\" -jar \"%~dp0bspsrc.jar\" \"%%V\""

REM Всё готово!
title BSPSourceContext - Installing complete!
echo For the changes to take effect, you may need to restart your computer!

pause>nul
