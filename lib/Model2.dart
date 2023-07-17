class Model2
{
  final Weather weather;
  final Main main;
  Model2({required this.main,required this.weather});
  factory Model2.tojson(Map<String,dynamic> map)
  {
    return Model2( main: Main.tojson(map['main']),weather: Weather.tojson(map['weather']));
  }


}

class Weather
{
  String? main;
  String description;
  Weather({required this.main,required this.description});
  factory Weather.tojson(Map<String,dynamic> map)
  {
    return Weather(main: map['main'], description: map['description']);
    
  }
}

class Main
{
  double? temp;
  Main({required this.temp});
  factory Main.tojson(Map<String,dynamic> map)
  {
    return Main(temp: map['temp']);
  }
}
