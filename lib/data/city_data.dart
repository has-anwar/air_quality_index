import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CityData {
  String _city;
  String _pollutant;
  String _aqi;
  String _datetime;

  CityData(this._city, this._aqi, this._pollutant, this._datetime);

  String getCity() {
    return this._city;
  }

  String getAqi() {
    return this._aqi;
  }

  String getPollutant() {
    return this._pollutant;
  }

  String getDate() {
    var parsedDatetime = DateTime.parse(this._datetime);
    String date = parsedDatetime.day.toString() +
        "/" +
        parsedDatetime.month.toString() +
        "/" +
        parsedDatetime.year.toString();

    return date;
  }

  String getTime() {
    var parsedDatetime = DateTime.parse(this._datetime);
    String formattedTime = DateFormat.jm().format(parsedDatetime);
    return formattedTime;
  }

  void displayCityInfo() {
    log("\n City: ${getCity()} \n AQI: ${getAqi()} \n Dominant Pollutant: ${getPollutant()} \n Update date: ${getDate()} \n Update time: ${getTime()}");
  }
}
