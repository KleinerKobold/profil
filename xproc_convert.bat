@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

IF EXIST Profile.pdf del Profile.pdf

REM Finde alle jars für den classpath
set FOPDIR=fop-1.1
set CALABASHDIR=calabash-1.0.16-94
set cp=
for /r %FOPDIR% %%i in (build\*.jar lib\*.jar) do set cp=!cp!;"%%i"
for /r %CALABASHDIR% %%i in (*.jar) do set cp=!cp!;"%%i"

java -classpath %cp% com.xmlcalabash.drivers.Main transform.xpl

IF EXIST Profile.pdf Profile.pdf


ENDLOCAL
