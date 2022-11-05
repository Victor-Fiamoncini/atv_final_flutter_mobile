import 'package:atv_final_flutter_mobile/domain/entities/position_entity.dart';

abstract class FetchLocationUseCase {
  Future<PositionEntity> fetchLocation();
}
