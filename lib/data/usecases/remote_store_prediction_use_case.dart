import 'package:atv_final_flutter_mobile/data/http/http_client.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/store_prediction_use_case.dart';

class RemoteStorePredictionUseCase implements StorePredictionUseCase {
  final HttpClient httpClient;
  final String apiEndpoint;

  const RemoteStorePredictionUseCase({
    required this.httpClient,
    required this.apiEndpoint,
  });

  @override
  Future<void> storePrediction(StorePredictionUseCaseParams params) async {
    await httpClient.request(
      method: 'post',
      url: apiEndpoint,
      body: {
        'address': params.address.toMap(),
        'weather': params.weather.toMap(),
      },
    );
  }
}
