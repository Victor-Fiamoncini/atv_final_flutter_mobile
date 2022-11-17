import 'dart:convert';

import 'package:atv_final_flutter_mobile/data/http/http_error.dart';
import 'package:atv_final_flutter_mobile/data/http/http_get_client.dart';
import 'package:atv_final_flutter_mobile/data/http/http_post_client.dart';
import 'package:http/http.dart';

class HttpAdapter implements HttpGetClient, HttpPostClient {
  final Client client;

  const HttpAdapter({required this.client});

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

  @override
  Future get({required String url}) async {
    var res = Response('', 500);

    try {
      final headers = {'content-type': 'application/json'};
      final parsedUrl = Uri.parse(url);

      res = await client.get(parsedUrl, headers: headers);
    } catch (err) {
      throw HttpError.serverError;
    }

    return _handleResponse(res);
  }

  @override
  Future post({required String url, body}) async {
    var res = Response('', 500);

    try {
      final headers = {'content-type': 'application/json'};
      final jsonBody = body != null ? jsonEncode(body) : null;
      final parsedUrl = Uri.parse(url);

      res = await client.post(parsedUrl, headers: headers, body: jsonBody);
    } catch (err) {
      throw HttpError.serverError;
    }

    return _handleResponse(res);
  }
}
