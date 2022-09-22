import 'package:solar_energy/module/constants/apis.dart';
import 'package:solar_energy/module/data/http_response.dart';
import 'package:solar_energy/module/http/get_http.dart';
import 'package:solar_energy/module/http/post_http.dart';

class Userdata {
  String? userName;
  String? phoneNumber;
  String? address;
  String? plantDetails;
  String? password;
  Userdata(
      {this.userName,
      this.address,
      this.phoneNumber,
      this.plantDetails,
      this.password});
  fetchdata() async {
    HttpResponse x = await getrequest(Apis().api+Routes().userinfo);
    if (x.status == false) {
      // we have to show erroe to user
      return;
    }
    userName = x.data["name"];
    address = x.data["address"];
    phoneNumber = x.data["phoneNumber"];
    plantDetails = x.data["plantDetails"];
    return;
  }

  register() async {
    if (address == null ||
        userName == null ||
        phoneNumber == null ||
        plantDetails == null ||
        password == null) {
      return; //show error (all details)
    }
    if (phoneNumber?.length != 10) {
      return; //show error(not valid)
    }

    HttpResponse y = await postrequest(Apis().api+Routes().register, {
      "name": "$userName",
      "phoneNumber": "$phoneNumber",
      "password": "$password",
      "address": "$address",
      "details": "$plantDetails"
    });
    if (y.status == false) {
      return; //user not created
    }
    //user created
  }

  login() async {
    HttpResponse z = await getrequest(Apis().api+Routes().adddevice, istokenrequired: false);
    if (z.status == false) {
      return; //not able to login
    }
  }
}
