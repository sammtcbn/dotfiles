@echo off

if "%~1"=="" goto usage

for %%x in (%*) do (
  if exist %%x del /s/q/f %%x
  git checkout %%x
)

exit /b

:usage
echo "Usage: regit [file1] [file2] ..."