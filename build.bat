@echo off

set project=Bqpl.Exceptions

set config=%1
if "%config%" == "" (
   set config=Release
)

REM Restore Packages by DotNet
call dotnet restore
if not "%errorlevel%"=="0" goto failure

REM Update AssemblyInfo by GitVersion
call %GitVersion% /updateassemblyinfo true
if not "%errorlevel%"=="0" goto failure

REM Build Solution by MSBuild
"%programfiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe" %project%.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false
if not "%errorlevel%"=="0" goto failure

REM Pack
set version=
if not "%PackageVersion%" == "" (
   set version=-Version %PackageVersion%
)
mkdir Build
call %nuget% pack "%project%\%project%.csproj" %version% -Symbols -o Build -p Configuration=%config%
if not "%errorlevel%"=="0" goto failure

:success
exit 0

:failure
exit -1