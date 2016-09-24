@echo off

set project=Bqpl.Exceptions

set config=%1
if "%config%" == "" (
   set config=Release
)

set version=
if not "%PackageVersion%" == "" (
   set version=-Version %PackageVersion%
)

REM Restore
call dotnet restore
if not "%errorlevel%"=="0" goto failure

REM Build
"%programfiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe" %project%.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false
if not "%errorlevel%"=="0" goto failure

REM Package
mkdir %cd%\Artifacts
call dotnet pack %project% --configuration %config% %version% --output Artifacts
if not "%errorlevel%"=="0" goto failure

:success
exit 0

:failure
exit -1
