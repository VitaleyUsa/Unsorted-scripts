setlocal enabledelayedexpansion
set WinLibDir=C:\Windows\SysWow64
set eNotPath=C:\Triasoft\eNot

regsvr32.exe /s %WinLibDir%\ActiveTree.ocx
regsvr32.exe /s %WinLibDir%\ActiveTree2.0.ocx
regsvr32.exe /s %WinLibDir%\msvcr120.dll
regsvr32.exe /s %WinLibDir%\capicom.dll
regsvr32.exe /s %WinLibDir%\enotddb2.dll
regsvr32.exe /s %WinLibDir%\msmask32.ocx
regsvr32.exe /s %WinLibDir%\vstwain.dll 
regsvr32.exe /s %eNotPath%\eNotTX23.dll
regsvr32.exe /s %eNotPath%\eNotTXres.dll

cd %eNotPath%\TX
::for /r %%a in (*.dll) do regsvr32 /s %%a
for /r %%a in (*.ocx) do regsvr32 /s %%a

cd %eNotPath%\TX23
::for /r %%a in (*.dll) do regsvr32 /s %%a
for /r %%a in (*.ocx) do regsvr32 /s %%a

cd %eNotPath%\TX25
::for /r %%a in (*.dll) do regsvr32 /s %%a
for /r %%a in (*.ocx) do regsvr32 /s %%a