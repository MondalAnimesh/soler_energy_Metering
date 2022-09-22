import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:solar_energy/module/data/http_response.dart';

Future<HttpResponse> postrequest(String url, var x) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode(x);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();

    return HttpResponse(data: await jsonDecode(data), status: true);
  } else {
    return HttpResponse(data: response.reasonPhrase, status: false);
  }
}
