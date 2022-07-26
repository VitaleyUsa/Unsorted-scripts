sc config lanmanserver start=auto
sc config Dnscache start=auto
sc config SSDPSRV start=auto
sc config upnphost start=auto
sc config FDResPub start=auto
sc config bowser start=auto

powershell $net = get-netconnectionprofile;Set-NetConnectionProfile -Name $net.Name -NetworkCategory Private
netsh advfirewall firewall set rule group="Обнаружение сети" new enable=Yes
netsh advfirewall firewall set rule group="Общий доступ к файлам и принтерам" new enable=Yes

reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v everyoneincludesanonymous /t REG_DWORD /d 1 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /v restrictnullsessaccess /t REG_DWORD /d 0 /f

sc.exe config lanmanworkstation depend=bowser/mrxsmb10/mrxsmb20/nsi
sc.exe config mrxsmb10 start=auto

reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f

::set "SystemPath=%SystemRoot%\System32"
::if not "%ProgramFiles(x86)%"=="" set "SystemPath=%SystemRoot%\SysWow"

%SystemRoot%\System32\dism.exe /Online /Enable-Feature /All /FeatureName:SMB1Protocol -NoRestart
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /All /FeatureName:SMB1Protocol-Client  -NoRestart
%SystemRoot%\System32\dism.exe /Online /Enable-Feature /All /FeatureName:SMB1Protocol-Server -NoRestart
%SystemRoot%\System32\dism.exe /Online /Disable-Feature /FeatureName:SMB1Protocol-Deprecation -NoRestart
powershell Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart
powershell Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Client" -NoRestart
powershell Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol-Server" -NoRestart


@echo off
echo 1. Get sid guest variable
for /f "delims= " %%a in ('"wmic useraccount where name='Гость' get sid"') do (
       if not "%%a"=="SID" (          
          set sid_guest=%%a
          goto :loop_end
       )   
    )

:loop_end

echo 2. Create script for regini
@echo \Registry\Machine\SECURITY [1 5 7 11 17 21]> x
@echo \Registry\Machine\SECURITY\policy [1 5 7 11 17 21]>> x
@echo \Registry\Machine\SECURITY\policy\accounts [1 5 7 11 17 21]>> x
@echo \Registry\Machine\SECURITY\policy\accounts\%sid_guest% [1 5 7 11 17 21]>> x
@echo \Registry\Machine\SECURITY\policy\accounts\%sid_guest%\ActSysAc [1 5 7 11 17 21]>> x

echo 3. Add permission for machine/security
net user Гость /active:yes
regini x
del x
@echo Windows Registry Editor Version 5.00 > y.reg
@echo [HKEY_LOCAL_MACHINE\SECURITY\Policy\Accounts\%sid_guest%\ActSysAc] >> y.reg
@echo @=hex(0):41,00,00,00 >> y.reg
reg import y.reg
del y.reg