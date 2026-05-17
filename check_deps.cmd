@echo off
setlocal enabledelayedexpansion

:: List your submodule directories here (space separated)
set "folders=clink-completions clink-gizmos clink-mise"

echo ========================================================
echo Checking for Upstream Updates (Original Repos)
echo ========================================================

for %%f in (%folders%) do (
    if exist "%%f\.git" (
        echo.
        echo [%%f]
        pushd "%%f"

        REM Reset per-iteration variables to avoid bleed-over between repos
        set "behind=0"
        set "branch="
        set "remote="

        REM 1. Resolve which remote to use:
        REM    Prefer 'upstream' (fork workflow), fall back to 'origin' (plain submodule)
        git remote get-url upstream >nul 2>&1
        if !errorlevel! equ 0 (
            set "remote=upstream"
            echo ^(fork - using remote: upstream^)
        ) else (
            git remote get-url origin >nul 2>&1
            if !errorlevel! equ 0 (
                set "remote=origin"
                echo ^(submodule - using remote: origin^)
            )
        )

        @REM 2. Abort if no usable remote was found at all
        if "!remote!"=="" (
            echo [^!] Skip: No 'upstream' or 'origin' remote found.
        ) else (
            REM 3. Fetch the latest from the chosen remote
            echo Fetching from !remote!...
            git fetch !remote! -q

            REM 4. Detect default branch (main or master)
            REM    Try 'main' first, then 'master', then give up
            git rev-parse --verify !remote!/main >nul 2>&1
            if !errorlevel! equ 0 (
                set "branch=main"
            ) else (
                git rev-parse --verify !remote!/master >nul 2>&1
                if !errorlevel! equ 0 (
                    set "branch=master"
                )
            )

            REM 5. Abort if neither standard branch was found
            if "!branch!"=="" (
                echo [^!] Skip: Could not find !remote!/main or !remote!/master.
                echo     Check the default branch name and set it manually.
            ) else (
                REM 6. Warn if HEAD is detached (merge advice would be misleading)
                set "headRef="
                for /f %%h in ('git symbolic-ref --short HEAD 2^>nul') do set "headRef=%%h"
                if "!headRef!"=="" (
                    echo [^!] Warning: Repository is in detached HEAD state.
                    echo     Commit count vs !remote!/!branch! may be inaccurate.
                )

                REM 7. Count commits between local HEAD and the chosen remote
                for /f %%c in ('git rev-list --count HEAD..!remote!/!branch! 2^>nul') do set "behind=%%c"

                if "!behind!"=="0" (
                    echo [OK] Up to date with !remote!/!branch!.
                ) else (
                    echo [UPDATE] Behind !remote!/!branch! by !behind! commit^(s^).
                    echo     To see changes: git log HEAD..!remote!/!branch! --oneline
                    echo     To merge:       git merge !remote!/!branch!
                )
            )
        )

        popd
    ) else (
        echo [%%f]
        echo [^!] Skip: Directory not found or not a git repo.
    )
)

echo ========================================================
pause