@echo off

if "%~1"=="" goto noarg

git diff --name-status %1

exit /b

:noarg
git diff --name-status