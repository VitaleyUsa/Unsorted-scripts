
:: HKEY_CURRENT_USER\Software\Microsoft\SystemCertificates
:: My - Личные
:: Root - Доверенные корневые центры сертификации
:: Trust - Доверительные отношения в предприятии
:: CA - Промежуточные центры сертификации
:: AuthRoot - Сторонние корневые центры центры сертификации
:: TrustedPublisher - Довереннные издатели
:: TrustedPeople - Доверенные лица
:: AddressBook - Другие пользователи

@echo off
:: BatchGotAdmin
::-------------------------------------
::REM  --> Check for permissions
::>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

::REM --> If error flag set, we do not have admin.
::if '%errorlevel%' NEQ '0' (
::    echo Requesting administrative privileges...
::    goto UACPrompt
::) else ( goto gotAdmin )

:::UACPrompt
::    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
::    set params = %*:"="
::    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

::    "%temp%\getadmin.vbs"
::    del "%temp%\getadmin.vbs"
::    exit /B

:::gotAdmin
::    pushd "%CD%"
::    CD /D "%~dp0"
::--------------------------------------

:: Очищаем старые CRL и сертификаты в неправильных хранилищах
call %~dp0/CertHelper.exe

:: Головной удостоверяющий и УЦ_1
certutil.exe -addstore -f Root %~dp0/certs/root.cer
certutil.exe -addstore -f CA  %~dp0/certs/uc1.0_ca.cer
certutil.exe -addstore -f CA %~dp0/certs/uc1.1_ca.cer 
certutil.exe -addstore -f CA %~dp0/certs/uc1.2_ca.cer 

:: Касперский / открытие гос. сайтов
certutil.exe -addstore -f Root %~dp0/certs/rootca_ssl_rsa2022.cer

:: УЦ ФЦИИТ
certutil.exe -addstore -f CA %~dp0/certs/fond_1.cer 
certutil.exe -addstore -f CA %~dp0/certs/fond_2.cer 
certutil.exe -addstore -f CA %~dp0/certs/fond_3.cer 
certutil.exe -addstore -f CA %~dp0/certs/fond_4.cer 

:: ЕИС "Реестр нотариальных дел"
::certutil.exe -addstore -f AddressBook %~dp0/certs/FNP2018-2019.cer
::certutil.exe -addstore -f AddressBook %~dp0/certs/FNP2019-2020.cer
certutil.exe -addstore -f AddressBook %~dp0/certs/FNP2020-202-0.cer
certutil.exe -addstore -f AddressBook %~dp0/certs/FNP2020-2021-1.cer
certutil.exe -addstore -f AddressBook %~dp0/certs/FNP2021-2022.cer

:: ЕИС "Обращения в Росреестр" (тех. работник)
certutil.exe -addstore -f Root %~dp0/certs/notariat-root.cer
certutil.exe -addstore -f Root %~dp0/certs/notariat-root_1.cer

:: Минцифры
certutil.exe -addstore -f Root %~dp0/certs/mincifri_1.cer

:: УЦ Росреестр
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_1.cer 
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_2.cer 
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_3.cer 
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_4.cer 
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_5.cer 
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_6.cer 

:: УЦ Росреестр -> Минцифры
certutil.exe -addstore -f CA %~dp0/certs/rosreestr_mincifri_1.cer

:: УЦ Минкомсвязь
certutil.exe -addstore -f Root %~dp0/certs/mincom_root.cer 
certutil.exe -addstore -f Root %~dp0/certs/mincom_root_2.cer 
certutil.exe -addstore -f CA %~dp0/certs/mincom_1.cer 

:: УЦ ПФР
certutil.exe -addstore -f CA %~dp0/certs/PFR.cer

:: УЦ Тензор (бух. отчетность + ОМС)
certutil.exe -addstore -f CA %~dp0/certs/tensor_1.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_2.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_4.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_5.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_6.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_7.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_8.cer
certutil.exe -addstore -f CA %~dp0/certs/tensor_9.cer

:: УЦ ГНИВС
certutil.exe -addstore -f CA %~dp0/certs/gnivc_1.cer
certutil.exe -addstore -f CA %~dp0/certs/gnivc_2.cer
certutil.exe -addstore -f CA %~dp0/certs/gnivc_3.cer
certutil.exe -addstore -f CA %~dp0/certs/gnivc_4.cer
certutil.exe -addstore -f CA %~dp0/certs/gnivc_5.cer
certutil.exe -addstore -f CA %~dp0/certs/gnivc_6.cer

:: УЦ ФНС
certutil.exe -addstore -f CA %~dp0/certs/fns_1.cer 
certutil.exe -addstore -f CA %~dp0/certs/fns_2.cer 
certutil.exe -addstore -f CA %~dp0/certs/fns_3.cer
certutil.exe -addstore -f CA %~dp0/certs/fns_4.cer
certutil.exe -addstore -f CA %~dp0/certs/fns_5.cer

:: УЦ e-Notary
certutil.exe -addstore -f CA %~dp0/certs/e-notary.cer 

:: УЦ ТехноКад
certutil.exe -addstore -f CA %~dp0/certs/ca_technokad_1.cer
certutil.exe -addstore -f CA %~dp0/certs/ca_technokad_2.cer

:: УЦ ГАС "Правосудие"
certutil.exe -addstore -f CA %~dp0/certs/gas.cer 
certutil.exe -addstore -f CA %~dp0/certs/gas_2.cer 

:: УЦ Траст
certutil.exe -addstore -f CA %~dp0/certs/trust_1.cer 

:: УЦ Казначейство
certutil.exe -addstore -f CA %~dp0/certs/kazna_1.cer 
certutil.exe -addstore -f CA %~dp0/certs/kazna_2.cer
certutil.exe -addstore -f CA %~dp0/certs/kazna_3.cer

:: КриптоПро NGate - доверенный издатель
certutil.exe -addstore -f TrustedPublisher %~dp0/certs/llc_crypto_pro.cer

:: СОС ГУЦ, Росреестр, ФЦИИТ
for %%a in (revoked.crl, revoked2.crl, revoked3.crl, revoked4.crl, revoked5.crl, revoked6.crl)  do if not exist %%a (
	%~dp0/../wget.exe https://uc.kadastr.ru/revoke/index/%%a --timeout=5 --tries=5 --no-check-certificate)
	
::for %%b in (guc.crl, vguc2.crl, vguc1_2.crl, vguc1_3.crl, vguc1_4.crl, vguc1_5.crl, vguc1_6.crl, vguc2_2.crl, guc_gost12.crl, guc2021.crl, vguc1.crl)   do if not exist %%b (
::	%~dp0/../wget.exe http://rostelecom.ru/cdp/%%b --timeout=5 --tries=5  --no-check-certificate)
	
::for %%d in (dd391a43ba20d5d80cea48df8b62e04030228be2.crl, efdd1b93a5c1fae883c5aa893ef465f055a093f5.crl, e34664375ed34fca819c9794fa968887f7ce1cd8.crl, 7f48212cbe54f57a3118256aba6471e0934a3c9c.crl)   do if not exist %%d (
::	%~dp0/../wget.exe http://cdp2.fciit.ru/cdp/%%d --timeout=5 --tries=5  --no-check-certificate)
	
for %%e in (ac53bead76ac54d0880675d705c58b01b5abbe94.crl, 163d4290bf0a9c881766b9264f928470a3d705db.crl)   do if not exist %%d (
	%~dp0/../wget.exe http://uc.nalog.ru/cdp/%%e --timeout=5 --tries=5  --no-check-certificate)	


for %%s in (*.crl) do certutil.exe -addstore -f CA %%s
for %%s in (*.crl) do del %%s

color a