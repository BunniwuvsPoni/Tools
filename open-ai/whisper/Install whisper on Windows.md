# How-To install open-ai's whisper on Windows 10

1. Install python (as at 04/02/2023, whisper does not support the latest python v3.11.2 so use v3.10.10 instead)
2. Install whisper: pip install -U openai-whisper
3. Install Microsoft Visual C++ Redistributable: https://aka.ms/vs/16/release/vc_redist.x64.exe
4. Install FFMPEG with PATH configured

Run whisper with the following command:

whisper.exe (audio file path)

whisper audio.flac audio.mp3 audio.wav --model (size) --language (language)

Note:

- Output files will appear in the same directory the command was run from

- Add the flag "--fp16 False" if you get the warning: "FP16 is not supported on CPU; using FP32 instead"
