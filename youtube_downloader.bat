@echo off
setlocal

:: =======================
:: Configuration Variables
:: =======================
set "YT_DIR=Youtube"
set "YTDLP_EXE=yt-dlp.exe"
set "YTDLP_URL=https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"

set "FFMPEG_ZIP=ffmpeg-master-latest-win64-gpl.zip"
set "FFMPEG_URL=https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/%FFMPEG_ZIP%"

:: =======================
:: User Information
:: =======================
echo This script will download a YouTube video or audio using yt-dlp and save it in the "%YT_DIR%" subfolder.
echo.

:: =======================
:: Ensure Youtube Directory Exists
:: =======================
if not exist "%YT_DIR%" (
    mkdir "%YT_DIR%"
    if errorlevel 1 (
        echo Error: Failed to create the "%YT_DIR%" directory. Exiting.
        exit /b
    )
)

:: =======================
:: Download yt-dlp if Not Present
:: =======================
if not exist "%YT_DIR%\%YTDLP_EXE%" (
    echo yt-dlp not found in "%YT_DIR%". Downloading yt-dlp...
    curl -L "%YTDLP_URL%" -o "%YT_DIR%\%YTDLP_EXE%" --ssl-no-revoke
    if errorlevel 1 (
        echo Error: Failed to download yt-dlp. Please check your internet connection and try again.
        exit /b
    )
)

:: =======================
:: Download and Setup ffmpeg if Not Present
:: =======================
if not exist "%YT_DIR%\ffmpeg.exe" (
    echo ffmpeg not found in "%YT_DIR%". Downloading ffmpeg...
    curl -L "%FFMPEG_URL%" -o "%YT_DIR%\%FFMPEG_ZIP%" --ssl-no-revoke
    if errorlevel 1 (
        echo Error: Failed to download ffmpeg. Please check your internet connection and try again.
        exit /b
    )

    echo Extracting ffmpeg...
    powershell -command "Expand-Archive -Path '%YT_DIR%\%FFMPEG_ZIP%' -DestinationPath '%YT_DIR%'"
    if errorlevel 1 (
        echo Error: Failed to extract ffmpeg. Ensure PowerShell is functioning correctly.
        exit /b
    )

    echo Moving ffmpeg.exe to "%YT_DIR%"...
    move "%YT_DIR%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe" "%YT_DIR%"
    if errorlevel 1 (
        echo Error: Failed to move ffmpeg.exe. Please check permissions and try again.
        exit /b
    )

    echo Cleaning up temporary files...
    del "%YT_DIR%\%FFMPEG_ZIP%"
    rmdir /s /q "%YT_DIR%\ffmpeg-master-latest-win64-gpl"
    if errorlevel 1 (
        echo Warning: Failed to remove temporary ffmpeg folders. Please delete them manually if necessary.
    )
)

:: =======================
:: Prompt for YouTube URL
:: =======================
set /p "url=Enter the YouTube URL: "
if "%url%"=="" (
    echo No URL provided. Exiting.
    exit /b
)

:: =======================
:: Choose Download Format
:: =======================
:choose_format
echo Choose the download format:
echo 1. Video
echo 2. MP3 Audio
set /p "format_choice=Enter choice (1/2): "
if not "%format_choice%"=="1" if not "%format_choice%"=="2" (
    echo Invalid choice. Please enter 1 or 2.
    goto choose_format
)

:: =======================
:: Determine Script Directory
:: =======================
for %%A in ("%~dp0.") do set "script_dir=%%~fA"

:: =======================
:: Start Download
:: =======================
echo Starting download...
if "%format_choice%"=="1" (
    set "format_info=video"
    "%YT_DIR%\%YTDLP_EXE%" -o "%script_dir%\%YT_DIR%\%%(title)s.%%(ext)s" "%url%" --restrict-filenames --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --verbose
) else (
    set "format_info=MP3 audio"
    "%YT_DIR%\%YTDLP_EXE%" -x --audio-format mp3 -o "%script_dir%\%YT_DIR%\%%(title)s.%%(ext)s" "%url%" --restrict-filenames --verbose
)

if errorlevel 1 (
    echo Error: Failed to download the %format_info%. Please ensure the URL is correct and try again.
    exit /b
)

echo Download completed successfully. The %format_info% file has been saved in the "%YT_DIR%" subfolder.
Pause
