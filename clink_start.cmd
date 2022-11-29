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
set HOME=%USERPROFILE%

:: Extra env vars

::   use ripgrep instead of dir for fzf (faster)
set FZF_CTRL_T_COMMAND=rg --files --hidden --follow --glob "!.git"

:: Add aliases
doskey /macrofile="%CLINK_DIR%\aliases"

:: Add additional install scripts (wrapped around cmd /c to surpress non-zero exit code
cmd /c "%CLINK_DIR%\clink installscripts %CLINK_DIR%\clink_completions >nul"
