import 'package:atv_final_flutter_mobile/data/usecases/remote_store_prediction_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/store_prediction_use_case.dart';
import 'package:atv_final_flutter_mobile/main/factories/http/http_client_factory.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

StorePredictionUseCase makeStorePredictionUseCase() {
  final apiBaseUrl = dotenv.env['MAIN_API_BASE_URL'];

  if (apiBaseUrl == null) throw Exception('MAIN_API_BASE_URL not found');

  final httpClient = makeHttpClient();
  final apiEndPoint = '$apiBaseUrl/predictions';

  return RemoteStorePredictionUseCase(
    httpClient: httpClient,
    apiEndpoint: apiEndPoint,
  );
}
