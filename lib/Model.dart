class LatLong
{
  String? name;
  double? lat;
  double? lon;
  LatLong({required this.name,required this.lat,required this.lon});


  factory LatLong.users(Map<String,dynamic> map)
  {
    return  LatLong(name: map['name'], lat: map['lat'], lon: map['lon']);
    
    
  }
}



