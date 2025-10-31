class DataModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  DataModel({this.location, this.current, this.forecast});

  DataModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
  }
}

class Location {
  String? name;
  String? country;

  Location({
    this.name,
      this.country,
      });

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
  }
}

class Current {
  double? tempC;
  Condition? condition;
  double? windKph;
  int? humidity;

  Current({
      this.tempC,
      this.condition,
      this.windKph,
      this.humidity,
      });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    humidity = json['humidity'];
  }
}

class Condition {
  String? text;
  String? icon;
  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(Forecastday.fromJson(v));
      });
    }
  }
}

class Forecastday {
  String? date;
  Day? day;
  List<Hour>? hour;

  Forecastday({this.date, this.day, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(new Hour.fromJson(v));
      });
    }
  }
}

class Day {
  double? avgtempC;
  double? maxwindKph;
  int? avghumidity;
  Condition? condition;

  Day({
      this.avgtempC,
      this.maxwindKph,
      this.avghumidity,
      this.condition,
      });

  Day.fromJson(Map<String, dynamic> json) {
    avgtempC = json['avgtemp_c'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }
}

class Hour {
  String? time;
  double? tempC;
  Condition? condition;

  Hour({
      this.time,
      this.tempC,
      this.condition,
      });

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }
}