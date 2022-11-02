import 'package:atv_final_flutter_mobile/data/http/http_client.dart';
import 'package:atv_final_flutter_mobile/infra/http_adapter.dart';
import 'package:http/http.dart';

HttpClient makeHttpClient() {
  final client = Client();

  return HttpAdapter(client: client);
}
