import 'package:atv_final_flutter_mobile/data/usecases/geolocator_fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/infra/location/location_adapter.dart';

FetchLocationUseCase makeFetchLocationUseCase() {
  final locationClient = LocationAdapter();

  return GeolocatorFetchLocationUseCase(locationClient: locationClient);
}
