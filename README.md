# YouTube Video and Audio Downloader

This script allows you to easily download YouTube videos or audio using yt-dlp and save them to your local machine. It provides a simple command-line interface to choose between video and MP3 audio formats for downloading.

## Prerequisites

Before using this script, ensure you have the following prerequisites installed:

- Windows Operating System
- [yt-dlp](https://github.com/yt-dlp/yt-dlp): A command-line downloader for YouTube media
- [curl](https://curl.se/): A command-line tool for downloading files from the internet
- [FFmpeg](https://ffmpeg.org/): A powerful multimedia framework for processing audio and video

## FFmpeg Installation

1. Clone or download this repository to your local machine.

2. Download the `ffmpeg-master-latest-win64-gpl-shared.zip` archive from the [FFmpeg-Builds releases](https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip).

3. Extract the contents of the `ffmpeg-master-latest-win64-gpl-shared.zip` archive.

4. Copy the `ffmpeg.exe` executable from the extracted folder to the same directory as the batch script (`youtube_downloader.bat`).
	```markdown
	The directory structure should look like this:

	- YourRepositoryFolder/
	  - youtube_downloader.bat
	  - ffmpeg.exe
	```
## Usage

1. Open a Command Prompt in the repository directory.

2. Run the batch script:

```batch
youtube_downloader.bat
```

3. Follow the prompts to enter the YouTube URL and choose the desired download format (video or MP3 audio).

4. The downloaded media will be saved in the "Youtube" subfolder within the repository directory.

## Important Notes

- Ensure that `ffmpeg.exe` is in the same directory as the batch script for audio processing.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://github.com/Fynn9563/YT-Vid-MP3/blob/master/LICENSE).

---
