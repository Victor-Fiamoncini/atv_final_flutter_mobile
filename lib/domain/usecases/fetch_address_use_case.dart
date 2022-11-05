import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';

class FetchAddressUseCaseParams {
  final double latitude;
  final double longitude;

  const FetchAddressUseCaseParams({
    required this.latitude,
    required this.longitude,
  });
}

abstract class FetchAddressUseCase {
  Future<AddressEntity> fetchAddress(FetchAddressUseCaseParams params);
}
