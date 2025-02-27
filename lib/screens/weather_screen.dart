import 'package:flutter/material.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/models/weather_model.dart';
import 'package:weather_application/weather_card/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;

  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherService.fetchingWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      },
      );
    } 
    catch (e) {

      // To check the API status response
      // print('Error: $e');



      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _weather != null
              ? _getWeatherGradient(_weather!.description)
              :  LinearGradient(
                  colors: [Colors.black87, Colors.orange.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
        ),




        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: const Color.fromARGB(110, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(209, 249, 249, 249),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Get Weather'),
                ),
                const SizedBox(height: 40),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!)
              ],
            ),
          ),
        ),
      ),
    );
  }



// Method for the Box-Decoration
  LinearGradient _getWeatherGradient(String description) {
    if (description.toLowerCase().contains('rain')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (description.toLowerCase().contains('clear')) {
      return const LinearGradient(
        colors: [Colors.orangeAccent, Colors.blueAccent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (description.toLowerCase().contains('thunderstorm')) {
      return const LinearGradient(
        colors: [Colors.deepPurple, Colors.black87],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (description.toLowerCase().contains('snow')) {
      return const LinearGradient(
        colors: [Colors.lightBlue, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (description.toLowerCase().contains('cloud')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (description.toLowerCase().contains('mist') ||
        description.toLowerCase().contains('fog') ||
        description.toLowerCase().contains('haze')) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.blueGrey],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return  LinearGradient(
        colors: [Colors.lightBlue, Colors.orange.shade400],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }
}
