import 'package:flutter/cupertino.dart';
import 'package:solar_energy/module/data/user_data.dart';

class Appstate extends ChangeNotifier {
  Userdata user = Userdata(
      userName: TextEditingController(),
      phoneNumber: TextEditingController(),
      password: TextEditingController(),
      plantDetails: TextEditingController(),
      address: TextEditingController());

  // Devices device = Devices(
  //   deviceid:

  // );

  updateUserData() {
    user.fetchdata();
    notifyListeners();
  }
}
