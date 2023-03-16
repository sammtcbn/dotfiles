@echo off
setlocal enabledelayedexpansion

for %%a in (*.mp3) do (
  set "name=%%~nxa"
  ren "%%a" "!name:~,2!.mp3"
)

@rem if your files looks like:
@rem   01 aaa.mp3
@rem   02 bbb.mp3
@rem   03 ccc.mp3
@rem after execute this batch , it will rename as below:
@rem   01.mp3
@rem   02.mp3
@rem   03.mp3