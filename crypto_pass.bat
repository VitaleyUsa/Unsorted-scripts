@echo off
cd C:\Distr\Notary\Tools\software

SetLocal EnableExtensions EnableDelayedExpansion
copy "C:\Program Files\Crypto Pro\CSP\csptest.exe" >nul
chcp 1251
if exist CryptoPass.txt del /f /q CryptoPass.txt
if exist temp.txt del /f /q temp.txt
set NameK=""
for /f "usebackq tokens=3,4* delims=\" %%a in (`csptest -keyset -enum_cont -fqcn -verifycontext` ) do (
set NameK=%%a
;csptest -passwd -showsaved -container "!NameK!" >> temp.txt
)
del /f /q csptest.exe
set/a $ai=-1
set/a $bi=2
for /f "usebackq delims=" %%a in ("temp.txt") do @(set "$a=%%a"
if "!$a:~,14!"=="AcquireContext" echo:!$a! >> CryptoPass.txt
if "!$a:~,8!"=="An error" echo:Увы, ключевой носитель отсутствует или пароль не был сохранен. >> CryptoPass.txt & echo: >> CryptoPass.txt
if "!$a:~,5!"=="Saved" set/a $ai=1
if !$ai! geq 0 set/a $ai-=1 & set/a $bi-=1 & echo:!$a! >> CryptoPass.txt
if !$bi!==0 echo: >> CryptoPass.txt & set/a $bi=2
)
del /f /q temp.txt
EndLocal
echo on

