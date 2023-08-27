
# YouTube Video and Audio Downloader

This script allows you to easily download YouTube videos or audio using `yt-dlp`. It ensures that the necessary tools (`yt-dlp` and `ffmpeg`) are available, downloading and setting them up if not.

## Features

- **Easy Downloads**: Download YouTube videos in MP4 format or audio in MP3 format with a simple command.
- **Automatic Setup**: The script checks for the presence of `yt-dlp` and `ffmpeg`, downloading and setting them up if they're not found.
- **User-Friendly**: Interactive command-line interface with prompts for user input.

## Usage

1. Run the `youtube_downloader.bat` script.
2. Enter the YouTube URL you wish to download.
3. Choose the desired download format (Video or MP3 Audio).
4. Wait for the download to complete. The downloaded file will be saved in the "Youtube" subfolder.

## Requirements

- Windows OS with PowerShell available for extracting zip files.
- Internet connection for downloading `yt-dlp`, `ffmpeg`, and YouTube content.

## Notes

- The script uses the latest version of `yt-dlp` available from its GitHub releases.
- `ffmpeg` is downloaded from the [FFmpeg-Builds releases page](https://github.com/BtbN/FFmpeg-Builds/releases) and is used to process multimedia content.
- All downloads, including the tools and the YouTube content, are saved in a subfolder named "Youtube".

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://github.com/Fynn9563/YT-Vid-MP3/blob/master/LICENSE).
