import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:solar_energy/module/data/http_response.dart';

Future<HttpResponse> getrequest(String url, {istokenrequired = true}) async {
  const storage = FlutterSecureStorage();
  var headers;
  if (istokenrequired) {
    String? token = await storage.read(key: "token");
    if (token == null) {
      return HttpResponse(data: "Please login again", status: false);
    }
    headers = {'x-access-token': token};
  }

  var request = http.Request('GET', Uri.parse(url));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();

    return HttpResponse(data: await jsonDecode(data), status: true);
  } else {
    return HttpResponse(data: response.reasonPhrase, status: false);
  }
}
