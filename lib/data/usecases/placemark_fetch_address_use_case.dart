import 'package:atv_final_flutter_mobile/data/location/location_client.dart';
import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';

class PlacemarkFetchAddressUseCase implements FetchAddressUseCase {
  final PlacemarkClient placemarkClient;

  const PlacemarkFetchAddressUseCase({required this.placemarkClient});

  @override
  Future<AddressEntity> fetchAddress(FetchAddressUseCaseParams params) async {
    final placemarkClientParams = PlacemarkClientParams(
      latitude: params.latitude,
      longitude: params.longitude,
    );

    final address = await placemarkClient.getPlacemark(placemarkClientParams);

    if (address == null) {
      throw Exception('Address not found');
    }

    return AddressEntity.fromMap({
      'street': address?.street.toString(),
      'neighborhood': address?.subLocality.toString(),
      'city':
          address?.locality != null && address.locality.toString().isNotEmpty
              ? address.locality.toString()
              : address?.subAdministrativeArea.toString(),
      'state': address?.administrativeArea.toString(),
      'postalCode': address?.postalCode.toString(),
      'country': address?.country.toString(),
    });
  }
}
