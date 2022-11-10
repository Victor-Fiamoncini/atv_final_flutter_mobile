import 'package:atv_final_flutter_mobile/data/location/location_client.dart';
import 'package:atv_final_flutter_mobile/domain/entities/position_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';

class GeolocatorFetchLocationUseCase implements FetchLocationUseCase {
  final CoordinatesClient coordinatesClient;

  const GeolocatorFetchLocationUseCase({required this.coordinatesClient});

  @override
  Future<PositionEntity> fetchLocation() async {
    final coordinates = await coordinatesClient.getCoordinates();

    return PositionEntity(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    );
  }
}
