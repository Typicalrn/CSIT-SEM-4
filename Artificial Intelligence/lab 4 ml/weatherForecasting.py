# Weather Forecasting Expert System
def predict_weather(temperature, humidity, cloud, wind):
    if humidity > 80 and cloud > 70:
        return "Rainy"
    elif humidity > 70 and cloud > 50:
        return "Possibly Rainy"
    elif temperature > 30 and humidity < 50:
        return "Hot and Sunny"
    elif temperature < 15 and cloud < 40:
        return "Cold and Clear"
    elif wind > 40:
        return "Windy"
    else:
        return "Partly Cloudy"
print("===== WEATHER EXPERT SYSTEM =====")
temperature = float(input("Enter temperature (°C): "))
humidity = float(input("Enter humidity (%): "))
cloud = float(input("Enter cloud coverage (%): "))
wind = float(input("Enter wind speed (km/h): "))
prediction = predict_weather(
 temperature,
 humidity,
 cloud,
 wind
)
print("\nPredicted Weather:", prediction)