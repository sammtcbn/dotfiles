@echo off
setlocal enabledelayedexpansion

set currdir=%~dp0

echo %currdir%

for %%a in (%currdir%\*.jpg) do (
  set filename=%%~nxa
  set foldername=!filename:~2,8!
  if not exist %currdir%\!foldername!\ (
    echo mkdir %currdir%\!foldername!
    mkdir %currdir%\!foldername!
  )
  echo move %currdir%\!filename! %currdir%\!foldername!
  move %currdir%\!filename! %currdir%\!foldername!
)

for %%a in (%currdir%\*.mp4) do (
  set filename=%%~nxa
  set foldername=!filename:~2,8!
  if not exist %currdir%\!foldername!\ (
    echo mkdir %currdir%\!foldername!
    mkdir %currdir%\!foldername!
  )
  echo move %currdir%\!filename! %currdir%\!foldername!
  move %currdir%\!filename! %currdir%\!foldername!
)

endlocal

:END