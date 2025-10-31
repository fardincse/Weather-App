import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> fetchLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(msg: "Your Location Service is off");
    throw Exception('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Location Permission is denied");
      throw Exception('Location permission denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(msg: "Location Permission is denied forever");
    throw Exception('Location permission denied forever');
  } else {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
