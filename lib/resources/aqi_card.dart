import 'package:flutter/material.dart';
import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/data/city_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:air_quality_index/resources/shimmer_loading.dart';

import 'dart:convert';
import 'dart:developer';

class AQICard extends StatefulWidget {
  AQICard({@required this.cityName});
  final String cityName;

  @override
  _AQICardState createState() => _AQICardState();
}

class _AQICardState extends State<AQICard> {
  _getCityData(String _city) async {
    http.Response response = await http.get(kAqiUrl + _city + kToken);
    var responseData = jsonDecode(response.body)["data"];
    String datetime = responseData["time"]["s"];
    String _aqi = responseData["aqi"].toString();
    String dominantPol = responseData["dominentpol"];
    CityData _cityData = CityData(_city, _aqi, dominantPol, datetime);
    return _cityData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getCityData(widget.cityName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return aqiCard(snapshot.data);
          } else {
            return loadingCard();
          }
        },
      ),
    );
  }

  Widget aqiCard(_cityData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: SizeConfig.safeBlockHorizontal * 7,
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 3,
                  ),
                  Column(
                    children: [
                      Text(
                        '${_cityData.getCity()}',
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _getCityData(widget.cityName);
                      });
                    },
                    icon: Icon(Icons.sync),
                    color: Colors.blue,
                    iconSize: SizeConfig.safeBlockHorizontal * 6,
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Last Updated',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('${_cityData.getTime()}'),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        'Air Quality Index',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('${_cityData.getAqi()}'),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        'Main Pollutant',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('${_cityData.getPollutant()}'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: SizeConfig.safeBlockHorizontal * 7,
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 3,
                  ),
                  Column(
                    children: [
                      shimmerLoading(),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.sync,
                    color: Colors.grey,
                    size: SizeConfig.safeBlockHorizontal * 6,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Last Updated',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      shimmerLoading(),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        'Air Quality Index',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      shimmerLoading(),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text(
                        'Main Pollutant',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      shimmerLoading(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
