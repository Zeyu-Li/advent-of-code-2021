@echo off
setlocal EnableExtensions 
setlocal enableDelayedExpansion 
@REM for /F %%i in (1.in) do
@REM     @echo %%i

set /a flag=1
set /a previous=1000
@REM set /p previous= 
set /a total=0
set /a curr=0

@REM FOR /F %%x in (1.in) DO (
@REM     set file=%%x
@REM     @REM echo %previous%
@REM     @REM if %%a gtr %previous% @echo "biggger"
@REM     if %%x gtr %previous% (
@REM         set /a total+=1
@REM     )
@REM     @REM if %flag%==1 (
@REM     @REM     set /a flag=0
@REM     @REM ) else (
@REM     @REM     echo %%x
@REM     @REM     @REM echo %curr%
@REM     @REM     if %%x gtr %previous% (
@REM     @REM         set /a total+=1
@REM     @REM     )
@REM     @REM )
@REM     set previous=!file!
@REM     @REM echo !file!
@REM     @REM echo !%previous%!
@REM )

FOR /F %%x in (1.in) DO call :Foo %%x
goto End

:Foo
set file=%1
if %file% gtr %previous% (
    set /a total+=1
)
set previous=!file!
goto :eof

:End

@REM set loopcount=10
@REM :loop
@REM set /p curr= 
@REM if %prev% gtr %curr% (
@REM     set /a total+=1
@REM )
@REM set /a previous=!%curr%!
@REM echo %previous%
@REM set /a curr=0
@REM set /a loopcount-=1
@REM if %loopcount%==0 goto exitloop
@REM goto loop
@REM :exitloop

@REM FOR /L %%p IN (1,1,2000) DO (
@REM     set /p curr= 
@REM     if %prev% gtr %curr% (
@REM         set /a total+=1
@REM     )
@REM     set previous=%curr%
@REM )

echo Total = 
echo !total!