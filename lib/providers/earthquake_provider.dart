import 'package:earthquakes_info/api/earthquakes_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/earthquake_model.dart';

class EarthquakesProvider extends ChangeNotifier {
  String? fromDate;
  String? toDate;
  num? currentMagnitude;
  EarthquakeModel? earthquakeModel;

  selectMagnitude(num value){
    currentMagnitude = value;
    print('cM: $currentMagnitude');
    notifyListeners();
  }

  selectFromDate(DateTime dateTime){
    fromDate = DateFormat('yyyy-MM-dd').format(dateTime);
    print(fromDate);
    notifyListeners();
  }


  selectToDate(DateTime dateTime){
    toDate = DateFormat('yyyy-MM-dd').format(dateTime);
    notifyListeners();
  }


  getEarthQuakeData() async {
    if (fromDate != null && toDate != null && currentMagnitude != null){
      earthquakeModel = await EarthQuakesApi.getEarthQuakesData(fromDate!, toDate!, currentMagnitude!);
      notifyListeners();
    }
  }
}
