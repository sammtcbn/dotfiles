@rem refer to https://github.com/mobilemind/dosbash/blob/master/npp.bat
@FOR %%f IN (%*) DO @start "Notepad++" "%PROGRAMFILES%\Notepad++\notepad++.exe" "%%f"