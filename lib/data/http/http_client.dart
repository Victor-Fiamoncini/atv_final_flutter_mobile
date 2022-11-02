enum HttpError {
  badRequest,
  notFound,
  serverError,
  unauthorized,
  forbidden,
  invalidData,
}

abstract class HttpClient {
  Future request({required String url, required String method, dynamic body});
}
