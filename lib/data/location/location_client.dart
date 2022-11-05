abstract class CoordinatesClient {
  Future getCoordinates();
}

class PlacemarkClientParams {
  final double latitude;
  final double longitude;

  const PlacemarkClientParams({
    required this.latitude,
    required this.longitude,
  });
}

abstract class PlacemarkClient {
  Future getPlacemark(PlacemarkClientParams params);
}
