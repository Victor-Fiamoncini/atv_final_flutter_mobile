import 'package:atv_final_flutter_mobile/data/location/location_client.dart';
import 'package:geolocator/geolocator.dart';

class LocationAdapter implements LocationClient {
  @override
  Future getLocation() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) throw Exception('Location service not enabled');

    var locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      throw Exception('Location permission is denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        throw Exception('Location permission is denied');
      }
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
}
