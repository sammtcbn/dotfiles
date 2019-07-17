@rem ref to https://stackoverflow.com/questions/13023920/how-to-export-import-putty-sessions-list

regedit /e "%USERPROFILE%\Desktop\putty-sessions.reg" HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions
