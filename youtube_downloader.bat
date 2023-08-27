@echo off
setlocal

echo This script will download a YouTube video or audio using yt-dlp, save it in a subfolder named "Youtube".
echo.

:: Specify the filename and URL for the yt-dlp executable.
set "yt_dlp_filename=yt-dlp.exe"
set "yt_dlp_url=https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"

:: Create a subfolder named "Youtube" if it doesn't exist.
if not exist "Youtube" (
    mkdir "Youtube"
)

:: Check if yt-dlp is present in the "Youtube" subfolder or download it.
if not exist "Youtube\%yt_dlp_filename%" (
    echo yt-dlp is not found in the "Youtube" subfolder. Downloading yt-dlp...
    curl -L "%yt_dlp_url%" -o "Youtube\%yt_dlp_filename%" --ssl-no-revoke
)

:: Specify the filename and URL for the ffmpeg zip file.
set "ffmpeg_zip_filename=ffmpeg-master-latest-win64-gpl.zip"
set "ffmpeg_zip_url=https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip" 

:: Set download location
if "%download_location%"=="" set "download_location=Youtube"

:: Check if ffmpeg is present in the specified folder or download and extract it.
if not exist "%download_location%\ffmpeg.exe" (
    echo ffmpeg is not found in the specified folder. Downloading ffmpeg...
    curl -L "%ffmpeg_zip_url%" -o "%download_location%\%ffmpeg_zip_filename%" --ssl-no-revoke
    echo Extracting ffmpeg...
    powershell -command "Expand-Archive -Path '%download_location%\%ffmpeg_zip_filename%' -DestinationPath '%download_location%'"
    
    echo Copying ffmpeg.exe to the specified folder...
    copy "%download_location%\ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe" "%download_location%\ffmpeg.exe"
    
    echo Cleaning up...
    del "%download_location%\%ffmpeg_zip_filename%"
    rmdir /s /q "%download_location%\ffmpeg-master-latest-win64-gpl"
)

set /p "url=Enter the YouTube URL: "
echo.

if "%url%"=="" (
    echo No URL provided. Exiting.
    pause
    exit /b
)

:choose_format
echo Choose the download format:
echo 1. Video
echo 2. MP3 Audio

set /p "format_choice=Enter choice (1/2): "
echo.

if "%format_choice%"=="1" (
    set "output_ext=mp4"
    set "format_info=video"
) else if "%format_choice%"=="2" (
    set "output_ext=mp3"
    set "format_info=MP3 audio"
) else (
    echo Invalid choice. Please choose 1 or 2.
    goto choose_format
)

echo Starting download...
echo.

REM Getting the directory where the script is located.
for %%A in ("%~dp0.") do set "script_dir=%%~fA"

:: Using yt-dlp to download the video or audio.
if "%format_choice%"=="1" (
    "Youtube\%yt_dlp_filename%" -o "%script_dir%\Youtube\%%(title)s.%%(ext)s" "%url%" --restrict-filenames --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --verbose
) else if "%format_choice%"=="2" (
    "Youtube\%yt_dlp_filename%" -x --audio-format mp3 -o "%script_dir%\Youtube\%%(title)s.%%(ext)s" "%url%" --restrict-filenames --verbose
)

echo.
echo Download completed. The %format_info% file has been saved in the "Youtube" subfolder.

echo.
echo Processing completed. The processed file has been saved in the "Youtube" subfolder.
Pause
