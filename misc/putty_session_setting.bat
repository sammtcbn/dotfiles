@echo off

if "%~1"=="" goto usage

for %%x in (%*) do (
  @rem change putty folder color to 85,85,255
  reg add HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\%%x  /v Colour14 /d 85,85,255 /f
)

exit /b

:usage
echo Usage:
echo         putty_session_setting [Session1Name] [Session2Name] ...
echo Example:
echo         putty_session_setting server1 server2 server3