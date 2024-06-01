import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weater_app/models/weather_model.dart';
import 'package:weater_app/service/weather_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _weatherService = WeatherService('e0e5758f38c3026e858378010e7bcb78');
  Weather? _weather;

  _fetchWeather() async {

    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String animation(String?mainCondition) {
    if(mainCondition == null) return ('asset/sunny.json');
    
    switch (mainCondition.toLowerCase()) {
    case 'clouds': 
    case 'mist': 
    case 'smoke': 
    case 'haze': 
    case 'dust': 
    case 'fog':
      return 'assets/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rainy.json';
    case 'thunderstorm':
      return 'assets/thunder.json';
    case 'clear':
      return 'assets/sunny.json';
    default:
      return 'assets/sunny.json';
    }
  }

  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading City...",style: TextStyle(fontSize: 35.0)),
            Lottie.asset(animation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C',style: TextStyle(fontSize: 30.0, color: Color.fromARGB(172, 183, 165, 3) ),),
            Text(_weather?.mainCondition??"",style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}