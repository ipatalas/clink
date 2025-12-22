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

:: Configure fzf to use fd (faster than ripgrep and default)
set FZF_CTRL_T_COMMAND=fd --hidden --follow --exclude ".git"
set FZF_ALT_C_COMMAND=fd --type d --hidden --follow --exclude ".git" --exclude "node_modules"

:: Add aliases
doskey /macrofile="%CLINK_DIR%\aliases"

:: Add additional install scripts (wrapped around cmd /c to surpress non-zero exit code
cmd /c "%CLINK_DIR%\clink installscripts %CLINK_DIR%\clink_completions >nul"
cmd /c "%CLINK_DIR%\clink installscripts %CLINK_DIR%\clink-gizmos >nul"
cmd /c "%CLINK_DIR%\clink installscripts %CLINK_DIR%\clink-mise >nul"

cmd /c "%CLINK_DIR%\clink installscripts %CLINK_DIR%\clink-flexprompt >nul"
