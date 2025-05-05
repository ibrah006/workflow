import 'package:workflow/core/api/local_http.dart';

class ApiClient {
  static const baseUrl = 'http://192.168.0.103:3000';

  static final LocalHttp http = LocalHttp(baseUrl: baseUrl);
}
