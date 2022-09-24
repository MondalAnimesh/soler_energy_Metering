import 'package:solar_energy/module/constants/apis.dart';
import 'package:solar_energy/module/data/http_response.dart';
import 'package:solar_energy/module/http/get_http.dart';

class Devices {
  String? deviceID;

  fetchid() async {
    HttpResponse id = await getrequest(Apis().api + Routes().adddevice);
    if (id.status == false) {
      return;
    }
    deviceID = id.data["deviceID"];
    return;
  }
}
