import 'package:atv_final_flutter_mobile/data/location/location_client.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationAdapter implements CoordinatesClient, PlacemarkClient {
  @override
  Future getCoordinates() async {
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
      forceAndroidLocationManager: true,
    );

    return position;
  }

  @override
  Future getPlacemark(PlacemarkClientParams params) async {
    final placemark = await placemarkFromCoordinates(
      params.latitude,
      params.longitude,
    );

    if (placemark.isNotEmpty) {
      return placemark.first;
    }
  }
}
