import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:solar_energy/module/data/http_response.dart';

Future<HttpResponse> postrequest(String url, var body,
    {istokenrequired = true}) async {
  const storage = FlutterSecureStorage();
  // ignore: prefer_typing_uninitialized_variables
  var headers = {'Content-Type': 'application/json'};
  if (istokenrequired) {
    String? token = await storage.read(key: "token");
    if (token == null) {
      return HttpResponse(data: "Please login again", status: false);
    }
    headers = {'x-access-token': token, 'Content-Type': 'application/json'};
  }
  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode(body);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();
    return HttpResponse(data: await jsonDecode(data), status: true);
  } else {
    String data = await response.stream.bytesToString();
    debugPrint(data);
    return HttpResponse(data: response.reasonPhrase, status: false);
  }
}
