import requests

# Get your free API key from: https://openweathermap.org/
api_key = 'YOUR_API_KEY'

city = input('Enter city name: ')

url = f'http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}'

response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    temp = data['main']['temp']
    desc = data['weather'][0]['description']
    print(f'Temperature: {temp} K')
    tempC = round(temp - 273.15,2)
    print(f'Temperature: {tempC} C')
    print(f'Description: {desc}')
else:
    print('Error fetching weather data')
