import 'package:atv_final_flutter_mobile/data/usecases/geolocator_fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/main/factories/location/location_client_factory.dart';

FetchLocationUseCase makeFetchLocationUseCase() {
  final locationClient = makeLocationClient();

  return GeolocatorFetchLocationUseCase(coordinatesClient: locationClient);
}
