# Useful Commands

- Loudness normalization: ffmpeg.exe -i input.mp4 -filter:a loudnorm output_srt.mp4
- Add subtitles: ffmpeg.exe -i input.mp4 -vf subtitles=subtitle.srt output_srt.mp4
