@echo off

SET TARGET_DIR=%1

for /f "tokens=1-4 delims=-/ " %%i IN ("%date%") DO (
  set year=%%i
  set month=%%j
  set day=%%k
)

for /f "tokens=1-4 delims=:." %%i IN ("%time%") DO (
  set hour=%%i
  set minute=%%j
  set second=%%k
  set centisecond=%%l
)

@rem echo %year%-%month%-%day% %hour%:%minute%:%second%.%centisecond%

set currtime=%year%%month%%day%-%hour%%minute%%second%
@rem echo %currtime%

if exist %TARGET_DIR% (
	@rem echo folder exist
	SET fn="%TARGET_DIR%-%currtime%.tar.gz"
	echo compressing %fn% ...
	tar zcfv "%fn%" "%TARGET_DIR%"
) else (
    echo folder doesn't exist
)