@echo off

set config=%1
if "%config%" == "" (
   set config=Release
)

set version=
if not "%PackageVersion%" == "" (
   set version=-Version %PackageVersion%
)

call %GitVersion% /updateassemblyinfo true

"%programfiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe" Solution.sln /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false

mkdir Build
call %nuget% pack "Bqpl.Contracts\Bqpl.Contracts.csproj" -symbols -o Build -p Configuration=%config% %version%
