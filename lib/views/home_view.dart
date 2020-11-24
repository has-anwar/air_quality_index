import 'dart:developer';

import 'package:air_quality_index/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:air_quality_index/resources/aqi_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:air_quality_index/data/city_data.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _cityNames = ['Karachi', 'Islamabad', 'Peshawar', 'Rawalpindi'];
  // String currentCity;

  Future<String> _getCurrentCity() async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    final coordinates =
        Coordinates(_currentPosition.latitude, _currentPosition.longitude);

    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first.subAdminArea;
  }

  // _generateDataList() async {
  //   String currentCity = await _getCurrentCity();
  //   log(currentCity);
  //   if (!_cityNames.contains(currentCity)) {
  //     _cityNames.insert(0, currentCity);
  //   }
  //   List<CityData> _cityDataList = [];
  //   for (String city in _cityNames) {
  //     CityData cityData = await _getCityData(city);
  //     _cityDataList.add(cityData);
  //   }
  //
  //   return _cityDataList;
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Quality Index'),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        child: FutureBuilder(
          future: _getCurrentCity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!_cityNames.contains(snapshot.data)) {
                _cityNames.insert(0, snapshot.data);
              }
              return cityAqiInfo();
            } else {
              return Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget cityAqiInfo() {
    return ListView.builder(
        itemCount: _cityNames.length,
        itemBuilder: (BuildContext context, int index) {
          return AQICard(cityName: _cityNames[index]);
        });
  }
}
