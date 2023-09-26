@echo off
title UnistallContext

REM Проверка на запуск от имени администратора
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
  title UnistallContext - Error
  echo Run this file as an administrator!
  pause>nul
  exit /b
)

REM Точно стереть ассоциации?
title UnistallContext - Waiting for input...
echo [Y/N] - Uninstall context?
choice /c yn /n
if %errorlevel% == 1 (
  REM Удаляем
  title UnistallContext - Installing...

  REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.bsp\shell\decompile" /f

  REM Всё готово!
  title UnistallContext - Uninstalling complete!
  echo For the changes to take effect, you may need to restart your computer!
  pause>nul
) else (
  exit /b
)