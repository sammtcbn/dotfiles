@echo off

if "%~1"=="" (
    echo Usage: %~n0 [IP]
    goto END	
)

ssh sam@%1 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

:END
