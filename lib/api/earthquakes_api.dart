import 'dart:convert';

import 'package:earthquakes_info/models/earthquake_model.dart';
import 'package:http/http.dart';

class EarthQuakesApi{
  static Future<EarthquakeModel> getEarthQuakesData(String fromDate, String toDate, num mag) async {
    final uri = Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=$fromDate&endtime=$toDate&minmagnitude=$mag&orderby=magnitude');
    try {
      final response = await get(uri);
      final map = jsonDecode(response.body);
      if(response.statusCode == 200) {
        EarthquakeModel earthquakeModel = EarthquakeModel.fromJson(map);
        print('earthquake: $earthquakeModel');
        return earthquakeModel;
      } else {
        print(map['message']);
        return EarthquakeModel();
      }
    }catch(error) {
      rethrow;
    }
  }
}