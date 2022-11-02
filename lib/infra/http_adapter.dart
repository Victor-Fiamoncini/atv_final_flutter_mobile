import 'dart:convert';

import 'package:atv_final_flutter_mobile/data/http/http_client.dart';
import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  const HttpAdapter({required this.client});

  @override
  Future request({
    required String url,
    required String method,
    dynamic body,
  }) async {
    var res = Response('', 500);

    final headers = {'content-type': 'application/json'};
    final jsonBody = body != null ? jsonEncode(body) : null;

    try {
      final parsedUrl = Uri.parse(url);

      switch (method) {
        case 'post':
          res = await client.post(parsedUrl, headers: headers, body: jsonBody);
          break;

        default:
          res = await client.get(parsedUrl, headers: headers);
      }
    } catch (err) {
      throw HttpError.serverError;
    }

    return _handleResponse(res);
  }

  Map? _handleResponse(Response response) {
    final responseByStatusCode = {
      200: () => response.body.isEmpty ? null : jsonDecode(response.body),
      201: () => response.body.isEmpty ? null : jsonDecode(response.body),
      204: () => null,
      400: () => throw HttpError.badRequest,
      401: () => throw HttpError.unauthorized,
      403: () => throw HttpError.forbidden,
      404: () => throw HttpError.notFound,
      500: () => throw HttpError.serverError,
    };

    return responseByStatusCode[response.statusCode]!();
  }
}
