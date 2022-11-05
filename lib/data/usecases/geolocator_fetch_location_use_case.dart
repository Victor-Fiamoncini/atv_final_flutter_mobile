import 'package:atv_final_flutter_mobile/data/location/location_client.dart';
import 'package:atv_final_flutter_mobile/domain/entities/position_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';

class GeolocatorFetchLocationUseCase implements FetchLocationUseCase {
  final LocationClient locationClient;

  const GeolocatorFetchLocationUseCase({required this.locationClient});

  @override
  Future<PositionEntity> fetchLocation() async {
    final coordinates = await locationClient.getLocation();

    return PositionEntity.fromMap({
      'latitude': double.parse(coordinates?.latitude),
      'longitude': double.parse(coordinates?.longigute),
    });
  }
}
