@echo off
color 0A
title Appolo1015 - System Configuration Tool   (CyberCenturion IV)

:Welcome
	cls
	
	echo Welcome to the Appolo1015 System Configuration Tool for CyberCenturion IV
	echo Version Number: 2018.0.1
	echo.
	echo WARNING: You may need administrator privileges for parts of this program to work.
	echo.
	
	pause
	goto :MainMenu
	
:MainMenu
	cls
	
	echo Main Menu
	echo ---------
	echo.
	echo 1. Auto-fix vulnerabilities
	echo.
	echo 2. User manager
	echo.
	echo 3. File Search
	echo.
	echo 4. Other stuff
	echo.
	echo 5. Exit
	echo.
	echo.
	set/p "option=Enter a number to make a selection:"
	
	if %option%==1 goto :Autofix
	if %option%==2 goto :UserManager
	if %option%==3 goto :FileSearch
	if %option%==4 goto :OtherStuff
	if %option%==5 exit
	
	goto :MainMenu
	
	
	
:Autofix
	cls
	echo Auto-fix
	echo --------
	echo.
	echo The following program will fix the following vulnerabilities:
	echo.
	echo Enable Firewall
	echo Disable Guest Account
	echo Enable Automatic Updates
	echo Enable User Account Control
	echo Set Security Polity Settings
	echo.
	echo Before each action is run, there will be a 'y or n' prompt asking whether you want each action to run
	echo IF THE README SAYS IT'S CRITICAL, DON'T RUN IT!
	echo.
	
	pause
	
	REM Enable firewall
	cls
	echo ENABLE FIREWALL
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y netsh advfirewall set allprofiles state on
		
	pause
	
	
	REM Disable guest account
	cls
	echo DISABLE GUEST ACCOUNT
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y net user guest /active:no
		
	pause
	
	
	REM Enable automatic updates
	cls
	echo ENABLE AUTOMATIC UPDATES
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f
		
	pause
	
	
	REM Enable user account control
	cls
	echo ENABLE USER ACCOUNT CONTROL
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
	pause
	
	
	REM Set secpol settings
	cls
	echo SET SECURITY POLICY SETTINGS
	echo.
	echo This will set the following settings:
	echo.
	echo Minimum password length:	8
	echo Minimum password age:		5
	echo Maximum password age:		90
	echo Password history:			5
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y (
		net accounts /minpwlen:8
		net accounts /minpwage:5
		net accounts /maxpwage:90
		net accounts /uniquepw:5
	)
	pause
	
	REM Set secpol settings - pw complexity and reversible encryption
	cls
	echo SET SECURITY POLICY SETTINGS
	echo.
	echo The following will set the password complexity and reverisble encryption settings
	echo This involves manual editing of a file
	echo.
	set/p "option=Do you want to perform this action? y or n:"
	
	if %option%==y (
		cls
		echo A notepad file will open.
		echo.
		echo YOU MUST MANUALLY EDIT THE FOLLOWING SETTINGS:
		echo.
		echo PasswordComplexity = 1
		echo ClearTextPassword = 0
		echo.
		echo Then save and close
		echo.
		pause
		
		secedit.exe /export /cfg C:\secconfig.cfg
		
		cls
		echo When the file has been edited, save it and close it
		
		notepad C:\secconfig.cfg
		
		secedit.exe /configure /db %windir%\securitynet.sdb /cfg C:\secconfig.cfg /areas SECURITYPOLICY
	)
	pause
	
	
	
	pause
	goto :MainMenu
	
	
	
:UserManager
	cls
	echo User Manager.
	pause
	goto :MainMenu
	
	
	
:FileSearch
	cls
	echo File Search.
	pause
	goto :MainMenu
	
	
	
:OtherStuff
	cls
	echo Other Stuff.
	pause
	goto :MainMenu