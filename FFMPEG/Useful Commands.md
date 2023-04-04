# Useful Commands

- Loudness normalization: ffmpeg.exe -i input.mp4 -filter:a loudnorm output_srt.mp4
- Add subtitles: ffmpeg.exe -i input.mp4 -vf subtitles=subtitle.srt output_srt.mp4
- Cut video/audio: ffmpeg.exe -i input.mp4 -ss x -to y -c:v copy -c:a copy output.mp4
  - "-ss x -to y": Start from x to y (format: 00:00:00)
  - "-c:v copy -c:a": Copy the original audio and video without re-encoding
