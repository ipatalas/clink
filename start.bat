@echo off

:: Check Git installation path
if exist "%ProgramFiles%\Git" (
    set "GIT_INSTALL_ROOT=%ProgramFiles%\Git"
) else if exist "%ProgramFiles(x86)%\Git" (
    set "GIT_INSTALL_ROOT=%ProgramFiles(x86)%\Git"
) else if exist "%LocalAppData%\Programs\Git" (
	set "GIT_INSTALL_ROOT=%LocalAppData%\Programs\Git"
)

:: Add git to the path
if defined GIT_INSTALL_ROOT (
    set "PATH=%GIT_INSTALL_ROOT%\bin;%GIT_INSTALL_ROOT%\usr\bin;%PATH%"
)

:: Enhance Path
set PATH=%CLINK_DIR%\bin;%PATH%

:: Add aliases
doskey /macrofile="%CLINK_DIR%\aliases"

:: start "Clink" cmd.exe /s /k ""%~dpnx0" inject %clink_profile_arg%%clink_quiet_arg%"
cmd.exe /s /k "%CLINK_DIR%\clink_x64.exe inject --profile %CLINK_DIR%\profile"
