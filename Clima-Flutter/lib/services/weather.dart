import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '9e6bb6127ea388e147b3125bb1689ab8';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    final networkHelper = NetworkHelper(
        url: '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey'
    );

    return await networkHelper.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    final networkHelper = NetworkHelper(
        url: '$openWeatherMapUrl?q=$cityName&units=metric&appid=$apiKey'
    );

    return await networkHelper.getData();
  }
}
