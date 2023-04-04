# Useful Commands

- Loudness normalization: ffmpeg.exe -i input.mp4 -filter:a loudnorm output_srt.mp4
- Add subtitles: ffmpeg.exe -i input.mp4 -vf subtitles=subtitle.srt output_srt.mp4
- Cut video/audio: ffmpeg.exe -i input.mp4 -ss xx:xx:xx -to yy:yy:yy -c:v copy -c:a copy output.mp4
  - "-ss xx:xx:xx -to yy:yy:yy": Start from x to y (format: 00:00:00)
  - "-c:v copy -c:a": Copy the original audio and video without re-encoding
- Copy and subtitle at the same time: ffmpeg.exe -i input.mp4 -vf subtitles=subtitle.srt -ss xx:xx:xx -to yy:yy:yy output.mp4
