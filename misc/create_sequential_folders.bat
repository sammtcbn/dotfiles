@echo off
setlocal enableDelayedExpansion
set prefix=
set startp=1
set endp=5
set step=1

for /L %%n in (%startp%,%step%,%endp%) do (
    set foldername=!prefix!%%n
    mkdir !foldername!
)