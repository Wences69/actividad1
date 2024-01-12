import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin {


  HttpAdmin();

  Future<double> getTemByGeoloc(double latitud, double longitud) async{
    var url = Uri.https('api.open-meteo.com', '/v1/forecast',
        { 'latitude': latitud.toString(),
          'longitude': longitud.toString(),
          'hourly': 'temperature_2m',
          'timezone': 'auto'
        });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse["hourly"]["temperature_2m"][DateTime.now().hour];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }

  }
}