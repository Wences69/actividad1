import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin {


  HttpAdmin();

  Future<double> getTemperatura(double lat, double lon) async {
    var url = Uri.https("api.open-meteo.com", "/v1/forecast",
        {
          "latitude": lat.toString(),
          "longitude": lon.toString(),
          "hourly" : "temperature_2m"
        });
    print("URL RESULTANTE: "+url.toString());

    var response = await http.get(url);

    if(response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      DateTime now = DateTime.now();
      int hour = now.hour;

      var jsonHourly = jsonResponse["hourly"];
      var jsonTimes = jsonHourly["time"];
      var jsonTiempo = jsonResponse["hourly"]["time"][hour];
      var jsonTemperaturas = jsonHourly["temperature_2m"];
      var jsonTemperatura = jsonTemperaturas[hour];

      print("LA TEMPERATURA A LAS ${jsonTiempo.toString()} FUE ${jsonTemperatura.toString()}");
      print(jsonResponse["hourly"]["time"][hour]);
      print(jsonResponse["hourly"]["temperature_2m"][hour].toString());
      return jsonTemperatura;
    }
    else {
      print("Request failed with status: ${response.statusCode}");
      return 0;
    }
  }
}