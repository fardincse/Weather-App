import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Provider/history_provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'common.dart';
import 'package:weather_app/Models/date_formater.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white10,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Consumer2<FetchData, HistoryProvider>(
        builder: (context, data, select, child){
            final weather = data.weather;
            final selectedIndex = context.watch<HistoryProvider>().selectedIndex;
            final selectedItem = weather!.forecast!.forecastday![selectedIndex];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: 120,
                            width: 120,
                          child: Image.network(
                            'https:${selectedItem.day!.condition!.icon}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              formatDate(selectedItem.date),
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${selectedItem.day!.condition!.text}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${selectedItem.day!.avgtempC}°',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ShortDetails(
                      temp: selectedItem.day!.avgtempC?.round() ?? 0, 
                      wind: selectedItem.day!.maxwindKph?.round() ?? 0, 
                      humidity: selectedItem.day!.avghumidity?.round() ?? 0
                      ),
                    SizedBox(height: 50),
                    Text(
                      'In 3 Days',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: weather.forecast!.forecastday!.length,
                        itemBuilder: (context, index) {
                          final item = weather.forecast!.forecastday![index];
                          bool isSelected = select.selectedIndex == index;
                          return GestureDetector(
                            onTap: (){
                                select.selectIndex(index);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color.fromARGB(136, 93, 152, 203) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('E').format(DateTime.parse(item.date.toString())),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      'https:${item.day!.condition!.icon}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 95,
                                    child: Text(
                                      item.day!.condition!.text.toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '${item.day!.avgtempC}°',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${item.day!.maxwindKph}km/h',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
        )
    );
  }
}
