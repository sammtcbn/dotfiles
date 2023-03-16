@echo off
setlocal enabledelayedexpansion

for %%a in (*.jpg) do (
  set "name=%%~nxa"
  ren "%%a" "!name:~2!"
)

@rem if your files looks like:
@rem   01aaa.jpg
@rem   02bbb.jpg
@rem   03ccc.jpg
@rem after execute this batch , it will rename as below:
@rem   aaa.jpg
@rem   bbb.jpg
@rem   ccc.jpg