import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin {


  HttpAdmin();

  void getTemperatura(double lat, double lon) async {
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

      var jsonHourly = jsonResponse["hourly"];
      var jsonTimes = jsonHourly["time"];
      var jsonTiempo = jsonTimes[10];
      var jsonTemperaturas = jsonHourly["temperature_2m"];
      var jsonTemperatura = jsonTemperaturas[10];

      print("LA TEMPERATURA A LAS ${jsonTiempo.toString()} FUE ${jsonTemperatura.toString()}");
    }
    else {
      print("Request failed with status: ${response.statusCode}");
    }
  }
}