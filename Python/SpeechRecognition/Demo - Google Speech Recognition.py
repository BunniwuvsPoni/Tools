import speech_recognition as sr

# Displays teh current SpeechRecognition version
print(sr.__version__)

# Obtain path to "english.wav" in the same folder as this script
from os import path
AUDIO_FILE = path.join(path.dirname(path.realpath(__file__)), "english.wav")

# Use the audio file as the audio source
r = sr.Recognizer()
with sr.AudioFile(AUDIO_FILE) as source:
    # Adjustment for ambient noise, default is 1 second and cuts off the source/speech recognition file by the same duration
    r.adjust_for_ambient_noise(source)
    # Read the entire audio file
    audio = r.record(source)

# Recognize speech using Google Speech Recognition
try:
    # For testing purposes, we're just using the default API key
    # To use another API key, use `r.recognize_google(audio, key="GOOGLE_SPEECH_RECOGNITION_API_KEY")`
    # instead of `r.recognize_google(audio)`
    print("Google Speech Recognition thinks you said: " + r.recognize_google(audio))
except sr.UnknownValueError:
    print("Google Speech Recognition could not understand audio")
except sr.RequestError as e:
    print("Could not request results from Google Speech Recognition service; {0}".format(e))
