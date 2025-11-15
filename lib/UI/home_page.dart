import 'package:flutter/material.dart';
import 'common.dart';
import 'details_page.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:provider/provider.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FetchData>().fetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white10,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white, size: 25),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white10,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.light_mode_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.nights_stay,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Consumer<FetchData>(
        builder: (context, data, child){
          final weather = data.weather;
          return (weather == null) ?
          Center(child: CircularProgressIndicator(),) :
          SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          '${weather.location!.name}, ${weather.location!.country}',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          'Today, ${DateFormat('d MMM').format(DateTime.parse(weather.forecast!.forecastday!.first.date ?? ''))}',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 170,
                          height: 170,
                          child: Image.network(
                            'https:${weather.current!.condition!.icon!}',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          weather.current!.tempC!.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          weather.current!.condition!.text!,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        ShortDetails(temp: 28, wind: 13, humidity: 84),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Details(),
                                  ),
                                );
                              },
                              child: Text(
                                'View Full Report',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      itemCount: weather.forecast!.forecastday!.first.hour!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyWeather =
                            weather.forecast!.forecastday!.first.hour![index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  'https:${hourlyWeather.condition!.icon}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                DateFormat('h a').format(DateTime.parse(hourlyWeather.time!)),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                hourlyWeather.tempC.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
        }
        )
    );
  }
}
