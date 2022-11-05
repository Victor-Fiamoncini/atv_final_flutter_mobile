import 'package:atv_final_flutter_mobile/data/usecases/placemark_fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/main/factories/location/location_client_factory.dart';

FetchAddressUseCase makeFetchAddressUseCase() {
  final locationClient = makeLocationClient();

  return PlacemarkFetchAddressUseCase(placemarkClient: locationClient);
}
