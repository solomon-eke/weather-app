import 'dart:convert';
import 'package:http/http.dart' as http;

/// This service handles API calls to OpenWeatherMap
class WeatherService {
  // Base URL for the OpenWeatherMap current weather endpoint
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  /// Fetch weather data by city name
  static Future<Map<String, dynamic>> fetchWeatherByCity(
    String city,
    String apiKey,
  ) async {
    final url = Uri.parse("$baseUrl?q=$city&appid=$apiKey&units=metric");
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Fetch weather data by geographic coordinates
  static Future<Map<String, dynamic>> fetchWeatherByCoords(
    double lat,
    double lon,
    String apiKey,
  ) async {
    final url = Uri.parse(
      "$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
    );
    final response = await http.get(url);
    return _handleResponse(response);
  }

  /// Handle API response and convert to a usable map
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load weather: ${response.statusCode}");
    }
  }
}
