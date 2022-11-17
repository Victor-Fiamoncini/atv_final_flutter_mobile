import 'package:atv_final_flutter_mobile/infra/http/http_adapter.dart';
import 'package:http/http.dart';

makeHttpClient() {
  final client = Client();

  return HttpAdapter(client: client);
}
