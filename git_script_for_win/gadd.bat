@echo off

if "%~1"=="" goto usage

for %%x in (%*) do (
  git add %%x
)

exit /b

:usage
echo "Usage: gadd [file1] [file2] ..."