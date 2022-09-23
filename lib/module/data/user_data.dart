import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solar_energy/module/constants/apis.dart';
import 'package:solar_energy/module/data/http_response.dart';
import 'package:solar_energy/module/http/get_http.dart';
import 'package:solar_energy/module/http/post_http.dart';

class Userdata {
  TextEditingController userName;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController password;
  TextEditingController plantDetails;
  final storage = const FlutterSecureStorage();
  Userdata(
      {required this.userName,
      required this.address,
      required this.phoneNumber,
      required this.plantDetails,
      required this.password});

  bool checkrequired({bool checkwholedata = true}) {
    if (phoneNumber.text.length != 10) {
      EasyLoading.showError("Phone Number is not valid");
      return false; //show error(not valid)
    }
    if (checkwholedata) {
      if (address.text.isEmpty ||
          userName.text.isEmpty ||
          password.text.isEmpty ||
          phoneNumber.text.isEmpty ||
          plantDetails.text.isEmpty) {
        EasyLoading.showError("All fields are required");
        return false; //show error
      }
    } else {
      if (password.text.isEmpty) {
        EasyLoading.showError("Please enter password");
        return false; //
      }
    }
    return true;
  }

  fetchdata() async {
    HttpResponse x = await getrequest(Apis().api + Routes().userinfo);
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

  Future<bool> register() async {
    if (!checkrequired()) {
      return false;
    }
    HttpResponse y = await postrequest(
        Apis().api + Routes().register,
        {
          "name": userName.text,
          "phoneNumber": phoneNumber.text,
          "password": password.text,
          "address": address.text,
          "details": plantDetails.text
        },
        istokenrequired: false);
    if (y.status == false) {
      EasyLoading.showError("User not created ${y.data}");
      return false; //user not created
    }
    return true;

    //user created
  }

  login() async {
    if (!checkrequired(checkwholedata: false)) {
      return false;
    }
    HttpResponse z = await getrequest(
        Apis().api + Routes().login(phoneNumber.text, password.text),
        istokenrequired: false);
    if (z.status == false) {
      EasyLoading.showError("unable to login ${z.data}");
      return false; //not able to login
    }
    await storage.write(key: "token", value: z.data['token']);
    return true;
  }
}
