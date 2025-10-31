import 'package:flutter/material.dart';

class ShortDetails extends StatelessWidget {

  int temp;
  int wind;
  int humidity;

  ShortDetails({super.key, required this.temp, required this.wind, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Temp',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                ),),
              Text(
                '$temp°',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Wind',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                ),),
              Text(
                '${wind}km/h',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Humidity',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                ),),
              Text(
                '$humidity%',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              )
            ],
          ),
        ]
    );
  }

}