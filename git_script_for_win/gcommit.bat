@echo off

if "%~1"=="" goto nomsg

git commit -m "%*"

exit /b

:nomsg
git commit